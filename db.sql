/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 5.7.26 : Database - tic84
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`tic84` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `tic84`;

/*Table structure for table `empleados` */

DROP TABLE IF EXISTS `empleados`;

CREATE TABLE `empleados` (
  `ide` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `sexo` varchar(50) DEFAULT NULL,
  `ids` int(11) DEFAULT NULL,
  PRIMARY KEY (`ide`),
  KEY `ids` (`ids`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `empleados` */

insert  into `empleados`(`ide`,`nombre`,`sexo`,`ids`) values 
(1,'paty','F',1),
(2,'Pedro','M',2),
(3,'Rodrigo','M',1),
(4,'Laura','F',2),
(5,'Memo','M',1);

/*Table structure for table `produccion` */

DROP TABLE IF EXISTS `produccion`;

CREATE TABLE `produccion` (
  `idpr` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `idp` int(11) DEFAULT NULL,
  `ide` int(11) DEFAULT NULL,
  `piezas` int(11) DEFAULT NULL,
  `turno` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idpr`),
  KEY `idp` (`idp`),
  KEY `ide` (`ide`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `produccion` */

insert  into `produccion`(`idpr`,`fecha`,`idp`,`ide`,`piezas`,`turno`) values 
(1,'2020-01-10',1,1,10,'m'),
(2,'2020-03-20',2,2,20,'m'),
(3,'2020-05-17',3,3,30,'m'),
(4,'2020-10-10',4,4,25,'v'),
(5,'2020-07-13',5,5,35,'v'),
(6,'2020-01-10',2,4,15,'v'),
(7,'2020-10-09',1,3,60,'m');

/*Table structure for table `productos` */

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `idp` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `cant` varchar(50) DEFAULT NULL,
  `costo` varchar(50) DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idp`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `productos` */

insert  into `productos`(`idp`,`nombre`,`cant`,`costo`,`tipo`) values 
(1,'p1','10','100','A'),
(2,'p2','15','200','B'),
(3,'p3','30','300','A'),
(4,'p4','70','150','B'),
(5,'p5','40','400','B');

/*Table structure for table `sucursal` */

DROP TABLE IF EXISTS `sucursal`;

CREATE TABLE `sucursal` (
  `ids` int(5) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  KEY `ids` (`ids`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `sucursal` */

insert  into `sucursal`(`ids`,`nombre`) values 
(1,'bimbo'),
(2,'coca');

/* Function  structure for function  `cuotamonto` */

/*!50003 DROP FUNCTION IF EXISTS `cuotamonto` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `cuotamonto`(ps1 int, ps2 int) RETURNS varchar(30) CHARSET latin1
begin
DECLARE monto VARCHAR(10);
declare prodanual int;
declare cuota varchar(5);
declare cadenafinal varchar(30);
select ps1 + ps2 into prodanual;
if(prodanual>=80) then
set cuota = "si";
select TRUNCATE((ps1+ps2)/10,0)*1000 into monto;
else
set cuota = "No";
set monto = "Na";
end if;
select concat(cuota, "-", monto) into cadenafinal;
return cadenafinal;
end */$$
DELIMITER ;

/* Function  structure for function  `mtp` */

/*!50003 DROP FUNCTION IF EXISTS `mtp` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `mtp`(sn varchar(15)) RETURNS varchar(3) CHARSET latin1
begin
declare mt varchar(3);
SELECT pr.turno into mt
FROM produccion AS pr 
INNER JOIN empleados AS e ON pr.ide = e.ide
INNER JOIN sucursal AS s ON e.ids = s.ids
where s.nombre = sn
GROUP BY pr.turno, s.nombre ORDER BY SUM(pr.piezas) DESC
LIMIT 1;
return mt;
end */$$
DELIMITER ;

/* Function  structure for function  `prodsem` */

/*!50003 DROP FUNCTION IF EXISTS `prodsem` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `prodsem`(suc varchar(30), fi date, ff date) RETURNS int(11)
begin
   declare tp int;
   select sum(pr.piezas) into tp
    from produccion as pr
    inner join empleados as e on e.ide = pr.ide
    inner join sucursal as s on s.ids = e.ids
    where s.nombre = suc and
    fecha >= fi and fecha <= ff;
   return tp;
  end */$$
DELIMITER ;

/* Function  structure for function  `splitString` */

/*!50003 DROP FUNCTION IF EXISTS `splitString` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `splitString`(str VARCHAR (255), delim VARCHAR(12),pos INT) RETURNS varchar(255) CHARSET latin1
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(str,delim,pos),
LENGTH(SUBSTRING_INDEX(str,delim,pos-1))+1),delim,'') */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
