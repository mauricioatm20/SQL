-- *** BBDD 0_tienda ***
-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
select p.id_producto, p.precio, f.id_fabricante, f.fabricante
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante;

-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.
select p.id_producto, p.precio, f.id_fabricante, f.fabricante
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
order by f.fabricante;

-- Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
    -- idem 1
    
-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
select p.id_producto, p.precio, f.id_fabricante, f.fabricante
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
order by p.precio
limit 1;

-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
select p.id_producto, p.precio, f.id_fabricante, f.fabricante
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
order by p.precio desc
limit 1;

-- Devuelve una lista de todos los productos del fabricante Lenovo.
select p.id_producto, p.precio, f.id_fabricante, f.fabricante
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
where f.fabricante = 'Lenovo';

-- Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
select p.id_producto, p.precio, f.id_fabricante, f.fabricante
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
where f.fabricante = 'Crucial' and p.precio > 200;

-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN.
select p.id_producto, p.precio, f.id_fabricante, f.fabricante
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
where f.fabricante = 'Asus' or f.fabricante = 'Hewlett-Packard' or f.fabricante = 'Seagate';

-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.
select p.id_producto, p.precio, f.id_fabricante, f.fabricante
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
where f.fabricante in ('Asus', 'Hewlett-Packard', 'Seagate');

-- Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.
select p.id_producto, p.precio, f.id_fabricante, f.fabricante
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
where f.fabricante like '%e';

-- Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
select p.id_producto, p.precio, f.id_fabricante, f.fabricante
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
where f.fabricante like '%w%';

-- Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan 
    -- un precio mayor o igual a 180€. 
    -- Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
select p.id_producto, p.precio, f.id_fabricante, f.fabricante
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
where p.precio > 180
order by p.precio, p.producto;

-- Devuelve un listado con el código y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.
select distinct f.id_fabricante, f.fabricante
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante;

-- Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene 
   -- cada uno de ellos. El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
select f.id_fabricante, f.fabricante, p.id_producto, p.precio
from productos p
right join fabricantes f on p.fk_fabricante=f.id_fabricante;

-- Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
select f.id_fabricante, f.fabricante
from productos p
right join fabricantes f on p.fk_fabricante=f.id_fabricante
where p.fk_fabricante is null;

-- Calcula el número total de productos que hay en la tabla productos.
select count(*)
from productos p;

-- Calcula el número total de fabricantes que hay en la tabla fabricante.
select count(*)
from fabricantes f;

-- Calcula el número de valores distintos de código de fabricante aparecen en la tabla productos.
select count(distinct fk_fabricante) from productos;

-- Calcula la media del precio de todos los productos.
select round(avg(p.precio), 2) precio_medio
from productos p;

-- Calcula el precio más barato de todos los productos.
select min(precio) from productos;

select precio from productos order by precio limit 1;

-- Calcula el precio más caro de todos los productos.
select max(precio) from productos;

select precio from productos order by precio desc limit 1;

-- Lista el nombre y el precio del producto más barato.
select * from productos order by precio limit 1;

select id_producto, producto, min(precio) from productos;

set session sql_mode=(select replace(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

-- Lista el nombre y el precio del producto más caro.
select * from productos order by precio desc limit 1;

-- Calcula la suma de los precios de todos los productos.
select sum(precio) total 
from productos;

-- Calcula el número de productos que tiene el fabricante Asus.
select f.fabricante, count(*)
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
where f.fabricante = 'Asus';

-- asi no funciona!!!!
-- puede haber varios fabricantes que contengan Asus
select f.fabricante, count(*)
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
where f.fabricante like '%Asus';

-- Calcula la media del precio de todos los productos del fabricante Asus.
select f.fabricante, round(avg(p.precio), 2) precio_medio
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
where f.fabricante = 'Asus';

-- Calcula el precio más barato de todos los productos del fabricante Asus.
select f.fabricante, min(p.precio)
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
where f.fabricante = 'Asus';

-- Calcula el precio más caro de todos los productos del fabricante Asus.
select f.fabricante, max(p.precio)
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
where f.fabricante = 'Asus';

select f.fabricante, p.precio
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
where f.fabricante = 'Asus'
order by p.precio desc limit 1;

-- Calcula la suma de todos los precios de los productos del fabricante Asus.
select f.fabricante, sum(p.precio)
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
where f.fabricante = 'Asus';

-- Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que tiene el fabricante Crucial.
select f.fabricante, max(p.precio), min(precio), avg(precio), count(*)
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
where f.fabricante = 'Crucial';

-- Muestra el número total de productos que tiene cada uno de los fabricantes.
   -- El listado también debe incluir los fabricantes que no tienen ningún producto.
   -- El resultado mostrará dos columnas, una con el nombre del fabricante y otra con el número 
   -- de productos que tiene. Ordene el resultado descendentemente por el número de productos.
select f.id_fabricante, f.fabricante, count(fk_fabricante) cant
from productos p
right join fabricantes f on p.fk_fabricante=f.id_fabricante
group by f.id_fabricante
order by cant desc;

-- Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los fabricantes. 
    -- El resultado mostrará el nombre del fabricante junto con los datos que se solicitan.
select f.id_fabricante, f.fabricante, max(p.precio) p_max, min(p.precio) p_min, round(avg(p.precio), 2) p_avg
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
group by f.id_fabricante;

-- Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes 
    -- que tienen un precio medio superior a 200€. 
    -- No es necesario mostrar el nombre del fabricante, con el código del fabricante es suficiente.
select p.fk_fabricante, max(p.precio) p_max, min(p.precio) p_min, round(avg(p.precio), 2) p_avg, count(p.id_producto) cant
from productos p
group by p.fk_fabricante
having p_avg > 200;

-- Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, precio medio y el número total de productos 
    -- de los fabricantes que tienen un precio medio superior a 200€. Es necesario mostrar el nombre del fabricante.
select f.id_fabricante, f.fabricante, max(p.precio) p_max, min(p.precio) p_min, round(avg(p.precio), 2) p_avg, count(p.id_producto) cant
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
group by f.id_fabricante
having p_avg > 200;

-- Calcula el número de productos que tienen un precio mayor o igual a 180€.
select count(*) cant
from productos
where precio >= 200;

-- Calcula el número de productos que tiene cada fabricante con un precio mayor o igual a 180€.
select f.id_fabricante, f.fabricante, count(p.id_producto) cant
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
where p.precio >= 180
group by f.id_fabricante;

-- Lista el precio medio los productos de cada fabricante, mostrando solamente el código del fabricante.
select p.fk_fabricante, round(avg(p.precio), 2) p_avg
from productos p
group by p.fk_fabricante;

-- Lista el precio medio los productos de cada fabricante, mostrando solamente el nombre del fabricante.
select f.fabricante, round(avg(p.precio), 2) p_avg
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
group by f.id_fabricante;

-- Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€.
select f.fabricante, round(avg(p.precio), 2) p_avg
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
group by f.id_fabricante
having p_avg > 150;

-- Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.

-- select f.fabricante, count(p.id_producto)
select f.fabricante
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
group by f.id_fabricante
having count(p.id_producto) >= 2;

-- Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno
   -- con un precio superior o igual a 220 €. 
   -- No es necesario mostrar el nombre de los fabricantes que no tienen productos que cumplan la condición.
select f.fabricante, count(p.id_producto) cant
from productos p
join fabricantes f on p.fk_fabricante=f.id_fabricante
where p.precio >= 220
group by f.id_fabricante;


