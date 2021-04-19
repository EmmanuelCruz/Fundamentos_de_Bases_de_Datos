-- a
SELECT nombre, ciudad
FROM Empleado NATURAL JOIN Trabajar NATURAL JOIN Empresa
WHERE razon_social = 'PEMEX';

-- b
SELECT CURP, nombre, paterno, materno, ciudad
FROM Empleado NATURAL JOIN Trabajar NATURAL JOIN Empresa 
WHERE ciudad = ciudad_empresa;

-- c
SELECT CURP, Salario
FROM Empleado NATURAL JOIN Trabajar NATURAL JOIN Dirigir NATURAL JOIN Empresa;

--d
SELECT RFC, CURP
FROM (
SELECT RFC, CURP, CAST(to_char(fecha_inicio_dirigir,'q') AS INTEGER) as trimestre
FROM dirigir
WHERE to_char(fecha_inicio_dirigir,'YYYY') = '2016'
GROUP BY RFC, CURP, to_char(fecha_inicio_dirigir,'q')) AS foo
WHERE trimestre = 1 OR trimestre = 3;

--e
SELECT EMP.CURP, EMP.nombre, EMP.paterno, EMP.materno
FROM (Empleado JOIN Supervisar ON CURP = CURP_supervisor) AS TSupervisor JOIN
Empleado EMP ON TSupervisor.CURP_supervisado = EMP.CURP
WHERE TSupervisor.ciudad=EMP.ciudad AND TSupervisor.calle=EMP.calle;

-- f
 SELECT razon_social, AVG(CAST(salario AS DECIMAL)) AS SalarioPromedio
 FROM Empresa NATURAL JOIN Trabajar
 GROUP BY razon_social;

 -- g
 SELECT CURP, nombre, paterno, materno, numProy
 FROM (SELECT CURP, nombre, paterno, materno, numProy
 FROM Empleado NATURAL JOIN Colaborar NATURAL JOIN Proyecto) EmProy
 EXCEPT (SELECT CURP, nombre, paterno, materno, numProy
 FROM Empleado NATURAL JOIN Trabajar NATURAL JOIN Empresa NATURAL JOIN Colaborar NATURAL JOIN Proyecto);

 -- h
 SELECT razon_social, SUM(Salario) AS Salarios
 FROM Empresa NATURAL JOIN Trabajar
 GROUP BY razon_social;
 
-- i
SELECT CURP, nombre, paterno, materno, numProy, numHoras
FROM (SELECT CURP, nombre, paterno, materno, COUNT(numProy) AS Proyectos
FROM Empleado NATURAL JOIN Colaborar NATURAL JOIN Proyecto
GROUP BY CURP
HAVING COUNT(numProy)>=2) Emple
NATURAL JOIN Colaborar NATURAL JOIN Proyecto 
WHERE numHoras>20;

-- j
SELECT RFC, COUNT(CURP) AS Empleados
FROM Empleado NATURAL JOIN Trabajar NATURAL JOIN Empresa
GROUP BY RFC;

-- k 
SELECT RFC, nombre
FROM Empleado NATURAL JOIN Trabajar NATURAL JOIN
(SELECT RFC, MAX(Salario) AS SalarioMax
FROM Empleado NATURAL JOIN Trabajar NATURAL JOIN Empresa
GROUP BY RFC) T
WHERE SalarioMax=Salario;

 --l
SELECT CURP, nombre, paterno, materno
FROM Empleado NATURAL JOIN Trabajar NATURAL JOIN
(SELECT RFC, AVG(CAST(salario AS DECIMAL)) AS SalarioProm
FROM Empresa NATURAL JOIN Trabajar
GROUP BY RFC) sub
WHERE CAST(salario AS DECIMAL)>SalarioProm;

-- m
SELECT RFC, CURP, nombre, paterno, materno
FROM Empleado NATURAL JOIN Trabajar NATURAL JOIN
(SELECT RFC, COUNT(CURP) as numEmpleados
FROM Trabajar NATURAL JOIN Empresa
GROUP BY RFC
HAVING COUNT(CURP) =
(SELECT MIN(NumEmpleados)
FROM (SELECT RFC, COUNT(CURP) AS NumEmpleados
FROM Empresa NATURAL JOIN Trabajar
GROUP BY RFC) CUANTOS)) AS SUB;

-- n
SELECT numProy, nombre_proyecto, fecha_inicio, fecha_fin
FROM Dirigir NATURAL JOIN Empresa NATURAL JOIN Colaborar NATURAL JOIN Proyecto;

--o
SELECT RFC, COUNT(ciudad_empresa) AS numCiudadesConEmpleados
FROM Empleado NATURAL JOIN Trabajar NATURAL JOIN Empresa
GROUP BY RFC
HAVING COUNT(ciudad_empresa)=
(SELECT COUNT(noCiudad) AS Ciudades
FROM
(SELECT ciudad_empresa, COUNT(ciudad_empresa) AS noCiudad
FROM Empresa
GROUP BY ciudad_empresa) SUB1);

-- p
SELECT CURP, nombre, paterno, materno
FROM Empleado NATURAL JOIN Colaborar NATURAL JOIN Proyecto
WHERE fecha_fin_colaborar < fecha_fin;

-- q
SELECT CURP, nombre, paterno, materno
FROM 
(SELECT CURP, nombre, paterno, materno
FROM Empleado) SUB1 EXCEPT
(SELECT CURP, nombre, paterno, materno
FROM Empleado NATURAL JOIN Colaborar NATURAL JOIN Proyecto);

-- r 
SELECT RFC, razon_social, calle_empresa, num_empresa, ciudad_empresa, CP_empresa
FROM Empresa NATURAL JOIN
(SELECT razon_social, ciudad, COUNT(CURP) AS Empleados
FROM Empleado NATURAL JOIN Trabajar NATURAL JOIN Empresa
GROUP BY razon_social, ciudad
HAVING COUNT(CURP) >= 2) AUX; 


-- s
SELECT numProy, SUM(numHoras) Horas_Dedicadas
FROM
(SELECT numProy, COUNT(CURP) AS NoEmpleado
FROM Colaborar NATURAL JOIN Proyecto
GROUP BY numProy
HAVING COUNT(CURP)=(SELECT MAX(Empleados) AS Numero_Empleados
FROM Proyecto NATURAL JOIN
(SELECT numProy, COUNT(CURP) AS Empleados
FROM Colaborar NATURAL JOIN Proyecto
GROUP BY numProy) Conteo)) NoEmpleados NATURAL JOIN Colaborar NATURAL JOIN Proyecto
GROUP BY numProy;


-- t
SELECT CURP, nombre, paterno, materno, f_nac, fecha_inicio_colaborar
FROM Empleado NATURAL JOIN Colaborar NATURAL JOIN Proyecto
WHERE TO_CHAR(f_nac, 'MON') = TO_CHAR(fecha_inicio_colaborar, 'MON') AND TO_CHAR(f_nac, 'DD') = TO_CHAR(fecha_inicio_colaborar, 'DD');


-- u
SELECT CURP, nombre, paterno, materno, COUNT(CURP_supervisado) AS Supervisados
FROM Empleado JOIN Supervisar ON Empleado.CURP=Supervisar.CURP_supervisor
GROUP BY CURP;

--v
SELECT	*
FROM 	 (SELECT  CURP, nombre, paterno, materno, date_part('year',age(f_nac)) AS edad
	FROM Empleado NATURAL JOIN Dirigir) AS foo  
WHERE  	edad  > 50;

-- w
SELECT CURP, nombre, paterno, materno
FROM Empleado
WHERE upper(paterno) ~'^[ADGJLPR]\w+';

-- x
SELECT RFC, numProy, COUNT(CURP) AS numEmpleados
FROM
(SELECT RFC, COUNT(CURP) as Empleados
FROM Empleado NATURAL JOIN Colaborar NATURAL JOIN Proyecto
GROUP BY RFC) numEmple NATURAL JOIN Colaborar NATURAL JOIN Proyecto
WHERE TO_CHAR(fecha_inicio,'MON')  = 'DEC'
GROUP BY RFC, numProy;

-- y
CREATE OR REPLACE VIEW Proyectos AS
SELECT CURP, nombre, paterno, materno, RFC, razon_social, calle, num, ciudad
FROM 
(SELECT CURP, COUNT(RFC) AS NoTrabajos
FROM Empleado NATURAL JOIN Trabajar NATURAL JOIN Empresa
GROUP BY CURP
HAVING COUNT(RFC)>=3) SUB NATURAL JOIN Empleado NATURAL JOIN Trabajar NATURAL JOIN Empresa;