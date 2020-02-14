/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 5.7.26 : Database - examen
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`examen` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `examen`;

/*Table structure for table `accesorios` */

DROP TABLE IF EXISTS `accesorios`;

CREATE TABLE `accesorios` (
  `ida` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  `idt` int(11) DEFAULT NULL,
  `costo` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `ide` int(11) DEFAULT NULL,
  PRIMARY KEY (`ida`),
  KEY `idt` (`idt`),
  KEY `ide` (`ide`),
  CONSTRAINT `accesorios_ibfk_1` FOREIGN KEY (`idt`) REFERENCES `tipoaccesorios` (`idt`),
  CONSTRAINT `accesorios_ibfk_2` FOREIGN KEY (`ide`) REFERENCES `especies` (`ide`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `accesorios` */

insert  into `accesorios`(`ida`,`nombre`,`idt`,`costo`,`cantidad`,`ide`) values 
(1,'A1',1,100,10,1),
(2,'A2',2,200,20,2),
(3,'A3',3,300,30,3),
(4,'A4',1,150,10,1),
(5,'A5',2,250,20,2),
(6,'A6',3,350,30,3),
(7,'A7',1,200,50,1);

/*Table structure for table `cirugias` */

DROP TABLE IF EXISTS `cirugias`;

CREATE TABLE `cirugias` (
  `idci` int(11) NOT NULL AUTO_INCREMENT,
  `idm` int(11) DEFAULT NULL,
  `ids` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `costo` int(11) DEFAULT NULL,
  PRIMARY KEY (`idci`),
  KEY `idm` (`idm`),
  KEY `ids` (`ids`),
  CONSTRAINT `cirugias_ibfk_1` FOREIGN KEY (`idm`) REFERENCES `mascotas` (`idm`),
  CONSTRAINT `cirugias_ibfk_2` FOREIGN KEY (`ids`) REFERENCES `servicios` (`ids`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `cirugias` */

insert  into `cirugias`(`idci`,`idm`,`ids`,`fecha`,`costo`) values 
(1,1,1,'2020-01-01',1000),
(2,3,2,'2020-10-10',2000),
(3,5,1,'2020-05-10',1500),
(4,7,2,'2020-08-09',700),
(5,2,1,'2020-09-10',1900);

/*Table structure for table `clientes` */

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `idc` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  `sexo` varchar(1) DEFAULT NULL,
  `tipo` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`idc`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `clientes` */

insert  into `clientes`(`idc`,`nombre`,`sexo`,`tipo`) values 
(1,'Paty','F','A'),
(2,'Laura','F','B'),
(3,'Memo','M','B'),
(4,'Rodrigo','M','A');

/*Table structure for table `especies` */

DROP TABLE IF EXISTS `especies`;

CREATE TABLE `especies` (
  `ide` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`ide`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `especies` */

insert  into `especies`(`ide`,`nombre`) values 
(1,'Gato'),
(2,'Perro'),
(3,'Ave');

/*Table structure for table `mascotas` */

DROP TABLE IF EXISTS `mascotas`;

CREATE TABLE `mascotas` (
  `idm` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  `ide` int(11) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `color` varchar(30) DEFAULT NULL,
  `idc` int(11) DEFAULT NULL,
  PRIMARY KEY (`idm`),
  KEY `ide` (`ide`),
  KEY `idc` (`idc`),
  CONSTRAINT `mascotas_ibfk_1` FOREIGN KEY (`ide`) REFERENCES `especies` (`ide`),
  CONSTRAINT `mascotas_ibfk_2` FOREIGN KEY (`idc`) REFERENCES `clientes` (`idc`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `mascotas` */

insert  into `mascotas`(`idm`,`nombre`,`ide`,`edad`,`color`,`idc`) values 
(1,'M1',1,2,'cafe',1),
(2,'M2',2,3,'cafe',2),
(3,'M3',3,1,'negro',3),
(4,'M4',1,2,'negro',4),
(5,'M5',2,1,'blanco',1),
(6,'M6',3,2,'blanco',2),
(7,'M7',1,3,'verde',3);

/*Table structure for table `servicios` */

DROP TABLE IF EXISTS `servicios`;

CREATE TABLE `servicios` (
  `ids` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`ids`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `servicios` */

insert  into `servicios`(`ids`,`nombre`) values 
(1,'vacunas'),
(2,'cirugia');

/*Table structure for table `tipoaccesorios` */

DROP TABLE IF EXISTS `tipoaccesorios`;

CREATE TABLE `tipoaccesorios` (
  `idt` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idt`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `tipoaccesorios` */

insert  into `tipoaccesorios`(`idt`,`nombre`) values 
(1,'collares'),
(2,'ropa'),
(3,'comida');

/*Table structure for table `ventas` */

DROP TABLE IF EXISTS `ventas`;

CREATE TABLE `ventas` (
  `idv` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `idc` int(11) DEFAULT NULL,
  `ida` int(11) DEFAULT NULL,
  `cant` int(11) DEFAULT NULL,
  `costo` int(11) DEFAULT NULL,
  PRIMARY KEY (`idv`),
  KEY `idc` (`idc`),
  KEY `ida` (`ida`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`idc`) REFERENCES `clientes` (`idc`),
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`ida`) REFERENCES `accesorios` (`ida`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `ventas` */

insert  into `ventas`(`idv`,`fecha`,`idc`,`ida`,`cant`,`costo`) values 
(1,'2020-10-10',1,1,10,100),
(2,'2020-05-10',2,2,2,200),
(3,'2020-07-10',3,3,5,700),
(4,'2020-08-05',4,4,7,200),
(5,'2020-06-10',1,5,8,300),
(6,'2020-07-10',2,6,9,300),
(7,'2020-03-10',3,7,12,200);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
