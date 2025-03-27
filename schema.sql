/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.11-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: localhost    Database: parkering25
-- ------------------------------------------------------
-- Server version	10.11.11-MariaDB-0+deb12u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `brukere`
--

DROP TABLE IF EXISTS `brukere`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `brukere` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `navn` varchar(100) NOT NULL,
  `epost` varchar(100) NOT NULL,
  `telefon` varchar(20) DEFAULT NULL,
  `registrert_dato` timestamp NULL DEFAULT current_timestamp(),
  `passord` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `epost` (`epost`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brukere`
--

LOCK TABLES `brukere` WRITE;
/*!40000 ALTER TABLE `brukere` DISABLE KEYS */;
INSERT INTO `brukere` VALUES
(1,'Erwan Barzic','erwan.barzic@gmail.com','46520996','2025-03-14 09:45:46',''),
(4,'Andreas Gutevall','andreas@example.com','112233445','2025-03-16 15:30:35',''),
(5,'Marius Bjurstrøm','marius@example.com','69696969','2025-03-16 15:31:22',''),
(6,'Teodor Meyer','teo@example.com','69696969','2025-03-16 15:32:22',''),
(7,'boss','test@test.com','32132151','2025-03-16 16:20:29',''),
(9,'arne ','arne@test.no','32142153','2025-03-16 17:14:08','');
/*!40000 ALTER TABLE `brukere` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kjøretøy`
--

DROP TABLE IF EXISTS `kjøretøy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `kjøretøy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bruker_id` int(11) NOT NULL,
  `registreringsnummer` varchar(20) NOT NULL,
  `merke` varchar(50) DEFAULT NULL,
  `modell` varchar(50) DEFAULT NULL,
  `elbil` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `registreringsnummer` (`registreringsnummer`),
  KEY `bruker_id` (`bruker_id`),
  CONSTRAINT `kjøretøy_ibfk_1` FOREIGN KEY (`bruker_id`) REFERENCES `brukere` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kjøretøy`
--

LOCK TABLES `kjøretøy` WRITE;
/*!40000 ALTER TABLE `kjøretøy` DISABLE KEYS */;
INSERT INTO `kjøretøy` VALUES
(1,1,'EL erwan','Tesla','Modell X',1);
/*!40000 ALTER TABLE `kjøretøy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parkeringshus`
--

DROP TABLE IF EXISTS `parkeringshus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `parkeringshus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `navn` varchar(100) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `antall_plasser` int(11) NOT NULL,
  `etasjer` int(11) NOT NULL,
  `opprettet_dato` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parkeringshus`
--

LOCK TABLES `parkeringshus` WRITE;
/*!40000 ALTER TABLE `parkeringshus` DISABLE KEYS */;
INSERT INTO `parkeringshus` VALUES
(1,'BoberPark','Høyskoleringen 3',10,1,'2025-03-14 10:13:18');
/*!40000 ALTER TABLE `parkeringshus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parkeringsplasser`
--

DROP TABLE IF EXISTS `parkeringsplasser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `parkeringsplasser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parkeringshus_id` int(11) NOT NULL,
  `plassnummer` varchar(10) NOT NULL,
  `etasje` int(11) NOT NULL,
  `er_opptatt` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `parkeringshus_id` (`parkeringshus_id`),
  CONSTRAINT `parkeringsplasser_ibfk_1` FOREIGN KEY (`parkeringshus_id`) REFERENCES `parkeringshus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parkeringsplasser`
--

LOCK TABLES `parkeringsplasser` WRITE;
/*!40000 ALTER TABLE `parkeringsplasser` DISABLE KEYS */;
INSERT INTO `parkeringsplasser` VALUES
(1,1,'1',1,0);
/*!40000 ALTER TABLE `parkeringsplasser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parkeringstransaksjoner`
--

DROP TABLE IF EXISTS `parkeringstransaksjoner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `parkeringstransaksjoner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kjøretøy_id` int(11) NOT NULL,
  `parkeringsplass_id` int(11) NOT NULL,
  `start_tidspunkt` timestamp NULL DEFAULT current_timestamp(),
  `slutt_tidspunkt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kjøretøy_id` (`kjøretøy_id`),
  KEY `parkeringsplass_id` (`parkeringsplass_id`),
  CONSTRAINT `parkeringstransaksjoner_ibfk_1` FOREIGN KEY (`kjøretøy_id`) REFERENCES `kjøretøy` (`id`) ON DELETE CASCADE,
  CONSTRAINT `parkeringstransaksjoner_ibfk_2` FOREIGN KEY (`parkeringsplass_id`) REFERENCES `parkeringsplasser` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parkeringstransaksjoner`
--

LOCK TABLES `parkeringstransaksjoner` WRITE;
/*!40000 ALTER TABLE `parkeringstransaksjoner` DISABLE KEYS */;
INSERT INTO `parkeringstransaksjoner` VALUES
(1,1,1,'2025-03-14 10:24:48','2025-03-14 10:25:30');
/*!40000 ALTER TABLE `parkeringstransaksjoner` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-27 11:34:53
