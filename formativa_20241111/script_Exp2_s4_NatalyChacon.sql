--QUERY CASO 1 --
select 
    (pv.nombre || ' ' || pv.apellido) as nombre_completo, 
    sum(distinct v.sale_id) as cantidad_ventas, 
    sum(v.cantidad * p.precio) as ingreso_generado
from ventas v
inner join personal_de_ventas pv on pv.staff_id = v.staff_id
inner join productos p on p.product_id = v.product_id
where v.fecha_venta > sysdate + interval '-1' year
group by pv.nombre , pv.apellido
order by ingreso_generado desc

--QUERY CASO 2 --
select 
    (c.nombre || ' ' || c.apellido) as nombre_completo, 
    max(v.fecha_venta) as fecha_primera_compra, 
    min(v.fecha_venta) as fecha_ultima_compra,
    count(distinct v.sale_id) as cantidad_compras
from ventas v
inner join clientes c on c.customer_id = v.customer_id
having count(distinct v.sale_id) > 1
group by c.nombre , c.apellido
order by cantidad_compras desc