-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: system_recommender_final
-- ------------------------------------------------------
-- Server version	5.7.22-0ubuntu18.04.1

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add permission',3,'add_permission'),(8,'Can change permission',3,'change_permission'),(9,'Can delete permission',3,'delete_permission'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add artwork',7,'add_artwork'),(20,'Can change artwork',7,'change_artwork'),(21,'Can delete artwork',7,'delete_artwork'),(22,'Can add author',8,'add_author'),(23,'Can change author',8,'change_author'),(24,'Can delete author',8,'delete_author'),(25,'Can add gender',9,'add_gender'),(26,'Can change gender',9,'change_gender'),(27,'Can delete gender',9,'delete_gender'),(28,'Can add user rating',10,'add_userrating'),(29,'Can change user rating',10,'change_userrating'),(30,'Can delete user rating',10,'delete_userrating');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$TPRcuLrmCISh$h/iv9ew27gGvrrB1L5HSRU9fD8XFAFZ0TcLvFKuT0VQ=',NULL,1,'josdavidmo','','','josdavidmo@gmail.com',1,1,'2018-06-27 02:31:02.996592');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(2,'auth','group'),(3,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(7,'system_recommender','artwork'),(8,'system_recommender','author'),(9,'system_recommender','gender'),(10,'system_recommender','userrating');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2018-06-27 02:10:26.816863'),(2,'auth','0001_initial','2018-06-27 02:10:38.827340'),(3,'admin','0001_initial','2018-06-27 02:10:41.466015'),(4,'admin','0002_logentry_remove_auto_add','2018-06-27 02:10:41.645492'),(5,'contenttypes','0002_remove_content_type_name','2018-06-27 02:10:43.132332'),(6,'auth','0002_alter_permission_name_max_length','2018-06-27 02:10:44.194664'),(7,'auth','0003_alter_user_email_max_length','2018-06-27 02:10:45.400127'),(8,'auth','0004_alter_user_username_opts','2018-06-27 02:10:45.479646'),(9,'auth','0005_alter_user_last_login_null','2018-06-27 02:10:46.184161'),(10,'auth','0006_require_contenttypes_0002','2018-06-27 02:10:46.228559'),(11,'auth','0007_alter_validators_add_error_messages','2018-06-27 02:10:46.290839'),(12,'auth','0008_alter_user_username_max_length','2018-06-27 02:10:47.511833'),(13,'sessions','0001_initial','2018-06-27 02:10:48.273030'),(14,'system_recommender','0001_initial','2018-06-27 02:12:08.478334'),(15,'system_recommender','0002_userrating','2018-06-27 02:18:04.647471');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_recommender_artwork`
--

DROP TABLE IF EXISTS `system_recommender_artwork`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_recommender_artwork` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `url` varchar(200) NOT NULL,
  `author_id` int(11) NOT NULL,
  `gender_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `system_recommender_a_author_id_c9e4f2e3_fk_system_re` (`author_id`),
  KEY `system_recommender_a_gender_id_31353f5e_fk_system_re` (`gender_id`),
  CONSTRAINT `system_recommender_a_author_id_c9e4f2e3_fk_system_re` FOREIGN KEY (`author_id`) REFERENCES `system_recommender_author` (`id`),
  CONSTRAINT `system_recommender_a_gender_id_31353f5e_fk_system_re` FOREIGN KEY (`gender_id`) REFERENCES `system_recommender_gender` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_recommender_artwork`
--

LOCK TABLES `system_recommender_artwork` WRITE;
/*!40000 ALTER TABLE `system_recommender_artwork` DISABLE KEYS */;
INSERT INTO `system_recommender_artwork` VALUES (1,'Albumcaricaturas','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP1510_7.jpg',1,2),(2,'Año nuevo 1931','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP0425.jpg',1,2),(3,'Gulliver seguía durmiendo','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP0426.jpg',1,2),(4,'Instantánea','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP1368.jpg',1,2),(5,'Ley 99-1931','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP0430.jpg',1,2),(6,'Navidad','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP0429.jpg',1,2),(7,'Régimen administrativo','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP0427.jpg',1,2),(8,'Acontecimiento (Evènement)','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP3321.jpg',2,1),(9,'Mujeres en la roca','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP0409.jpg',2,1),(10,'Sin título','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP0435.jpg',2,1),(11,'Parque de la Independencia','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP2948.jpg',3,3),(12,'Paisaje','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP1777.jpg',3,3),(13,'Chircal','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP2945.jpg',3,3),(14,'Casa prisión de Antonio Nariño','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/default_images/generica_1_0.jpg',3,3),(15,'Baño rosado (Homenaje a Botticelli)','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP4861.jpg',4,5),(16,'Hecho un ocho (De la colección grabado en Colombia No.1)','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP0750.jpg',4,5),(17,'Amarillo creciente','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP3898.jpg',4,5),(18,'Tablero','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP1792.jpg',4,5),(19,'Autorretrato y pizarra','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP2293.jpg',4,5),(20,'Ángeles','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP1096.jpg',5,3),(21,'Cabeza de Cristo','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP1093.jpg',5,3),(22,'Dolorosa o Santa Teresa','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP1092.jpg',5,3),(23,'Obediencia, Huida a Egipto, Paciencia. (Tríptico)','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP1082.jpg',5,3),(24,'Un billar en la ciudad','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP1079.jpg',6,3),(25,'Un billar en la ciudad','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP1075.jpg',6,3),(26,'Un billar en la ciudad','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP1080.jpg',6,3),(27,'Sin título','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP1233.jpg',6,3),(28,'A la estatua del libertador (En la plaza mayor de Bogotá) (8)','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP1109.jpg',7,3),(29,'Domingo, Avenida Caracas','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP3175.jpg',7,3),(30,'Barro colorado','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP3176.jpg',7,3),(31,'La bella durmiente','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP3179.jpg',7,3),(32,'Autorretrato','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP3845.jpg',8,6),(33,'Tejados de Popayán','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP3966.jpg',8,6),(34,'Indios Cuna','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP3846.jpg',8,6),(35,'San Francisco de Asís','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP3834.jpg',8,6),(36,'Tejados de Cartagena','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP0240.jpg',8,6),(37,'Ventana','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP0766.jpg',9,4),(38,'Sin título (2)','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP0668.jpg',9,4),(39,'Sin título (9)','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP0675.jpg',9,4),(40,'Espacios vecinos (2)','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra//AP0407.jpg',9,4),(41,'Sin título','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP0607.jpg',10,4),(42,'Sin título','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP0610.jpg',10,4),(43,'Pájaro - Gárgola','http://www.banrepcultural.org/coleccion-de-arte-banco-de-la-republica/sites/default/files/obra/AP0279_0.jpg',10,4);
/*!40000 ALTER TABLE `system_recommender_artwork` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_recommender_author`
--

DROP TABLE IF EXISTS `system_recommender_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_recommender_author` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_recommender_author`
--

LOCK TABLES `system_recommender_author` WRITE;
/*!40000 ALTER TABLE `system_recommender_author` DISABLE KEYS */;
INSERT INTO `system_recommender_author` VALUES (1,'Ricardo','Rendón'),(2,'Roberto','Matta'),(3,'Roberto','Páramo'),(4,'Santiago','Cárdenas'),(5,'Santiago','Páramo'),(6,'Saturnio','Ramírez'),(7,'Sergio','Trujillo'),(8,'Sofía','Urrutía'),(9,'Umberto','Giangrandi'),(10,'Victor','Chab');
/*!40000 ALTER TABLE `system_recommender_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_recommender_gender`
--

DROP TABLE IF EXISTS `system_recommender_gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_recommender_gender` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_recommender_gender`
--

LOCK TABLES `system_recommender_gender` WRITE;
/*!40000 ALTER TABLE `system_recommender_gender` DISABLE KEYS */;
INSERT INTO `system_recommender_gender` VALUES (1,'Abstracto'),(2,'Expresionismo'),(3,'Realismo'),(4,'Abstracto'),(5,'Surrealismo'),(6,'Expresionismo');
/*!40000 ALTER TABLE `system_recommender_gender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_recommender_userrating`
--

DROP TABLE IF EXISTS `system_recommender_userrating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_recommender_userrating` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rating` int(11) NOT NULL,
  `artwork_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `system_recommender_u_artwork_id_59b9bc85_fk_system_re` (`artwork_id`),
  KEY `system_recommender_userrating_user_id_40adf0f0_fk_auth_user_id` (`user_id`),
  CONSTRAINT `system_recommender_u_artwork_id_59b9bc85_fk_system_re` FOREIGN KEY (`artwork_id`) REFERENCES `system_recommender_artwork` (`id`),
  CONSTRAINT `system_recommender_userrating_user_id_40adf0f0_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_recommender_userrating`
--

LOCK TABLES `system_recommender_userrating` WRITE;
/*!40000 ALTER TABLE `system_recommender_userrating` DISABLE KEYS */;
INSERT INTO `system_recommender_userrating` VALUES (1,10,1,1);
/*!40000 ALTER TABLE `system_recommender_userrating` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-03 21:25:49
