/*1. estudiantes con promedio mayor al promedio de su carrera*/
select
    codEst,
    codUni,
    promponder
from estudiante e
where promponder >
(
  select avg(promponder)
  from estudiante
  where codCar = e.codCar
);

/*2. empresas con más trabajadores que el promedio general y activas*/
select 
  codEmp,
  razsocial,
  canttrabaj
from empresa
where canttrabaj >
(
  select avg(canttrabaj)
  from empresa
)
and est = 'activo';

/*3. estudiantes con más documentos que el promedio*/
select
    codEst,
    codUni
from estudiante
where codEst in
(
    select codEst
    from documento
    group by codEst
    having count(*) >
    (
        select avg(totaldoc)
        from
        (
            select count(*) as totaldoc
            from documento
            group by codEst
        ) as promedio
    )
);

/*4. carreras con más estudiantes que el promedio de carreras*/
select 
    codCar,
    nom
from carrera
where codCar in
(
    select codCar
    from estudiante
    group by codCar
    having count(*) >
    (
        select avg(totalest)
        from
        (
            select count(*) as totalest
            from estudiante
            group by codCar
        ) as promedio
    )
);
/*5. empresas con más sucursales que el promedio*/
select
    codEmp,
    razsocial
from empresa
where codEmp in
(
    select codEmp
    from sucursal
    group by codEmp
    having count(*) >
    (
        select avg(totalsuc)
        from
        (
            select count(*) as totalsuc
            from sucursal
            group by codEmp
        ) as promedio
    )
);
/*6. asesores pertenecientes a facultades con carreras activas*/

select 
  codAse,
  espec,
  codFac
from asesor
where codFac in
(
  select codFac
  from carrera
  where est = 'activo'
);

/*7. postulaciones con puntaje mayor al promedio y aprobadas*/
select 
    codPost,
    puntaje,
    estpost
from postulacion
where puntaje >
(
    select avg(puntaje)
    from postulacion
)
and estpost = 'aprobado';

/*8. supervisores que supervisan más de una práctica*/
select 
    codSup,
    carg
from supervisor
where codSup in
(
    select codSup
    from practicarealizada
    group by codSup
    having count(*) > 1
);

/*9. convenios de empresas con más trabajadores que el promedio*/
select 
    codCon,
    tipconv
from convenio
where codEmp in
(
    select codEmp
    from empresa
    where canttrabaj >
    (
        select avg(canttrabaj)
        from empresa
    )
);
/*10. estudiantes con más de 3 postulaciones*/
select 
    codEst,
    codUni
from estudiante
where codEst in
(
    select codEst
    from postulacion
    group by codEst
    having count(*) > 3
);