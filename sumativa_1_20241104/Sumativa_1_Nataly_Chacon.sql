--Desafio I:
-- 	Lista el nombre de cada producto agrupado por categoría. Ordena los resultados por precio de mayor a menor
select upper(concat(categoria,' ' || nombre)) as producto, precio 
from productos
order by precio desc

-- Calcula el promedio de ventas mensuales (en cantidad de productos) y muestra el mes y año con mayores ventas
select EXTRACT(YEAR FROM fecha) AS AGNO,  EXTRACT(MONTH FROM fecha) AS MES, cast(avg(cantidad) as decimal) as promedio_ventas_mensuales
from ventas
group by EXTRACT(YEAR FROM fecha), EXTRACT(MONTH FROM fecha)
order by promedio_ventas_mensuales desc

-- Encuentra el ID del cliente que ha gastado más dinero en compras durante el último año. Asegúrate de considerar clientes que se registraron hace menos de un año
select c.cliente_id, sum(p.precio * v.cantidad) as cantidad_gastada 
from ventas v
inner join clientes c on c.cliente_id = v.cliente_id
inner join productos p on p.producto_id = v.producto_id
where to_char(v.fecha,'yyyy') = to_char(sysdate,'yyyy') and c.fecha_registro > sysdate + interval '-1' year and rownum = 1
group by c.cliente_id
order by cantidad_gastada desc

--Desafio II:
-- Determina el salario promedio, el salario máximo y el salario mínimo por departamento
select departamento, max(salario) as salario_maximo, min(salario) as salario_minimo, avg(salario) as salario_promedio
from empleados
group by departamento

--Utilizando funciones de grupo, encuentra el salario más alto en cada departamento.
select departamento, max(salario) as salario_maximo
from empleados
group by departamento

-- Calcula la antigüedad en años de cada empleado y muestra aquellos con más de 10 años en la empresa
select nombre, fecha_contratacion, round((SYSDATE - fecha_contratacion)/365,2) as agnos
from empleados
where fecha_contratacion <= sysdate + interval '-10' year