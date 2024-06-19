-- Adminer 4.8.1 MySQL 8.3.0 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `album`;
CREATE TABLE `album` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `album` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` tinytext NOT NULL,
  `email` tinytext NOT NULL,
  `blocked` int NOT NULL DEFAULT '0',
  `active` tinyint NOT NULL DEFAULT '0',
  `role` varchar(6) NOT NULL DEFAULT 'user',
  `location` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'upload',
  `access` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'denied',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`(32))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `auth` (`id`, `username`, `password`, `email`, `blocked`, `active`, `role`, `location`, `access`) VALUES
(53,	'sakil',	'$2y$09$vKlhKY8hTa1kHpFKodeXbeumnU/vA2H2.Ph0wcGK.t8eCI5xn040m',	'b.sakilobm@gmail.com',	0,	1,	'admin',	'sakil/',	'granted'),
(56,	'Sowbharath',	'$2y$09$wOkWTjAnn0Y4/Upm9/iNYeSPRdyRI.PTZ9GRL1Sz15YmWKDyfGQAO',	'b.sowbharath@gmail.com',	0,	1,	'admin',	'sakil/',	'granted'),
(60,	'sj',	'$2y$09$OXKmz4SDbrOh2YdgZjfGBOHsNsC6R96maABy4QTckiUcSn5exRkzq',	'sj@gmail.com',	0,	1,	'user',	'upload',	'denied'),
(61,	'samuthra',	'$2y$09$zhj/dJ2v.hyZSZ1dR4xmN.cMALWes.kNaR0xdpyGz2roRRZ9CgHAO',	'samuthrasamsds08@gmail.com',	0,	1,	'admin',	'upload',	'granted');

DROP TABLE IF EXISTS `gallery`;
CREATE TABLE `gallery` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title1` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `title2` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `image_uri` varchar(512) NOT NULL,
  `video_uri` varchar(512) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `gallery` (`id`, `title1`, `title2`, `image_uri`, `video_uri`) VALUES
(1,	'Wedding',	'E-PHOTO BOOK',	'wedding.jpg',	''),
(2,	'Wedding',	'Video',	'Video-icon-2.jpg',	'Salem.mp4'),
(3,	'Birthday',	'Party',	'Video-icon-3.jpg',	''),
(4,	'Pre Wedding',	'Shoot Promo',	'Video-icon-4.jpg',	'');

DROP TABLE IF EXISTS `packages`;
CREATE TABLE `packages` (
  `id` int NOT NULL,
  `date` datetime DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `packages` (`id`, `date`, `type`, `description`) VALUES
(1,	'2023-04-08 07:02:01',	'Gold-Elite : 2,50,000',	'1 Traditional Photography , 1 Candid Photography , 2 Printed Album (45 Sheets & 3D Embossing) Complimentary : Post Wedding Photo Shoot , 2 Frames , 2 Mug : 2 calendar '),
(2,	'2023-04-08 07:03:13',	'Platinum-Plus : 1,75,000 ',	'1 Traditional Photography , 1 Candid Photography , 1-Printed Album (35 Sheets) Complimentary : Post Wedding Photo Shoot , 2 Frames '),
(3,	'2023-04-08 07:05:04',	'Silver Royal : 50,000',	'1 Traditional Photography , 1 Videography');

DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `category` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `img_location` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `owner` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `session`;
CREATE TABLE `session` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int NOT NULL,
  `token` varchar(32) NOT NULL,
  `login_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `ip` varchar(23) NOT NULL,
  `user_agent` varchar(256) NOT NULL,
  `active` int NOT NULL DEFAULT '1',
  `fingerprint` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  CONSTRAINT `session_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `auth` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 2024-06-14 14:15:57
