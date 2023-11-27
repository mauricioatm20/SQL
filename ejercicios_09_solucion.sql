-- ****Resuelva las siguiente consultas utilizando la sintaxis de SQL1 y SQL2 para las 4 primeras. El resto sólo con SQL2***
-- Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.
select *
from empleados e, departamentos d
where e.fk_departamento = d.id_departamento;

select *
from empleados e
join departamentos d on e.fk_departamento=d.id_departamento;

-- Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. 
    -- Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético) 
    -- y en segundo lugar por los apellidos y el nombre de los empleados.
select d.id_departamento, d.departamento, e.id_empleado, e.apellido1, e.apellido2, e.nombre
from empleados e
join departamentos d on e.fk_departamento = d.id_departamento
order by d.departamento, e.apellido1, e.apellido2, e.nombre;

-- Devuelve un listado con el código y el nombre del departamento, solamente de aquellos departamentos que tienen empleados.
select distinct d.id_departamento, d.departamento
from departamentos d
join empleados e on d.id_departamento = e.fk_departamento;

-- Devuelve un listado con el código, el nombre del departamento y el valor del presupuesto actual del que dispone, solamente de aquellos departamentos que tienen empleados.
    -- El valor del presupuesto actual lo puede calcular restando al valor del presupuesto inicial (columna presupuesto) menos el valor de los gastos que ha generado (columna gastos).
    -- Verificar el resultado en el departamento I+D si es correcto.
select d.id_departamento, d.departamento, cast(d.presupuesto as signed) - d.gastos
from departamentos d
join empleados e on d.id_departamento = e.fk_departamento;

select d.id_departamento, d.departamento, cast(d.presupuesto as signed) - d.gastos
from departamentos d, empleados e where d.id_departamento = e.fk_departamento;
    
-- Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.
select d.id_departamento, d.departamento
from departamentos d
join empleados e on d.id_departamento = e.fk_departamento
where e.nif = '38382980M';

-- Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.
select d.id_departamento, d.departamento
from departamentos d
join empleados e on d.id_departamento = e.fk_departamento
where e.nombre='Pepe' and e.apellido1='Ruiz' and e.apellido2='Santana';

-- Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. Ordena el resultado alfabéticamente.
select e.id_empleado, e.apellido1, e.apellido2, e.nombre
from empleados e
join departamentos d on e.fk_departamento = d.id_departamento
where d.departamento = 'I+D'
order by e.apellido1, e.apellido2, e.nombre;

-- Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas, Contabilidad o I+D. Ordena el resultado alfabéticamente.
select e.id_empleado, e.apellido1, e.apellido2, e.nombre, d.departamento
from empleados e
join departamentos d on e.fk_departamento = d.id_departamento
where d.departamento = 'Sistemas' or d.departamento = 'Contabilidad' or d.departamento = 'i+d'
order by e.apellido1, e.apellido2, e.nombre;

-- Devuelve una lista con el nombre de los empleados que tienen los departamentos que no tienen un presupuesto entre 100000 y 200000 euros.
select e.id_empleado, e.apellido1, e.apellido2, e.nombre, d.departamento
from empleados e
join departamentos d on e.fk_departamento = d.id_departamento
where d.presupuesto not between 100000 and 200000
order by e.apellido1, e.apellido2, e.nombre;

-- Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo apellido sea NULL. 
   -- Tenga en cuenta que no debe mostrar nombres de departamentos que estén repetidos.
select distinct id_departamento, departamento
from empleados e
join departamentos d on e.fk_departamento = d.id_departamento
where e.apellido2 is null;

-- ****Resuelva las siguientes consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.***
-- Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. 
    -- Este listado también debe incluir los empleados que no tienen ningún departamento asociado.
    
select *
from empleados e
left join departamentos d on e.fk_departamento = d.id_departamento;

-- Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado.
select *
from empleados
where fk_departamento is null;

-- Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado.
select d.*
from empleados e right join departamentos d on e.fk_departamento = d.id_departamento
where e.fk_departamento is null;

select d.*
from departamentos d left join empleados e on d.id_departamento = e.fk_departamento
where e.fk_departamento is null;

-- Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. 
    -- El listado debe incluir los empleados que no tienen ningún departamento asociado 
    -- y los departamentos que no tienen ningún empleado asociado. 
    -- Ordene el listado alfabéticamente por el nombre del departamento.
(select e.id_empleado, e.nombre, e.apellido1, e.apellido2, d.departamento
from empleados e
left join departamentos d on e.fk_departamento = d.id_departamento
union
select e.id_empleado, e.nombre, e.apellido1, e.apellido2, d.departamento
from empleados e
right join departamentos d on e.fk_departamento = d.id_departamento) order by departamento;

-- Devuelve un listado con los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. 
    -- Ordene el listado alfabéticamente por el nombre del departamento.
