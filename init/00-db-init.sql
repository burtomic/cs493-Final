-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: tarpaulin
-- ------------------------------------------------------
-- Server version	5.7.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
  (0,'Admin','admin@businesses.com','$2a$08$Y00/JO/uN9n0dHKuudRX2eKksWMIHXDLzHWKuz/K67alAYsZRRike',"admin"),
  (1,'Nick Arzner','nick@block15.com','$2a$08$Y2IHnr/PU9tzG5HKrHGJH.zH3HAvlR5i5puD5GZ1sHA/mVrHKci72',"student"),
  (2,'Tori Lockwood','tori@robnetts.com','$2a$08$bAKRXPs6fUPhqjZy55TIeO1e.aXud4LD81awrYncaCKJoMsg/s0c.',"student"),
  (3,'Joel Rea','joel@lickspigot.com','$2a$08$WvRkJm.bz3zoRnmA.aQZBewLopoe00nA4qbzbnLyS4eRbm2MFNkMO',"instructor"),
  (4,'The Owners','owners@firstalt.coop','$2a$08$FBStm3plzBCnh/MPIUsJ0.f7kJkp6aH47haXHb3HY.Gfygan7e8He',"instructor"),
  (5,'Kim Marchesi','kim@localboyzhawaiiancafe.com','$2a$08$q8njvTTel9JDR.BQbb1cD.XL73CR.QCOXLnofdpd9orbv0dzWGir.',"student"),
  (6,'William McCanless','william@interzoneorganic1','$2a$08$U7IXbbolDIk0SRlmH/dnT.FBCvf.EMvorShGlM65XeQFr./P0rhqe',"student"),
  (7,'Paul Turner','paul@darksidecinema.com','$2a$08$Kb1f8JbT/9kl.wRuRsRoYO19ddMcc79zXvfUcwchJJ1qHxVMDJN1K',"student"),
  (8,'Allan Stuart','allan@allanscoffee.com','$2a$08$ALw6f6NIpdptAUhhezTjhezjjnMLcbBP/uRnqVCwYNSWBdno6y2I6',"student"),
  (9,'Winco Employees','employees@wincofoods.com','$2a$08$64je8REF7I4j4bQuJKIdXO09VkCXJqoaF18znHs/a3zuKi/olDR/S',"student"),
  (10,'Philip Wilson','philib@bookbin.com','$2a$08$Ev.K7sU3yWrCUECK2O2a5.eA8mbvVEImv/EyYka1yhRxQFKIbxrfS',"student"),
  (11,'Fred Meyer','fred@fredmeyer.com','$2a$08$ljdJ4mrSIEXsaiEMu29xUuEFAOj43gL5rcR7wCq8Rl2z/bqzf.xuC',"student"),
  (12,'Mike Easter','mike@cyclotopia.com','$2a$08$Apk5L0bDogb4G6ZtoKluPeZXCxye0qdNZCah9TJX9QvdRqZ5hwWAy',"student"),
  (13,'Casey Collett','casey@oregoncoffeeandtea.com','$2a$08$5SL3bkbe5S1WnE6rWciiX.9HAfXG/UGbZAQU7K0S4XTNGIHapPBy2',"student"),
  (14,'John Semadeni','john@corvalliscycleryinc.com','$2a$08$xIku71t6OFFN9Ztil1Kh2eQWk/0lC8C.UThx3PwAwYCSMxdzpPhTO',"student"),
  (15,'Alex Spaeth','alex@spaethlumber.com','$2a$08$H9dDFONytVUgh2ZcCQlHL.8uP6RricbtoCk2vsr/roTBtGkYLUivS',"student"),
  (16,'Tristan James','tristan@newmorningbakery.com','$2a$08$pJFEMJNiTa7azhokPUnXZusS6NMqT3eBJE45sX6Kli380PZoM2nje',"student")
  ;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `number` mediumint(9) NOT NULL,
  `title` varchar(255) NOT NULL,
  `term` varchar(255) NOT NULL,
  `instructorId` mediumint(9) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`number`),
  CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`instructorId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES
  (1,'493', "Cloud Development","wt20",3),
  (2,'444', "Operating Systems II", "wt20",3),
  (3,'463', "Senior Capstone", "wt20",3),
  (4,'475', "Parallel Programming","wt20",4)
  ;
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignments`
--

DROP TABLE IF EXISTS `assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignments` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `courseId` mediumint(9) NOT NULL,
  `title` varchar(255) NOT NULL,
  `points` mediumint(9) NOT NULL,
  `due` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `assignments_ibfk_1` FOREIGN KEY (`courseId`) REFERENCES `courses` (`number`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignments`
--

LOCK TABLES `assignments` WRITE;
/*!40000 ALTER TABLE `assignments` DISABLE KEYS */;
INSERT INTO `assignments` VALUES
  (1,NULL,11,15),
  (2,NULL,7,2),
  (3,'Hops',2,3),
  (4,'Sticky Hands',14,18),
  (5,NULL,5,2),
  (6,'Popcorn!',11,7),
  (7,'This is my dinner.',8,5),
  (8,'Big fermentor',5,18),
  (9,'Cake!',6,16),
  (10,NULL,2,5);
/*!40000 ALTER TABLE `assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollment`
--

DROP TABLE IF EXISTS `enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enrollment` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `courseId` mediumint(9) NOT NULL,
  `userId` mediumint(9) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_userid` (`userid`),
  KEY `idx_businessid` (`businessid`),
  CONSTRAINT `enrollment_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `enrollment_ibfk_2` FOREIGN KEY (`courseId`) REFERENCES `courses` (`number`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment`
--

LOCK TABLES `enrollment` WRITE;
/*!40000 ALTER TABLE `enrollment` DISABLE KEYS */;
INSERT INTO `enrollment` VALUES
  (1,493,1),
  (2,475,1),
  (3,463,1),
  (4,444,1),
  (5,493,2),
  (6,444,13),
  (7,475,13),
  (8,475,2),
  (9,475,14),
  (10,444,14);
/*!40000 ALTER TABLE `enrollment` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `submissions`
--

DROP TABLE IF EXISTS `submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submissions` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `assignmentId` mediumint(9) NOT NULL,
  `studentId` mediumint(9) NOT NULL,
  `timestamp` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_assignmentId` (`assignmentId`),
  KEY `idx_studentId` (`studentId`),
  CONSTRAINT `submissions_ibfk_1` FOREIGN KEY (`studentId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `submissions_ibfk_2` FOREIGN KEY (`assignmentId`) REFERENCES `assignments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-16  6:47:05
