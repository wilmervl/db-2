/*1. vista estudiantes*/
create view vw_estudiante as
select 
    e.codest,
    e.coduni,
    u.nom as nombres,
    u.ape as apellidos,
    u.correo,
    u.tel,
    u.dire,
    u.fechnac,
    u.estado,
    c.codcar,
    c.nom as carrera,
    c.durcic,
    c.gradacad,
    c.dircarr,
    f.codfac,
    f.nom as facultad,
    e.ciclo,
    e.promponder,
    e.estacad
from estudiante e
inner join usuario u
on e.codest = u.codusu
inner join carrera c
on e.codcar = c.codcar
inner join facultad f
on c.codfac = f.codfac
where u.estado = 'activo';

/*2. vista asesores*/
create view vw_asesores as
select
    a.codase,
    u.nom as nombres,
    u.ape as apellidos,
    u.correo,
    u.tel,
    u.dire,
    u.estado,
    a.espec,
    f.codfac,
    f.nom as facultad
from asesor a
inner join usuario u
on a.codase = u.codusu
inner join facultad f
on a.codfac = f.codfac;

/*3. vista supervisores*/
create view vw_supervisores as
select
    s.codsup,
    u.nom as nombres,
    u.ape as apellidos,
    u.correo,
    u.tel,
    u.dire,
    u.estado,
    s.carg,
    s.area_trab,
    s.exp_lab
from supervisor s
inner join usuario u
on s.codsup = u.codusu;

/*4. vista practicas ofertas*/
create view vw_practicas_ofertas as
select
    p.codpracofe,
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
    e.codemp,
    e.nomcomer as empresa
from practicaoferta p
inner join sucursal s
on p.codsuc = s.codsuc
inner join empresa e
on s.codemp = e.codemp;

/*5. vista de empresas y cantidad de sucursales*/
create view vw_empresas_sucursales as
select
    emp.codemp,
    emp.razsocial,
    emp.ruc,
    count(s.codsuc) as total_sucursales
from empresa emp
inner join sucursal s
on emp.codemp = s.codemp
group by emp.codemp, emp.razsocial, emp.ruc
order by total_sucursales desc;

/*6. vista carreras*/
create view vw_carreras as
select
    c.codcar,
    c.nom as carrera,
    c.durcic,
    c.gradacad,
    c.dircarr,
    c.est,
    f.codfac,
    f.nom as facultad
from carrera c
inner join facultad f
on c.codfac = f.codfac;

/*7. vista ofertas activas*/
create view vw_ofertas_activas as
select
    po.codpracofe,
    po.titulo,
    po.req,
    po.remune,
    po.cantvac,
    s.nomsuc,
    emp.razsocial as empresa,
    datediff(po.fecierre, now()) as dias_restantes
from practicaoferta po
inner join sucursal s
on po.codsuc = s.codsuc
inner join empresa emp
on s.codemp = emp.codemp
where po.est = 'activo'
order by po.remune desc;

/*8. vista de postulaciones por estudiante*/
create view vw_postulaciones_estudiantes as
select
    p.codpost,
    concat(u.nom, ' ', u.ape) as estudiante,
    po.titulo,
    emp.razsocial as empresa,
    p.puntaje,
    p.estpost,
    p.fecpost
from postulacion p
inner join estudiante e
on p.codest = e.codest
inner join usuario u
on e.codest = u.codusu
inner join practicaoferta po
on p.codpracofe = po.codpracofe
inner join sucursal s
on po.codsuc = s.codsuc
inner join empresa emp
on s.codemp = emp.codemp
order by p.puntaje desc;

/*9. vista de cantidad de postulantes por oferta*/
create view vw_postulantes_por_oferta as
select
    po.codpracofe,
    po.titulo,
    count(p.codpost) as cantidad_postulantes
from practicaoferta po
inner join postulacion p
on po.codpracofe = p.codpracofe
group by po.codpracofe, po.titulo
order by cantidad_postulantes desc;

/*10. vista de promedio de puntajes por carrera*/
create view vw_promedio_puntaje_carrera as
select
    c.nom as carrera,
    avg(p.puntaje) as promedio_puntaje,
    max(p.puntaje) as mayor_puntaje,
    min(p.puntaje) as menor_puntaje
from postulacion p
inner join estudiante e
on p.codest = e.codest
inner join carrera c
on e.codcar = c.codcar
group by c.nom
order by promedio_puntaje desc;

/*11. empresas con más ofertas*/
create view vw_empresas_mas_ofertas as
select
    emp.razsocial,
    (
        select count(*)
        from practicaoferta po
        inner join sucursal s
        on po.codsuc = s.codsuc
        where s.codemp = emp.codemp
    ) as total_ofertas
from empresa emp
order by total_ofertas desc;

/*12. vista de convenios por empresa y carreras*/
create view vw_convenios_carreras as
select
    emp.razsocial,
    c.nom as carrera,
    con.tipconv,
    con.numvac,
    con.est
from convenio con
inner join empresa emp
on con.codemp = emp.codemp
inner join convenio_carrera cc
on con.codcon = cc.codcon
inner join carrera c
on cc.codcar = c.codcar
order by emp.razsocial;