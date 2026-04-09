CREATE DATABASE  IF NOT EXISTS `dispatch_mate_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `dispatch_mate_db`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: dispatch_mate_db
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `module_code` varchar(20) NOT NULL,
  `current_stock` int DEFAULT '0',
  `status` enum('Available','Out of Stock') DEFAULT 'Available',
  PRIMARY KEY (`book_id`),
  UNIQUE KEY `module_code` (`module_code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'Database Management Systems','COU3301',20,'Available'),(2,'Fundamentals of Programming','COU3304',50,'Available'),(3,'System Analysis and Design','COU3202',0,'Out of Stock'),(4,'Software Engineering','COU3303',0,'Out of Stock'),(5,'IT Organization','SU3201',30,'Available'),(6,'Fundamentals of Information Systems','ISU3300',0,'Out of Stock');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restock_alerts`
--

DROP TABLE IF EXISTS `restock_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restock_alerts` (
  `alert_id` int NOT NULL AUTO_INCREMENT,
  `student_reg_number` varchar(20) DEFAULT NULL,
  `book_id` int DEFAULT NULL,
  `alert_status` enum('Pending','Notified') DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`alert_id`),
  KEY `student_reg_number` (`student_reg_number`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `restock_alerts_ibfk_1` FOREIGN KEY (`student_reg_number`) REFERENCES `students` (`reg_number`) ON DELETE CASCADE,
  CONSTRAINT `restock_alerts_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restock_alerts`
--

LOCK TABLES `restock_alerts` WRITE;
/*!40000 ALTER TABLE `restock_alerts` DISABLE KEYS */;
INSERT INTO `restock_alerts` VALUES (1,'526774619',1,'Pending','2026-04-09 16:54:16'),(2,'426783622',1,'Pending','2026-04-09 16:54:16'),(3,'726775416',2,'Pending','2026-04-09 16:54:16');
/*!40000 ALTER TABLE `restock_alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` enum('Admin','Staff') DEFAULT 'Staff',
  `password_hash` varchar(255) NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'user1','admin@ousl.lk','Admin','01'),(2,'user2','user@ousl.lk','Staff','02');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_enrollments`
--

DROP TABLE IF EXISTS `student_enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_enrollments` (
  `enrollment_id` int NOT NULL AUTO_INCREMENT,
  `student_reg_number` varchar(20) DEFAULT NULL,
  `module_code` varchar(20) DEFAULT NULL,
  `is_collected` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`enrollment_id`),
  KEY `student_reg_number` (`student_reg_number`),
  KEY `module_code` (`module_code`),
  CONSTRAINT `student_enrollments_ibfk_1` FOREIGN KEY (`student_reg_number`) REFERENCES `students` (`reg_number`) ON DELETE CASCADE,
  CONSTRAINT `student_enrollments_ibfk_2` FOREIGN KEY (`module_code`) REFERENCES `books` (`module_code`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_enrollments`
--

LOCK TABLES `student_enrollments` WRITE;
/*!40000 ALTER TABLE `student_enrollments` DISABLE KEYS */;
INSERT INTO `student_enrollments` VALUES (1,'526774619','COU3304',0),(2,'526774619','COU3303',0),(3,'526774276','COU3304',1),(4,'526774276','ISU3300',0),(5,'726775416','COU3202',1),(6,'226775413','COU3304',0);
/*!40000 ALTER TABLE `student_enrollments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `reg_number` varchar(20) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `academic_year` varchar(10) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  PRIMARY KEY (`reg_number`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES ('226775413','Devini Dilshara','devini12@gmail.com','26/27','user4'),('326775674','Malshani','s24007366@ousl.lk','26/27','user7'),('426783622','Dinesh Perera','dineshpererasmart5@gmail.com','26/27','user2'),('526774276','Purandi Sarasavi Thathsarani','s24007381@ousl.lk','26/27','user5'),('526774619','Hirusha Perera','hirushamalindra@1gmail.com','26/27','user1'),('726774259','Sajani Dewmini','s24007358@ousl.lk','26/27','user6'),('726775416','kavidu Kumara','s25008097@ousl.lk','26/27','user3');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_slots`
--

DROP TABLE IF EXISTS `time_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_slots` (
  `slot_id` int NOT NULL AUTO_INCREMENT,
  `slot_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `max_capacity` int NOT NULL,
  `current_bookings` int DEFAULT '0',
  PRIMARY KEY (`slot_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_slots`
--

LOCK TABLES `time_slots` WRITE;
/*!40000 ALTER TABLE `time_slots` DISABLE KEYS */;
INSERT INTO `time_slots` VALUES (1,'2026-05-12','09:00:00','10:00:00',30,0),(2,'2026-05-12','10:00:00','11:00:00',30,0),(3,'2026-05-12','11:00:00','11:45:00',15,0),(4,'2026-05-12','12:45:00','13:30:00',35,0),(5,'2026-05-12','13:30:00','14:30:00',30,0),(6,'2026-05-12','14:30:00','16:00:00',40,0);
/*!40000 ALTER TABLE `time_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `token_id` int NOT NULL AUTO_INCREMENT,
  `student_reg_number` varchar(20) DEFAULT NULL,
  `slot_id` int DEFAULT NULL,
  `token_string` varchar(100) NOT NULL,
  `is_used` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`token_id`),
  UNIQUE KEY `token_string` (`token_string`),
  KEY `student_reg_number` (`student_reg_number`),
  KEY `slot_id` (`slot_id`),
  CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`student_reg_number`) REFERENCES `students` (`reg_number`) ON DELETE CASCADE,
  CONSTRAINT `tokens_ibfk_2` FOREIGN KEY (`slot_id`) REFERENCES `time_slots` (`slot_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (1,'526774619',1,'TK-ABC-12345',0),(2,'426783622',2,'TK-XYZ-98765',0),(3,'726775416',3,'TK-LMN-54321',0);
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-09 23:08:05
