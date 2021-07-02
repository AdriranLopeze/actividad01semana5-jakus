CREATE TABLE rol
 (
    name varchar (50),
    CONSTRAINT pk_rol primary key (name)
);

CREATE TABLE user_authority
 (
    name_rol varchar (50) not null,
    login varchar (50) not null,
    CONSTRAINT fk_rol FOREIGN key(name_rol) references rol(name_rol),
    CONSTRAINT fk_usuario FOREIGN key(login) references usuario (login)
);

CREATE TABLE usuario
 (
    login varchar (50),
    password varchar (60) not null,
    email varchar (254) not null,
    activated int4 not null,
    lang_key varchar (6) not null,
    image_url varchar (256),
    activation_key varchar(20),
    reset_key varchar (20),
    reset_date timestamp, 
    CONSTRAINT pk_login primary key (login)
    
);

CREATE TABLE cliente 
(
    numero_documento varchar (50),
    primer_nombre varchar (50)  not null,
    segundo_nombre varchar (50),
    primer_apellido varchar (50) not null,
    segundo_apellido varchar (50), 
    sigla varchar (10) not null,
    login varchar (50) not null,
    CONSTRAINT pk_numero_documento primary key (numero_documento),
    CONSTRAINT fk_tipo_documento FOREIGN KEY (sigla) references tipo_documento (sigla),
    CONSTRAINT fk_user  FOREIGN key (login) references usuario (login)


);

CREATE TABLE tipo_documento
 (
     sigla varchar (10) not null,
     nombre_documento varchar(100),
     estado varchar (40) not null,
     CONSTRAINT pk_sigla primary key (sigla)

);

CREATE TABLE log_errores
(
    id int4 not null,
    nivel varchar (400) not null,
    log_name varchar (400) not null,
    mensaje varchar (400) not null,
    fecha date not null,
    numero_documento varchar (50) not null,
    sigla varchar (10) not null,
    CONSTRAINT pk_id primary key (id),
    CONSTRAINT Fk_cliente FOREIGN key(numero_documento) references cliente (numero_documento),
    CONSTRAINT fk_cliente  FOREIGN key(sigla) references cliente (sigla)

);

CREATE TABLE log_auditoria 
(
    id int4 not null, 
    nivel varchar (400) not null,
    log_name varchar (400) not null,
    mensaje varchar (400) not null,
    fecha date not null,
    numero_documento varchar (50) not null,
    sigla varchar (10) not null,
    CONSTRAINT Pk_id primary key (id), 
    CONSTRAINT fk_cliente  FOREIGN key(numero_documento) references cliente (numero_documento),
    CONSTRAINT fk_cliente  FOREIGN key(sigla) references cliente (sigla) 

);

CREATE TABLE aprendiz 
(
    numero_documento varchar (50) not null,
    sigla varchar (10) not null,
    numero_ficha varchar (100) not null,
    nombre_estado varchar (40) not null,
    CONSTRAINT fk_cliente  FOREIGN key(numero_documento) references cliente (numero_documento),
    CONSTRAINT fk_cliente  FOREIGN key(sigla) references cliente (sigla),
    CONSTRAINT fk__ficha FOREIGN key(numero_ficha) references ficha (numero_ficha),
    CONSTRAINT fk_estado_formacion FOREIGN key (nombre_estado) references estado_formacion (nombre_estado)

);

CREATE TABLE estado_formacion
 (
    nombre_estado varchar (40),
    estado varchar (40) not null,
    CONSTRAINT pk_nombre_estado PRIMARY key (nombre_estado),


);

CREATE TABLE ficha
 (
     numero_ficha varchar (100),
     fecha_inicio date not null,
     fecha_fin date not null,
     ruta varchar (40) not null,
     codigo varchar (50) not null,
     version varchar (40) not null,
     nombre_estado varchar (20) not null,
     sigla_jornada varchar (20) not null,
     CONSTRAINT Pk_numero_ficha PRIMARY key(numero_ficha),
     CONSTRAINT fk_programa FOREIGN key(codigo) references programa (codigo),
     CONSTRAINT fk_programa FOREIGN key(version) references programa (version),
     CONSTRAINT fk_estado_ficha FOREIGN key(nombre_estado) references estado_ficha (nombre_estado),
     CONSTRAINT fk_jornada FOREIGN key(sigla_jornada) references jornada (sigla_jornada)

);

CREATE TABLE ficha_Planeacion 
(
    numero_ficha varchar (100) not null,
    codigo_planeacion varchar (40) not null,
    estado varchar (40) not null,
    CONSTRAINT fk_ficha FOREIGN key(numero_ficha) references ficha (numero_ficha),
    CONSTRAINT fk_planeacion_trimestre FOREIGN key(codigo_planeacion) references planeacion_trimestre (codigo_planeacion)

);

CREATE TABLE estado_ficha
 (
     nombre_estado varchar (20),
     estado int4 not null,
     CONSTRAINT pk_nombre_estado primary key (nombre_estado)

 );

CREATE TABLE jornada 
(
    sigla_jornada varchar (20),
    nombre_jornada varchar (40) not null,
    descripcion varchar (100) not null,
    imagen_url varchar (1000),
    estado varchar (40) not null, 
    CONSTRAINT pk_sigla_jornada primary key (sigla_jornada),

);

CREATE TABLE trimestre 
 (
     nombre_trimestre int4,
     nivel varchar (40) not null,
     sigla_jornada varchar (20) not null,
     estado varchar (40) not null,
     CONSTRAINT pk_nombre_trimestre primary key (nombre_trimestre),
     CONSTRAINT fk_nivel_formacion FOREIGN key(nivel) references nivel_formacion (nivel),
     CONSTRAINT fk_jornada FOREIGN key(sigla_jornada) references jornada (sigla_jornada)

);

CREATE TABLE ficha_has_trimestre 
(
    numero_ficha varchar (100) not null,
    sigla_jornada varchar (20) not null,
    nivel varchar (40) not null,
    nombre_trimestre int4 not null,
    CONSTRAINT fk_ficha FOREIGN key (numero_ficha) references ficha (numero_ficha),
    CONSTRAINT fk_jornada FOREIGN key(sigla_jornada) references jornada (sigla_jornada),
    CONSTRAINT fk_nivel_formacion FOREIGN key(nivel) references nivel_formacion (nivel),
    CONSTRAINT fk_trimestre FOREIGN key(nombre_trimestre) references trimestre (nombre_trimestre)

);

CREATE TABLE resultados_vistos
 (
     codigo_resultado varchar (40) not null,
     codigo_competencia varchar (50) not null,
     codigo_programa varchar (50) not null,
     version_programa varchar (40) not null,
     numero_ficha varchar (100) not null,
     sigla_jornada varchar (20) not null,
     nivel varchar (40) not null,
     nombre_trimestre int4 not null,
     codigo_planeacion varchar (40) not null,
     CONSTRAINT fk_resultado_aprendizaje FOREIGN key(codigo_resultado) references resultado_aprendizaje (codigo_resultado),
     CONSTRAINT fk_competencia FOREIGN key(codigo_competencia) references competencia (codigo_competencia),
     CONSTRAINT fk_programa FOREIGN key (codigo_programa) references  programa (codigo_programa),
     CONSTRAINT fk_programa FOREIGN key(version_programa) references programa (version_programa),
     CONSTRAINT fk_ficha FOREIGN key(numero_ficha) references ficha (numero_ficha),
     CONSTRAINT fk_jornada FOREIGN key(sigla_jornada) references jornada (sigla_jornada),
     CONSTRAINT fk_nivel_formacion FOREIGN key(nivel) references nivel_formacion (nivel),
     CONSTRAINT fk_trimestre FOREIGN key(nombre_trimestre) references trimestre (nombre_trimestre),
     CONSTRAINT fk_planeacion FOREIGN key(codigo_planeacion) references planeacion (codigo_planeacion)

);


CREATE TABLE planeacion
(
    codigo varchar (40),
    estado varchar (40) not null,
    fecha date not null, 
    CONSTRAINT pk_planeacion primary key (codigo)

);

CREATE TABLE nivel_formacion
 (
     nivel varchar (40),
     estado varchar (40) not null,
     CONSTRAINT pk_nivel_formacion primary key (nivel)

);

CREATE TABLE programa
 (
     codigo varchar (50),
     version varchar (40),
     nombre varchar (500) not null,
     sigla varchar (40) not null, 
     estado varchar (40) not null,
     nivel varchar (40) not null,
     CONSTRAINT pk_programa primary key (codigo , version),
     CONSTRAINT fk_nivel_formacion FOREIGN KEY (nivel) references nivel_formacion (nivel)

);

CREATE TABLE competencia
 (
     codigo_competencia varchar (50),
     denominacion varchar (1000),
     codigo_programa varchar (50) not null,
     version_programa varchar (40) not null,
     CONSTRAINT pk_competencia primary key (codigo_competencia),
     CONSTRAINT fk_programa FOREIGN key(codigo_programa,version_programa) references programa (codigo, version)

);

CREATE TABLE resultado_aprendizaje 
(
    codigo_resultado varchar (40),
    denominacion varchar (1000),
    codigo_competencia varchar (50) not null,
    codigo_programa varchar (50) not null,
    version_programa varchar (40) not null,
    CONSTRAINT fk_resultado_aprendizaje primary key (codigo_resultado),
    CONSTRAINT fk_competencia FOREIGN KEY (codigo_competencia) references competencia (codigo ),
    
);

CREATE TABLE planeacion_trimestre
 (
     codigo_resultado varchar (40) not null,
     codigo_competencia varchar (50) not null,
     codigo_programa varchar (50) not null,
     version_programa varchar (40) not null,
     sigla_jornada varchar (20) not null,
     nivel varchar (40) not null,
     nombre_trimestre int4 not null,
     codigo_planeacion varchar (40) not null,
     CONSTRAINT fk_resultado_aprendizaje FOREIGN key(codigo_resultado) references resultado_aprendizaje (codigo_resultado),
     CONSTRAINT fk_competencia FOREIGN key(codigo_competencia) references competencia   (codigo_competencia),
     CONSTRAINT fk_programa FOREIGN key(codigo_programa) references programa (codigo_programa),
     CONSTRAINT fk_programa FOREIGN key(version_programa) references programa (version_programa),
     CONSTRAINT fk_jornada FOREIGN key (sigla_jornada) references jornada (sigla_jornada),
     CONSTRAINT fk_nivel_formacion FOREIGN key(nivel) references nivel_formacion (nivel),
     CONSTRAINT fk_trimestre FOREIGN key (nombre_trimestre) references trimestre (nombre_trimestre),
     CONSTRAINT Fk_planeacion FOREIGN key (codigo_planeacion) references planeacion (codigo_planeacion)

);

CREATE TABLE actividad_planeacion 
(
    codigo_resultado varchar (40) not null,
    codigo_competencia varchar (50) not null,
    codigo_programa varchar (50) not null,
    version_programa varchar (40) not null,
    sigla_jornada varchar (20) not null,
    nivel varchar (40) not null,
    nombre_trimestre int4 not null,
    nombre_fase varchar (40) not null,
    codigo_proyecto varchar (40) not null,
    numero_actividad int4 not null,
    codigo_planeacion varchar (40) not null,
    CONSTRAINT fk_resultado_aprendizaje FOREIGN key(codigo_resultado) references resultado_aprendizaje (codigo_resultado),
    CONSTRAINT fk_competencia FOREIGN key(codigo_competencia) references competencia (codigo_competencia), 
    CONSTRAINT fk_programa FOREIGN key (codigo_programa) references programa (codigo_programa),
    CONSTRAINT fk_programa FOREIGN key(version_programa) references programa (version_programa),
    CONSTRAINT fk_jornada FOREIGN key(sigla_jornada) references jornada (sigla_jornada),
    CONSTRAINT fk_nivel_formacion FOREIGN key(nivel) references nivel_formacion (nivel),
    CONSTRAINT fk_trimestre FOREIGN key(nombre_trimestre) references trimestre (nombre_trimestre),
    CONSTRAINT fk_fase FOREIGN key (nombre_fase) references fase (nombre_fase),
    CONSTRAINT fk_proyecto FOREIGN key (codigo_proyecto) references proyecto (codigo_proyecto),
    CONSTRAINT fk_actividad_proyecto FOREIGN key (numero_actividad) references actividad_proyecto (numero_proyecto),
    CONSTRAINT fk_planeacion FOREIGN key (codigo_planeacion) references planeacion (codigo_planeacion)

);

create table actividadejemplo.nivel_formacion(
    nivel varchar(40) not null ,
    estado varchar(40) not null,
   constraint pk_nivel_formacion primary key (nivel)

);

create table actividadejemplo.programa(
    codigo varchar(50) not null ,
    version varchar(40) not null ,
    nombre varchar(500) not null ,
    sigla varchar(40) not null ,
    estado varchar(40) not null ,
    nivel varchar(40) not null ,
    constraint pk_programa primary key (nivel, codigo),
    constraint fk_nivel_formacion foreign key (nivel) references actividadejemplo.nivel_formacion(nivel),
);

    create table actividadejemplo.competencia(
        codigo_competencia varchar(50) not null ,
        denominacion varchar(1000) not null ,
        codigo_programa varchar(50) not null ,
        version_programa varchar(40) not null,
        constraint pk_competencia primary key (codigo_competencia) ,
    );

    create table actividadejemplo.resultado_aprendizaje(
        codigo_resultado varchar(40) not null ,
        denominacion varchar(1000) not null ,
        codigo_competencia varchar(50)not null ,
        codigo_programa varchar(30) not null ,
        version_programa varchar(40) not null ,
        constraint pk_resultado_aprendizaje primary key (codigo_resultado) ,
    );

    create table  actividadejemplo.planeacion_trimestre(
        codigo_resultado varchar(40) not null ,
        codigo_competencia varchar(30) not null ,
        codigo_programa varchar(30) not null ,
        version_programa varchar(40) not null ,
        sigla_jornada varchar(20) not null ,
        nivel varchar(40) not null ,
        nombre_trimestre int4 ,
        codigo_planeacion varchar(40) ,
        constraint pk_codigo_resultado primary key (codigo_resultado) ,
        constraint fk_codigo_resultado foreign key (codigo_resultado) references actividadejemplo.resultado_aprendizaje(codigo_resultado) ,
    );

    create table actividadejemplo.planeacion(
        codigo varchar(40) ,
        estado varchar(40) ,
        fecha date ,
        constraint fk_codigo primary key (codigo) ,
    );

    create table actividadejemplo.actividad_planeacion(
        codigo_resultado varchar(40) ,
        codigo_competencia varchar(50) ,
        codigo_programa varchar(50) ,
        version_programa varchar(40) ,
        sigla_programa varchar(40) ,
        nivel varchar(40) ,
        nombre_trimestre int4 ,
        nombre_fase varchar(40) ,
        codigo_proyecto varchar(40) ,
        numero_activida int4 ,
        codigo_planeacion varchar(40) ,
    );
CREATE TABLE public.dia
(
    nombre_dia character varying(40) COLLATE pg_catalog."default" NOT NULL,
    estado character varying(40) COLLATE pg_catalog."default",
    CONSTRAINT dia_pkey PRIMARY KEY (nombre_dia)
);


CREATE TABLE modalidad (
nombre_modalidad varchar (40),
color  varchar (50),
estado varchar (40),
PRIMARY KEY (nombre_modalidad)
);
CREATE TABLE trimestre_vigente(
trimestre_programado  int4,
fecha_inicio          date,
fecha_fin             date,
estado            varchar (40),
number_year           int4,
constraint pk_trimestre_vigente PRIMARY KEY (number_year,trimestre_programado),
constraint fk_year foreign key (number_year) references year(number_year)
);

CREATE TABLE version_horario(
numero_version     varchar (40),
estado             varchar (40),
number_year         int4,
trimestre_programado int4,
constraint pk_version_horario PRIMARY KEY (trimestre_programdo, number_year,numero_version),
Constraint fk_trimestre_vigente foreign key(trimestre_programado,number_year) references trimestre_vigente
    );
CREATE TABLE horario(
hora_inicio  time ,
hora_fin     time,
numero_documento varchar (50),
sigla           varchar (10),
numero_ambiente  Varchar (50),
nombre_sede   varchar (59),
numero_ficha  Varchar (100),
sigla_jornada  varchar (20),
nivel    varchar (40),
nombre_trimestre  int4 ,
nombre_dia varchar (40),
nombre_modalidad varchar (40),
numero_version varchar (40),
number_year int4,
trimestre_programado int4 ,
CONSTRAINT pk_horario primary key (trimestre_programado,number_year,numero_version,nombre_dia,nombre_trimestre,nivel,sigla_jornada,numero_ficha,nombre_sede,numero_ambiente,sigla,numero_documento,hora_inicio),
CONSTRAINT fk_trimestre_vigente foreign key (trimestre_programado,number_year) REFERENCES trimestre_vigente(trimestre_vigente,number_year),
CONSTRAINT fk_version_horario   FOREIGN KEY (numero_version ) REFERENCES version_horario (numero_version),
CONSTRAINT fk_dia foreign key (nombre_dia) REFERENCES dia (nombre_dia),
CONSTRAINT fk_trimestre foreign key ( nombre_trimestre) REFERENCES trimestre(nombre_trimestre),
CONSTRAINT fk_nivel_formacion foreign key (nivel) references nivel_formacion (nivel),
CONSTRAINT fk_jornada  foreign key (sigla_jornada) REFERENCES jornada(sigla_jornada),
CONSTRAINT fk_ficha foreign key(numero_ficha) REFERENCES ficha(numero_ficha),
CONSTRAINT fk_sede foreign key (nombre_sede) REFERENCES sede(nombre_sede),
CONSTRAINT fk_ambiente foreign key (numero_ambiente) REFERENCES ambiente(numero_ambiente),
CONSTRAINT fk_tipo_documento foreign key (sigla) REFERENCEs tipo_documento(sigla),
CONSTRAINT fk_cliente foreign key (numero_documento) REFERENCES cliente(numero_documento),
CONSTRAINT fk_modalidad foreign key (nombre_modalidad) REFERENCES modalidad(nombre_modalidad)
);

Create table tipo_ambiente(
tipo varchar (50),
descripcion varchar (100),
estado varchar (40),
PRIMARY KEY (tipo)

);

CREATE TABLE sede(
nombre_sede varchar (50),
direccion  varchar (400),
estado     varchar (40),
PRIMARY KEY (nombre_sede)
);
CREATE TABLE ambiente(
numero_ambiente varchar (50),
nombre_sede varchar (50),
descripcion varchar (1000),
estado varchar (40),
limitacion varchar (40),
tipo   varchar (50),
CONSTRAINT pk_ambiente primary key (numero_ambiente,nombre_sede),
CONSTRAINT fk_sede foreign key (nombre_sede) REFERENCES sede(nombre_sede),
CONSTRAINT fk_tip_ambiente foreign key (tipo) REFERENCES tipo_ambiente(tipo)
);
CREATE TABLE limitacion_ambiente(
numero_ambiente     varchar (50),
nombre_sede         varchar(50),
codigo_resultado    varchar (40),
codigo_competencia  varchar (50),
codigo_programa     varchar (50),
version_programa    varchar (40),
CONSTRAINT pk_limitacion_ambiente primary key (numero_ambiente,nombre_sede,codigo_resultado,codigo_competencia,codigo_programa,version_program),
CONSTRAINT fk_ambiente foreign key (numero_ambiente) REFERENCES ambiente(numero_ambiente),
CONSTRAINT fk_sede   foreign key (nombre_sede) REFERENCES sede(nombre_sede),
CONSTRAINT fk_resultado_aprendizaje foreign key (codigo_resultado) REFERENCES resultado_aprendizaje(codigo_resultado),
CONSTRAINT fk_competencia foreign key (codigo_competencia) REFERENCES competencia(codigo_competencia),
CONSTRAINT fk_programa foreign key (codigo_programa,version_programa) REFERENCES programa(codigo_programa,version_programa)	
	
);

CREATE TABLE proyecto(
codigo  varchar (40),
nombre    varchar (500),
estado  varchar (40),
codigo_programa  varchar (50),
version           varchar (40),
PRIMARY KEY (codigo) ,
CONSTRAINT fk_proyecto foreign key (codigo_programa,version)
);

Create TABLE fase(
nombre    Varchar (50),
estado    varchar (40),
codigo_proyecto  varchar (40),
CONSTRAINT pk_fase primary key (nombre,codigo_proyecto),
CONSTRAINT fk_fase foreign key (codigo_proyecto) references fase(codigo_proyecto)
);

CREATE TABLE actividad_proyecto(
numero_actividad int4,
descripcion_actividad varchar (400),
estado varchar (40),
nombre_fase varchar (40),
codigo_proyecto  varchar (40),
CONSTRAINT pk_actividad_proyecto primary key (codigo_proyecto,nombre_fase,numero_actividad),
CONSTRAINT fk_actividad_proyecto foreign key (codigo_proyecto,nombre_fase) references actividad_proyecto(codigo_proyecto,nombre_fase)
):
create table  instructor.area(
nombre_area varchar(40) not null ,
estado varchar(40) not null ,
url_logo varchar(1000) not null ,
constraint pk_instructor primary key (nombre_area),
);
create table  instructor.area_instructor(
numero_documento varchar(40) not null ,
sigla varchar (40) not null ,
nombre_area varchar(40) not null ,
estado  varchar(40) not null ,
constraint pk_numero_documento primary key (numero_documento),
constraint pk_sigla primary key (sigla),
constraint pk_nombre_area primary key (nombre_area),
);
create table  instructor.instructor
estado varchar(40) not null,
numero_documento varchar(50) not null,
sigla varchar(40) not null,
constraint pk_numero_documento primary key (numero_documento),
constraint pk_sigla primary key (sigla),
);
create table instructor.year
number_year int(4) ,
estado varchar(40) not null,
constraint pk_number_year primary key (number_year),

create table instructor.vinculacion
tipo_vinculacion varchar(40)not null,
horas int(4)
estado varchar(40)not null,
constraint pk_tipo_vinculacion primary key (tipo_vinculacion),

);
create table instructor.jornada_instructor
nombre_jornada varchar(80) not null,
descripcion varchar(200) not null,
estado varchar(40) not null,
constraint pk_nombre_jornada primary key (nombre_jornada),
);
create table instructor.disponibilidad_competencias
codigo_competenci varchar(50) not null,
codigo_programa varchar(50) not null,
version_programa varchar(40) not null,
numero_documento varchar(50) not null,
sigla varchar(10) not null,
number_year int(4),
tipo_vinculacion varchar(40) not null,
constraint pk_codigo_competencia primary key (codigo_competencia),
constraint pk_codigo_programa primary key (codigo_programa),
constraint pk_version_programa primary key (version_programa),
constraint pk_sigla primary key (sigla),
constraint pk_number_year primary key (number_year),
constraint pk_tipo_vinculacion primary key (tipo_vinculacion),
constraint pk_fecha_inicio primary key (fecha_inicio),
);
create table instructor.disponibilidad_horaria
numero_documento varchar(50) not null,
sigla varchar(10) not null,
number_year int(4),
tipo_vinculacion varchar(40) not null,
fecha_inicio date,
nombre_jornada varchar(80) not null,
constraint pk_numero_documento primary key (numero_documento),
constraint pk_sigla primary key (sigla),
constraint pk_number_year primary key (number_year),
constraint pk_tipo_vinculacion primary key (tipo_vinculacion),
constraint pk_fecha_inicio  primary key (fecha_inicio ),
constraint pk_nombre_jornada primary key (nombre_jornada),
);

create table instructor.vinculacion_instructor
fecha_inicio date
fecha_fin date
numero_documento varchar(50) not null,
sigla varchar(10) not null,
number_year int(4),
tipo_vinculacion varchar(40) not null,
constraint pk_fecha_inicio primary key (fecha_inicio ),
constraint pk_numero_documento primary key (numero_documento),
constraint pk_sigla primary key (sigla),
constraint pk_number_year primary key (number_year),
constraint pk_tipo_vinculacion primary key (tipo_vinculacion),
);

create table instructor.dia_jornada
hora_inicio int(4)
hora_fin int(4) 
nombre_jornada varchar(80) not null,
nombre_dia varchar(40) not null,
constraint pk_hora_inicio primary key (hora_inicio),
constraint pk_hora_fin primary key (hora_fin),
constraint pk_nombre_jornada primary key (nombre_jornada),
constraint pk_nombre_dia primary key (nombre_dia),
);





