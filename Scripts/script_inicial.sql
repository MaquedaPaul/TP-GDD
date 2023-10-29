USE GD2C2023
GO

-------------------Limpiamos tablas---------------------
--Desde adentro para afuera

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Pago_venta')
DROP TABLE AMCGDD.Pago_venta;

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Venta_inmueble')
DROP TABLE AMCGDD.Venta_inmueble;

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Medio_de_pago')
DROP TABLE AMCGDD.Medio_de_pago;

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Moneda')
DROP TABLE AMCGDD.Moneda;

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Anuncio')
DROP TABLE AMCGDD.Anuncio;

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Comprador')
DROP TABLE AMCGDD.Comprador;

---------------------Limpiamos procedimientos---------------------


IF EXISTS(SELECT name FROM sys.procedures WHERE name = 'migracion_medios_de_pago')
    DROP PROCEDURE AMCGDD.migracion_medios_de_pago;
GO

IF EXISTS(SELECT name FROM sys.procedures WHERE name = 'migracion_monedas')
    DROP PROCEDURE AMCGDD.migracion_monedas;
GO
IF EXISTS(SELECT name FROM sys.procedures WHERE name = 'migracion_venta_inmuebles')
    DROP PROCEDURE AMCGDD.migracion_venta_inmuebles;
GO
IF EXISTS(SELECT name FROM sys.procedures WHERE name = 'migracion_pago_venta_inmuebles')
    DROP PROCEDURE AMCGDD.migracion_pago_venta_inmuebles;
GO



---------------------Limpiamos el esquema---------------------
IF EXISTS (SELECT name FROM sys.schemas WHERE name = 'AMCGDD')
BEGIN
	DROP SCHEMA AMCGDD
END
GO


---------------------Creamos el esquema---------------------

CREATE SCHEMA AMCGDD;
GO

----------------Creamos las tablas sin PK ni FK, pero aclarando cuáles son PK y FK------------------


------------ANUNCIO-----------
CREATE TABLE AMCGDD.Anuncio(
anuncio_codigo NUMERIC(19,0)
PRIMARY KEY (anuncio_codigo)
)


------------COMPRADOR-----------
CREATE TABLE AMCGDD.Comprador(
comprador_id NUMERIC(19,0) --PRIMARY KEY
PRIMARY KEY (comprador_id)
)

------------MONEDA-----------
CREATE TABLE AMCGDD.Moneda (
moneda_codigo NUMERIC(19,0) IDENTITY (1,1), --PRIMARY KEY
moneda_nombre NVARCHAR(100)
PRIMARY KEY (moneda_codigo)
)


------------MEDIO DE PAGO-----------
CREATE TABLE AMCGDD.Medio_de_pago (
medio_de_pago_id NUMERIC(19,0) IDENTITY (1,1), --PRIMARY KEY
medio_de_pago_nombre NVARCHAR(100)
PRIMARY KEY (medio_de_pago_id)
)


------------VENTA INMUEBLE-----------
CREATE TABLE AMCGDD.Venta_inmueble (
    venta_codigo NUMERIC(19,0),
    venta_anuncio NUMERIC(19,0), --FK
    venta_comprador NUMERIC(19,0), --FK
    venta_fecha DATETIME,
    venta_precio NUMERIC(18,2),
    venta_comision NUMERIC(18,2),
    venta_moneda NUMERIC(19,0), --FK
	PRIMARY KEY (venta_codigo)
	--FOREIGN KEY (venta_anuncio) REFERENCES AMCGDD.Anuncio(anuncio_codigo),
    --FOREIGN KEY (venta_comprador) REFERENCES AMCGDD.Comprador(comprador_id),
    --FOREIGN KEY (venta_moneda) REFERENCES AMCGDD.Moneda(moneda_codigo)
);

------------PAGO VENTA-----------
CREATE TABLE AMCGDD.Pago_venta (
    pago_venta_codigo NUMERIC(19,0) IDENTITY (1,1),
    pago_venta_venta NUMERIC(19,0), --FK
    pago_venta_cotizacion_moneda NUMERIC(18,2),
    pago_venta_moneda NUMERIC(19,0), --FK
    pago_venta_medio_pago NUMERIC(19,0), --FK
    pago_venta_importe NUMERIC(18,2),
	PRIMARY KEY (pago_venta_codigo)
    --FOREIGN KEY (pago_venta_venta) REFERENCES AMCGDD.Venta_inmueble(venta_codigo),
    --FOREIGN KEY (pago_venta_moneda) REFERENCES AMCGDD.Moneda(moneda_codigo),
    --FOREIGN KEY (pago_venta_medio_pago) REFERENCES AMCGDD.Medio_de_pago(medio_de_pago_id)
);

---------------------VENTA INMUEBLE---------------------
ALTER TABLE AMCGDD.Venta_inmueble
ADD CONSTRAINT fk_anuncio_venta
FOREIGN KEY (venta_anuncio) REFERENCES AMCGDD.Anuncio

ALTER TABLE AMCGDD.Venta_inmueble
ADD CONSTRAINT fk_comprador_venta
FOREIGN KEY (venta_comprador) REFERENCES AMCGDD.Comprador

ALTER TABLE AMCGDD.Venta_inmueble
ADD CONSTRAINT fk_moneda_venta
FOREIGN KEY (venta_moneda) REFERENCES AMCGDD.Moneda


---------------------PAGO VENTA---------------------
ALTER TABLE AMCGDD.Pago_Venta
ADD CONSTRAINT fk_venta_pago_venta
FOREIGN KEY (pago_venta_venta) REFERENCES AMCGDD.Venta_inmueble

ALTER TABLE AMCGDD.Pago_Venta
ADD CONSTRAINT fk_moneda_pago_venta
FOREIGN KEY (pago_venta_moneda) REFERENCES AMCGDD.Moneda

ALTER TABLE AMCGDD.Pago_Venta
ADD CONSTRAINT fk_medio_pago_pago_venta
FOREIGN KEY (pago_venta_medio_pago) REFERENCES AMCGDD.Medio_de_pago


--/-------------------MIGRACION DE DATOS-------------------/--

IF EXISTS(SELECT name FROM sys.procedures WHERE name = 'migracion_medios_de_pago')
    DROP PROCEDURE AMCGDD.migracion_medios_de_pago;
GO

----------------------MEDIOS DE PAGO--------------------------
CREATE PROCEDURE AMCGDD.migracion_medios_de_pago
 AS
  BEGIN
	PRINT '**MIGRACION** Medios de pago'
		INSERT INTO AMCGDD.Medio_de_pago(medio_de_pago_nombre)
		SELECT DISTINCT PAGO_VENTA_MEDIO_PAGO  FROM gd_esquema.Maestra
		WHERE PAGO_VENTA_MEDIO_PAGO IS NOT NULL
  END
GO

---------------------MONEDAS---------------------
CREATE PROCEDURE AMCGDD.migracion_monedas
 AS
  BEGIN
	PRINT '**MIGRACION** Monedas'
		INSERT INTO AMCGDD.Moneda(moneda_nombre)
		SELECT DISTINCT ANUNCIO_MONEDA FROM gd_esquema.Maestra
  END
GO

/*

INSERT INTO AMCGDD.Venta_inmueble(venta_codigo, venta_comision,venta_fecha, venta_moneda, venta_precio)
SELECT DISTINCT VENTA_CODIGO, VENTA_COMISION, VENTA_FECHA,VENTA_MONEDA, VENTA_PRECIO_VENTA FROM gd_esquema.Maestra
WHERE VENTA_CODIGO IS NOT NULL
*/

CREATE PROCEDURE AMCGDD.migracion_venta_inmuebles
 AS
  BEGIN
	PRINT '**MIGRACION** Venta inmuebles'
		INSERT INTO AMCGDD.Venta_inmueble (venta_codigo, venta_comision, 
		venta_fecha, venta_moneda, venta_precio)
		SELECT DISTINCT VENTA_CODIGO, VENTA_COMISION, VENTA_FECHA,
       mon.moneda_codigo, VENTA_PRECIO_VENTA
		FROM gd_esquema.Maestra m
		INNER JOIN AMCGDD.Moneda mon ON m.VENTA_MONEDA = mon.moneda_nombre
		WHERE VENTA_CODIGO IS NOT NULL;
  END
GO



CREATE PROCEDURE AMCGDD.migracion_pago_venta_inmuebles
 AS
  BEGIN
	PRINT '**MIGRACION** Pagos de venta de inmuebles'
		INSERT INTO AMCGDD.Pago_venta(pago_venta_venta, pago_venta_cotizacion_moneda,
		pago_venta_importe,pago_venta_medio_pago, pago_venta_moneda)
		SELECT VENTA_CODIGO, PAGO_VENTA_COTIZACION,PAGO_VENTA_IMPORTE,
		(SELECT TOP 1 medio_de_pago_id FROM AMCGDD.Medio_de_pago
		WHERE medio_de_pago_nombre = PAGO_VENTA_MEDIO_PAGO) AS 'Medio Pago',
		(SELECT TOP 1 moneda_codigo FROM AMCGDD.Moneda
		WHERE moneda_nombre = PAGO_VENTA_MONEDA) AS 'Moneda'
		FROM gd_esquema.Maestra
		WHERE VENTA_CODIGO IS NOT NULL
  END
GO


EXEC AMCGDD.migracion_medios_de_pago;
EXEC AMCGDD.migracion_monedas;
EXEC AMCGDD.migracion_venta_inmuebles;
EXEC AMCGDD.migracion_pago_venta_inmuebles

/*
SELECT * FROM AMCGDD.Anuncio
SELECT * FROM AMCGDD.Comprador
SELECT * FROM AMCGDD.Medio_de_pago
SELECT * FROM AMCGDD.Moneda
SELECT * FROM AMCGDD.Pago_venta
SELECT * FROM AMCGDD.Venta_inmueble
*/
