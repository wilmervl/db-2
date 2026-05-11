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

/*3. estudiantes que realizaron más postulaciones que el promedio*/
select
    codEst,
    codUni
from estudiante
where codEst in
(
    select codEst
    from postulacion
    group by codEst
    having count(*) >
    (
        select avg(totalpost)
        from
        (
            select count(*) as totalpost
            from postulacion
            group by codEst
        ) as promedio
    )
);

/*4. ofertas de prácticas con más postulaciones que el promedio*/
select
    codPracOfe,
    titulo
from practica_oferta
where codPracOfe in
(
    select codPracOfe
    from postulacion
    group by codPracOfe
    having count(*) >
    (
        select avg(totalpost)
        from
        (
            select count(*) as totalpost
            from postulacion
            group by codPracOfe
        ) as promedio
    )
);

/*5. empresas con más convenios que el promedio*/
select
    codEmp,
    razsocial
from empresa
where codEmp in
(
    select codEmp
    from convenio
    group by codEmp
    having count(*) >
    (
        select avg(totalconv)
        from
        (
            select count(*) as totalconv
            from convenio
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
/*7. ofertas de prácticas con más vacantes que el promedio y activas*/
select
    codPracOfe,
    titulo,
    cantvac
from practica_oferta
where cantvac >
(
    select avg(cantvac)
    from practica_oferta
)
and est = 'activo';

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