-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: library_management
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `adminId` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `role` enum('Super Admin','Admin','Moderator') DEFAULT 'Admin',
  `permissions` json DEFAULT NULL,
  `isActive` tinyint(1) DEFAULT '1',
  `lastLogin` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `adminId` (`adminId`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'ADMIN001','testadmin','$2a$12$Hiuonil9woc.NO.NEPfOZuEyO1e12Z./timvq9MdaRLTrzRT99nbO','admin@test.com','Test','Admin','Admin','[]',1,'2025-07-25 20:03:46','2025-07-25 20:03:37','2025-07-25 20:03:46');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `genre` varchar(255) NOT NULL,
  `description` text,
  `publishedYear` int NOT NULL,
  `isbn` varchar(255) NOT NULL,
  `coverImage` varchar(255) DEFAULT NULL,
  `pdfUrl` varchar(255) DEFAULT NULL,
  `hasEbook` tinyint(1) DEFAULT '0',
  `availableCopies` int NOT NULL DEFAULT '1',
  `totalCopies` int NOT NULL DEFAULT '1',
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `approvedAt` datetime DEFAULT NULL,
  `approvedBy` int DEFAULT NULL,
  `donatedBy` int DEFAULT NULL,
  `borrowedBy` json DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `isbn` (`isbn`),
  KEY `approvedBy` (`approvedBy`),
  KEY `donatedBy` (`donatedBy`),
  CONSTRAINT `books_ibfk_1` FOREIGN KEY (`approvedBy`) REFERENCES `admins` (`id`),
  CONSTRAINT `books_ibfk_2` FOREIGN KEY (`donatedBy`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'To Kill a Mockingbird','Harper Lee','Fiction',NULL,1960,'978-0-06-112008-4',NULL,NULL,0,1,1,'pending',NULL,NULL,NULL,NULL,'2025-07-26 04:15:53','2025-07-26 04:15:53'),(2,'1984','George Orwell','Dystopian',NULL,1949,'978-0-452-28423-4',NULL,NULL,0,1,1,'pending',NULL,NULL,NULL,NULL,'2025-07-26 04:15:53','2025-07-26 04:15:53'),(3,'Pride and Prejudice','Jane Austen','Romance',NULL,1813,'978-0-14-143951-8',NULL,NULL,0,1,1,'pending',NULL,NULL,NULL,NULL,'2025-07-26 04:15:53','2025-07-26 04:15:53');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donations`
--

DROP TABLE IF EXISTS `donations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `donationId` varchar(50) NOT NULL,
  `donorId` int NOT NULL,
  `bookTitle` varchar(255) NOT NULL,
  `bookAuthor` varchar(255) NOT NULL,
  `bookIsbn` varchar(20) DEFAULT NULL,
  `bookGenre` varchar(100) NOT NULL,
  `bookCondition` enum('New','Like New','Good','Fair','Poor') NOT NULL,
  `bookDescription` text,
  `bookImages` json DEFAULT NULL,
  `bookPublishedYear` int DEFAULT NULL,
  `bookLanguage` varchar(50) DEFAULT 'Hindi',
  `status` enum('PENDING','UNDER_REVIEW','APPROVED','REJECTED','ADDED_TO_LIBRARY') DEFAULT 'PENDING',
  `submissionDate` datetime DEFAULT NULL,
  `reviewDate` datetime DEFAULT NULL,
  `reviewedById` int DEFAULT NULL,
  `reviewNotes` text,
  `rejectionReason` text,
  `estimatedValue` decimal(10,2) DEFAULT '0.00',
  `pickupDetails` json DEFAULT NULL,
  `donorPreferences` json DEFAULT NULL,
  `libraryBookId` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `donationId` (`donationId`),
  KEY `donorId` (`donorId`),
  KEY `reviewedById` (`reviewedById`),
  KEY `libraryBookId` (`libraryBookId`),
  CONSTRAINT `donations_ibfk_1` FOREIGN KEY (`donorId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `donations_ibfk_2` FOREIGN KEY (`reviewedById`) REFERENCES `admins` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `donations_ibfk_3` FOREIGN KEY (`libraryBookId`) REFERENCES `books` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donations`
--

LOCK TABLES `donations` WRITE;
/*!40000 ALTER TABLE `donations` DISABLE KEYS */;
INSERT INTO `donations` VALUES (14,'DON-1753518076153-rybtdbxr0',3,'Test Book','Test Author',NULL,'Fiction','Good','Test description','[]',NULL,'Hindi','PENDING','2025-07-26 08:21:16',NULL,NULL,'','',0.00,'{\"pickupDate\": null, \"pickupStatus\": \"PENDING\", \"pickupAddress\": {\"city\": \"\", \"state\": \"\", \"street\": \"\", \"zipCode\": \"\"}, \"isPickupRequired\": false}','{\"anonymousDonation\": false, \"taxReceiptRequired\": false, \"certificateRequired\": true}',NULL,'2025-07-26 08:21:16','2025-07-26 08:21:16'),(15,'DON-1753518196769-n8ksatjm2',3,'Atomic Habit','robert d jr',NULL,'Literature','New','Mobile: 8520852052, ISBN: 7419634152520','[]',NULL,'Hindi','PENDING','2025-07-26 08:23:16',NULL,NULL,'','',0.00,'{\"pickupDate\": null, \"pickupStatus\": \"PENDING\", \"pickupAddress\": {\"city\": \"\", \"state\": \"\", \"street\": \"\", \"zipCode\": \"\"}, \"isPickupRequired\": false}','{\"anonymousDonation\": false, \"taxReceiptRequired\": false, \"certificateRequired\": true}',NULL,'2025-07-26 08:23:16','2025-07-26 08:23:16');
/*!40000 ALTER TABLE `donations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donors`
--

DROP TABLE IF EXISTS `donors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `donated_books` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donors`
--

LOCK TABLES `donors` WRITE;
/*!40000 ALTER TABLE `donors` DISABLE KEYS */;
/*!40000 ALTER TABLE `donors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) DEFAULT 'user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` varchar(50) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) DEFAULT 'employee',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `email` varchar(255) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text,
  `membershipType` enum('Basic','Premium','Student','Faculty') DEFAULT 'Basic',
  `isActive` tinyint(1) DEFAULT '1',
  `joinDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `userId` (`userId`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,'admin123','\\/1MbS50IDJNYOuXA9kc3w0jd1FGRewTdk/.6vABogKga','admin','2025-07-22 07:45:35',NULL,NULL,NULL,NULL,NULL,'Basic',1,'2025-07-25 20:06:42','2025-07-25 20:06:42','2025-07-25 20:07:10'),(3,'USER001','testuser','$2a$12$eq8ZnP3mEraPLepNJ4XHLuMR7gXc3Yq97f5px5nXRGD8GzWhcp4Dm','employee','2025-07-25 20:07:22','user@test.com',NULL,NULL,NULL,'{\"street\":\"\",\"city\":\"\",\"state\":\"\",\"zipCode\":\"\"}','Basic',1,'2025-07-25 20:07:22','2025-07-25 20:07:22','2025-07-25 20:07:22'),(7,'karsh722','Karsh','7223053241','user','2025-07-26 07:25:48','karsh@library.com','Karsh',NULL,'7223053241',NULL,'Basic',1,'2025-07-26 07:25:48','2025-07-26 07:41:48','2025-07-26 07:25:48'),(9,'autouser876','Auto User','8765432109','user','2025-07-26 07:32:00','auto@example.com','Auto User',NULL,'8765432109',NULL,'Basic',1,'2025-07-26 07:32:00','2025-07-26 07:41:48','2025-07-26 07:32:00'),(10,'tanmay626','Tanmay Sahu','6261193015','user','2025-07-26 07:34:41','tanmay@gmail.com','Tanmay Sahu',NULL,'6261193015',NULL,'Basic',1,'2025-07-26 07:34:41','2025-07-26 07:41:48','2025-07-26 07:34:41');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-26 16:25:41
