SELECT * FROM users
ORDER BY created_at ASC
LIMIT 5;

SELECT count(*) FROM users;

-- What day of week do most users register on?
SELECT DAYNAME(created_at) as day_of_week, count(*) registration_count FROM users
GROUP BY day_of_week
ORDER BY registration_count DESC;

-- Find the users who have never posted a photo
SELECT username, count(*) AS photo_count FROM users
LEFT JOIN photos on users.id = photos.user_id
GROUP BY username
HAVING photo_count IS NULL
LIMIT 10;

SELECT username, photos.id FROM users
LEFT JOIN photos on users.id = photos.user_id
WHERE photos.id IS NULL
LIMIT 10;


-- Who has the most likes on a single photo?
-- (1) Which photo has the most likes?
-- (2) Who owns the photos

SELECT username, photos.id, photos.image_url, COUNT(*) AS count FROM photos
JOIN likes ON photos.id = likes.photo_id
JOIN users ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY count DESC
LIMIT 15;


SELECT * FROM photos
JOIN users ON photos.user_id = users.id
JOIN likes ON photos.id = likes.photo_id
LIMIT 15;

-- How many times does the avg user post?
-- Number of photos / number of users

SELECT count(*) / (SELECT count(*) FROM users) FROM photos; -- a little hard to read

SELECT (SELECT count(*) FROM photos) / (SELECT count(*) FROM users); -- easier to read

-- What are the top 5 most commonly used hashtags?

SELECT photo_tags.tag_id, tags.tag_name, COUNT(*) AS tag_count 
FROM photo_tags JOIN tags ON photo_tags.tag_id = tags.id
GROUP BY tag_id
ORDER BY tag_count DESC
LIMIT 5;

-- Find users who have liked every single photo on the site
-- Count distinct photos = 257
-- Find users who have liked 257 disntict photo ids

SELECT count(*) FROM photos;

SELECT user_id, COUNT(*) AS count_of_photos_liked FROM likes
GROUP BY user_id
HAVING count_of_photos_liked = 257
ORDER BY count_of_photos_liked DESC
LIMIT 25;

SELECT user_id, username, COUNT(*) AS count_of_photos_liked FROM likes
JOIN users ON likes.user_id = users.id
GROUP BY user_id
HAVING count_of_photos_liked = 257
ORDER BY count_of_photos_liked DESC
LIMIT 25;

SELECT user_id, username, COUNT(*) AS count_of_photos_liked FROM likes
JOIN users ON likes.user_id = users.id
GROUP BY user_id
HAVING count_of_photos_liked = (SELECT COUNT(*) FROM photos)
ORDER BY count_of_photos_liked DESC
LIMIT 25;