--functions

DELIMITER$$
CREATE FUNCTION getMonto(tipoClienteF VARCHAR(3)) RETURNS INT
BEGIN
DECLARE monto INT;
SELECT SUM(s.costo) INTO monto
FROM cirugias AS s
INNER JOIN mascotas AS m ON m.idm = s.idm
INNER JOIN clientes AS c ON c.idc = m.idc
WHERE c.tipo = tipoClienteF;
RETURN monto;
END$$

DELIMITER$$
CREATE FUNCTION eneroJulio(tipoCliente VARCHAR(3)) RETURNS INT
BEGIN
DECLARE cantidad INT;
SELECT COUNT(s.idci) INTO cantidad
FROM cirugias AS s
INNER JOIN mascotas AS m ON m.idm = s.idm
INNER JOIN clientes AS c ON c.idc = m.idc
WHERE c.tipo = tipoCliente
AND s.fecha >= "2020-01-01" AND s.fecha < "2020-08-01";
RETURN cantidad;
END$$





--query

SELECT DISTINCT(c.tipo), COUNT(s.idci) AS cirugias, getMonto(c.tipo) AS monto, eneroJulio(c.tipo) AS EneroJulio,
IF((getMonto(c.tipo)) > 3000, "si", "no") AS cuota
FROM cirugias AS s
INNER JOIN mascotas AS m ON m.idm = s.idm
INNER JOIN clientes AS c ON c.idc = m.idc
GROUP BY c.tipo;