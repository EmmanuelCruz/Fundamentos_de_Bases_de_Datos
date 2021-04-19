CREATE SCHEMA Geografico;
CREATE SCHEMA Partido_Politico;
CREATE SCHEMA Casilla;
CREATE SCHEMA Representante;
DROP SCHEMA Public;
--Crea la Tabla Estado en el esquema Geografico
CREATE TABLE Geografico.Estado(
	id_Estado	DECIMAL(4),
	nombre_estado		VARCHAR(60),
	CONSTRAINT	PK_Estado	PRIMARY KEY(id_Estado));

COMMENT ON TABLE Geografico.Estado IS 'Tabla que contiene los Estados.';
COMMENT ON COLUMN Geografico.Estado.id_Estado IS 'Identificador del Estado.';
COMMENT ON COLUMN Geografico.Estado.nombre_estado IS 'Nombre del Estado.';

--Crea la Tabla Distrito en el esquema Geografico	
CREATE TABLE Geografico.Distrito(
	id_Estado	DECIMAL(4),
	id_Distrito	DECIMAL(4),
	nombre_distrito		VARCHAR(80),
	CONSTRAINT	PK_Distrito	PRIMARY KEY	(id_Estado, id_Distrito),
	CONSTRAINT	FK_1	FOREIGN KEY (id_Estado) REFERENCES Geografico.Estado(id_Estado));
COMMENT ON TABLE Geografico.Distrito IS 'Tabla que contiene los Distritos.';
COMMENT ON COLUMN Geografico.Distrito.id_Distrito IS 'Identificador del Distrito.';
COMMENT ON COLUMN Geografico.Distrito.nombre_distrito IS 'Nombre del Distrito.';

--Crea la Tabla Casilla en el esquema Casilla
CREATE TABLE Casilla.Casilla(
	id_Estado	DECIMAL(4),
	id_Distrito 	DECIMAL(4), 	
	seccion_casilla	DECIMAL(5),
	tipo		CHAR(1),
	aprobada	CHAR(1),
	id_Casilla 	DECIMAL(4),
	CONSTRAINT PK_Casilla	PRIMARY KEY	(id_Casilla, id_Estado, id_Distrito, seccion_casilla, tipo),
	CONSTRAINT	FK_4		FOREIGN KEY 	(id_Estado, id_Distrito) REFERENCES Geografico.Distrito(id_Estado, id_Distrito));
COMMENT ON TABLE Casilla.Casilla IS 'Tabla que contiene las casillas.';
COMMENT ON COLUMN Casilla.Casilla.seccion_casilla IS 'La sección a la que pertenece una casilla.';
COMMENT ON COLUMN Casilla.Casilla.tipo IS 'El tipo de casilla.';
COMMENT ON COLUMN Casilla.Casilla.aprobada IS 'La casilla está aprobada o no.';

--Crea la Tabla Partido_Politico en el esquema Partido Politico
CREATE TABLE Partido_Politico.PartidoPolitico(
	id_Estado	DECIMAL(4),
	id_Distrito	DECIMAL(4),	
	id_Politico	DECIMAL(4),
	nombre_partido		VARCHAR(80),
	siglas 		VARCHAR(10), 
	CONSTRAINT	PK_PartidoPolitico	PRIMARY KEY	(id_Estado, id_Distrito, id_Politico),
	CONSTRAINT	FK_3	FOREIGN KEY	(id_Estado,id_Distrito)	REFERENCES Geografico.Distrito(id_Estado, id_Distrito));
COMMENT ON TABLE Partido_Politico.PartidoPolitico IS 'Tabla que contiene los partidos políticos.';
COMMENT ON COLUMN Partido_Politico.PartidoPolitico.id_Politico IS 'Identificador del Partido Político.';

--Crea la Tabla Representante_Preliminar en el esquema Representante
CREATE TABLE Representante.Representante_Preliminar(
	id_Estado	DECIMAL(4),
	id_Distrito	DECIMAL(4),
	seccion_casilla	DECIMAL(5),
	tipo 		CHAR(1),
	id_Politico	DECIMAL(4),
	id_Rep_Preliminar DECIMAL(4),
	nombre		VARCHAR(40),
	paterno		VARCHAR(40),
	materno		VARCHAR(40),
	estado		VARCHAR(40),
	numero		DECIMAL(4),
	calle		VARCHAR(80),
	seccion 	DECIMAL(5),
	clave_Elector	CHAR(18),
	tipo_cargo	CHAR(15),
	correo		VARCHAR(80),
	id_Casilla	DECIMAL(4),
	CONSTRAINT PK_Representante_Preliminar	PRIMARY KEY	(id_Estado, id_Distrito, seccion_casilla, tipo, id_Politico,id_Rep_Preliminar),
	CONSTRAINT UQ_1	Unique (id_Rep_Preliminar),
	CONSTRAINT FK_4	FOREIGN KEY	(id_Casilla,id_Estado, id_Distrito, seccion_casilla, tipo) REFERENCES Casilla.Casilla(id_Casilla,id_Estado, id_Distrito, seccion_casilla, tipo),
	CONSTRAINT FK_5 FOREIGN KEY	(id_Estado, id_Distrito, id_Politico) REFERENCES Partido_Politico.PartidoPolitico(id_Estado, id_Distrito, id_Politico));
COMMENT ON TABLE Representante.Representante_Preliminar IS 'Tabla que contiene los Representantes Preliminares.';
COMMENT ON COLUMN Representante.Representante_Preliminar.id_Rep_Preliminar IS 'Identificador de Representantes Preliminares.';
COMMENT ON COLUMN Representante.Representante_Preliminar.nombre IS 'Nombre del representante';
COMMENT ON COLUMN Representante.Representante_Preliminar.paterno IS 'Apellido paterno del representante';
COMMENT ON COLUMN Representante.Representante_Preliminar.materno IS 'Apellido materno del representante';
COMMENT ON COLUMN Representante.Representante_Preliminar.estado IS 'Estado al que pertenece el representante';
COMMENT ON COLUMN Representante.Representante_Preliminar.numero IS 'Número de residencia del representante';
COMMENT ON COLUMN Representante.Representante_Preliminar.calle IS 'Calle de residencia del representante';
COMMENT ON COLUMN Representante.Representante_Preliminar.seccion IS 'Sección en donde habita el representante';
COMMENT ON COLUMN Representante.Representante_Preliminar.clave_Elector IS 'Clave de elector del representante';
COMMENT ON COLUMN Representante.Representante_Preliminar.correo IS 'Correo del representante';
COMMENT ON COLUMN  Representante.Representante_Preliminar.tipo_cargo IS 'Tipo de cargo del representante: Propietario o suplente';


--Crea la Tabla Nombre en el esquema Representante
CREATE TABLE Representante.Nombre(
	id_Rep_Preliminar DECIMAL(4),
	nombre	VARCHAR(40),
	CONSTRAINT PK_Nombre PRIMARY KEY (id_Rep_Preliminar,nombre),
	CONSTRAINT FK_21 FOREIGN KEY	(id_Rep_Preliminar) REFERENCES Representante.Representante_Preliminar(id_Rep_Preliminar));
COMMENT ON TABLE Representante.Nombre IS 'Tabla que contiene los nombres de los representantes preliminares.';
COMMENT ON COLUMN Representante.Nombre.nombre IS 'Nombre de cada representante.';
	


--Crea la Tabla Representante_Aprobado en el esquema Representante
CREATE TABLE Representante.Representante_Aprobado(
	id_Rep_Preliminar DECIMAL(4),
	curp 		CHAR(18),
	CONSTRAINT PK_Representante_Aprobado	PRIMARY KEY	(id_Rep_Preliminar,curp),
	CONSTRAINT UQ_2 Unique (curp),
	CONSTRAINT FK_6 FOREIGN KEY	(id_Rep_Preliminar) REFERENCES Representante.Representante_Preliminar(id_Rep_Preliminar));
COMMENT ON TABLE Representante.Representante_Aprobado IS 'Tabla que contiene los Representantes Aprobados.';
COMMENT ON COLUMN Representante.Representante_Aprobado.curp IS 'Identificador del representante aprobado que está dada por la CURP de éste.';

--Crea la Tabla Representante sustituciones en el esquema Representante
CREATE TABLE Representante.Representante_Sustituciones(
	id_RepSustituido DECIMAL(4),
	id_Rep_Preliminar DECIMAL(4),
	curp 		CHAR(18),
	CONSTRAINT PK_Representante_Sustituciones	PRIMARY KEY	(id_Rep_Preliminar,curp, id_RepSustituido),
	CONSTRAINT UQ_3 Unique (id_RepSustituido),
	CONSTRAINT FK_7 FOREIGN KEY	(id_Rep_Preliminar) REFERENCES Representante.Representante_Preliminar(id_Rep_Preliminar),
	CONSTRAINT FK_8 FOREIGN KEY	(curp) REFERENCES Representante.Representante_Aprobado(curp));
COMMENT ON TABLE Representante.Representante_Sustituciones IS 'Tabla que contiene a los representantes que sustituyeron y por quiénes fueron sustituidos.';

--Crea la Tabla log_RepAprobado en el esquema Representante
CREATE TABLE Representante.log_RepAprobado(
	curp 		CHAR(18),
	idLog_Aprobado	DECIMAL(4),
	CONSTRAINT PK_log_RepAprobado	PRIMARY KEY	(curp, idLog_Aprobado),
	CONSTRAINT UQ_4 Unique (idLog_Aprobado),
	CONSTRAINT FK_9 FOREIGN KEY	(curp) REFERENCES Representante.Representante_Aprobado(curp));
COMMENT ON TABLE Representante.log_RepAprobado IS 'Tabla que contiene los representantes modificados y la modificación que se realizó.';

--Crea la Tabla Asistencia en el esquema Representante
CREATE TABLE Representante.Asistencia(
	id_Asistencia	DECIMAL(4),
	curp 		char(18),
	hora_inicio	TIME,
	hora_fin	TIME,
	inicio		DATE,
	fin		DATE,
	CONSTRAINT	PK_Asistencia	PRIMARY KEY	(curp,id_Asistencia),
	CONSTRAINT UQ_5 Unique (id_Asistencia),
	CONSTRAINT FK_10 FOREIGN KEY	(curp) REFERENCES Representante.Representante_Aprobado(curp));
COMMENT ON TABLE Representante.Asistencia IS 'Tabla que contiene las asistencias de los representantes aprobados.';
COMMENT ON COLUMN Representante.Asistencia.id_Asistencia IS 'Identificador para cada asistencia.';
COMMENT ON COLUMN Representante.Asistencia.hora_inicio IS 'Hora en la que el representante inicio la jornada';
COMMENT ON COLUMN Representante.Asistencia.hora_fin IS 'Hora en la que el representante finalizó la jornada';
COMMENT ON COLUMN Representante.Asistencia.inicio IS 'inicio de la jornada';
COMMENT ON COLUMN Representante.Asistencia.fin IS 'fin de la jornada';

CREATE TABLE Representante.Modificar(
	idLog_Aprobado	DECIMAL(4),
	curp 		CHAR(18),
	hora_modificacion TIME,
	usuario	VARCHAR(80),
	tipo_Operacion	char(1),
	CONSTRAINT PK_Modificar PRIMARY KEY (curp, idLog_Aprobado),
	CONSTRAINT	FK_11	FOREIGN KEY (curp) REFERENCES Representante.Representante_Aprobado(curp),
	CONSTRAINT FK_14 	FOREIGN KEY (idLog_Aprobado) REFERENCES Representante.log_RepAprobado(idLog_Aprobado));
COMMENT ON TABLE Representante.Modificar IS 'Tabla que contiene las modificaciones realizadas a un representante.';
COMMENT ON COLUMN  Representante.Modificar.hora_modificacion IS 'Hora en la que se modificó al representante.';
COMMENT ON COLUMN  Representante.Modificar.usuario IS 'Usuario que modificó al representante.';

CREATE TABLE Representante.Sustituir(
	curp	CHAR(18),
	id_RepSustituido DECIMAL(4),
	fecha_sustitucion DATE,
	hora_sustitucion TIME,
	CONSTRAINT 	PK_Sustituir PRIMARY KEY (curp, id_RepSustituido),
	CONSTRAINT FK_13	FOREIGN KEY (curp) REFERENCES Representante.Representante_Aprobado(curp),
	CONSTRAINT FK_14 	FOREIGN KEY (id_RepSustituido) REFERENCES Representante.Representante_Sustituciones(id_RepSustituido));
COMMENT ON TABLE  Representante.Sustituir IS 'Tabla que contiene la hora y fecha de sustitución.';
COMMENT ON COLUMN  Representante.Sustituir.fecha_sustitucion IS 'Fecha que se sustituyó al representante.';
COMMENT ON COLUMN  Representante.Sustituir.hora_sustitucion IS 'Hora en la que se sustituyó al representante';

CREATE TABLE Representante.Agregar(
	id_Rep_Preliminar DECIMAL(4),
	id_RepSustituido DECIMAL(4),
	fecha_agregacion DATE,
	hora_agregacion TIME,
	CONSTRAINT 	PK_Agregar PRIMARY KEY(id_Rep_Preliminar, id_RepSustituido),
	CONSTRAINT FK_15 FOREIGN KEY (id_Rep_Preliminar) REFERENCES Representante.Representante_Preliminar(id_Rep_Preliminar),
	CONSTRAINT FK_16 FOREIGN KEY (id_RepSustituido) REFERENCES Representante.Representante_Sustituciones(id_RepSustituido));
COMMENT ON TABLE Representante.Agregar IS 'Tabla que contiene los representantes que serán agregados.';
COMMENT ON COLUMN Representante.Agregar.hora_agregacion IS 'Hora en la que se agregó el representante';
COMMENT ON COLUMN Representante.Agregar.fecha_agregacion IS 'Fecha en la que se agregó el representante';

CREATE TABLE Representante.Registrar(
	id_Rep_Preliminar DECIMAL(4),
	id_Estado	DECIMAL(4),
	id_Distrito	DECIMAL(4),	
	id_Politico	DECIMAL(4),
	siglas 		VARCHAR(10), 
	nombre		VARCHAR(40),
	fecha_registro	DATE,
	hora_registro	TIME, 
	paterno		VARCHAR(40),
	materno		VARCHAR(40),
	estado		VARCHAR(40),
	numero		DECIMAL(4),
	calle		VARCHAR(80),
	seccion 	DECIMAL(5),
	tipo_cargo	CHAR(15),
	clave_Elector	CHAR(18),
	correo		VARCHAR(80),
	CONSTRAINT PK_Registrar PRIMARY KEY(id_Rep_Preliminar),
	CONSTRAINT FK_17 FOREIGN KEY (id_Rep_Preliminar) REFERENCES Representante.Representante_Preliminar(id_Rep_Preliminar),
	CONSTRAINT FK_18 FOREIGN KEY (id_Estado, id_Distrito, id_Politico) REFERENCES Partido_Politico.PartidoPolitico(id_Estado, id_Distrito, id_Politico));
COMMENT ON TABLE Representante.Registrar IS 'Tabla que contiene los representantes registrados por partidos politicos.';

CREATE TABLE Representante.Alojar(
	id_Rep_Preliminar DECIMAL (4),
	id_Estado	DECIMAL(4),
	id_Distrito 	DECIMAL(4), 	
	seccion_casilla	DECIMAL(5),
	tipo		CHAR(1),
	nombre		VARCHAR(40),
	paterno		VARCHAR(40),
	materno		VARCHAR(40),
	estado		VARCHAR(40),
	numero		DECIMAL(4),
	calle		VARCHAR(80),
	seccion 	DECIMAL(5),
	tipo_cargo	CHAR(15),
	clave_Elector	char(18),
	correo		VARCHAR(80),
	aprobada	CHAR(1),
	id_Casilla 	DECIMAL(4),
	CONSTRAINT PK_Alojar PRIMARY KEY (id_Rep_Preliminar, id_Estado, id_Distrito, seccion_casilla, tipo),
	CONSTRAINT FK_19 FOREIGN KEY (id_Casilla,id_Estado, id_Distrito, seccion_casilla,tipo) REFERENCES Casilla.Casilla(id_Casilla,id_Estado, id_Distrito, seccion_casilla,tipo),
	CONSTRAINT FK_20 FOREIGN KEY (id_Rep_Preliminar) REFERENCES Representante.Representante_Preliminar(id_Rep_Preliminar));
COMMENT ON TABLE Geografico.Estado IS 'Tabla que contiene los representantes que son alojados en casillas.';

ALTER TABLE Representante.Nombre RENAME TO Informacion_representante;

ALTER TABLE Representante.Informacion_representante ADD paterno VARCHAR(40);
ALTER TABLE Representante.Informacion_representante ADD materno VARCHAR(40);
ALTER TABLE Representante.Informacion_representante ADD estado VARCHAR(40);
ALTER TABLE Representante.Informacion_representante ADD numero DECIMAL(4);
ALTER TABLE Representante.Informacion_representante ADD calle VARCHAR(80);
ALTER TABLE Representante.Informacion_representante ADD seccion DECIMAL(4);
ALTER TABLE Representante.Informacion_representante ADD clave_elector CHAR(18);
ALTER TABLE Representante.Informacion_representante ADD correo VARCHAR(80);

COMMENT ON COLUMN Representante.Informacion_representante.paterno IS 'Apellido paterno del representante';
COMMENT ON COLUMN Representante.Informacion_representante.materno IS 'Apellido materno del representante';
COMMENT ON COLUMN Representante.Informacion_representante.estado IS 'Estado al que pertenece el representante';
COMMENT ON COLUMN Representante.Informacion_representante.numero IS 'Número de residencia del representante';
COMMENT ON COLUMN Representante.Informacion_representante.calle IS 'Calle de residencia del representante';
COMMENT ON COLUMN Representante.Informacion_representante.seccion IS 'Sección en donde habita el representante';
COMMENT ON COLUMN Representante.Informacion_representante.clave_Elector IS 'Clave de elector del representante';
COMMENT ON COLUMN Representante.Informacion_representante.correo IS 'Correo del representante';

ALTER TABLE Representante.Representante_Preliminar DROP COLUMN paterno;
ALTER TABLE Representante.Representante_Preliminar DROP COLUMN materno;
ALTER TABLE Representante.Representante_Preliminar DROP COLUMN estado;
ALTER TABLE Representante.Representante_Preliminar DROP COLUMN numero;
ALTER TABLE Representante.Representante_Preliminar DROP COLUMN calle;
ALTER TABLE Representante.Representante_Preliminar DROP COLUMN seccion;
ALTER TABLE Representante.Representante_Preliminar DROP COLUMN clave_elector;
ALTER TABLE Representante.Representante_Preliminar DROP COLUMN correo;

CREATE TABLE Representante.Aprobar(
	id_Rep_Preliminar DECIMAL(4),
	curp 		CHAR(18),
	usuario 	VARCHAR(15),
	fecha_aprobacion	DATE NOT NULL,
	hora_aprobacion		TIME NOT NULL,
	CONSTRAINT PK_Aprobar PRIMARY KEY (id_Rep_Preliminar,curp),
	CONSTRAINT FK_21 FOREIGN KEY (id_Rep_Preliminar) REFERENCES Representante.Representante_Preliminar(id_Rep_Preliminar),
	CONSTRAINT FK_22 FOREIGN KEY (curp) REFERENCES Representante.Representante_Aprobado(curp));

COMMENT ON COLUMN Representante.Aprobar.fecha_aprobacion IS 'Fecha de aprobación del representante preliminar';
COMMENT ON COLUMN Representante.Aprobar.hora_aprobacion IS 'Hora de aprobación del representante preliminar';
COMMENT ON COLUMN Representante.Aprobar.usuario IS 'Usuario que aprobó al representante';
COMMENT ON COLUMN Representante.Aprobar.id_Rep_Preliminar IS 'El id del representante preliminar que ha sido aprobado';
COMMENT ON COLUMN Representante.Aprobar.curp IS 'curp del representante';

ALTER TABLE Geografico.Estado ADD abreviaturas CHAR(10); 


COMMENT ON COLUMN Casilla.Casilla.id_Casilla is 'id de la Casilla';

ALTER TABLE Casilla.Casilla ADD CONSTRAINT UQ_7 UNIQUE (id_Casilla);


ALTER TABLE Representante.Informacion_representante DROP CONSTRAINT FK_21;

ALTER TABLE Representante.Informacion_representante DROP COLUMN id_Rep_Preliminar;

ALTER TABLE Representante.Informacion_representante ADD PRIMARY KEY (clave_elector);

ALTER TABLE Representante.Representante_Preliminar DROP CONSTRAINT PK_Representante_Preliminar;

ALTER TABLE Representante.Representante_Preliminar ADD clave_Elector CHAR(18);

COMMENT ON COLUMN Representante.Representante_Preliminar.clave_Elector IS 'Clave de elector del representante';

ALTER TABLE Representante.Representante_Preliminar ADD CONSTRAINT FK_23 FOREIGN KEY (clave_Elector) REFERENCES Representante.Informacion_representante(clave_Elector);

ALTER TABLE Representante.Representante_Preliminar ADD CONSTRAINT PK_Representante_Preliminar PRIMARY KEY(id_Estado, id_Distrito, seccion_casilla, tipo, id_Politico,id_Rep_Preliminar, clave_elector);

DROP TABLE Representante.Agregar;

CREATE TABLE Representante.log_Preliminar(
	clave_elector 		CHAR(18) NOT NULL,
	id_Log_Preliminar	DECIMAL(4),
	hora_preliminar		TIME,
	fecha_preliminar 	DATE,
	usuario_preliminar	VARCHAR(40),
	tipo_Operacion_preliminar VARCHAR(20),
	nombre		VARCHAR(40),
	paterno		VARCHAR(40),
	materno		VARCHAR(40),
	fecha_nacimiento DATE,
	estado		VARCHAR(40),
	numero		DECIMAL(4),
	calle		VARCHAR(80),
	seccion 	DECIMAL(5),
	correo		VARCHAR(80),
	CONSTRAINT PK_log_Preliminar PRIMARY KEY (id_Log_Preliminar));
COMMENT ON TABLE Representante.log_Preliminar IS 'Tabla que contiene las modificaciones a los representantes preliminares';
COMMENT ON COLUMN Representante.log_Preliminar.clave_elector IS 'La clave de elector del representante al que se le está haciendo la modificación';
COMMENT ON COLUMN Representante.log_Preliminar.id_Log_Preliminar IS 'ID de la operación a determinado representante';
COMMENT ON COLUMN Representante.log_Preliminar.hora_preliminar IS 'Hora en que se realizó la operación';
COMMENT ON COLUMN Representante.log_Preliminar.fecha_preliminar IS 'Fecha en la que se hizo la operación';
COMMENT ON COLUMN Representante.log_Preliminar.usuario_preliminar IS 'Usuario que realizó la operación';
COMMENT ON COLUMN Representante.log_Preliminar.tipo_Operacion_Preliminar IS 'Tipo de operación que se realizó al representante';
COMMENT ON COLUMN Representante.log_Preliminar.nombre IS 'Nombre del representante';
COMMENT ON COLUMN Representante.log_Preliminar.paterno IS 'Apellido paterno del representante';
COMMENT ON COLUMN Representante.log_Preliminar.materno IS 'Apellido materno del representante';
COMMENT ON COLUMN Representante.log_Preliminar.fecha_nacimiento IS 'Fecha de nacimiento del representante';
COMMENT ON COLUMN Representante.log_Preliminar.estado IS 'Estado al que pertenece el representante';
COMMENT ON COLUMN Representante.log_Preliminar.numero IS 'Número de residencia del representante';
COMMENT ON COLUMN Representante.log_Preliminar.calle IS 'Calle de residencia del representante';
COMMENT ON COLUMN Representante.log_Preliminar.seccion IS 'Sección en donde habita el representante';
COMMENT ON COLUMN Representante.log_Preliminar.clave_Elector IS 'Clave de elector del representante';
COMMENT ON COLUMN Representante.log_Preliminar.correo IS 'Correo del representante';

ALTER TABLE Representante.Modificar DROP CONSTRAINT FK_14;

ALTER TABLE Representante.Modificar DROP CONSTRAINT FK_11;

DROP TABLE Representante.log_RepAprobado;

ALTER TABLE Representante.Modificar RENAME TO log_RepAprobado;
COMMENT ON COLUMN Representante.log_RepAprobado.tipo_Operacion IS 'Tipo de operación que se realizó al representante aprobado';
COMMENT ON COLUMN Representante.log_RepAprobado.curp IS 'Curp del representante al que se le hará la modificación';
COMMENT ON COLUMN Representante.log_RepAprobado.idLog_Aprobado IS 'identificador para la operación y el representante al que se le aplica dicha operación';


COMMENT ON COLUMN Casilla.Casilla.id_Estado IS 'Estado al que pertenece la casilla';

COMMENT ON COLUMN Casilla.Casilla.id_Distrito IS 'Distrito al que pertenece la casilla';

COMMENT ON COLUMN Geografico.Estado.abreviaturas IS 'Abreviaturas del estado';

COMMENT ON COLUMN Geografico.Distrito.id_Estado IS 'Estado al que pertenece el distrito';

COMMENT ON COLUMN Partido_Politico.PartidoPolitico.id_Estado IS 'Estado al que pertenece el partido político';
COMMENT ON COLUMN Partido_Politico.PartidoPolitico.id_Distrito IS 'Distrito al que pertenece el partido político';
COMMENT ON COLUMN Partido_Politico.PartidoPolitico.nombre_partido IS 'Nombre que tiene el partido Politico';
COMMENT ON COLUMN Partido_Politico.PartidoPolitico.siglas IS 'Siglar que tiene el partido político';

ALTER TABLE Representante.Alojar DROP COLUMN paterno;
ALTER TABLE Representante.Alojar DROP COLUMN materno;
ALTER TABLE Representante.Alojar DROP COLUMN estado;
ALTER TABLE Representante.Alojar DROP COLUMN numero;
ALTER TABLE Representante.Alojar DROP COLUMN calle;
ALTER TABLE Representante.Alojar DROP COLUMN seccion;
ALTER TABLE Representante.Alojar DROP COLUMN clave_elector;
ALTER TABLE Representante.Alojar DROP COLUMN correo;


ALTER TABLE Representante.Registrar DROP COLUMN paterno;
ALTER TABLE Representante.Registrar DROP COLUMN materno;
ALTER TABLE Representante.Registrar DROP COLUMN estado;
ALTER TABLE Representante.Registrar DROP COLUMN numero;
ALTER TABLE Representante.Registrar DROP COLUMN calle;
ALTER TABLE Representante.Registrar DROP COLUMN seccion;
ALTER TABLE Representante.Registrar DROP COLUMN correo;

ALTER TABLE Representante.Alojar ADD clave_elector CHAR(18);

COMMENT ON COLUMN Representante.Alojar.clave_elector IS 'Clave de elector del representante que aloja la casilla';

COMMENT ON COLUMN Representante.Aprobar.curp IS 'Curp del representante que está siendo aprobado';

COMMENT ON COLUMN Representante.Alojar.id_Rep_Preliminar IS 'Identificador de Representantes Preliminar que está siendo alojado en la casilla.';
COMMENT ON COLUMN Representante.Alojar.id_Estado IS 'Estado de la casilla';
COMMENT ON COLUMN Representante.Alojar.id_Distrito IS 'Distrito de la casilla';
COMMENT ON COLUMN Representante.Alojar.seccion_casilla IS 'Sección de la casilla';
COMMENT ON COLUMN Representante.Alojar.tipo IS 'Tipo de la casilla';
COMMENT ON COLUMN Representante.Alojar.tipo_cargo IS 'tipo de cargo del representante';
COMMENT ON COLUMN Representante.Alojar.aprobada IS 'Nos dice si la casilla es aprobada o no';

ALTER TABLE Representante.Alojar DROP COLUMN nombre;

COMMENT ON COLUMN Representante.Asistencia.curp IS 'Curp del representante aprobado que toma asistencia';


COMMENT ON COLUMN Representante.Registrar.tipo_cargo IS 'tipo de cargo del representante';
COMMENT ON COLUMN Representante.Registrar.id_Rep_Preliminar IS 'Identificador de Representantes Preliminar que está siendo alojado en la casilla.';
COMMENT ON COLUMN Representante.Registrar.clave_elector IS 'Clave de elector del representante';
COMMENT ON COLUMN Representante.Registrar.id_Politico IS 'Partido que registra al representante';
COMMENT ON COLUMN Representante.Registrar.id_Estado IS 'Estado del partido que está registrando';
COMMENT ON COLUMN Representante.Registrar.id_Distrito IS 'Distrito del partido que está registrando';
COMMENT ON COLUMN Representante.Registrar.siglas IS 'Siglas del partido que está registrando';

ALTER TABLE Representante.Registrar DROP COLUMN nombre;

ALTER TABLE Representante.Registrar ADD COLUMN nombre_partido VARCHAR(80);

COMMENT ON COLUMN Representante.Registrar.nombre_partido IS 'Nombre del partido que está registrando';

COMMENT ON COLUMN Representante.Registrar.hora_registro IS 'Hora que se registró al representante';
COMMENT ON COLUMN Representante.Registrar.fecha_registro IS 'Fecha que se registró al representante';

COMMENT ON COLUMN Representante.Representante_Aprobado.id_Rep_Preliminar IS 'Representante preliminar que fue aprobado';

COMMENT ON COLUMN Representante.Representante_Preliminar.id_Politico IS 'Partido al que pertenece el representante';
COMMENT ON COLUMN Representante.Representante_Preliminar.id_Estado IS 'Estado al que pertenece la casilla';
COMMENT ON COLUMN Representante.Representante_Preliminar.id_Distrito IS 'Distrito al que pertenece la casilla';
COMMENT ON COLUMN Representante.Representante_Preliminar.tipo IS 'Tipo de la casilla';
COMMENT ON COLUMN Representante.Representante_Preliminar.seccion_casilla IS 'Sección de la casilla';

COMMENT ON COLUMN Representante.Representante_Sustituciones.curp IS 'Representante que será sustituido';
COMMENT ON COLUMN Representante.Representante_Sustituciones.id_Rep_Preliminar IS 'Representante preliminar que va a sustituir';
COMMENT ON COLUMN Representante.Representante_Sustituciones.id_RepSustituido IS 'Id que identifica a los dos representantes';

COMMENT ON COLUMN Representante.Sustituir.curp IS 'Curp del que se va a sustituir';
COMMENT ON COLUMN Representante.Sustituir.id_RepSustituido IS 'id para los representantes que van a sustituir';

ALTER TABLE Representante.Sustituir ADD COLUMN id_Rep_Preliminar DECIMAL(4);
COMMENT ON COLUMN Representante.Sustituir.id_Rep_Preliminar IS 'Representante que sustituye';

ALTER TABLE Representante.Representante_Aprobado ADD COLUMN activo BOOLEAN;
COMMENT ON COLUMN Representante.Representante_Aprobado.activo IS 'Nos dice si un representante aun está o ya fue sustituido (dado de baja)';

ALTER TABLE Representante.Informacion_Representante ADD COLUMN genero CHAR(1);
COMMENT ON COLUMN Representante.Informacion_Representante.genero IS 'El género del representante';

ALTER TABLE Representante.Representante_Preliminar ADD COLUMN activo_preliminar BOOLEAN;
COMMENT ON COLUMN Representante.Representante_Preliminar.activo_preliminar IS 'Nos dice si un representante aun está o ya fue sustituido (dado de alta)';

ALTER TABLE Representante.log_RepAprobado ADD COLUMN fecha_modificacion DATE;
COMMENT ON COLUMN Representante.log_RepAprobado.fecha_modificacion IS 'Fecha de modificación del representante aprobado';

ALTER TABLE Representante.Representante_Preliminar DROP CONSTRAINT FK_23;

DROP TABLE Representante.Informacion_Representante;

CREATE TABLE Representante.Nombre_Representante(
	nombre		VARCHAR(40),
	paterno		VARCHAR(40),
	materno		VARCHAR(40),
	fecha_nacimiento	DATE,
	clave_elector	CHAR(18),
	CONSTRAINT PK_Nombre PRIMARY KEY(nombre,paterno,materno,fecha_nacimiento));
COMMENT ON COLUMN Representante.Nombre_Representante.nombre IS 'Nombre del representante preliminar.';
COMMENT ON COLUMN Representante.Nombre_Representante.paterno IS 'Apellido paterno del representante.';
COMMENT ON COLUMN Representante.Nombre_Representante.materno IS 'Apellido materno del representante preliminar';
COMMENT ON COLUMN Representante.Nombre_Representante.fecha_nacimiento IS 'Fecha de nacimiento del representante preliminar';
COMMENT ON COLUMN Representante.Nombre_Representante.clave_elector IS 'Clave de elector del representante preliminar';

CREATE TABLE Representante.Direccion_Representante(
	estado		VARCHAR(40),
	numero		DECIMAL(4),
	calle		VARCHAR(80),
	seccion 	DECIMAL(5),
	correo		VARCHAR(80),
	clave_elector	CHAR(18),
	CONSTRAINT PK_Direccion PRIMARY KEY(clave_elector));
COMMENT ON COLUMN Representante.Direccion_Representante.estado IS 'Estado al que pertenece el representante';
COMMENT ON COLUMN Representante.Direccion_Representante.numero IS 'Número de residencia del representante';
COMMENT ON COLUMN Representante.Direccion_Representante.calle IS 'Calle de residencia del representante';
COMMENT ON COLUMN Representante.Direccion_Representante.seccion IS 'Sección en donde habita el representante';
COMMENT ON COLUMN Representante.Direccion_Representante.clave_Elector IS 'Clave de elector del representante';
COMMENT ON COLUMN Representante.Direccion_Representante.correo IS 'Correo del representante';

CREATE TABLE Representante.Genero_Representante(
	genero		CHAR(1),
	clave_elector	CHAR(18),
	CONSTRAINT PK_Genero	PRIMARY KEY(Clave_elector));
COMMENT ON COLUMN Representante.Genero_Representante.clave_elector IS 'Clave de elector del representante';
COMMENT ON COLUMN Representante.Genero_Representante.genero IS 'Genero del representante';

ALTER TABLE Representante.Representante_Preliminar ADD CONSTRAINT FK_23 FOREIGN KEY (clave_Elector) REFERENCES Representante.Direccion_Representante(clave_Elector);

CREATE TABLE Representante.Informacion(
	nombre		VARCHAR(40),
	paterno		VARCHAR(40),
	materno		VARCHAR(40),
	fecha_nacimiento	DATE,
	genero		CHAR(1),
	CONSTRAINT PK_Informacion PRIMARY KEY(nombre,paterno,materno,fecha_nacimiento,genero));
COMMENT ON COLUMN Representante.Informacion.nombre IS 'Nombre del representante preliminar.';
COMMENT ON COLUMN Representante.Informacion.paterno IS 'Apellido paterno del representante.';
COMMENT ON COLUMN Representante.Informacion.materno IS 'Apellido materno del representante preliminar';
COMMENT ON COLUMN Representante.Informacion.fecha_nacimiento IS 'Fecha de nacimiento del representante preliminar';
COMMENT ON COLUMN Representante.Informacion.genero IS 'Genero del representante preliminar';

ALTER TABLE Representante.Representante_Preliminar DROP COLUMN seccion_casilla;
ALTER TABLE Representante.Representante_Preliminar DROP COLUMN tipo;


COMMENT ON COLUMN Representante.Representante_Preliminar.id_casilla IS 'Casilla a la que pertenece el representante';

ALTER TABLE Representante.Representante_Preliminar ADD CONSTRAINT FK_Casilla FOREIGN KEY (id_casilla) REFERENCES Casilla.Casilla(id_casilla);


ALTER TABLE Geografico.Distrito DROP CONSTRAINT FK_1;
ALTER TABLE Partido_Politico.PartidoPolitico DROP CONSTRAINT FK_3;
ALTER TABLE Casilla.Casilla DROP CONSTRAINT FK_4;
ALTER TABLE Representante.Alojar DROP CONSTRAINT FK_19;
ALTER TABLE Representante.Alojar DROP CONSTRAINT FK_20;
ALTER TABLE Representante.Aprobar DROP CONSTRAINT FK_21;
ALTER TABLE Representante.Aprobar DROP CONSTRAINT FK_22;
ALTER TABLE Representante.Asistencia DROP CONSTRAINT FK_10;
ALTER TABLE Representante.Registrar DROP CONSTRAINT FK_17;
ALTER TABLE Representante.Registrar DROP CONSTRAINT FK_18;
ALTER TABLE Representante.Representante_Aprobado DROP CONSTRAINT FK_6;
ALTER TABLE Representante.Representante_Preliminar DROP CONSTRAINT FK_23;
ALTER TABLE Representante.Representante_Preliminar DROP CONSTRAINT FK_5;
ALTER TABLE Representante.Representante_Preliminar DROP CONSTRAINT FK_casilla;
ALTER TABLE Representante.Representante_Sustituciones DROP CONSTRAINT FK_7;
ALTER TABLE Representante.Representante_Sustituciones DROP CONSTRAINT FK_8;
ALTER TABLE Representante.Sustituir DROP CONSTRAINT FK_13;
ALTER TABLE Representante.Sustituir DROP CONSTRAINT FK_14;

CREATE TABLE Representante.Tomar(
	curp	CHAR (18),
	id_Asistencia DECIMAL(4),
	CONSTRAINT PK_Tomar PRIMARY KEY(curp,id_Asistencia));

ALTER TABLE Casilla.Casilla ALTER COLUMN tipo TYPE CHAR(2) USING CAST(tipo AS CHAR);

ALTER TABLE Representante.Representante_Preliminar DROP COLUMN nombre;

ALTER TABLE Representante.Alojar ALTER COLUMN tipo TYPE CHAR(2) USING CAST(tipo AS CHAR);






