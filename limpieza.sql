-- ================================================================ --
-- 					LIMPIEZA DE DATOS 
-- ================================================================ --

select * from clientes;

DELIMITER // 
CREATE PROCEDURE new_clientes()
begin 
	select * from clientes; -- se crea un procedimiento 
END//

DELIMITER ;
CALL new_clientes (); 

-- RENOMBRAR COLUMNAS 

alter table clientes change column `linea_direccion1` Direccion varchar(100) null;

-- VERIFICAR VALORES DUPLICADOS 

select id_empleado, count(*) as duplicados from empleados
group by id_empleado
having count(*)>1; -- analizamos valores duplicados 

select count(*) as cant_duplicados from (
select id_empleado, count(*) as duplicados from empleados
group by id_empleado
having count(*)>1
)as subquery; -- esta subconsulta cuenta los valores duplicados previamnete analizados 



-- CREACION DE TABLA TEMPORAL PARA CONSULTA DE DATOS 
-- las tablas temporales son objetos de base de datos que se utlizan para almacenar  datos temporales durante la ejecucion de una sesion.
-- cuando se cierra sesion se elimina la tabla temporal.

create temporary table tem_clientes as
select distinct * from clientes;

SELECT 
    COUNT(*) AS original
FROM
    clientes;
SELECT 
    COUNT(*) AS original
FROM
    tem_clientes;

CREATE TABLE new_clientes AS SELECT * FROM
    tem_clientes;

call new_clientes;


alter table  new_clientes change column apellido_contacto apellido varchar(45) null;

-- muestra los datos de los datos 
describe new_clientes;