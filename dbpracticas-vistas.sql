/*1. vista estudiantes*/
create view vw_estudiante as
select 
    e.codEst,
    e.codUni,
    concat(u.nom1,' ',u.nom2) as nombres,
    concat(u.ape1,' ',u.ape2) as apellidos,
    u.correo,
    u.tel,
    u.dire,
    u.fechnac,
    u.estado,
    c.codCar,
    c.nom as carrera,
    c.durcic,
    c.gradacad,
    c.dircarr,
    f.codFac,
    f.nom as facultad,
    e.ciclo,
    e.promponder,
    e.estacad
from estudiante e
inner join usuario u
on e.codEst = u.codUsu
inner join carrera c
on e.codCar = c.codCar
inner join facultad f
on c.codFac = f.codFac
where u.estado = 'activo';
/*2. vista asesores*/
create view vw_asesores as
select
    a.codAse,
    concat(u.nom1,' ',u.nom2) as nombres,
    concat(u.ape1,' ',u.ape2) as apellidos,
    u.correo,
    u.tel,
    u.dire,
    u.estado,
    a.espec,
    f.codFac,
    f.nom as facultad
from asesor a
inner join usuario u
on a.codAse = u.codUsu
inner join facultad f
on a.codFac = f.codFac;

/*3. vista supervisores*/
create view vw_supervisores as
select 
    s.codSup,
    concat(u.nom1,' ',u.nom2) as nombres,
    concat(u.ape1,' ',u.ape2) as apellidos,
    u.correo,
    u.tel,
    u.dire,
    u.estado,
    s.carg,
    s.area_trab,
    s.exp_lab
from supervisor s
inner join usuario u
on s.codSup = u.codUsu;
/*4. vista practicas ofertas*/
create view vw_practicas_ofertas as
select
    p.codPracOfe,
    p.titulo,
    p.descrip,
    p.funcion,
    p.req,
    p.modal,
    p.horar,
    p.durac,
    p.remune,
    p.fechpub,
    p.fecierre,
    p.cantvac,
    p.est,
    s.codsuc,
    s.nomsuc,
    s.ciu,
    e.codEmp,
    e.nomcomer as empresa
from practica_oferta p
inner join sucursal s
on p.codSuc = s.codsuc
inner join empresa e
on s.codEmp = e.codEmp;
/*5. Vista de empresas y cantidad de sucursales*/
CREATE VIEW vw_empresas_sucursales AS
SELECT 
    emp.codEmp,
    emp.razsocial,
    emp.ruc,
    COUNT(s.codsuc) AS total_sucursales
FROM empresa emp
INNER JOIN sucursal s
    ON emp.codEmp = s.codEmp
GROUP BY emp.codEmp, emp.razsocial, emp.ruc
ORDER BY total_sucursales DESC;

/*6. vista carreras*/
create view vw_carreras as
select 
    c.codCar,
    c.nom as carrera,
    c.durcic,
    c.gradacad,
    c.dircarr,
    c.est,
    f.codFac,
    f.nom as facultad
from carrera c
inner join facultad f
on c.codFac = f.codFac;

/*7. vista postulaciones*/
CREATE VIEW vw_ofertas_activas AS
SELECT 
    po.codPracOfe,
    po.titulo,
    po.req,
    po.remune,
    po.cantvac,
    s.nomsuc,
    emp.razsocial AS empresa,
    DATEDIFF(po.fecierre, NOW()) AS dias_restantes
FROM practica_oferta po
INNER JOIN sucursal s
    ON po.codSuc = s.codsuc
INNER JOIN empresa emp
    ON s.codEmp = emp.codEmp
WHERE po.est = 'ACTIVO'
ORDER BY po.remune DESC;

/*8. Vista de postulaciones por estudiante */
CREATE VIEW vw_postulaciones_estudiantes AS
SELECT 
    p.codPost,
    CONCAT(u.nom1, ' ', u.ape1) AS estudiante,
    po.titulo,
    emp.razsocial AS empresa,
    p.puntaje,
    p.estpost,
    p.fecpost
FROM postulacion p
INNER JOIN estudiante e
    ON p.codEst = e.codEst
INNER JOIN usuario u
    ON e.codEst = u.codUsu
INNER JOIN practica_oferta po
    ON p.codPracOfe = po.codPracOfe
INNER JOIN sucursal s
    ON po.codSuc = s.codsuc
INNER JOIN empresa emp
    ON s.codEmp = emp.codEmp
ORDER BY p.puntaje DESC;

/*9. Vista de cantidad de postulantes por oferta */
CREATE VIEW vw_postulantes_por_oferta AS
SELECT 
    po.codPracOfe,
    po.titulo,
    COUNT(p.codPost) AS cantidad_postulantes
FROM practica_oferta po
INNER JOIN postulacion p
    ON po.codPracOfe = p.codPracOfe
GROUP BY po.codPracOfe, po.titulo
ORDER BY cantidad_postulantes DESC;

/*10. Vista de promedio de puntajes por carrera */
CREATE VIEW vw_promedio_puntaje_carrera AS
SELECT 
    c.nom AS carrera,
    AVG(p.puntaje) AS promedio_puntaje,
    MAX(p.puntaje) AS mayor_puntaje,
    MIN(p.puntaje) AS menor_puntaje
FROM postulacion p
INNER JOIN estudiante e
    ON p.codEst = e.codEst
INNER JOIN carrera c
    ON e.codCar = c.codCar
GROUP BY c.nom
ORDER BY promedio_puntaje DESC;

/* 11. empresas con más ofertas */
CREATE VIEW vw_empresas_mas_ofertas AS
SELECT 
    emp.razsocial,
    (
        SELECT COUNT(*)
        FROM practica_oferta po
        INNER JOIN sucursal s
            ON po.codSuc = s.codsuc
        WHERE s.codEmp = emp.codEmp
    ) AS total_ofertas
FROM empresa emp
ORDER BY total_ofertas DESC;

/* 12. Vista de convenios por empresa y carreras */
CREATE VIEW vw_convenios_carreras AS
SELECT 
    emp.razsocial,
    c.nom AS carrera,
    con.tipconv,
    con.numvac,
    con.est
FROM convenio con
INNER JOIN empresa emp
    ON con.codEmp = emp.codEmp
INNER JOIN convenio_carrera cc
    ON con.codCon = cc.codCon
INNER JOIN carrera c
    ON cc.codCar = c.codCar
ORDER BY emp.razsocial;