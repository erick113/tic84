DELIMITER$$
CREATE FUNCTION cats(customerName VARCHAR(30)) RETURNS INT
BEGIN
DECLARE q INT;
SELECT COUNT(m.idm) INTO q
FROM mascotas AS m
INNER JOIN especies AS e ON e.ide = m.ide
INNER JOIN clientes AS c ON c.idc = m.idc
WHERE c.nombre = customerName
AND e.nombre = "Gato";
RETURN q;
END$$

DELIMITER$$
CREATE FUNCTION dogs(customerName VARCHAR(30)) RETURNS INT
BEGIN
DECLARE q INT;
SELECT COUNT(m.idm) INTO q
FROM mascotas AS m
INNER JOIN especies AS e ON e.ide = m.ide
INNER JOIN clientes AS c ON c.idc = m.idc
WHERE c.nombre = customerName
AND e.nombre = "Perro";
RETURN q;
END$$


DELIMITER$$
CREATE FUNCTION birds(customerName VARCHAR(30)) RETURNS INT
BEGIN
DECLARE q INT;
SELECT COUNT(m.idm) INTO q
FROM mascotas AS m
INNER JOIN especies AS e ON e.ide = m.ide
INNER JOIN clientes AS c ON c.idc = m.idc
WHERE c.nombre = customerName
AND e.nombre = "Ave";
RETURN q;
END$$


DELIMITER$$
CREATE FUNCTION janJun(customerName VARCHAR(30)) RETURNS INT
BEGIN
DECLARE cantidad INT;
SELECT v.cant * a.costo INTO cantidad
FROM ventas AS v
INNER JOIN clientes AS c ON c.idc = v.idc
INNER JOIN accesorios AS a ON a.ida = v.ida
INNER JOIN especies AS e ON e.ide = a.ide
WHERE c.nombre = customerName
AND e.nombre = "Gato"
AND v.fecha >= "2020-01-01" AND v.fecha < "2020-07-01";
RETURN cantidad;
END$$

DELIMITER$$
CREATE FUNCTION julDec(customerName VARCHAR(30)) RETURNS INT
BEGIN
DECLARE cantidad INT;
SELECT v.cant * a.costo INTO cantidad
FROM ventas AS v
INNER JOIN clientes AS c ON c.idc = v.idc
INNER JOIN accesorios AS a ON a.ida = v.ida
INNER JOIN especies AS e ON e.ide = a.ide
WHERE c.nombre = customerName
AND e.nombre = "Gato"
AND v.fecha >= "2020-07-01" AND v.fecha < "2021-01-01";
RETURN cantidad;
END$$



----------------------------------------------------------------------------------




SELECT c.nombre, cats(c.nombre) AS gatos, dogs(c.nombre) AS perros, birds(c.nombre) AS aves,
IFNULL(janJun(c.nombre), 0) AS "enero-junio",
IFNULL(julDec(c.nombre), 0) AS "julio-diciembre"
FROM clientes AS c;