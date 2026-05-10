create database dbpracticas;

use dbpracticas;

create table rol (
    codRol int primary key,
    nom varchar(50) not null,
    descr varchar(255) not null,
    permi varchar(255) not null
);

create table usuario (
    codUsu int auto_increment primary key,
    nom1 varchar(20) not null,
    nom2 varchar(20) not null,
    ape1 varchar(20) not null,
    ape2 varchar(20) not null,
    correo varchar(150) unique not null,
    contr varchar(150),
    tel varchar(20),
    dire varchar(150),
    fechnac datetime,
    estado varchar(50)
);

create table empresa (
    codEmp int auto_increment primary key,
    ruc CHAR(13) unique not null,
    razsocial varchar(50),
    nomcomer varchar(100),
    dirfisc varchar(150),
    telprinc varchar(20),
    correo varchar(150),
    pagweb varchar(100),
    reprelegal varchar(150),
    fechcrea datetime not null,
    canttrabaj int,
    est varchar(50)
);

create table facultad (
    codFac int primary key,
    nom varchar(150)
);

create table carrera (
    codCar int primary key,
    nom varchar(150),
    durcic int,
    gradacad varchar(100),
    dircarr varchar(150),
    est varchar(50),
    codFac int not null,
    constraint fk_facultad foreign key (codFac) references facultad (codFac)
);

create table usuario_rol (
    codUsu int,
    codRol int,
    primary key (codUsu, codRol),
    constraint fk_usuario foreign key (codUsu) references usuario (codUsu),
    constraint fk_rol foreign key (codRol) references rol (codRol)
);

create table estudiante (
    codEst int primary key,
    codUni varchar(10) unique not null,
    ciclo int not null,
    promponder int,
    codCar int not null,
    estacad varchar(50),
    constraint fk_carrera_estudiante foreign key (codCar) references carrera(codCar),
    constraint fk_usuario_estudiante foreign key (codEst) references usuario(codUsu)
);

create table sucursal (
    codsuc int auto_increment  primary key,
    nomsuc varchar(150),
    dist varchar(100),
    ciu varchar(100),
    tel varchar(20),
    corr_cont varchar(150),
    respsuc varchar(150),
    codEmp int,
    foreign key (codEmp) references empresa(codEmp)
);

create table convenio (
    codCon int auto_increment primary key,
    fecinic datetime not null,
    fecfin datetime not null,
    tipconv varchar(50) not null,
    est varchar(20) not null,
    numvac int not null,
    observ varchar(255),
    respons varchar(150) not null,
    represen varchar(150) not null,
    codEmp int,
    constraint fk_empresa foreign key (codEmp) references empresa (codEmp)
);

create table documento (
    codDocu int primary key,
    nom varchar(100) not null,
    tip varchar(50) not null,
    fechemi datetime not null,
    fechcar datetime not null,
    form varchar(20),
    tama varchar (20),
    est varchar(20),
    obser TEXT,
    ubicarchi varchar(150),
    codEst int,
    constraint fk_estudiante foreign key (codEst) references estudiante(codEst)
);

create table asesor (
    codAse int primary key,
    espec varchar(150) not null,
    codFac int not null,
    est varchar(50),

    constraint fk_usuario_asesor foreign key (codAse) references usuario(codUsu),
    constraint fk_facultad_asesor foreign key (codFac) references facultad(codFac)
);

create table supervisor (
    codSup int primary key,
    carg varchar(100),
    area_trab varchar(150),
    exp_lab TEXT,
    est varchar(50),
    constraint fk_usuario_supervisor foreign key (codSup) references usuario (codUsu)
);

create table practica_oferta (
    codPracOfe int primary key,
    titulo varchar(150) not null,
    descrip TEXT,
    funcion int not null,
    req varchar(50) not null,
    modal int,
    horar varchar(50),
    durac int,
    remune int,
    fechpub datetime,
    fecierre datetime,
    cantvac int,
    est varchar(50),
    codSuc int,
    constraint fk_sucursal foreign key (codSuc) references sucursal (codsuc)
);

create table convenio_carrera (
    codCon int,
    codCar int,
    primary key (codCon, codCar),
    foreign key (codCon) references convenio (codCon),
    foreign key (codCar) references carrera (codCar)
);

create table postulacion (
    codPost int primary key,
    fecpost datetime,
    estpost varchar(50),
    puntaje int,
    fechresp datetime,
    medcontac int not null,
    codEst int,
    observ TEXT,
    codPracOfe int,
    constraint fk_practicaoferta foreign key (codPracOfe) references practica_oferta (codPracOfe),
    constraint fk_estudiante_postulacion foreign key (codEst) references estudiante (codEst)
);

create table practicaoferta_carrera (
    codPracOfe int,
    codCar int,
    primary key (codPracOfe, codCar),
    foreign key (codPracOfe) references practica_oferta (codPracOfe),
    foreign key (codCar) references carrera (codCar)
);

create table practicarealizada (
    codPracReal int primary key,
    fecinic datetime,
    fecfin datetime,
    modalidad int,
    jornsema int,
    est varchar(50),
    horacumul int,
    areaasign int,
    observ TEXT,
    codAse int,
    codSup int,
    constraint fk_asesor foreign key (codAse) references asesor (codAse),
    constraint fk_supervisor_practicarealizada foreign key (codSup) references supervisor (codSup)
);

create table informefinal (
    codInforFi int primary key,
    titu varchar (100),
    fechent datetime,
    estrev varchar (30),
    obsase TEXT,
    notfin DECIMAL(5,2),
    fechpro datetime,
    constraint fk_informefinal_practicarealizada foreign key (codInforFi) references practicarealizada (codPracReal)
);

create table seguimiento (
    codSeg int auto_increment primary key,
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
    foreign key (codPracReal) references practicarealizada(codPracReal)
);

create table evaluacion (
    codEval int auto_increment primary key,
    fech date,
    crit varchar(50),
    coment varchar(255),
    observ int,
    resultfin text,
    codPracReal int,
    constraint fk_seguimiento foreign key (codPracReal) references seguimiento(codPracReal)
);