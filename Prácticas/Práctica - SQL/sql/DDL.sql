ALTER TABLE Geografico.Distrito ADD CONSTRAINT FK_Estado FOREIGN KEY (id_Estado) REFERENCES Geografico.Estado(id_Estado) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE Partido_Politico.PartidoPolitico ADD CONSTRAINT FK_Distrito01 FOREIGN KEY (id_Estado, id_Distrito) REFERENCES Geografico.Distrito(id_Estado, id_Distrito) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE Casilla.Casilla ADD CONSTRAINT FK_Distrito02 FOREIGN KEY (id_Estado, id_Distrito) REFERENCES Geografico.Distrito(id_Estado, id_Distrito) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;
      
ALTER TABLE Representante.Alojar ADD CONSTRAINT FK_Preliminar01 FOREIGN KEY (id_Rep_Preliminar)
      REFERENCES Representante.Representante_Preliminar (id_Rep_Preliminar) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE Representante.Alojar ADD CONSTRAINT FK_Casilla FOREIGN KEY (id_Casilla, id_Estado, id_Distrito, seccion_casilla, tipo)
        REFERENCES Casilla.Casilla (id_Casilla, id_Estado, id_Distrito, seccion_casilla, tipo) MATCH SIMPLE
        ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Representante.Aprobar ADD CONSTRAINT FK_Aprobado01 FOREIGN KEY (curp)
      REFERENCES Representante.Representante_Aprobado (curp) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE Representante.Aprobar ADD CONSTRAINT FK_Prelimar02 FOREIGN KEY (id_Rep_Preliminar)
      REFERENCES Representante.Representante_Preliminar (id_Rep_Preliminar) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE Representante.Asistencia ADD CONSTRAINT FK_Aprobado02 FOREIGN KEY (curp)
      REFERENCES Representante.Representante_Aprobado (curp) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Representante.Registrar ADD CONSTRAINT  FK_Partido01 FOREIGN KEY (id_Estado, id_Distrito, id_Politico)
      REFERENCES Partido_Politico.PartidoPolitico (id_Estado, id_Distrito, id_Politico) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE Representante.Registrar ADD CONSTRAINT FK_Preliminar03 FOREIGN KEY (id_Rep_Preliminar)
      REFERENCES Representante.Representante_Preliminar (id_Rep_Preliminar) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE Representante.Representante_Aprobado ADD CONSTRAINT FK_Preliminar04 FOREIGN KEY (id_Rep_Preliminar)
      REFERENCES Representante.Representante_Preliminar (id_Rep_Preliminar) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;


 ALTER TABLE Representante.Representante_Preliminar ADD CONSTRAINT FK_Clave FOREIGN KEY (clave_elector)
 REFERENCES Representante.Direccion_Representante (clave_elector) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

 ALTER TABLE Representante.Representante_Preliminar ADD CONSTRAINT FK_Partido02 FOREIGN KEY (id_Estado, id_Distrito, id_Politico)
      REFERENCES Partido_Politico.PartidoPolitico (id_Estado, id_Distrito, id_Politico) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;

 ALTER TABLE Representante.Representante_Preliminar ADD CONSTRAINT FK_Casilla01 FOREIGN KEY (id_Casilla)
      REFERENCES Casilla.Casilla (id_Casilla) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;

 ALTER TABLE Representante.Representante_Sustituciones ADD CONSTRAINT FK_Preliminar05 FOREIGN KEY (id_Rep_Preliminar)
      REFERENCES Representante.Representante_Preliminar (id_Rep_Preliminar) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;
      
ALTER TABLE Representante.Representante_Sustituciones ADD CONSTRAINT  FK_Aprobado03 FOREIGN KEY (curp)
      REFERENCES Representante.Representante_Aprobado (curp) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE Representante.Sustituir ADD CONSTRAINT FK_Aprobado04 FOREIGN KEY (curp)
      REFERENCES Representante.Representante_Aprobado (curp) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE Representante.Sustituir ADD CONSTRAINT FK_Sustituido FOREIGN KEY (id_RepSustituido)
      REFERENCES Representante.Representante_Sustituciones (id_RepSustituido) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE Representante.Sustituir ADD CONSTRAINT FK_Preliminar06 FOREIGN KEY (id_Rep_Preliminar)
      REFERENCES Representante.Representante_Preliminar (id_Rep_Preliminar) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE Representante.Tomar ADD CONSTRAINT FK_Asistencia FOREIGN KEY (id_Asistencia)
      REFERENCES Representante.Asistencia (id_Asistencia) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;
 
ALTER TABLE Representante.Tomar ADD CONSTRAINT FK_Aprobado05 FOREIGN KEY (curp)
      REFERENCES Representante.Representante_Aprobado (curp) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;