-- *** BBDD 04_tienda ***
use 04_tienda;
-- *** Subconsultas (En la cláusula WHERE) ***

-- *** Con operadores básicos de comparación ***
-- Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).

	-- Hallar el id de Lenovo
    select id_fabricante
    from fabricantes
    where fabricante = 'Lenovo';

-- solucion
select *
from productos
where fk_fabricante = (
	select id_fabricante
    from fabricantes
    where fabricante = 'Lenovo'
);

-- Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).

	-- Encontrar el precio del producto mas caro de Lenovo
    -- Primero necesitamos encontrar el id de Lenovo para no hacer ningun join
    select id_fabricante
    from fabricantes
    where fabricante = 'Lenovo';

	-- Maximo precio de Lenovo
	select max(precio)
    from productos
    where fk_fabricante = (
		select id_fabricante
		from fabricantes
		where fabricante = 'Lenovo'
	);
    
-- solucion
select *
from productos
where precio = (
	select max(precio)
    from productos
    where fk_fabricante = (
		select id_fabricante
		from fabricantes
		where fabricante = 'Lenovo'
	)
);
    
-- Lista el nombre del producto más caro del fabricante Lenovo.

		-- ya se que lenovo es el 2 y el precio 559

		select *
		from productos
		where (fk_fabricante, precio) = (2, 559);

		-- encontrar el id de Lenovo y el precio maximo de sus productos
		select id_fabricante, max(precio)
		from fabricantes
		join productos on id_fabricante = fk_fabricante
		where fabricante = 'Lenovo'
		group by id_fabricante;

-- solucion con join en la subconsulta
select *
from productos
where (fk_fabricante, precio) = (select id_fabricante, max(precio)
	from fabricantes
	join productos on id_fabricante = fk_fabricante
	where fabricante = 'Lenovo'
	group by id_fabricante);

-- encontrar el id de Lenovo y el precio maximo de sus productos sin hacer join
	select fk_fabricante, max(precio)
	from productos
	where fk_fabricante = (select id_fabricante from fabricantes where fabricante = 'Lenovo')
	group by fk_fabricante;

-- solucion sin ningun join
select *
from productos
where (fk_fabricante, precio) = (select fk_fabricante, max(precio)
	from productos
	where fk_fabricante = (select id_fabricante from fabricantes where fabricante = 'Lenovo')
	group by fk_fabricante
);

-- Lista el nombre del producto más barato del fabricante Hewlett-Packard.
select *
from productos
where (fk_fabricante, precio) = (select fk_fabricante, min(precio)
	from productos
	where fk_fabricante = (select id_fabricante from fabricantes where fabricante = 'Hewlett-Packard')
	group by fk_fabricante
);

-- Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro 
	-- del fabricante Lenovo.
    
    -- productos cuyo precio es >= 599
    select *
    from productos
    where precio >= 559;
    
    -- precio del producto mas caro de Lenovo
    select max(precio)
    from productos
    join fabricantes on fk_fabricante = id_fabricante
    where fabricante = 'Lenovo';
    
-- solucion
    select *
    from productos
    where precio >= (
		select max(precio)
		from productos
		join fabricantes on fk_fabricante = id_fabricante
		where fabricante = 'Lenovo'
	);

-- Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
	-- productos de Asus (1) con precio > 200
    select *
    from productos p
    where fk_fabricante = 1 and precio > 200;

	-- media de precios de Asus (1)
    select avg(p.precio)
    from productos p
    where p.fk_fabricante = 1;
    
    -- id de Asus
    select id_fabricante
    from fabricantes
    where fabricante = 'Asus';

-- solucion
    select *
    from productos p
    where fk_fabricante = (
		select id_fabricante
		from fabricantes
		where fabricante = 'Asus'
	) and precio > (
			select avg(p.precio)
			from productos p
			where p.fk_fabricante = (
				select id_fabricante
				from fabricantes
				where fabricante = 'Asus'
			)
        );

	-- los productos de Asus con precio mayor a 210 
    
    select *
    from productos p
    join fabricantes f on p.fk_fabricante = f.id_fabricante
    where f.fabricante = 'Asus'
    and p.precio > 210;
    
    -- calcular la media de los precios de los productos de Asus
    select avg(p.precio)
    from productos p
    join fabricantes f on p.fk_fabricante = f.id_fabricante
    where f.fabricante = 'Asus';

-- solucion con join
select *
from productos p
join fabricantes f on p.fk_fabricante = f.id_fabricante
where f.fabricante = 'Asus'
and p.precio > (
	select avg(p.precio)
    from productos p
    join fabricantes f on p.fk_fabricante = f.id_fabricante
    where f.fabricante = 'Asus'
);


-- *** Subconsultas con ALL y ANY ***
-- Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni LIMIT.
select *
from productos
where precio >= all (select precio from productos);

-- select max(precio) from productos;

-- Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.
	-- Por favor, no copiar y pegar del anterior. Volver a pensarlo y escribirlo completo!!!
select *
from productos
where precio <= all (select precio from productos);

-- Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).
select *
from fabricantes
where id_fabricante =any (select fk_fabricante from productos);

-- Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).
select *
from fabricantes
where id_fabricante <> all (select fk_fabricante from productos);
-- IMPORTANTE
-- COMO FK_FABRICANTE ACEPTA NULL, ES NECESARIO FILTRARLO EN LA SUBCONSULTA

-- *** Subconsultas con IN y NOT IN ***
-- Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
select *
from fabricantes
where id_fabricante in (select fk_fabricante from productos);

-- Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
select *
from fabricantes
where id_fabricante not in (select fk_fabricante from productos where fk_fabricante is not null);
-- IMPORTANTE
-- COMO FK_FABRICANTE ACEPTA NULL, ES NECESARIO FILTRARLO EN LA SUBCONSULTA

-- *** Subconsultas con EXISTS y NOT EXISTS ***
-- Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).
select *
from fabricantes f_cont
where exists (select * from productos where fk_fabricante = f_cont.id_fabricante);

-- Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).
select *
from fabricantes f_cont
where not exists (select * from productos where fk_fabricante = f_cont.id_fabricante);

-- *** Subconsultas correlacionadas ***
-- Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.
select *
from productos p_cont
join fabricantes f on p_cont.fk_fabricante = f.id_fabricante
where p_cont.precio = (select max(p_sub.precio) from productos p_sub where p_sub.fk_fabricante = p_cont.fk_fabricante);

-- Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media 
    -- de todos los productos de su mismo fabricante.

select *, (select avg(p_sub.precio) from productos p_sub where p_sub.fk_fabricante = p_cont.fk_fabricante) media
from productos p_cont;

select *, (select avg(p_sub.precio) from productos p_sub where p_sub.fk_fabricante = p_cont.fk_fabricante) media
from productos p_cont
where p_cont.precio >= (select avg(p_sub.precio) from productos p_sub where p_sub.fk_fabricante = p_cont.fk_fabricante);
