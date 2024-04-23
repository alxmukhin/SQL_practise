-- 1. Создать БД vk, исполнив скрипт _vk_db_creation.sql (в материалах к уроку)
-- 2. Написать скрипт, добавляющий в созданную БД vk 2-3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей) (CREATE TABLE)
 
DROP TABLE IF EXISTS `countries`;
CREATE TABLE `countries` (
	`id` SERIAL,
	`name` VARCHAR(255) NOT NULL
);

DROP TABLE IF  EXISTS `regions`;
CREATE TABLE `regions` (
	`id` SERIAL,
	`name` VARCHAR(255) NOT NULL,
	`country_id` BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (country_id) REFERENCES countries(id)
);

DROP TABLE IF EXISTS `cities`;
CREATE TABLE `cities` (
	`id` SERIAL,
	`name` VARCHAR(255) NOT NULL,
	`region_id` BIGINt UNSIGNED NOT NULL,
	`country_id` BIGINT UNSIGNED NOT NULL,

	FOREIGN KEY (country_id) REFERENCES countries(id),
	FOREIGN KEY (region_id) REFERENCES regions(id)
);

DROP TABLE IF EXISTS `schools`;
CREATE TABLE `schools` (
	`id` SERIAL,
	`name` VARCHAR(255) NOT NULL,
	`city_id` BIGINT UNSIGNED NOT NULL,
	`region_id` BIGINT UNSIGNED NOT NULL,
	`country_id` BIGINT UNSIGNED NOT NULL,
		
	FOREIGN KEY (city_id) REFERENCES cities(id),
	FOREIGN KEY (country_id) REFERENCES countries(id),
	FOREIGN KEY (region_id) REFERENCES regions(id)
);

ALTER TABLE profiles ADD COLUMN school_id BIGINT UNSIGNED NOT NULL;
ALTER TABLE profiles ADD CONSTRAINT fk_profiles_school_id
FOREIGN KEY (school_id) REFERENCES schools(id);
ALTER TABLE profiles ADD COLUMN city_id BIGINT UNSIGNED NOT NULL;
ALTER TABLE profiles ADD CONSTRAINT fk_profiles_city_id
FOREIGN KEY (city_id) REFERENCES cities(id);

-- 3. Заполнить 2 таблицы БД vk данными (по 10 записей в каждой таблице) (INSERT)

INSERT INTO `users` VALUES
(1, 'Ivan', 'Sidorov', 'isidorov@gmail.com', 'e0658be2956d5c6d02d389872d62ac75', 9994873495),
(2, 'Andrey', 'Petrov', 'andreypetrov@mail.ru','85a0b45cc502368df8c02ffe65f36c76',9267841234),
(3, 'Irina', 'Ivanova', 'i.ivanova@ya.ru', '841f6345a1c7726a584ea153ef010f75', 9162794179),
(4, 'Aleksandr', 'Aleksandrov', 'aalexandrov@gmail.com', '6ba9f372393864fc29cdab521987b378', 9091236547),
(5, 'Olga', 'Alekseeva', 'o.alekseeva@mail.ru', 'a21294fa238ed77891f77fab2261f050', 9156578211),
(6, 'Daria', 'Andreeva', 'daria.andreeva@ya.ru', '74f2c75ee95ae3222c7e09430b4041e7', 9173571543),
(7, 'Marina', 'Potapova', 'mpotapova@ya.ru', '82fdbe4b94e5bcb4506aec9900fcbce2', 9057634567),
(8, 'Dmitriy', 'Smirnov', 'dmitriy.smirnov@gmail.com', 'c3303ad683a091a49142f21861e205a1', 9065641103),
(9, 'Stanislav', 'Vasiliev', 's.vasiliev@mail.ru', 'f4bb55d79a52dcf6aedf55a5fc68f21c', 9297126545),
(10, 'Maria', 'Dmitrieva', 'mariadmitrieva@ya.ru', '4333aed8290e4e249cb57b10648536eb', 9851431110)
;

INSERT INTO `countries` VALUES
(1, 'Russia'),
(2, 'Belarus'),
(3, 'Kazakhstan')
;

INSERT INTO `regions` VALUES
(1, 'Moscow', 1),
(2, 'Saint Petersburg', 1),
(3, 'Moscow Oblast', 1),
(4, 'Sverdlovsk Oblast', 1),
(5, 'Krasnodar Krai', 1),
(6, 'Republic of Tatarstan', 1),
(7, 'Gomel Oblast', 2),
(8, 'Almaty', 3)
;

INSERT INTO `cities` VALUES
(1, 'Moscow', 1, 1),
(2, 'Saint Petersburg', 2, 1),
(3, 'Electrostal', 3, 1),
(4, 'Serpukhov', 3, 1),
(5, 'Ekaterinburg', 4, 1),
(6, 'Sochi', 5, 1),
(7, 'Chistopol', 6, 1),
(8, 'Gomel', 7, 2),
(9, 'Almaty', 8, 3)
;

-- 4.* Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = true). 
-- При необходимости предварительно добавить такое поле в таблицу profiles со значением по умолчанию = false (или 0) (ALTER TABLE + UPDATE)

ALTER TABLE profiles ADD COLUMN active_status BIT DEFAULT 1;
UPDATE profiles
SET active_status = 0
WHERE birthday > (NOW() - INTERVAL 18 year);

-- 5.* Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней) (DELETE)

DELETE FROM messages 
WHERE created_at > NOW();
