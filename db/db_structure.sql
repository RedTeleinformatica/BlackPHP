-- MySQL dump 10.19  Distrib 10.3.34-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: blackphp
-- ------------------------------------------------------
-- Server version	10.3.34-MariaDB-0+deb10u1

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
-- Table structure for table `app_actions`
--

DROP TABLE IF EXISTS `app_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_actions` (
  `action_id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `action_key` varchar(16) NOT NULL COMMENT 'Clave de la acción',
  `infinitive_verb` varchar(16) NOT NULL COMMENT 'Verbo en infinitivo',
  `past_verb` varchar(16) NOT NULL COMMENT 'Verbo en pasado',
  PRIMARY KEY (`action_id`),
  UNIQUE KEY `action_key` (`action_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Acciones a realizar sobre los diferentes elementos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_elements`
--

DROP TABLE IF EXISTS `app_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_elements` (
  `element_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'ID de la tabla',
  `element_key` varchar(16) NOT NULL COMMENT 'Clave del elemento',
  `element_name` varchar(32) NOT NULL COMMENT 'Nombre del elemento',
  `element_gender` char(1) NOT NULL COMMENT 'M: Masculino, F: Femenino',
  `element_number` char(1) NOT NULL COMMENT 'S: Singular, P: Plural',
  `unique_element` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Es un elemento único',
  `module_id` int(11) NOT NULL COMMENT 'ID del módulo',
  `method_name` varchar(32) NOT NULL COMMENT 'Nombre del método para ver detalle',
  PRIMARY KEY (`element_id`),
  UNIQUE KEY `element_key` (`element_key`),
  KEY `element_method` (`module_id`),
  CONSTRAINT `element_module` FOREIGN KEY (`module_id`) REFERENCES `app_modules` (`module_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Elementos de la aplicación para actividad del usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_installers`
--

DROP TABLE IF EXISTS `app_installers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_installers` (
  `installer_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la tabla',
  `installer_nickname` varchar(32) NOT NULL COMMENT 'Usuario',
  `installer_password` char(32) NOT NULL COMMENT 'Resumen de contraseña',
  `installer_name` varchar(128) NOT NULL COMMENT 'Nombre del instalador',
  `installer_phone` varchar(16) NOT NULL COMMENT 'Teléfono',
  `installer_email` varchar(64) NOT NULL COMMENT 'Correo electrónico',
  `creation_time` datetime NOT NULL COMMENT 'Hora y fecha de creación',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'Eliminado, inactivo, activo',
  PRIMARY KEY (`installer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Instaladores del sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_methods`
--

DROP TABLE IF EXISTS `app_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_methods` (
  `method_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la tabla',
  `module_id` int(11) NOT NULL COMMENT 'ID del módulo',
  `method_name` varchar(32) NOT NULL COMMENT 'Nombre del método',
  `method_url` varchar(32) NOT NULL COMMENT 'URL del método (Nombre de la función PHP)',
  `method_icon` varchar(32) NOT NULL COMMENT 'Ícono del método en el menú',
  `method_description` tinytext NOT NULL COMMENT 'Descripción del método',
  `default_order` tinyint(4) NOT NULL COMMENT 'Orden por defecto',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'Estado 0:inactivo, 1:activo',
  PRIMARY KEY (`method_id`),
  KEY `module_id` (`module_id`),
  CONSTRAINT `method_module` FOREIGN KEY (`module_id`) REFERENCES `app_modules` (`module_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Todos los métodos disponibles en el sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_modules`
--

DROP TABLE IF EXISTS `app_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_modules` (
  `module_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la tabla',
  `module_name` varchar(32) NOT NULL COMMENT 'Nombre del módulo',
  `module_url` varchar(32) NOT NULL COMMENT 'URL del módulo',
  `module_key` char(1) NOT NULL COMMENT 'Tecla de acceso rápido',
  `module_description` tinytext NOT NULL COMMENT 'Descripción del módulo',
  `default_order` tinyint(4) NOT NULL COMMENT 'Orden por defecto',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'Estado 0:inactivo, 1:activo',
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Todos los módulos disponibles en el sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_themes`
--

DROP TABLE IF EXISTS `app_themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_themes` (
  `theme_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la tabla',
  `theme_name` varchar(32) NOT NULL COMMENT 'Nombre del tema',
  `theme_url` varchar(16) NOT NULL COMMENT 'Nombre de la carpeta pública',
  PRIMARY KEY (`theme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Temas (estilos) del sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `browsers`
--

DROP TABLE IF EXISTS `browsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `browsers` (
  `browser_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la tabla',
  `user_agent` varchar(255) NOT NULL COMMENT 'Cadena completa User Agent enviada por el navegador',
  `browser_name` varchar(16) NOT NULL COMMENT 'Nombre del navegador',
  `browser_version` varchar(16) NOT NULL COMMENT 'Versión del navegador',
  `platform` varchar(16) NOT NULL COMMENT 'Sistema operativo',
  `creation_user` int(11) NOT NULL COMMENT 'Primer usuario que lo registra',
  `creation_time` datetime NOT NULL COMMENT 'Hora y fecha de registro',
  PRIMARY KEY (`browser_id`),
  UNIQUE KEY `user_agent` (`user_agent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Navegadores con los que se ha accedido';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entities`
--

DROP TABLE IF EXISTS `entities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entities` (
  `entity_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la tabla',
  `entity_name` varchar(64) NOT NULL COMMENT 'Nombre de la empresa',
  `entity_slogan` varchar(128) NOT NULL COMMENT 'Eslogan de la empresa',
  `admin_user` int(11) DEFAULT NULL COMMENT 'Usuario principal (Superadministrador)',
  `entity_date` date NOT NULL COMMENT 'Fecha actual de operaciones (En caso que difiera del sistema)',
  `entity_begin` date NOT NULL COMMENT 'Fecha de inicio de las operaciones',
  `entity_subdomain` varchar(32) DEFAULT NULL COMMENT 'Subdominio (Para funcionamiento en línea)',
  `sys_name` varchar(32) NOT NULL COMMENT 'Nombre de la distribución del sistema',
  `default_locale` char(5) DEFAULT NULL COMMENT 'Idioma por defecto de la entidad',
  `creation_installer` int(11) DEFAULT NULL COMMENT 'ID del usuario que instaló el sistema',
  `creation_time` datetime NOT NULL,
  `edition_installer` int(11) DEFAULT NULL,
  `installer_edition_time` datetime NOT NULL,
  `edition_user` int(11) DEFAULT NULL,
  `user_edition_time` datetime DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `comp_subdomain` (`entity_subdomain`),
  KEY `company_creator` (`creation_installer`),
  KEY `company_editor` (`edition_installer`),
  CONSTRAINT `company_creator` FOREIGN KEY (`creation_installer`) REFERENCES `app_installers` (`installer_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `company_editor` FOREIGN KEY (`edition_installer`) REFERENCES `app_installers` (`installer_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Negocios, empresas y compañías que utilizarán el sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entity_methods`
--

DROP TABLE IF EXISTS `entity_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_methods` (
  `emethod_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la tabla',
  `entity_id` int(11) NOT NULL COMMENT 'ID de la empresa',
  `method_id` int(11) NOT NULL COMMENT 'ID del método',
  `method_order` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'Orden en el que aoparecerá el método en el menú',
  `creation_time` datetime NOT NULL,
  `edition_time` datetime NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`emethod_id`),
  UNIQUE KEY `comp_method` (`entity_id`,`method_id`),
  KEY `method_id` (`method_id`),
  CONSTRAINT `cmethod_company` FOREIGN KEY (`entity_id`) REFERENCES `entities` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cmethod_method` FOREIGN KEY (`method_id`) REFERENCES `app_methods` (`method_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Métodos habilitados para cada empresa';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entity_modules`
--

DROP TABLE IF EXISTS `entity_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_modules` (
  `emodule_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la tabla',
  `entity_id` int(11) NOT NULL COMMENT 'ID de la empresa',
  `module_id` int(11) NOT NULL COMMENT 'ID del módulo',
  `module_order` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'Ubicación del módulo en el menú',
  `creation_time` datetime NOT NULL,
  `edition_time` datetime NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`emodule_id`),
  KEY `comp_id` (`entity_id`),
  KEY `module_id` (`module_id`),
  CONSTRAINT `cmodule_company` FOREIGN KEY (`entity_id`) REFERENCES `entities` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cmodule_module` FOREIGN KEY (`module_id`) REFERENCES `app_modules` (`module_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Módulos habilitados para cada empresa';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_logs`
--

DROP TABLE IF EXISTS `user_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_logs` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la tabla',
  `user_id` int(11) NOT NULL COMMENT 'ID del usuario',
  `element_id` smallint(6) NOT NULL COMMENT 'ID del tipo de elemento',
  `action_id` tinyint(4) NOT NULL COMMENT 'Acción realizada',
  `date_time` datetime NOT NULL COMMENT 'Hora y fecha',
  `element_link` int(11) NOT NULL COMMENT 'Enlace al elemento en cuestión',
  PRIMARY KEY (`log_id`),
  KEY `log_user` (`user_id`),
  KEY `log_element` (`element_id`),
  KEY `log_action` (`action_id`),
  CONSTRAINT `log_action` FOREIGN KEY (`action_id`) REFERENCES `app_actions` (`action_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `log_element` FOREIGN KEY (`element_id`) REFERENCES `app_elements` (`element_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `log_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Registro de actividades del usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_methods`
--

DROP TABLE IF EXISTS `user_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_methods` (
  `umethod_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la tabla',
  `user_id` int(11) NOT NULL COMMENT 'ID del usuario',
  `method_id` int(11) NOT NULL COMMENT 'ID del método',
  `access_type` tinyint(3) unsigned NOT NULL DEFAULT 255 COMMENT 'Tipo de acceso',
  `creation_user` int(11) NOT NULL,
  `creation_time` datetime NOT NULL,
  `edition_user` int(11) NOT NULL,
  `edition_time` datetime NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`umethod_id`),
  KEY `umethod_method` (`method_id`),
  KEY `umethod_user` (`user_id`),
  CONSTRAINT `umethod_method` FOREIGN KEY (`method_id`) REFERENCES `app_methods` (`method_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `umethod_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Acceso de los usuarios a los métodos de la aplicación';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_modules`
--

DROP TABLE IF EXISTS `user_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_modules` (
  `umodule_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la tabla',
  `module_id` int(11) NOT NULL COMMENT 'ID del módulo',
  `user_id` int(11) NOT NULL COMMENT 'ID del usuario',
  `access_type` int(11) DEFAULT NULL COMMENT 'Tipo de acceso al módulo',
  `creation_user` int(11) NOT NULL,
  `creation_time` datetime NOT NULL,
  `edition_user` int(11) NOT NULL,
  `edition_time` datetime NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`umodule_id`),
  UNIQUE KEY `unique_access` (`umodule_id`,`module_id`),
  KEY `module_id` (`module_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `umodule_module` FOREIGN KEY (`module_id`) REFERENCES `app_modules` (`module_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `umodule_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Acceso a los usaurios por módulo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_recovery`
--

DROP TABLE IF EXISTS `user_recovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_recovery` (
  `urecovery_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la tabla',
  `user_id` int(11) NOT NULL COMMENT 'ID del usuario',
  `urecovery_code` char(32) NOT NULL COMMENT 'Código de recuperación',
  `expiration_time` datetime NOT NULL COMMENT 'Fecha y hora de vencimiento',
  `creation_user` int(11) NOT NULL,
  `creation_time` datetime NOT NULL,
  `edition_user` int(11) NOT NULL,
  `edition_time` datetime NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`urecovery_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `urecovery_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Recuperación de cuentas de usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_sessions`
--

DROP TABLE IF EXISTS `user_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_sessions` (
  `usession_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la tabla',
  `user_id` int(11) NOT NULL COMMENT 'ID del usuario',
  `branch_id` int(11) DEFAULT NULL COMMENT 'Sucursal en la que inició sesión',
  `ip_address` varchar(15) NOT NULL COMMENT 'Dirección IP desde donde se conecta',
  `browser_id` int(11) DEFAULT NULL COMMENT 'Navegador que usa',
  `date_time` datetime NOT NULL COMMENT 'Fecha y hora',
  PRIMARY KEY (`usession_id`),
  KEY `user_id` (`user_id`),
  KEY `browser_id` (`browser_id`),
  KEY `usession_branch` (`branch_id`),
  CONSTRAINT `usession_browser` FOREIGN KEY (`browser_id`) REFERENCES `browsers` (`browser_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `usession_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Registro de sesiones del usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la tabla',
  `entity_id` int(11) NOT NULL COMMENT 'ID de la empresa',
  `user_name` varchar(64) NOT NULL COMMENT 'Nombre completo del usuario',
  `nickname` varchar(32) DEFAULT NULL COMMENT 'Usuario para inicio de sesión',
  `email` varchar(64) DEFAULT NULL COMMENT 'Correo electrónico',
  `password` char(32) NOT NULL COMMENT 'Contraseña',
  `theme_id` int(11) DEFAULT 1 COMMENT 'Tema de visualización del usuario',
  `locale` char(5) DEFAULT NULL COMMENT 'Idioma del usuario',
  `creation_user` int(11) NOT NULL,
  `creation_time` datetime NOT NULL,
  `edition_user` int(11) NOT NULL,
  `edition_time` datetime NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `comp_nickname` (`entity_id`,`nickname`),
  UNIQUE KEY `comp_email` (`entity_id`,`email`),
  KEY `theme_id` (`theme_id`),
  CONSTRAINT `user_company` FOREIGN KEY (`entity_id`) REFERENCES `entities` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_theme` FOREIGN KEY (`theme_id`) REFERENCES `app_themes` (`theme_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
