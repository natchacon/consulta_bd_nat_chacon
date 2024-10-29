CREATE TABLE CUSTOMERS 
(
  CUSTOMER_ID NUMBER NOT NULL 
, NOMBRE VARCHAR2(100) NOT NULL 
, APELLIDO VARCHAR2(100) 
, FECHA_REGISTRO TIMESTAMP 
, EMAIL VARCHAR2(100) 
, TELEFONO VARCHAR2(20) 
, CONSTRAINT CUSTOMERS_PK PRIMARY KEY 
  (
    CUSTOMER_ID 
  )
  ENABLE 
);


INSERT INTO customers (customer_id, nombre, apellido, fecha_registro, email, telefono)
VALUES (1, 'Juan', 'Pérez', TO_DATE('2024-01-01','YYYY-MM-DD'), 'juan.perez@mail.com', '123456789');

INSERT INTO customers (customer_id, nombre, apellido, fecha_registro, email, telefono)
VALUES (2, 'Maria', 'González', TO_DATE('2024-06-03','YYYY-MM-DD'), 'maria@mail.com', '12547854');

INSERT INTO customers (customer_id, nombre, apellido, fecha_registro, email, telefono)
VALUES (3, 'Pedro', 'Escamoso', TO_DATE('2024-05-20','YYYY-MM-DD'), 'juan.perez@mail.com', '2245245');

INSERT INTO customers (customer_id, nombre, apellido, fecha_registro, email, telefono)
VALUES (4, 'Alan', 'Brito', TO_DATE('2024-07-08','YYYY-MM-DD'), 'juan.perez@mail.com', '6456465');

INSERT INTO customers (customer_id, nombre, apellido, fecha_registro, email, telefono)
VALUES (5, 'Armando', 'Casas', TO_DATE('2024-09-18','YYYY-MM-DD'), 'juan.perez@mail.com', '65464654');

--DESAFIO 1

SELECT CONCAT(NOMBRE,' ') || APELLIDO AS NOMBRE, 
FECHA_REGISTRO AS FECHA_REGISTRO
FROM customers
WHERE 
EXTRACT(YEAR FROM FECHA_REGISTRO) = EXTRACT(YEAR FROM SYSDATE)
AND
EXTRACT(MONTH FROM FECHA_REGISTRO) = EXTRACT(MONTH FROM SYSDATE) 
ORDER BY FECHA_REGISTRO DESC;

-- DESAFIO 2

CREATE TABLE PRODUCTS 
(
  PRODUCT_ID NUMBER NOT NULL 
, NOMBRE_PRODUCTO VARCHAR2(100) NOT NULL 
, CATEGORIA VARCHAR2(50) NOT NULL 
, PRECIO DECIMAL NOT NULL 
, STOCK INT NOT NULL 
, CONSTRAINT PRODUCTS_PK PRIMARY KEY 
  (
    PRODUCT_ID 
  )
  ENABLE 
);


INSERT INTO PRODUCTS(PRODUCT_ID, NOMBRE_PRODUCTO, CATEGORIA, PRECIO, STOCK) VALUES (1,'VESTIDO','ROPA',15.5, 5);
INSERT INTO PRODUCTS(PRODUCT_ID, NOMBRE_PRODUCTO, CATEGORIA, PRECIO, STOCK) VALUES (2,'ZAPATILA PABLITO NEUQUEN','CALZADO',20.0, 10);
INSERT INTO PRODUCTS(PRODUCT_ID, NOMBRE_PRODUCTO, CATEGORIA, PRECIO, STOCK) VALUES (3,'ANILLO DIORO','ACCESORIO',70.5, 11);
INSERT INTO PRODUCTS(PRODUCT_ID, NOMBRE_PRODUCTO, CATEGORIA, PRECIO, STOCK) VALUES (4,'CARTERA PITUCA','ACCESORIO',102.8, 8);
INSERT INTO PRODUCTS(PRODUCT_ID, NOMBRE_PRODUCTO, CATEGORIA, PRECIO, STOCK) VALUES (5,'PANTALONES ELEFANT','ROPA',6.0, 50);

SELECT ROUND(PRECIO+(PRECIO*0.15),1) AS price_plus_15_percent,
    PRECIO AS original_price, NOMBRE_PRODUCTO as product_name
FROM PRODUCTS
WHERE NOMBRE_PRODUCTO LIKE '%A'
    AND STOCK > 10
ORDER BY 1 ASC;


--DESAFIO 3

CREATE TABLE SALES_STAFF 
(
  STAFF_ID NUMBER NOT NULL 
, NOMBRE VARCHAR2(100) NOT NULL 
, APELLIDO VARCHAR2(100) NOT NULL 
, EMAIL VARCHAR2(100) NOT NULL 
, TELEFONO VARCHAR2(100) NOT NULL 
, CONSTRAINT SALES_STAFF_PK PRIMARY KEY 
  (
    STAFF_ID 
  )
  ENABLE 
);

INSERT INTO sales_staff(staff_id, nombre, apellido, email, telefono) values (1,'Juan', 'Perez', 'jperez@mail.com', '231232');
INSERT INTO sales_staff(staff_id, nombre, apellido, email, telefono) values (2,'Maria', 'Te quiero todavia', 'maria@mail.com', '321312');
INSERT INTO sales_staff(staff_id, nombre, apellido, email, telefono) values (3,'Dolores', 'Delorto', 'adolorida@mail.com', '323232');
INSERT INTO sales_staff(staff_id, nombre, apellido, email, telefono) values (4,'Eusebio', 'Lillo', 'cancionnacional@mail.com', '635433');
INSERT INTO sales_staff(staff_id, nombre, apellido, email, telefono) values (5,'Eustaquio', 'Salas', 'euse@mail.com', '7543543');

SELECT
    nombre || CONCAT (' ', apellido) AS nombre_empleado,
    email AS email,
    SUBSTR(nombre,1,4) || LENGTH(email) || SUBSTR(apellido,LENGTH(apellido)-2) AS pwd
FROM sales_staff
ORDER BY apellido DESC, nombre ASC;
