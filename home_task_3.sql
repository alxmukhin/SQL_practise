-- 1. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке. [ORDER BY]

SELECT DISTINCT firstname
FROM users
ORDER BY firstname;

-- 2. Выведите количество мужчин старше 35 лет [COUNT].

SELECT *
FROM profiles
WHERE (birthday + INTERVAL 35 YEAR) < NOW() AND gender = 'm';

-- 3. Сколько заявок в друзья в каждом статусе? (таблица friend_requests) [GROUP BY]

SELECT COUNT(status), status 
FROM friend_requests
GROUP BY status ;

-- 4.* Выведите номер пользователя, который отправил больше всех заявок в друзья (таблица friend_requests) [LIMIT].

SELECT COUNT(status), initiator_user_id
FROM friend_requests
GROUP BY initiator_user_id
ORDER BY COUNT(status) DESC
LIMIT 1

-- 5.* Выведите названия и номера групп, имена которых состоят из 5 символов [LIKE].

SELECT name
FROM communities
WHERE name LIKE '_____'