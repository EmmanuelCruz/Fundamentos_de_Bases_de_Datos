-- Ejercicio 1
SELECT	nombre
FROM 	 (SELECT  nombre, date_part('year',age(fecha_nacimiento)) AS edad
	FROM Representante.Nombre_Representante) AS foo
WHERE  	edad  > 25;

-- Ejercicio 2
SELECT nombre, date_part('year',age(fecha_nacimiento)) AS edad 
FROM (Representante.Nombre_Representante 
NATURAL JOIN Representante.Representante_Preliminar NATURAL JOIN Representante.Representante_Aprobado NATURAL JOIN Representante.Asistencia)
WHERE inicio IS NOT NULL AND fin IS NOT NULL;

-- Ejercicio 3
SELECT *
FROM
(SELECT seccion_casilla, COUNT(seccion_casilla) AS numSecciones
FROM Casilla.Casilla
GROUP BY seccion_casilla) numSecciones
WHERE numSecciones > 10;

-- Ejercicio 4
SELECT 	*
FROM 	(SELECT curp, date_part('year',age(fecha_nacimiento)) AS edad 
	FROM Representante.Nombre_Representante NATURAL JOIN Representante.Representante_Preliminar NATURAL JOIN Representante.Representante_Aprobado) AS foo
WHERE edad > 30;

-- Ejercicio 5

SELECT id_Distrito, nombre_Distrito, nombre, paterno, materno, tipo_cargo, id_Casilla
FROM Geografico.Distrito NATURAL JOIN
(SELECT D.id_Distrito, curp, COUNT(curp) AS Aprobados
FROM Geografico.Distrito D  JOIN (Geografico.Distrito NATURAL JOIN Casilla.Casilla NATURAL JOIN 
 Representante.Representante_Preliminar NATURAL JOIN Representante.Nombre_Representante NATURAL JOIN Representante.Representante_Aprobado) A
 ON D.id_Distrito = A.id_Distrito
GROUP BY D.id_Distrito, curp) numAprobados
 NATURAL JOIN Casilla.Casilla NATURAL JOIN 
 Representante.Representante_Preliminar NATURAL JOIN  Representante.nombre_Representante NATURAL JOIN Representante.Representante_Aprobado 
WHERE Aprobados > 20;

--Ejercicio 6
SELECT AVG(date_part('year',age(fecha_nacimiento))) AS PROMEDIO
FROM (Representante.Informacion NATURAL JOIN Representante.Representante_Preliminar NATURAL JOIN Representante.Registrar)
WHERE fecha_registro BETWEEN '2018-01-01' AND '2018-05-31';

--Ejercicio 7
SELECT id_rep_preliminar,nombre,materno,paterno
FROM  (geografico.Estado NATURAL JOIN Geografico.Distrito  NATURAL JOIN Casilla.Casilla
NATURAL JOIN representante.alojar NATURAL JOIN Representante.Representante_preliminar NATURAL JOIN Representante.Nombre_Representante)
WHERE nombre_estado = 'San Luis Potosí' AND seccion_casilla = '321' AND tipo_cargo = 'Propietario';

--Ejercicio 8
SELECT COUNT(id_rep_preliminar)
FROM Representante.Representante_Preliminar
WHERE tipo_cargo = 'suplente';

--Ejercicio 9 
SELECT nombre,materno,paterno,curp
FROM  Representante.Asistencia NATURAL JOIN Representante.Representante_Aprobado
NATURAL JOIN Representante.Representante_Preliminar NATURAL JOIN Representante.Nombre_Representante
WHERE inicio IS NULL;

--Ejercicio 10 
SELECT nombre, materno, paterno
FROM Representante.nombre_Representante NATURAL JOIN Representante.Representante_Preliminar NATURAL JOIN 
representante.Representante_Aprobado NATURAL JOIN Representante.Sustituir;

--Ejercicio 11
SELECT 	nombre_partido, siglas, MAX(count_partido)
FROM 	(SELECT nombre_estado, nombre_partido, siglas, COUNT(id_Politico) AS count_partido 
	FROM Geografico.Estado NATURAL JOIN Geografico.Distrito NATURAL JOIN Partido_Politico.PartidoPolitico NATURAL JOIN Representante.Representante_Preliminar NATURAL JOIN 
	representante.Representante_Aprobado
	GROUP BY nombre_estado, nombre_partido, siglas) AS foo
WHERE nombre_estado = 'Morelos'
GROUP BY nombre_partido, siglas;

--Ejercicio 12
SELECT nombre
FROM Representante.Nombre_Representante NATURAL JOIN Representante.Representante_Preliminar NATURAL JOIN Representante.Representante_Aprobado 
WHERE nombre ~ '^[A-Za-z]+\s[\w\s]+';
