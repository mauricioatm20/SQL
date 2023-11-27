-- *** BBDD 05_empleados ***
use 05_empleados;
-- Utilizar subconsultas para la resolución

-- Devuelve un listado con todos los empleados que tiene el departamento de Sistemas. 
	-- (Sin utilizar INNER JOIN).
	
    -- buscar el id del departamento de Sistemas
    select id_departamento
    from departamentos
    where departamento = 'Sistemas';

select id_empleado, apellido1, apellido2, nombre
from empleados
where fk_departamento = (select id_departamento
    from departamentos
    where departamento = 'Sistemas');
    
-- Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada.
select *
from departamentos
where presupuesto = (select max(presupuesto) from departamentos);

-- Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada.
select *
from departamentos
where presupuesto = (select min(presupuesto) from departamentos);

-- *** Subconsultas con ALL y ANY ***
-- Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada. 
	-- Sin hacer uso de MAX, ORDER BY ni LIMIT.
select *
from departamentos
where presupuesto >= all (select presupuesto from departamentos);

-- Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada. 
	-- Sin hacer uso de MIN, ORDER BY ni LIMIT.
select *
from departamentos
where presupuesto <= all (select presupuesto from departamentos);

-- Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando ALL o ANY).
select *
from departamentos
where id_departamento =any (select fk_departamento from empleados where fk_departamento is not null);

-- Devuelve los nombres de los departamentos que no tienen empleados asociados. (Utilizando ALL o ANY).
select *
from departamentos
where id_departamento <>all (select fk_departamento from empleados where fk_departamento is not null);

-- *** Subconsultas con IN y NOT IN ***
-- Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando IN o NOT IN).
select *
from departamentos
where id_departamento in (select fk_departamento from empleados where fk_departamento is not null);

-- Devuelve los nombres de los departamentos que no tienen empleados asociados. (Utilizando IN o NOT IN).
select *
from departamentos
where id_departamento not in (select fk_departamento from empleados where fk_departamento is not null);

-- *** Subconsultas con EXISTS y NOT EXISTS ***
-- Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando EXISTS o NOT EXISTS).
select *
from departamentos
where exists (select * from empleados where fk_departamento=id_departamento);

-- Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando EXISTS o NOT EXISTS).
select *
from departamentos
where not exists (select * from empleados where fk_departamento=id_departamento);



