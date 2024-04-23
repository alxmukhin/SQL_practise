-- 1. Создайте представление с произвольным SELECT-запросом из прошлых уроков [CREATE VIEW]

CREATE OR REPLACE  VIEW user_communities_number AS
SELECT firstname, lastname, COUNT(*) AS communities_number
FROM users
JOIN users_communities ON users.id = users_communities.user_id 
GROUP BY users.id
ORDER BY communities_number DESC;

-- 2. Выведите данные, используя написанное представление [SELECT]

SELECT * FROM user_communities_number;

-- 3. Удалите представление [DROP VIEW]

DROP VIEW user_communities_number;

-- 4.* Сколько новостей (записей в таблице media) у каждого пользователя? Вывести поля: news_count (количество новостей), user_id (номер пользователя), user_email (email пользователя). Попробовать решить с помощью CTE или с помощью обычного JOIN.

SELECT COUNT(*) AS news_count, user_id, email
FROM media
JOIN users ON users.id = media.user_id
GROUP BY user_id;
