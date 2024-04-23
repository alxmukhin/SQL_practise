-- 1. Подсчитать количество групп (сообществ), в которые вступил каждый пользователь.

SELECT lastname, COUNT(*) AS communities_number
FROM users
JOIN users_communities ON users.id = users_communities.user_id 
GROUP BY users.id;

-- 2. Подсчитать количество пользователей в каждом сообществе.

SELECT name, COUNT(*) AS community_users_number
FROM users_communities
JOIN communities ON users_communities.community_id = communities.id
GROUP BY name;

-- 3. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT from_user_id, users.firstname, users.lastname, COUNT(*) AS user_message_number
FROM messages
JOIN users ON users.id = messages.from_user_id
-- задается номер пользователя по которому ищется кто с ним больше всего общался
WHERE to_user_id = 1
GROUP BY from_user_id
ORDER BY user_message_number DESC
LIMIT 1;

-- 4.* Подсчитать общее количество лайков, которые получили пользователи младше 18 лет.

SELECT COUNT(*) AS likes_number_younger18
FROM likes
JOIN media ON likes.media_id = media.id
JOIN profiles ON profiles.user_id = media.user_id
WHERE YEAR(NOW()) - YEAR(birthday) < 18;


-- 5.* Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT gender, COUNT(*) AS likes_number
FROM likes
JOIN profiles ON likes.user_id = profiles.user_id
GROUP BY gender
ORDER BY likes_number DESC
LIMIT 1;

