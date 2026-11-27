SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categories` (`id`, `category_name`) VALUES
(1, '一般討論'),
(2, '問題回報'),
(3, '系統公告'),
(10, '技術交流'),
(11, '閒聊專區'),
(12, '網站建議');

DROP TABLE IF EXISTS `users`;
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

INSERT INTO `users` (`id`, `username`, `password`, `role`, `email`, `avatar`, `created_at`) VALUES
(1, 'admin', 'admin123', 'admin', 'admin@example.com', NULL, '2026-11-06 02:56:27'),
(2, '小華', 'user123', 'user', 'hua@example.com', NULL, '2026-11-06 02:56:27'),
(5, '小明', 'userpass123', 'user', 'ming@example.com', NULL, '2026-11-06 03:26:21');

DROP TABLE IF EXISTS `messages`;
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

INSERT INTO `messages` (`id`, `user_id`, `category_id`, `content`, `likes`, `created_at`) VALUES
(1, 1, 3, '歡迎大家來到三資料表結構的新版留言板！', 2, '2026-11-06 02:56:27'),
(2, 2, 1, '這是我第一次測試跨資料表留言。', 0, '2026-11-06 02:56:27'),
(3, 1, 3, '歡迎大家來到三資料表結構的新版留言板！', 0, '2026-11-06 02:58:12'),
(4, 2, 1, '這是我第一次測試跨資料表留言。', 0, '2026-11-06 02:58:12'),
(5, 1, 1, '這是我用 SQL INSERT INTO 手動新增的技術討論留言！', 0, '2026-11-06 03:27:00'),
(6, 5, 11, 'nice', 1, '2026-11-06 03:32:44');

DROP TABLE IF EXISTS `replies`;
CREATE TABLE `replies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `reply_content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_reply_message` (`message_id`),
  KEY `fk_reply_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `replies` (`id`, `message_id`, `user_id`, `reply_content`) VALUES
(1, 1, 2, '謝謝管理員建立新版留言板！'),
(2, 2, 5, '跨資料表留言測試成功！'),
(3, 5, 2, 'SQL INSERT 新增留言很方便！');

DROP TABLE IF EXISTS `message_likes`;
CREATE TABLE `message_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_message_user` (`message_id`, `user_id`),
  KEY `fk_like_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `message_likes` (`id`, `message_id`, `user_id`) VALUES
(1, 1, 2),
(2, 1, 5),
(3, 6, 1);

ALTER TABLE `messages`
  ADD CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `replies`
  ADD CONSTRAINT `fk_reply_message` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_reply_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `message_likes`
  ADD CONSTRAINT `fk_like_message` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_like_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

COMMIT;
SET FOREIGN_KEY_CHECKS = 1;
