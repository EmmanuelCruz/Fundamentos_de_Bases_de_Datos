CREATE TABLE Empleado(
    CURP	CHAR(18)	NOT NULL	CHECK (CURP SIMILAR TO '[A-Z]{4}[0-9]{6}[H,­M][A-Z]{5}[0-9]{2}'),
    nombre	VARCHAR(80)	NOT NULL	CHECK (nombre SIMILAR TO '[a-zA-Z\s]+'),
    paterno	VARCHAR(80)	NOT NULL	CHECK (paterno SIMILAR TO '[a-zA-Z\s]+') ,
    materno 	VARCHAR(80)	NOT NULL	CHECK (materno SIMILAR TO '[a-zA-Z\s]+'),
    f_nac	DATE		NOT NULL	CHECK (f_nac BETWEEN '1960-01-01' AND '1995-01-01'),
    calle	VARCHAR(200)	NOT NULL	CHECK (calle SIMILAR TO '[a-zA-Z\d.\s]+'),
    num		DECIMAL(4)	NOT NULL	CHECK (num > 0),
    ciudad	VARCHAR(100)	NOT NULL	CHECK(ciudad SIMILAR TO '[a-zA-Z\s]+'),
    CP		DECIMAL(5)	NOT NULL	CHECK(CP > 0),
    CONSTRAINT PK_Empleado PRIMARY KEY (CURP));
    
COMMENT ON COLUMN Empleado.CURP IS 'CURP del empleado.';
COMMENT ON COLUMN Empleado.nombre IS 'Nombre del empleado.';
COMMENT ON COLUMN Empleado.paterno IS 'Apellido paterno del empleado.';
COMMENT ON COLUMN Empleado.materno IS 'Apellido materno del empleado.';
COMMENT ON COLUMN Empleado.f_nac IS 'Fecha de nacimiento del empleado.';
COMMENT ON COLUMN Empleado.calle IS 'Calle de residencia del empleado.';
COMMENT ON COLUMN Empleado.num IS 'Numero de la residencia del empleado.';
COMMENT ON COLUMN Empleado.ciudad IS 'Ciudad de residencia del empleado.';
COMMENT ON COLUMN Empleado.CP IS 'Código postal de la residencia del empleado';

CREATE TABLE Supervisar(
   CURP_supervisado	CHAR(18)	NOT NULL,
   CURP_supervisor	CHAR(18)	NOT NULL,
   CONSTRAINT	PK_Supervisar	PRIMARY KEY (CURP_supervisado, CURP_supervisor),
   CONSTRAINT FK_Supervisado	FOREIGN KEY (CURP_supervisado)  REFERENCES Empleado(CURP) 
   MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
   CONSTRAINT FK_Supervisor 	FOREIGN KEY (CURP_supervisor)   REFERENCES Empleado(CURP)
   MATCH SIMPLE ON UPDATE CASCADE ON DELETE SET NULL);

COMMENT ON COLUMN Supervisar.CURP_supervisado IS 'CURP del empleado que es supervisado.';
COMMENT ON COLUMN Supervisar.CURP_supervisor IS 'CURP del empleado que es supervisor.';

CREATE TABLE Empresa(
    RFC 	CHAR(13)	NOT NULL 	CHECK(RFC SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z]{2}[0-9]{1}'),
    razon_social VARCHAR(200)	NOT NULL,
    calle_empresa	VARCHAR(200)	NOT NULL	CHECK (calle_empresa SIMILAR TO '[a-zA-Z\d.\s]+'),
    num_empresa		DECIMAL(4)	NOT NULL	CHECK (num_empresa > 0),
    ciudad_empresa	VARCHAR(100)	NOT NULL	CHECK (ciudad_empresa SIMILAR TO '[a-zA-Z\s]+'),
    CP_empresa		DECIMAL(5)	NOT NULL	CHECK (CP_empresa > 0),
    CONSTRAINT PK_Empresa 	PRIMARY KEY (RFC));    
COMMENT ON COLUMN Empresa.RFC IS 'RFC de la empresa';
COMMENT ON COLUMN Empresa.razon_social IS 'Razón social de la empresa';
COMMENT ON COLUMN Empresa.calle_empresa IS 'Calle donde se encuentra la empresa';
COMMENT ON COLUMN Empresa.num_empresa IS 'Número de la ubicación de la empresa';
COMMENT ON COLUMN Empresa.ciudad_empresa IS 'Ciudad donde se encuentra la empresa';  
COMMENT ON COLUMN Empresa.CP_empresa IS 'Codigo postal de la empresa';

CREATE TABLE Trabajar(
    CURP	CHAR(18)	NOT NULL,
    RFC		CHAR(13)	NOT NULL,
    fecha_ingreso DATE		NOT NULL	CHECK(fecha_ingreso <= NOW()),
    Salario	MONEY		NOT NULL	CHECK(Salario > CAST(0 AS MONEY)),
    CONSTRAINT PK_Trabajar	PRIMARY KEY (CURP, RFC),
    CONSTRAINT FK_CURP 	FOREIGN KEY (CURP) REFERENCES	 Empleado(CURP)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_RFC	FOREIGN KEY (RFC) REFERENCES	Empresa(RFC)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE);

COMMENT ON COLUMN Trabajar.CURP IS 'CURP de los empleados que trabajan en determinada empresa.';
COMMENT ON COLUMN Trabajar.RFC IS 'RFC de la empresa en la que trabajan los empleados.';
COMMENT ON COLUMN Trabajar.fecha_ingreso IS 'Fecha en la que ingresó el empleado a la empresa'; 
COMMENT ON COLUMN Trabajar.Salario IS 'Salario del empleado.';

CREATE TABLE Dirigir(
    CURP	CHAR(18)	NOT NULL,
    RFC		CHAR(13)	NOT NULL,
    fecha_inicio_dirigir DATE	NOT NULL	CHECK (fecha_inicio_dirigir <= NOW()),
    CONSTRAINT	PK_Dirigir	PRIMARY KEY	(CURP, RFC),
    CONSTRAINT 	FK_Dirigir_RFC 	FOREIGN KEY 	(RFC) 	REFERENCES Empresa(RFC)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT 	FK_Dirigir_CURP FOREIGN KEY 	(CURP) 	REFERENCES Empleado(CURP)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE SET NULL);
    
COMMENT ON COLUMN Dirigir.CURP IS 'CURP del empleado que dirige la empresa (jefe)';
COMMENT ON COLUMN Dirigir.RFC IS 'RFC de la empresa.';
COMMENT ON COLUMN Dirigir.fecha_inicio_dirigir IS 'fecha_inicio en la que el jefe comenzó a dirigir la empresa.';


CREATE TABLE Proyecto(
    numProy	DECIMAL(4)	NOT NULL,
    RFC		CHAR(13)	NOT NULL,
    nombre_proyecto	VARCHAR(100)	NOT NULL,
    fecha_inicio	DATE		NOT NULL	CHECK (fecha_inicio <  NOW()),
    fecha_fin	DATE		CHECK (fecha_fin > fecha_inicio ),
    CONSTRAINT PK_Proyecto PRIMARY KEY(numProy),
    CONSTRAINT FK_Proyecto_RFC FOREIGN KEY (RFC) REFERENCES Empresa(RFC)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE);
COMMENT ON COLUMN Proyecto.numProy IS 'Numero del proyecto';
COMMENT ON COLUMN Proyecto.RFC IS 'RFC de la empresa que controla el proyecto';
COMMENT ON COLUMN Proyecto.fecha_inicio IS 'Fecha en la que inicio el proyecto';
COMMENT ON COLUMN Proyecto.fecha_fin IS 'Fecha en la que finalizó el proyecto.';


CREATE TABLE Colaborar(
   CURP	CHAR(18)	NOT NULL,
   numProy	DECIMAL(4)	NOT NULL	CHECK (numProy > 0),	
   fecha_inicio_colaborar	DATE NOT NULL	CHECK(fecha_inicio_colaborar < NOW()),
   fecha_fin_colaborar	DATE		CHECK(fecha_fin_colaborar > fecha_inicio_colaborar),
   numHoras	DECIMAL(3) NOT NULL  CHECK(numHoras > 0),
   CONSTRAINT PK_Colaborar PRIMARY KEY(CURP, numProy),
   CONSTRAINT FK_Colaborar_CURP FOREIGN KEY (CURP) REFERENCES Empleado(CURP)
   MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
   CONSTRAINT FK_Colaborar_Proyecto	FOREIGN KEY (numProy) REFERENCES Proyecto(numProy)
   MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE);
COMMENT ON COLUMN Colaborar.numProy IS 'Numero del proyecto en el que colabora el empleado.';
COMMENT ON COLUMN Colaborar.CURP IS 'CURP del empleado que colabora en el proyecto.';
COMMENT ON COLUMN Colaborar.fecha_inicio_colaborar IS 'Fecha en la que el empleado inicio su colaboración en el proyecto.';
COMMENT ON COLUMN Colaborar.fecha_fin_colaborar IS 'Fecha en la que finalizó la colaboración del empleado';
COMMENT ON COLUMN Colaborar.numHoras IS 'Número de horas que colabora el empleado.';



