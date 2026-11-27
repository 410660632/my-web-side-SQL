CREATE DATABASE IF NOT EXISTS `my_website`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE `my_website`;

DROP TABLE IF EXISTS `message_likes`;
DROP TABLE IF EXISTS `replies`;
DROP TABLE IF EXISTS `messages`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'user',
  `email` varchar(100) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `content` longtext NOT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_user` (`user_id`),
  KEY `fk_category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categories` (`id`, `category_name`) VALUES
(1, '一般討論'),
(2, '問題回報'),
(3, '系統公告'),
(10, '技術交流'),
(11, '閒聊專區'),
(12, '網站建議');

INSERT INTO `users` (`id`, `username`, `password`, `role`, `email`) VALUES
(1, 'admin', 'admin123', 'admin', 'admin@example.com'),
(2, '小華', 'user123', 'user', 'hua@example.com'),
(5, '小明', 'userpass123', 'user', 'ming@example.com'),
(6, '測試帳號', 'temp123', 'user', 'temp@example.com');

INSERT INTO `messages` (`id`, `user_id`, `category_id`, `content`, `likes`) VALUES
(1, 1, 3, '歡迎大家來到三資料表結構的新版留言板！', 0),
(2, 2, 1, '這是我第一次測試跨資料表留言。', 0),
(5, 1, 10, '這是我用 SQL INSERT INTO 手動新增的技術討論留言！', 0),
(6, 5, 11, 'nice', 0);

UPDATE `messages`
SET `likes` = 5, `content` = 'nice（已完成 UPDATE 更新測試）'
WHERE `id` = 6;

DELETE FROM `users`
WHERE `username` = '測試帳號';

SELECT * FROM `categories`;
SELECT * FROM `users`;
SELECT * FROM `messages`;
