-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 21, 2023 at 03:53 AM
-- Server version: 8.0.31
-- PHP Version: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `reseller_experience`
--
CREATE DATABASE IF NOT EXISTS `reseller_experience` DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;
USE `reseller_experience`;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `title`) VALUES
(1, 'Advertising'),
(2, 'Blog'),
(3, 'Booking'),
(4, 'Business'),
(5, 'Design'),
(6, 'Health and Beauty'),
(7, 'Personal website or Freelancer'),
(8, 'Portfolio'),
(9, 'Real Estate'),
(10, 'Restaurant'),
(11, 'Services');

-- --------------------------------------------------------

--
-- Table structure for table `lead_status`
--

DROP TABLE IF EXISTS `lead_status`;
CREATE TABLE IF NOT EXISTS `lead_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `lead_status`
--

INSERT INTO `lead_status` (`id`, `title`) VALUES
(1, 'open'),
(2, 'working'),
(3, 'completed');

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
CREATE TABLE IF NOT EXISTS `log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `initiator` int NOT NULL,
  `objectToLog` int DEFAULT NULL,
  `status` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `dateTime` datetime NOT NULL,
  `oldData` json DEFAULT NULL,
  `newData` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `initiator` (`initiator`),
  KEY `objectToLog` (`objectToLog`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `maps_info`
--

DROP TABLE IF EXISTS `maps_info`;
CREATE TABLE IF NOT EXISTS `maps_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fk_lead` int NOT NULL,
  `jsondata` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `website` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `warning` int NOT NULL,
  `id_cat` int DEFAULT NULL,
  `id_cat_automatica` int DEFAULT NULL,
  UNIQUE KEY `unique_id` (`id`),
  KEY `fk_lead` (`fk_lead`) USING BTREE,
  KEY `id_cat` (`id_cat`,`id_cat_automatica`),
  KEY `id_cat_automatica` (`id_cat_automatica`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `reseller_experience_customer`
--

DROP TABLE IF EXISTS `reseller_experience_customer`;
CREATE TABLE IF NOT EXISTS `reseller_experience_customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `AccountID` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `TaxRegID` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Nome` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Cognome` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `RagioneSociale` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Email` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Indirizzo` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Comune` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `CAP` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Provincia` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Tel` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NumMobile` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NumPagineDaAttivare` int NOT NULL,
  `NumPagineAttivate` int NOT NULL DEFAULT '0',
  `status` smallint NOT NULL DEFAULT '0' COMMENT '0 new, 1 ok, 2 ko',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `readed` tinyint NOT NULL DEFAULT '0',
  `reseller_experience_manager_id` smallint UNSIGNED DEFAULT NULL,
  `CAOName` tinyint UNSIGNED DEFAULT NULL,
  `lead_status_cat` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `AccountID-CAOName` (`AccountID`,`CAOName`),
  KEY `fk_lead_status` (`lead_status_cat`)
) ENGINE=InnoDB AUTO_INCREMENT=119364 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reseller_experience_customer`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` int NOT NULL DEFAULT '3' COMMENT '0:''connected'';\r\n1:''offline'';\r\n2:''actived'' When a user is created or reactivated, he can connect;\r\n3:''deactivated'' When a user is deactivated, he cannot connect;',
  `role` int NOT NULL DEFAULT '1' COMMENT '1 = readOnly\r\n2 = read/write\r\n3 = admin',
  `lastconnection` datetime DEFAULT NULL,
  `token` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `status`, `role`, `lastconnection`, `token`) VALUES
(1, 'admin', '$2y$10$Xi5yb142u52NX3DceYhOU.t2Rm8lHLazGjQR0hzXYyEdd6IRPQ/h6', 3, 3, NULL, NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `log_ibfk_1` FOREIGN KEY (`initiator`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `log_ibfk_2` FOREIGN KEY (`objectToLog`) REFERENCES `reseller_experience_customer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `maps_info`
--
ALTER TABLE `maps_info`
  ADD CONSTRAINT `maps_info_ibfk_1` FOREIGN KEY (`fk_lead`) REFERENCES `reseller_experience_customer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `maps_info_ibfk_2` FOREIGN KEY (`id_cat`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `maps_info_ibfk_3` FOREIGN KEY (`id_cat_automatica`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `reseller_experience_customer`
--
ALTER TABLE `reseller_experience_customer`
  ADD CONSTRAINT `fk_lead_status` FOREIGN KEY (`lead_status_cat`) REFERENCES `lead_status` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
