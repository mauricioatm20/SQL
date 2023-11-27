-- Lista el nombre de todos los productos que hay en la tabla producto.
select id_producto, producto from productos;

-- Lista los nombres y los precios de todos los productos de la tabla producto.
select id_producto, producto, precio from productos;

-- Lista todas las columnas de la tabla producto.
select * from productos;

-- Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
select id_producto, producto, precio euros, round(precio*1.07, 2) usd from productos;

-- Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). 
   -- Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.
select id_producto, producto 'nombre de producto', precio euros, round(precio*1.07, 2) dolares from productos;
   
-- Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.
select id_producto, upper(producto) producto, precio from productos;

-- Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.
select id_producto, lower(producto) producto, precio from productos;

-- Lista el nombre de todos los fabricantes en una columna, 
    -- y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
select id_fabricante, fabricante, upper(left(fabricante, 2)) from fabricantes;

-- Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
select id_producto, producto, round(precio) precio from productos;

-- Lista los nombres y los precios de todos los productos de la tabla producto, 
   -- truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
select id_producto, producto, truncate(precio, 0) precio from productos;

-- Lista el código de los fabricantes que tienen productos en la tabla producto.
select fk_fabricante from productos;

-- Lista el código de los fabricantes que tienen productos en la tabla producto, eliminando los códigos que aparecen repetidos.
select distinct fk_fabricante from productos;

-- Lista los nombres de los fabricantes ordenados de forma ascendente.
select * from fabricantes order by fabricante;

-- Lista los nombres de los fabricantes ordenados de forma descendente.
select * from fabricantes order by fabricante desc;

-- Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente 
   -- y en segundo lugar por el precio de forma descendente.
select id_producto, producto, precio
from productos
order by producto, precio desc;

-- Devuelve una lista con las 5 primeras filas de la tabla fabricante.
select * from fabricantes
limit 5;

-- Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. 
   -- La cuarta fila también se debe incluir en la respuesta.
select * from fabricantes
limit 2 offset 3;

select * from fabricantes
limit 3, 2;

-- Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
select id_producto, producto, precio
from productos
order by precio
limit 1;

-- Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
select id_producto, producto, precio
from productos
order by precio desc
limit 1;

-- Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.
select id_producto, producto
from productos
where fk_fabricante = 2;

-- Lista el nombre de los productos que tienen un precio menor o igual a 120€.
select id_producto, producto, precio
from productos
where precio <= 120;

-- Lista el nombre de los productos que tienen un precio mayor o igual a 400€.
select id_producto, producto, precio
from productos
where precio >= 400;

-- Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.
select id_producto, producto, precio
from productos
where precio < 400;

select id_producto, producto, precio
from productos
where not (precio >= 400);

-- Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.
select id_producto, producto, precio
from productos
where precio >= 80 and precio <= 300;

-- Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.
select id_producto, producto, precio
from productos
where precio between 60 and 200;

-- Lista todos los productos que tengan un precio mayor que 200€ y que el código de fabricante sea igual a 6.
select id_producto, producto, precio
from productos
where precio >= 200 and fk_fabricante = 6;

-- Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.
select id_producto, producto, precio, fk_fabricante
from productos
where fk_fabricante = 1 or fk_fabricante = 3 or fk_fabricante = 5;

-- Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
select id_producto, producto, precio, fk_fabricante
from productos
where fk_fabricante in (1, 3, 5);

-- Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio).
   -- Cree un alias para la columna que contiene el precio que se llame céntimos.
select id_producto, producto, precio * 100 centimos
from productos;

-- Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
select id_fabricante, fabricante
from fabricantes
where fabricante like 's%';

-- Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
select id_fabricante, fabricante
from fabricantes
where fabricante like '%e';

-- Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
select id_fabricante, fabricante
from fabricantes
where fabricante like '%w%';

-- Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
select id_fabricante, fabricante
from fabricantes
where fabricante like '____';

select id_fabricante, fabricante
from fabricantes
where length(fabricante) = 4;

-- Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
select id_producto, producto
from productos
where producto like '%portatil%';

-- Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y 
    -- tienen un precio inferior a 215 €.
select id_producto, producto
from productos
where producto like '%monitor%' and precio < 215;

-- Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. 
    -- Ordene el resultado en primer lugar por el precio (en orden descendente) y 
    -- en segundo lugar por el nombre (en orden ascendente).
select id_producto, producto, precio
from productos
where precio >= 215
order by precio desc, producto;
