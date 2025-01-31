--Obtén un listado de clientes que han alquilado un vehículo de categoría ”lujo”.
select * 
from cliente 
where id_cliente in (SELECT a.ID_cliente
FROM Alquiler a
JOIN Vehiculo v ON a.ID_vehiculo = v.ID_vehiculo
WHERE v.categoria = 'lujo');

-- Primero obtenemos el ID_cliente de los alquileres que se correspondan a coches de lujo
-- haciendo un join de las tablas alquiler y vehiculo por su clave primaria. Luego seleccionamos
-- los datos de los clientes cuyo ID_clientes esta en la lista obtenida. 

--Calcula el total de ingresos generados por cada categoría de vehículos.

SELECT v.categoria, SUM(a.coste) AS total_ingresos
FROM Alquiler a
JOIN Vehiculo v ON a.ID_vehiculo = v.ID_vehiculo
GROUP BY v.categoria;

-- Se unen las tablas Alquiler y Vehiculo y se suman los costes agrupandolos por categorias.


--Muestra los vehículos que no han sido alquilados en los últimos 6 meses.

select * 
from Vehiculo
where id_vehiculo not in (SELECT v.ID_vehiculo
FROM Alquiler a
JOIN Vehiculo v on a.ID_vehiculo = v.ID_vehiculo
where a.fecha_inicio >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH))

-- Obtenemos los ID_vehiculo de los vehiculos que aparacen en la tabla alquiler con fecha_inicio
--de los ultimos 6 meses. Luego mostramos la informacion de los vehiculos que no aparezcan en esa lista

-- Devuelve el nombre completo del cliente con m´as alquileres registrados.

select c.nombre,c.apellido, count(a.ID_cliente) as "Recuento Alquileres"
from Cliente c
JOIN Alquiler a on a.ID_cliente = c.ID_cliente
GROUP by c.ID_cliente
order by "Recuento Alquileres" desc
limit 1 ;

-- contamos las veces que aparece cada ID_cliente en la tabla alquiler. Luego ordenamos en
-- orden descendente esa lista y seleccionamos solo la prima tupla

-- Obtén un listado de alquileres que tengan una duración superior a 30 d´ıas.

SELECT * 
FROM Alquiler
WHERE DATEDIFF(fecha_fin, fecha_inicio) > 30;

-- Con la funcion datediff obtenemos los dias que hay entre la fecha_fin y la fecha_inicio.
-- Seleccionamos la informacion de la tabla alquiler cuando esa diferencia sea mayor de 30