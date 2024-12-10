CREATE VIEW PRY2205_USER2.V_RECALCULO_PAGOS AS
SELECT p.pac_run, p.dv_run, s.descripcion as sist_salud, initcap(p.apaterno) || ' ' || initcap(p.pnombre) as nombre_paciente, b.costo, 
round(case when b.costo between 15000 and 25000 then b.costo * 1.15 when b.costo > 25000 then b.costo * 1.2 else b.costo end) as monto_a_cancelar,
round((sysdate - p.fecha_nacimiento) / 365) as edad
FROM SPUB_PACIENTE p
inner join SPUB_SALUD s on s.sal_id = p.sal_id
inner join SPUB_BONO_CONSULTA b on b.pac_run = p.pac_run
where to_number(replace(b.hr_consulta,':','')) >= 1715
order by pac_run asc, monto_a_cancelar asc