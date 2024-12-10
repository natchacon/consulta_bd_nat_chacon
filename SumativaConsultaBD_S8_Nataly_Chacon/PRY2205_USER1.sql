create synonym "PRY2205_USER1".SPRIV_CARGO for "PRY2205_USER1"."CARGO";
create synonym "PRY2205_USER1".SPRIV_BONO_CONSULTA for "PRY2205_USER1"."BONO_CONSULTA";
create synonym "PRY2205_USER1".SPRIV_CANT_BONOS_PACIENTES_ANNIO for "PRY2205_USER1"."CANT_BONOS_PACIENTES_ANNIO";
create synonym "PRY2205_USER1".SPRIV_DET_ESPECIALIDAD_MED for "PRY2205_USER1"."DET_ESPECIALIDAD_MED";
create synonym "PRY2205_USER1".SPRIV_ESPECIALIDAD_MEDICA for "PRY2205_USER1"."ESPECIALIDAD_MEDICA";
create synonym "PRY2205_USER1".SPRIV_MEDICO for "PRY2205_USER1"."MEDICO";
create synonym "PRY2205_USER1".SPRIV_PACIENTE for "PRY2205_USER1"."PACIENTE";
create synonym "PRY2205_USER1".SPRIV_PAGOS for "PRY2205_USER1"."PAGOS";
create synonym "PRY2205_USER1".SPRIV_PCT_DESCTO_ADULTO_MAYOR for "PRY2205_USER1"."PCT_DESCTO_ADULTO_MAYOR";
create synonym "PRY2205_USER1".SPRIV_SALUD for "PRY2205_USER1"."SALUD";
create synonym "PRY2205_USER1".SPRIV_SISTEMA_SALUD for "PRY2205_USER1"."SISTEMA_SALUD";
create synonym "PRY2205_USER1".SPRIV_UNIDAD_CONSULTA for "PRY2205_USER1"."UNIDAD_CONSULTA";

create public synonym SPUB_CARGO for "PRY2205_USER1"."CARGO";
create public synonym SPUB_BONO_CONSULTA for "PRY2205_USER1"."BONO_CONSULTA";
create public synonym SPUB_CANT_BONOS_PACIENTES_ANNIO for "PRY2205_USER1"."CANT_BONOS_PACIENTES_ANNIO";
create public synonym SPUB_DET_ESPECIALIDAD_MED for "PRY2205_USER1"."DET_ESPECIALIDAD_MED";
create public synonym SPUB_ESPECIALIDAD_MEDICA for "PRY2205_USER1"."ESPECIALIDAD_MEDICA";
create public synonym SPUB_MEDICO for "PRY2205_USER1"."MEDICO";
create public synonym SPUB_PACIENTE for "PRY2205_USER1"."PACIENTE";
create public synonym SPUB_PAGOS for "PRY2205_USER1"."PAGOS";
create public synonym SPUB_PCT_DESCTO_ADULTO_MAYOR for "PRY2205_USER1"."PCT_DESCTO_ADULTO_MAYOR";
create public synonym SPUB_SALUD for "PRY2205_USER1"."SALUD";
create public synonym SPUB_SISTEMA_SALUD for "PRY2205_USER1"."SISTEMA_SALUD";
create public synonym SPUB_UNIDAD_CONSULTA for "PRY2205_USER1"."UNIDAD_CONSULTA";



create view VISTA_AUM_MEDICO_X_CARGO as
select (REPLACE(RTRIM( TO_CHAR(m.rut_med, 'FM99,999,999,990.99' ), '.' ),',','.') || '-' || m.dv_run) as rut_medico, c.nombre as cargo, m.sueldo_base as sueldo_base, '$' || REPLACE(RTRIM( TO_CHAR(round(m.sueldo_base * 1.15), 'FM99,999,999,990.99' ), '.' ),',','.') as sueldo_aumentado
from SPRIV_MEDICO m
inner join SPRIV_CARGO c on c.car_id = m.car_id
where  lower(c.nombre) like '%atención%'
order by sueldo_base

--CREACION DE INDICE PARA MEJORAR PLAN DE EJECUCION DE LA VISTA VISTA_AUM_MEDICO_X_CARGO
CREATE INDEX CARGO_INDEX ON CARGO (NOMBRE ASC) 
LOGGING 
TABLESPACE USERS 
PCTFREE 10 
INITRANS 2 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  BUFFER_POOL DEFAULT 
) 
NOPARALLEL;


create view VISTA_AUM_MEDICO_X_CARGO_2 as
select (REPLACE(RTRIM( TO_CHAR(m.rut_med, 'FM99,999,999,990.99' ), '.' ),',','.') || '-' || m.dv_run) as rut_medico, c.nombre as cargo, m.sueldo_base as sueldo_base, '$' || REPLACE(RTRIM( TO_CHAR(round(m.sueldo_base * 1.15), 'FM99,999,999,990.99' ), '.' ),',','.') as sueldo_aumentado
from SPRIV_MEDICO m
inner join SPRIV_CARGO c on c.car_id = m.car_id
where m.car_id = 400 and m.sueldo_base < 1500000 
order by m.rut_med
--creacion de indice para mejorar el plan de ejecucion
CREATE INDEX MEDICO_INDEX_SUELDO_CARGO ON MEDICO (SUELDO_BASE, CAR_ID);