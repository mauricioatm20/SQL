-- *** BBDD 3_universidad ***

-- Obtener el nombre completo de los alumnos que estén cursando "Matematica Discreta"

select alu.*, asi.asignatura from alumnos alu
join notas n on alu.id_alumno = n.fk_alumno
join asignaturas asi on n.fk_asignatura = asi.id_asignatura
where asi.asignatura = 'Matematica Discreta';

-- Obtener el nombre completo y la nota obtenida de los alumnos que hayan cursado "Matematica Discreta"

select alu.nombre, alu.apellido1, alu.apellido2, n.nota, asi.asignatura from alumnos alu
join notas n on alu.id_alumno = n.fk_alumno
join asignaturas asi on n.fk_asignatura = asi.id_asignatura
where asi.asignatura='Matematica Discreta' order by nota desc;

-- Obtener el listado de profesores de la Factultad de "Informatica"

select pro.*, asi.facultad from profesores pro
join asignaturas asi on asi.fk_profesor = pro.id_profesor
where asi.facultad = 'informatica' ;

-- Obtener la cantidad de alumnos por ciudad

select count(ciudad)cant_alumnos, ciudad from alumnos 
group by ciudad order by cant_alumnos desc;

-- Obtener el nombre completo y edad de todos los alumnos

select nombre,apellido1,apellido2, fecha_nacimiento, timestampdiff(year, fecha_nacimiento, now()) edad
from alumnos;

-- Obtener las edades de los alumnos que cursan asignaturas

select alu.nombre, alu.apellido1, alu.apellido2, timestampdiff(year,fecha_nacimiento,now()) edad,asi.asignatura from alumnos alu
join notas n on n.fk_alumno = alu.id_alumno
join asignaturas asi on n.fk_asignatura = asi.id_asignatura;

-- Obtener las notas medias de los alumnos por edad

select  timestampdiff(year, alu.fecha_nacimiento, now()) edad, avg(n.nota) nota_media
from alumnos alu
join notas n on n.fk_alumno = alu.id_alumno
group by edad;

-- Cantidad de alumnos matriculados en más de dos asignaturas

select count(*) cantidad
from
(select fk_alumno, count(fk_asignatura)
from notas
group by fk_alumno
having count(fk_asignatura) > 2) matriculados;


-- Obtener los datos de los alumnos que no cursan ninguna asignatura ni tienen ninguna nota

select alu.*, n.nota,asi.asignatura from alumnos alu 
left join notas n on n.fk_alumno = alu.id_alumno
left join asignaturas asi on n.fk_asignatura = asi.id_asignatura
where n.nota  is null and asi.asignatura is null;

-- Cantidad de notas y media de notas de cada alumno

select  alu.nombre, count(n.nota)cant_notas, avg(n.nota)nota_media from alumnos alu 
left join notas n on n.fk_alumno = alu.id_alumno
group by alu.id_alumno order by nota_media desc;

-- Listado de profesores con la cantidad de asignaturas que imparte cada uno de ellos, aunque ahora no estén impartiendo ninguna.

select p.nombre, count(asi.asignatura)cant_asignatura from profesores p
left join asignaturas asi on asi.fk_profesor = p.id_profesor
group by p.id_profesor order by cant_asignatura desc;

-- Notas medias por asignaturas que imparte cada profesor

select p.nombre, avg(n.nota)nota_media,asi.asignatura from profesores p
join notas n on n.fk_asignatura = p.id_profesor
left join asignaturas asi on n.fk_asignatura = asi.id_asignatura
group by p.id_profesor;

-- Mostrar, de la Asignatura “Programacion I”, la nota máxima, mínima y la diferencia entre ambas. 
   -- Devolver también el número de alumnos que la han cursado.
   
select asi.asignatura, min(n.nota), max(n.nota) , max(n.nota) - min(n.nota) dif, count(alu.id_alumno) from asignaturas asi
   join notas n on n.fk_asignatura = asi.id_asignatura
   join alumnos alu on n.fk_alumno = alu.id_alumno
   where asi.asignatura ='Programacion I' ;
   
-- Obtener de Cada profesor las asignaturas que imparte, con los alumnos en cada una de ellas y su nota

select p.nombre profesor , asi.asignatura, alu.nombre alumno, n.nota from profesores p
left join asignaturas asi on asi.fk_profesor = p.id_profesor
left join notas n on n.fk_asignatura = asi.id_asignatura
left join alumnos alu on n.fk_alumno = alu.id_alumno
order by asi.asignatura desc;

-- *** Subconsultas ***
-- Cantidad de alumnos aprobados por ciudad, usando una subconsulta

	  -- alumnos ciudad
    select  ciudad, count(ciudad) from alumnos
    group by ciudad order by ciudad;
    
	-- alumnos aprobados
    select distinct fk_alumno
    from notas
    where nota >= 5;

select ciudad, count(ciudad)
from alumnos
where id_alumno in (select distinct fk_alumno
		from notas
		where nota >= 5)
group by ciudad order by ciudad;

-- Notas de las asignaturas de cada uno de los alumnos comparada con la nota media de la asignatura

select alu.id_alumno, asi.asignatura, n.nota, medias.MEDIA from alumnos alu
join notas n on n.fk_alumno = alu.id_alumno
join asignaturas asi on n.fk_asignatura = asi.id_asignatura
join (select fk_asignatura, avg(nota) MEDIA from notas 
group by fk_asignatura) Medias on n.fk_asignatura = Medias.fk_asignatura;

select fk_asignatura, avg(nota) media from notas 
group by fk_asignatura; -- medias: es el nombre de la tabla;

-- Alumnos que están cursando asignaturas con los profesores de Málaga (subconsulta en JOIN)

select alu.id_alumno, asi.asignatura, profe.id_profesor from alumnos alu
join notas n on n.fk_alumno = alu.id_alumno
join asignaturas asi on n.fk_asignatura =asi.id_asignatura
join (select id_profesor, nombre, ciudad from profesores 
where ciudad = 'malaga' group by id_profesor) profe on asi.fk_profesor = profe.id_profesor;



select id_profesor, ciudad from profesores 
where ciudad = 'malaga' group by id_profesor;

-- Nota media por asignatura, sólo aquéllas que la nota media sea mayor a la nota media del alumnos con dni 55630078R

select alu.dni,asi.asignatura,n.nota, MEDIA.media from alumnos alu
join notas n on n.fk_alumno = alu.id_alumno
join asignaturas asi on n.fk_asignatura = asi.id_asignatura
join (select fk_asignatura, avg(nota) media from notas 
group by fk_asignatura) MEDIA on n.fk_asignatura = MEDIA.fk_asignatura
where dni = '55630078R';

select * from alumnos alu
left join notas n on n.fk_alumno = alu.id_alumno
join asignaturas asi on n.fk_asignatura = asi.id_asignatura
order by id_alumno;



