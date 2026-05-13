/* 1. Estudiantes cuyo promedio ponderado es mayor al promedio
   de los estudiantes de su mismo ciclo y carrera,
   mostrando la carrera y ordenados por promedio ponderado */
SELECT
    (
        SELECT c.nom
        FROM carrera c
        WHERE c.codCar = e.codCar
    ) AS carrera,
    (
        SELECT CONCAT(u.nom, ' ', u.ape)
        FROM usuario u
        WHERE u.codUsu = e.codEst
    ) AS estudiante,
    e.codUni,
    e.ciclo,
    e.promponder
FROM estudiante e
WHERE e.promponder > (
    SELECT AVG(e2.promponder)
    FROM estudiante e2
    WHERE e2.codCar = e.codCar
      AND e2.ciclo = e.ciclo
)
ORDER BY
    e.promponder DESC;
/*2. empresas con más trabajadores que el promedio general
y que estén activas*/

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
and est = 'activo'
limit 100;
/*3. estudiantes que realizaron más postulaciones
que el promedio de postulaciones*/

select
    codEst,
    codUni,
    codCar
from estudiante
where codEst in
(
    select codEst
    from postulacion
    group by codEst
    having count(*) >
    (
        select avg(cantidad)
        from
        (
            select count(*) as cantidad
            from postulacion
            group by codEst
        ) t
    )
)
order by codCar
limit 100;
/*3. estudiantes que realizaron más postulaciones
que el promedio de postulaciones*/

select
    codEst,
    codUni,
    codCar
from estudiante
where codEst in
(
    select codEst
    from postulacion
    group by codEst
    having count(*) >
    (
        select avg(cantidad)
        from
        (
            select count(*) as cantidad
            from postulacion
            group by codEst
        ) t
    )
)
order by codCar
limit 100;
/*4. ofertas de prácticas con más vacantes
que el promedio*/

select
    codPracOfe,
    titulo,
    cantvac
from practicaoferta
where cantvac >
(
    select avg(cantvac)
    from practicaoferta
)
limit 100;
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
        select avg(cantidad)
        from
        (
            select count(*) as cantidad
            from convenio
            group by codEmp
        ) t
    )
)
limit 100;
/*6. asesores pertenecientes a facultades
con carreras activas*/

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
)
limit 100;
/*7. ofertas activas con vacantes mayores
al promedio*/

select
    codPracOfe,
    titulo,
    cantvac
from practicaoferta
where cantvac >
(
    select avg(cantvac)
    from practicaoferta
)
and est = 'activo'
limit 100;
/*8. supervisores que supervisan
más de una práctica*/

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
)
limit 100;
/*9. convenios de empresas con más trabajadores
que el promedio*/

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
)
limit 100;
/*10. estudiantes con más de 3 postulaciones*/

select
    codEst,
    codUni,
    codCar
from estudiante
where codEst in
(
    select codEst
    from postulacion
    group by codEst
    having count(*) > 3
)
order by codCar
limit 100;