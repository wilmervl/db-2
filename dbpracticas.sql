-- Active: 1777529110319@@127.0.0.1@3306@dbpracticas
CREATE DATABASE dbpracticas;

USE dbpracticas;

CREATE TABLE rol (
    codRol INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    descr VARCHAR(255) NOT NULL,
    permi VARCHAR(255) NOT NULL
);

CREATE TABLE usuario (
    codUsu INT PRIMARY KEY,
    nom1 VARCHAR(20) NOT NULL,
    nom2 VARCHAR(20) NOT NULL,
    ape1 VARCHAR(20) NOT NULL,
    ape2 VARCHAR(20) NOT NULL,
    correo VARCHAR(150) UNIQUE NOT NULL,
    contr VARCHAR(150),
    tel VARCHAR(20),
    dire VARCHAR(150),
    fechnac DATETIME,
    estado VARCHAR(50)
);

CREATE TABLE empresa (
    codEmp INT PRIMARY KEY,
    ruc CHAR(13) UNIQUE NOT NULL,
    razsocial VARCHAR(20),
    nomcomer VARCHAR(100),
    dirfisc VARCHAR(150),
    telprinc VARCHAR(20),
    correo VARCHAR(150),
    pagweb VARCHAR(20),
    reprelegal VARCHAR(150),
    fechcrea DATETIME NOT NULL,
    canttrabaj INT,
    est VARCHAR(50)
);

create table facultad (
    codFac INT PRIMARY KEY,
    nom VARCHAR(150)
);

CREATE TABLE carrera (
    codCar INT PRIMARY KEY,
    nom VARCHAR(150),
    durcic INT,
    gradacad VARCHAR(100),
    dircarr VARCHAR(150),
    est VARCHAR(50),
    codFac INT NOT NULL,
    CONSTRAINT fk_facultad FOREIGN KEY (codFac) REFERENCES facultad (codFac)
);

CREATE TABLE usuario_rol (
    codUsu INT,
    codRol INT,
    PRIMARY KEY (codUsu, codRol),
    CONSTRAINT fk_usuario FOREIGN KEY (codUsu) REFERENCES usuario (codUsu),
    CONSTRAINT fk_rol FOREIGN KEY (codRol) REFERENCES rol (codRol)
);

CREATE TABLE estudiante (
    codEst INT PRIMARY KEY,
    codUni VARCHAR(10) UNIQUE NOT NULL,
    ciclo INT NOT NULL,
    promponder INT,
    codCar INT NOT NULL,
    estacad VARCHAR(50),
    CONSTRAINT fk_carrera_estudiante FOREIGN KEY (codCar) REFERENCES carrera(codCar),
    CONSTRAINT fk_usuario_estudiante FOREIGN KEY (codEst) REFERENCES usuario(codUsu)
);

CREATE TABLE sucursal (
    codsuc INT PRIMARY KEY,
    nomsuc VARCHAR(150),
    dist VARCHAR(100),
    ciu VARCHAR(100),
    tel VARCHAR(20),
    corr_cont VARCHAR(150),
    respsuc VARCHAR(150),
    codEmp INT,
    FOREIGN KEY (codEmp) REFERENCES empresa(codEmp)
);

CREATE TABLE convenio (
    codCon INT PRIMARY KEY,
    fecinic DATETIME NOT NULL,
    fecfin DATETIME NOT NULL,
    tipconv VARCHAR(50) NOT NULL,
    est VARCHAR(20) NOT NULL,
    numvac INT NOT NULL,
    observ VARCHAR(255),
    respons VARCHAR(150) NOT NULL,
    represen VARCHAR(150) NOT NULL,
    codEmp INT,
    CONSTRAINT fk_empresa FOREIGN KEY (codEmp) REFERENCES empresa (codEmp)
);

CREATE TABLE documento (
    codDocu INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    tip VARCHAR(50) NOT NULL,
    fechemi DATETIME NOT NULL,
    fechcar DATETIME NOT NULL,
    form VARCHAR(20),
    tama VARCHAR (20),
    est VARCHAR(20),
    obser TEXT,
    ubicarchi VARCHAR(150),
    codEst INT,
    CONSTRAINT fk_estudiante FOREIGN KEY (codEst) REFERENCES estudiante(codEst)
);

CREATE TABLE asesor (
    codAse INT PRIMARY KEY,
    espec VARCHAR(150) NOT NULL,
    facult VARCHAR(150) NOT NULL,
    est VARCHAR(50),
    CONSTRAINT fk_usuario_asesor FOREIGN KEY (codAse) REFERENCES usuario(codUsu)
);

CREATE TABLE supervisor (
    codSup INT PRIMARY KEY,
    carg VARCHAR(100),
    area_trab VARCHAR(150),
    exp_lab TEXT,
    est VARCHAR(50),
    CONSTRAINT fk_usuario_supervisor FOREIGN KEY (codSup) REFERENCES usuario (codUsu)
);

CREATE TABLE practica_oferta (
    codPracOfe INT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descrip TEXT,
    funcion INT NOT NULL,
    req VARCHAR(50) NOT NULL,
    modal INT,
    horar VARCHAR(50),
    durac INT,
    remune INT,
    fechpub DATETIME,
    fecierre DATETIME,
    cantvac INT,
    est VARCHAR(50),
    codSuc INT,
    CONSTRAINT fk_sucursal FOREIGN KEY (codSuc) REFERENCES sucursal (codsuc)
);

CREATE TABLE convenio_carrera (
    codCon INT,
    codCar INT,
    PRIMARY KEY (codCon, codCar),
    FOREIGN KEY (codCon) REFERENCES convenio (codCon),
    FOREIGN KEY (codCar) REFERENCES carrera (codCar)
);

CREATE TABLE postulacion (
    codPost INT PRIMARY KEY,
    fecpost DATETIME,
    estpost VARCHAR(50),
    puntaje INT,
    fechresp DATETIME,
    medcontac INT NOT NULL,
    codEst INT,
    observ TEXT,
    codPracOfe INT,
    CONSTRAINT fk_practicaoferta FOREIGN KEY (codPracOfe) REFERENCES practica_oferta (codPracOfe),
    CONSTRAINT fk_estudiante_postulacion FOREIGN KEY (codEst) REFERENCES estudiante (codEst)
);

CREATE TABLE practicaoferta_carrera (
    codPracOfe INT,
    codCar INT,
    PRIMARY KEY (codPracOfe, codCar),
    FOREIGN KEY (codPracOfe) REFERENCES practica_oferta (codPracOfe),
    FOREIGN KEY (codCar) REFERENCES carrera (codCar)
);

CREATE TABLE informefinal (
    codInforFi INT PRIMARY KEY,
    titu VARCHAR (100),
    fechent DATETIME,
    estrev VARCHAR (30),
    obsase TEXT,
    notfin DECIMAL(5,2),
    fechpro DATETIME
);

CREATE TABLE practicarealizada (
    codPracReal INT PRIMARY KEY,
    fecinic DATETIME,
    fecfin DATETIME,
    modalidad INT,
    jornsema INT,
    est VARCHAR(50),
    horacumul INT,
    areaasign INT,
    observ TEXT,
    codAse INT,
    codSup INT,
    CONSTRAINT fk_asesor FOREIGN KEY (codAse) REFERENCES asesor (codAse),
    CONSTRAINT fk_supervisor_practicarealizada FOREIGN KEY (codSup) REFERENCES supervisor (codSup)
);

CREATE TABLE practicarealizada_informefinal(
    codInforFi INT,
    codPracReal INT,
    PRIMARY KEY (codInforFi, codPracReal),
    FOREIGN KEY (codInforFi) REFERENCES informefinal(codInforFi),
    FOREIGN KEY (codPracReal) REFERENCES practicarealizada(codPracReal)
);

create table seguimiento (
    codSeg int primary key,
    fech date,
    tip varchar(50),
    descrip varchar(255),
    dificencontradas text,
    observ text,
    porcenavanc int,
    recomend text,
    est varchar(50),
    codPracReal int,
    constraint fk_practicarealizada foreign key (codPracReal) references practicarealizada (codPracReal)
);

create table certificado(
    codPracReal int primary key,
    numcert varchar(50),
    fechemi date,
    horacert int ,
    cargdese varchar(100),
    firmresp varchar(100),
    obs text,
    FOREIGN KEY (codPracReal) REFERENCES practicarealizada(codPracReal)
);

create table evaluacion (
    codEval int primary key,
    fech date,
    crit varchar(50),
    coment varchar(255),
    observ int,
    resultfin text,
    codPracReal int,
    constraint fk_seguimiento foreign key (codPracReal) references seguimiento(codPracReal)
);