-- 1. Написать функцию, которая удаляет всю информацию об указанном пользователе из БД vk. Пользователь задается по id. Удалить нужно все сообщения, лайки, медиа записи, профиль и запись из таблицы users. Функция должна возвращать номер пользователя.

DROP FUNCTION IF EXISTS func_delete_user;

DELIMITER $$
$$
CREATE FUNCTION func_delete_user(delete_id BIGINT UNSIGNED)
RETURNS INT MODIFIES SQL DATA
BEGIN
	DELETE likes FROM likes RIGHT JOIN media ON likes.media_id = media.id WHERE media.user_id = delete_id;
	DELETE FROM likes WHERE user_id = delete_id;
	DELETE profiles FROM profiles RIGHT JOIN media ON profiles.photo_id = media.id WHERE media.user_id = delete_id;
	DELETE FROM media WHERE user_id = delete_id;
	DELETE FROM users_communities WHERE user_id = delete_id;
	DELETE FROM friend_requests WHERE initiator_user_id = delete_id OR target_user_id = delete_id;
	DELETE FROM messages WHERE from_user_id = delete_id OR to_user_id = delete_id;
	DELETE FROM users WHERE id = delete_id;
	RETURN delete_id;
END$$
DELIMITER ;

-- Функция применяется для пользователя с ID = 1
SELECT func_delete_user(1);

-- 2. Предыдущую задачу решить с помощью процедуры и обернуть используемые команды в транзакцию внутри процедуры.

DROP PROCEDURE IF EXISTS proc_delete_user;

DELIMITER $$
$$
CREATE PROCEDURE proc_delete_user(id_delete BIGINT UNSIGNED)
BEGIN
	START TRANSACTION;
	DELETE likes FROM likes RIGHT JOIN media ON likes.media_id = media.id WHERE media.user_id = id_delete;
	DELETE FROM likes WHERE user_id = id_delete;
	DELETE profiles FROM profiles RIGHT JOIN media ON profiles.photo_id = media.id WHERE media.user_id = id_delete;
	DELETE FROM media WHERE user_id = id_delete;
	DELETE FROM users_communities WHERE user_id = id_delete;
	DELETE FROM friend_requests WHERE initiator_user_id = id_delete OR target_user_id = id_delete;
	DELETE FROM messages WHERE from_user_id = id_delete OR to_user_id = id_delete;
	DELETE FROM users WHERE id = id_delete;
	COMMIT;
END$$
DELIMITER ;

-- Процедура применяется для пользователя с ID = 2
CALL proc_delete_user(2);

-- 3.* Написать триггер, который проверяет новое появляющееся сообщество. Длина названия сообщества (поле name) должна быть не менее 5 символов. Если требование не выполнено, то выбрасывать исключение с пояснением.

DROP TRIGGER IF EXISTS check_new_community;

DELIMITER $$
$$
CREATE TRIGGER check_new_community
BEFORE INSERT ON communities
FOR EACH ROW
BEGIN 
	IF CHAR_LENGTH(NEW.name) < 5 THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Название сообщества должно быть не менее 5 символов!';
    END IF;
END$$

DELIMITER ;

INSERT INTO communities VALUES
(11, 'Try');

