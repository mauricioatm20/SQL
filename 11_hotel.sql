SELECT * FROM 11_hotel.habitaciones;

-- consultar disponibilidad para fechas
set @desde ='2023-11-10';
set @hasta ='2023-11-20';

select num_habitacion
from habitaciones
left join reservas on habitaciones.ID_Habitacion = Reservas.fk_habitacion
    and @desde <= reservas.fecha_salida
    and @hasta >= Reservas.fecha_entrada
		where reservas.fk_habitacion is null;

-- la disponibilidad de una habitacion es a partir de la fecha que el cliente abandona la habitacion ocupada

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- chequear si hay alguna planta entera libre para el 12/11
set @fecha1 = '2023-11-12';


select planta_habitacion from habitaciones 
	where  planta_habitacion 
not in (
select planta_habitacion from habitaciones
	join reservas on id_habitacion = fk_habitacion
		where @fecha1 between fecha_entrada and fecha_salida) group by planta_habitacion;
        


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- consultar reservas en octubre

select * from habitaciones
	left join reservas on reservas.fk_habitacion = habitaciones.id_habitacion
		where month(fecha_entrada)= 9 and month(fecha_salida) =10
        or month(fecha_entrada) =10 and month(fecha_salida)=10
        or month(fecha_entrada)=10 and month(fecha_salida)=11;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- habitacion mas reservada en noviembre

select num_habitacion, count(*) total_reservas from habitaciones
	right join reservas on reservas.fk_habitacion = habitaciones.id_habitacion
    where month(fecha_entrada)=11 and month(fecha_salida)=11
    or  month(fecha_entrada)=11 and month(fecha_salida)=12
	group by num_habitacion
    order by total_reservas desc ;
    
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    

	-- habitacon con mas días reservados en noviembre
    
select num_habitacion, sum(datediff(fecha_salida,fecha_entrada)) dias_reservados from habitaciones
	join reservas on fk_habitacion = id_habitacion
    and '2023-11-01' <= reservas.fecha_salida
    and '2023-11-30' >= Reservas.fecha_entrada
    where month()
    group by num_habitacion
    order by dias_reservados desc ;
    
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
-- cantidad media de dias de estancia por planta

select ceil(avg((datediff(fecha_salida,fecha_entrada)))) dias_estancia, planta_habitacion from habitaciones 
	join reservas on fk_habitacion = id_habitacion
	group by planta_habitacion;

select * from reservas;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- datos de los 3 clientes con mayor cantidad de dias de estancia

select id_cliente,nombre,apellido1,telefono,email,fk_habitacion,num_tarjeta, (datediff(fecha_salida,fecha_entrada))dias_estancia from personas
 join clientes on id_persona = id_cliente
 join reservas on id_cliente = fk_cliente
 order by dias_estancia desc limit 3;
