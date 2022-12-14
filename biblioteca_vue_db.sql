##DROP DATABASE biblioteca_db;
CREATE DATABASE IF NOT EXISTS biblioteca_vue_db;
USE biblioteca_vue_db;

CREATE TABLE IF NOT EXISTS libro(
	lib_id INT NOT NULL AUTO_INCREMENT,
    lib_titulo VARCHAR(50)NOT NULL,
    lib_autor VARCHAR(50)NOT NULL,
    lib_editorial VARCHAR(50) NOT NULL,
    lib_edicion TINYINT NOT NULL,
    PRIMARY KEY(lib_id)
 );
 
 CREATE TABLE IF NOT EXISTS usuario(
	usu_id INT NOT NULL AUTO_INCREMENT,
    usu_nombre VARCHAR(20)NOT NULL,
    usu_ap_pat VARCHAR(10)NOT NULL,
    usu_ap_mat VARCHAR(10)NOT NULL,
    usu_correo VARCHAR(20)NOT NULL,
    usu_activo VARCHAR(1)NOT NULL,
    PRIMARY KEY(usu_id),
    INDEX (usu_nombre),
    INDEX (usu_ap_pat),
    INDEX (usu_ap_mat),
    UNIQUE (usu_correo)
 );
 CREATE TABLE IF NOT EXISTS prestamo(
	pre_id INT NOT NULL AUTO_INCREMENT,
    pre_fec_pres DATE NOT NULL,
    pre_fec_entre DATE NOT NULL,
    pre_fec_real_entre DATE,
    pre_usu_id INT,
    PRIMARY KEY(pre_id),
	CONSTRAINT fk_usuario_prestamo
        FOREIGN KEY( pre_usu_id)
        REFERENCES usuario(usu_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS detalle_prestamo(
      dep_id INT NOT NULL AUTO_INCREMENT,
	dep_pre_id INT NOT NULL,
    dep_lib_id INT NOT NULL,
    dep_multa DECIMAL(5,2) NOT NULL,
    PRIMARY KEY(dep_id,dep_pre_id,dep_lib_id),
    CONSTRAINT fk_prestamo_detalle_prestamo
	   FOREIGN KEY(dep_pre_id)
       REFERENCES prestamo(pre_id)
       ON DELETE CASCADE
       ON UPDATE CASCADE,
   CONSTRAINT fk_libro_detalle_prestamo
       FOREIGN KEY(dep_lib_id)
       REFERENCES libro(lib_id)
       ON DELETE CASCADE
       ON UPDATE CASCADE
);

INSERT INTO libro(lib_titulo,lib_autor,lib_editorial,lib_edicion)
       VALUES('el calculo de leithold','luois leithold','oxford university press',7);
INSERT INTO libro(lib_titulo,lib_autor,lib_editorial,lib_edicion)
       VALUES('calculo diferencial','samuel fuenlabrada','mcgraw hill',1),
             ('sistemas operativos modernos','andrews. tanenbaum','pearson',3),
             ('sistemas operativos aspectos internos','willian stallings','pearson',2),
             ('fundamentos de bases de datos','silberschatz','mcgraw hill',3),
             ('programacion en c,c++,java y uml','luis joyanes','mcgraw hill',2);

INSERT INTO usuario(usu_nombre,usu_ap_pat,usu_ap_mat,usu_correo,usu_activo)
            VALUES('renato','navarrete','medina','ro.navarrete@ugto.mx','s');
            
INSERT INTO usuario(usu_nombre,usu_ap_pat,usu_ap_mat,usu_correo,usu_activo)
           VALUES('sandra','medina','mosqueda','sandy@hotmail.com','n'),
                  ('ernesto','ramirez','hernandez','ramireze@hotmail.com','s'),
                  ('maria','salgado','rosas','rosas@hotmail.com','n');

INSERT INTO prestamo(pre_fec_pres,pre_fec_entre,pre_fec_real_entre,pre_usu_id)
       VALUES('2022-11-17','2022-11-25','2022-11-19',1);
INSERT INTO prestamo(pre_fec_pres,pre_fec_entre,pre_fec_real_entre,pre_usu_id)
       VALUES('2022-11-20','2022-11-25','2022-11-23',2),
             ('2022-11-21','2022-11-25','2022-11-24',3),
		 ('2022-11-23','2022-11-26','2022-11-24',4),
             ('2022-11-25','2022-11-26','2022-11-25',1);
             
INSERT INTO detalle_prestamo(dep_pre_id,dep_lib_id,dep_multa)
	VALUES(3,1,'5');
