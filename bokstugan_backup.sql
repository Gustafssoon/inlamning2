-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: bokstugan
-- ------------------------------------------------------
-- Server version	9.5.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

-- SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '0942ceab-bf9d-11f0-bbc4-e073e728ed24:1-307';

--
-- Table structure for table `bestallningar`
--

DROP TABLE IF EXISTS `bestallningar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bestallningar` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `KundID` int NOT NULL,
  `Datum` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Totalbelopp` decimal(10,2) NOT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `KundID` (`KundID`),
  CONSTRAINT `bestallningar_ibfk_1` FOREIGN KEY (`KundID`) REFERENCES `kunder` (`KundID`),
  CONSTRAINT `bestallningar_chk_1` CHECK ((`Totalbelopp` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bestallningar`
--

LOCK TABLES `bestallningar` WRITE;
/*!40000 ALTER TABLE `bestallningar` DISABLE KEYS */;
INSERT INTO `bestallningar` VALUES (1,1,'2024-02-29 23:00:00',328.00),(2,1,'2024-03-14 23:00:00',398.00),(3,2,'2024-03-04 23:00:00',159.00),(4,3,'2024-03-09 23:00:00',499.00),(5,1,'2024-03-19 23:00:00',499.00),(6,4,'2024-03-21 23:00:00',199.00),(7,2,'2024-03-24 23:00:00',129.00),(8,1,'2024-03-27 23:00:00',149.00);
/*!40000 ALTER TABLE `bestallningar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bocker`
--

DROP TABLE IF EXISTS `bocker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bocker` (
  `BokID` int NOT NULL AUTO_INCREMENT,
  `ISBN` bigint NOT NULL,
  `Titel` varchar(200) NOT NULL,
  `Forfattare` varchar(100) NOT NULL,
  `Pris` decimal(10,2) NOT NULL,
  `Lagerstatus` int NOT NULL,
  PRIMARY KEY (`BokID`),
  UNIQUE KEY `ISBN` (`ISBN`),
  CONSTRAINT `bocker_chk_1` CHECK ((`Pris` > 0)),
  CONSTRAINT `bocker_chk_2` CHECK ((`Lagerstatus` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bocker`
--

LOCK TABLES `bocker` WRITE;
/*!40000 ALTER TABLE `bocker` DISABLE KEYS */;
INSERT INTO `bocker` VALUES (1,9780553296129,'Star Wars: Heir to the Empire','Timothy Zahn',129.00,8),(2,9780470835847,'The Game','Ken Dryden',159.00,4),(3,9780132350884,'Clean Code: A Handbook of Agile Software Craftsmanship','Robert C. Martin',499.00,6),(4,9780261102217,'The Hobbit','J.R.R. Tolkien',199.00,21),(5,9780439136365,'Harry Potter and the Prisoner of Azkaban','J.K. Rowling',149.00,17),(6,9780743211383,'Band of Brothers','Stephen E. Ambrose',179.00,10),(7,9780385737944,'The Maze Runner','James Dashner',159.00,16);
/*!40000 ALTER TABLE `bocker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kunder`
--

DROP TABLE IF EXISTS `kunder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kunder` (
  `KundID` int NOT NULL AUTO_INCREMENT,
  `Namn` varchar(100) NOT NULL,
  `Epost` varchar(100) NOT NULL,
  `Telefon` varchar(50) NOT NULL,
  `Adress` varchar(255) NOT NULL,
  PRIMARY KEY (`KundID`),
  UNIQUE KEY `Epost` (`Epost`),
  KEY `idx_epost` (`Epost`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kunder`
--

LOCK TABLES `kunder` WRITE;
/*!40000 ALTER TABLE `kunder` DISABLE KEYS */;
INSERT INTO `kunder` VALUES (1,'Anna Andersson','anna.andersson@mail.com','070-1111111','Stora vägen 1, 111 11 Stockholm'),(2,'Bengt Bengtsson','bengt@mail.com','070-2222222','Lilla vägen 2, 222 22 Göteborg'),(3,'Carl Carlsson','carl@mail.com','070-3333333','Norra vägen 3, 333 33 Malmö'),(4,'Didrik Didriksson','didrik@mail.com','070-4444444','Södra vägen 4, 444 44 Kalmar'),(5,'Erik Eriksson','erik@mail.com','070-5555555','Östra vägen 5, 555 55 Nybro');
/*!40000 ALTER TABLE `kunder` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `logga_ny_kund` AFTER INSERT ON `kunder` FOR EACH ROW BEGIN
    INSERT INTO KundLogg (KundID, Namn)
    VALUES (NEW.KundID, NEW.Namn);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `kundlogg`
--

DROP TABLE IF EXISTS `kundlogg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kundlogg` (
  `LoggID` int NOT NULL AUTO_INCREMENT,
  `KundID` int NOT NULL,
  `Namn` varchar(100) NOT NULL,
  `RegistreradDatum` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`LoggID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kundlogg`
--

LOCK TABLES `kundlogg` WRITE;
/*!40000 ALTER TABLE `kundlogg` DISABLE KEYS */;
INSERT INTO `kundlogg` VALUES (1,1,'Anna Andersson','2026-03-16 21:16:07'),(2,2,'Bengt Bengtsson','2026-03-16 21:16:07'),(3,3,'Carl Carlsson','2026-03-16 21:16:07'),(4,4,'Didrik Didriksson','2026-03-16 21:16:07'),(5,5,'Erik Eriksson','2026-03-16 21:16:07');
/*!40000 ALTER TABLE `kundlogg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderrader`
--

DROP TABLE IF EXISTS `orderrader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderrader` (
  `OrderradID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int NOT NULL,
  `BokID` int NOT NULL,
  `Antal` int NOT NULL,
  `Pris` decimal(10,2) NOT NULL,
  PRIMARY KEY (`OrderradID`),
  KEY `OrderID` (`OrderID`),
  KEY `BokID` (`BokID`),
  CONSTRAINT `orderrader_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `bestallningar` (`OrderID`),
  CONSTRAINT `orderrader_ibfk_2` FOREIGN KEY (`BokID`) REFERENCES `bocker` (`BokID`),
  CONSTRAINT `orderrader_chk_1` CHECK ((`Antal` > 0)),
  CONSTRAINT `orderrader_chk_2` CHECK ((`Pris` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderrader`
--

LOCK TABLES `orderrader` WRITE;
/*!40000 ALTER TABLE `orderrader` DISABLE KEYS */;
INSERT INTO `orderrader` VALUES (1,1,1,1,129.00),(2,1,4,1,199.00),(3,2,4,2,199.00),(4,3,2,1,159.00),(5,4,3,1,499.00),(6,5,3,1,499.00),(7,6,4,1,199.00),(8,7,1,1,129.00),(9,8,5,1,149.00);
/*!40000 ALTER TABLE `orderrader` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `minska_lager` AFTER INSERT ON `orderrader` FOR EACH ROW BEGIN
    UPDATE Bocker
    SET Lagerstatus = Lagerstatus - NEW.Antal
    WHERE BokID = NEW.BokID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'bokstugan'
--
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-16 22:40:40
