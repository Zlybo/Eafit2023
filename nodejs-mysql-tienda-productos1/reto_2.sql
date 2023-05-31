CREATE DATABASE NODO_Eafit;

USE NODO_Eafit;

CREATE TABLE usuario(
id_usuario int  not null primary key auto_increment,
nombre varchar(50),
email varchar(30),
genero varchar(20),
contraseña varchar(50)
);
CREATE TABLE estudiante(
id_estudiante int  not null primary key,
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) 
		ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE profesor(
id_profesor int  not null primary key,
id_usuario int,
area_ppal varchar(50),
area_alt varchar(50),
telefono int,
FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) 
		ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE administrador(
id_admin  int  not null primary key,
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) 
		ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE curso(
id_curso int not null primary key,
precio double,
url varchar(50),
categoria varchar(50),
año int,
fecha_inicio date,
fecha_fin date,
semestre varchar(50),
nombre varchar(50),
id_profesor int,
FOREIGN KEY (id_profesor) REFERENCES profesor(id_profesor)
       ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE actividad(
id_profesor int,
id_curso int,
id_actividad int not null primary key,
nombre varchar(50),
feche_creacion date,
fecha_fin date,
descripcion varchar (256),
FOREIGN KEY (id_profesor) REFERENCES profesor(id_profesor)
       ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
       ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE participa_act_est(
id_estudiante int not null,
id_actividad int not null,
primary key(id_estudiante,id_actividad),
FOREIGN KEY (id_estudiante) REFERENCES estudiante (id_estudiante) 
		ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (id_actividad) REFERENCES actividad (id_actividad) 
		ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE matricula_est_curso(
id_curso int not null,
id_estudiante int not null,
primary key(id_curso, id_estudiante),
FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
       ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (id_estudiante) REFERENCES estudiante(id_estudiante)
       ON UPDATE CASCADE ON DELETE RESTRICT
); 

CREATE TABLE tarea(
id_tarea int not null primary key,
id_actividad int,
archivo varchar(50),
puntaje double,
FOREIGN KEY (id_actividad) REFERENCES actividad(id_actividad)
       ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE foro(
id_actividad int,
id_foro int not null primary key,
FOREIGN KEY (id_actividad) REFERENCES actividad(id_actividad)
       ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE mensaje(
id_mensaje int not null primary key,
id_foro int,
nombre varchar(50),
descripcion varchar(256),
id_usuario_creador int,
id_usuario_dirigente int,
FOREIGN KEY (id_usuario_creador) REFERENCES usuario(id_usuario)
       ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (id_usuario_dirigente) REFERENCES usuario(id_usuario)
       ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (id_foro) REFERENCES foro(id_foro)
       ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE material(
id_material int not null primary key,
id_curso int,
titulo varchar(50),
descripcion varchar(256),
archivos varchar(50),
FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
       ON UPDATE CASCADE ON DELETE RESTRICT
);