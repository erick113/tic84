SELECT s.nombre, emp.sexo, SUM(pr.piezas) AS npiezas, 
IF (SUM(pr.piezas)>=20, "si", "No")AS cuota
FROM producción AS pr
INNER JOIN productos AS p ON p.idp = pr.idp
INNER JOIN empleados AS emp ON emp.ide = pr.ide
INNER JOIN sucursal AS s ON s.ids = emp.ids
WHERE emp.sexo = "F"
GROUP BY emp.sexo, s.nombre;



SELECT t1.nombre, t1.sexo, t1.cuantos,
IF(t1.cuantos>20, "si", "No")AS cuota
FROM(SELECT s.nombre, emp.sexo, SUM(pr.piezas) AS cuantos
FROM producción AS pr
INNER JOIN productos AS p ON p.idp = pr.idp
INNER JOIN empleados AS emp ON emp.ide = pr.ide
INNER JOIN sucursal AS s ON s.ids = emp.ids
WHERE emp.sexo = "F"
GROUP BY emp.sexo, s.nombre) AS t1;



SELECT s.nombre, emp.sexo, SUM(pr.piezas) AS npiezas,  
IF (SUM(pr.piezas)>=20, "si", "No")AS cuota
FROM producción AS pr
INNER JOIN productos AS p ON p.idp = pr.idp
INNER JOIN empleados AS emp ON emp.ide = pr.ide
INNER JOIN sucursal AS s ON s.ids = emp.ids
WHERE emp.sexo = "F"
GROUP BY emp.sexo, s.nombre;



DELIMITER$$
 CREATE FUNCTION prodsem(suc VARCHAR(30), fi DATE, ff DATE) RETURNS INT
  BEGIN
   DECLARE tp INT;
   SELECT SUM(pr.piezas) INTO tp
    FROM produccion AS pr
    INNER JOIN empleados AS e ON e.ide = pr.ide
    INNER JOIN sucursal AS s ON s.ids = e.ids
    WHERE s.nombre = suc AND
    fecha >= fi AND fecha <= ff;
  RETURN tp;
END$$
  
SELECT prodsem("bimbo", "2020-01-1", "2020-06-30");



DELIMITER$$
CREATE FUNCTION mtp(sn VARCHAR(15)) RETURNS VARCHAR(3)
BEGIN
DECLARE mt VARCHAR(3);
SELECT pr.turno INTO mt
FROM produccion AS pr 
INNER JOIN empleados AS e ON pr.ide = e.ide
INNER JOIN sucursal AS s ON e.ids = s.ids
WHERE s.nombre = sn
GROUP BY pr.turno, s.nombre ORDER BY SUM(pr.piezas) DESC
LIMIT 1;
RETURN mt;
END$$
SELECT mtp("coca");



DELIMITER$$
CREATE FUNCTION cuotamonto(ps1 INT, ps2 INT) RETURNS VARCHAR(30)
BEGIN
DECLARE monto VARCHAR(10);
DECLARE prodanual INT;
DECLARE cuota VARCHAR(5);
DECLARE cadenafinal VARCHAR(30);
SELECT ps1 + ps2 INTO prodanual;
IF(prodanual>=80) THEN
SET cuota = "si";
SELECT TRUNCATE((ps1+ps2)/10,0)*1000 INTO monto;
ELSE
SET cuota = "No";
SET monto = "Na";
END IF;
SELECT CONCAT(cuota, "-", monto) INTO cadenafinal;
RETURN cadenafinal;
END$$



-- REPAIR splitString warning;

DELIMITER $$
USE `tic84`$$
DROP FUNCTION IF EXISTS `splitString`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `splitString`(str VARCHAR (255), delim VARCHAR(12),pos INT) RETURNS VARCHAR(255) CHARSET latin1
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(str,delim,pos),
LENGTH(SUBSTRING_INDEX(str,delim,pos-1))+1),delim,'')$$
DELIMITER ;




SELECT t1.nombre, t1.prodsem1, t1.prodsem2, t1.bt,
	IF((t1.prodsem1 + t1.prodsem2) >= 80, "si", "no") AS cuota,
	IF(IF((t1.prodsem1 + t1.prodsem2) >= 80, "si", "no")="si", TRUNCATE((t1.prodsem1 + t1.prodsem2)/10,0)*1000, "NA") AS bono
FROM (SELECT s.nombre,
prodsem(s.nombre, "2020-01-01", "2020-06-30") AS prodsem1,
prodsem(s.nombre, "2020-07-01", "2020-12-31") AS prodsem2,
IF(mtp(s.nombre) = "M", "matutino", "Vespertino") AS bt
FROM sucursal AS s) AS t1;



SELECT t1.nombre, t1.prodsem1, t1.prodsem2, t1.bt,
splitString(cuotamonto(t1.prodsem1, t1.prodsem2), "-", 1) AS cuota,
splitString(cuotamonto(t1.prodsem1, t1.prodsem2), "-", 2) AS bono
FROM (SELECT s.nombre,
prodsem(s.nombre, "2020-01-01", "2020-06-30") AS prodsem1,
prodsem(s.nombre, "2020-07-01", "2020-12-31") AS prodsem2,
IF(mtp(s.nombre) = "M", "matutino", "Vespertino") AS bt
FROM sucursal AS s) AS t1;