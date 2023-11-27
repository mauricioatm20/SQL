-- Lista el nombre de todos los productos que hay en la tabla producto.

SELECT producto FROM productos;

-- Lista los nombres y los precios de todos los productos de la tabla producto.

select producto,precio from productos;

-- Lista todas las columnas de la tabla producto.

select * from productos;

-- Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).1.07

select producto,precio as en_euros, precio * 1.07 as en_dolares from productos;

-- Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.

select producto as  nombre_producto,precio as euros,precio * 1.07 as dolares  from productos;

-- Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.
-- UPDATE usuarios SET nombre = UPPER(nombre);       OJO ESTA CONSULTA MODIFICA LA BASE DE DATOS Y CAMBIA A MAYUSCULAS PERMANENTEMENTE.

SELECT UPPER(PRODUCTO) producto, precio FROM productos;-- ESTA CONSULTA ES CORRECTA 

-- Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.

select lower(producto) nombre, precio from productos;

-- Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.

select fabricante,upper(left(fabricante,3)) fabricante from fabricantes;

-- Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.

SELECT producto,precio,round(precio) redondeado from productos;

-- Lista los nombres y los precios de todos los productos de la tabla productos, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.

SELECT producto,precio,truncate(precio,0) PRECIO FROM productos;

-- Lista el código de los fabricantes que tienen productos en la tabla producto.

select fk_fabricante from productos;

-- Lista el código de los fabricantes que tienen productos en la tabla producto, eliminando los códigos que aparecen repetidos.

select distinct  fk_fabricante from productos;

-- Lista los nombres de los fabricantes ordenados de forma ascendente.

select * from fabricantes  ORDER BY fabricante;

-- Lista los nombres de los fabricantes ordenados de forma descendente.

select * from fabricantes  ORDER BY fabricante desc;

-- Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.

select* from productos order by producto, precio desc;

-- Devuelve una lista con las 5 primeras filas de la tabla fabricante.

select * from fabricantes limit 0,5;

-- Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta

select * from fabricantes limit 3,2;

-- Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)

select producto,precio from productos order by precio limit 0,1 ;

-- Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)

select producto,precio from productos order by precio desc limit 0,1 ;

-- Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.

select fk_fabricante, producto from productos where fk_fabricante =2;

-- Lista el nombre de los productos que tienen un precio menor o igual a 120€.

select producto,precio from productos where precio<=120;

-- Lista el nombre de los productos que tienen un precio mayor o igual a 400€.ç

select producto,precio from productos where precio>=400;

-- Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.

select producto,precio from productos where precio<=400 order by precio ;

-- Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.

select * from productos where precio>=80 and precio<=300 order by precio;

-- Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.

SELECT * FROM productos WHERE precio BETWEEN 60 AND 200 order by precio;
