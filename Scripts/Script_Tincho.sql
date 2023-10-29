-------------------Limpiamos tablas---------------------
--Desde adentro para afuera

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Alquiler')
DROP TABLE AMCGDD.Pago_venta;

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Importe_alquiler')
DROP TABLE AMCGDD.Venta_inmueble;

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Estado_alquiler')
DROP TABLE AMCGDD.Medio_de_pago;

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'pago_alquiler')
DROP TABLE AMCGDD.Moneda;

---------------------Limpiamos procedimientos---------------------


IF EXISTS(SELECT name FROM sys.procedures WHERE name = 'migracion_alquiler')
    DROP PROCEDURE AMCGDD.migracion_medios_de_pago;
GO

IF EXISTS(SELECT name FROM sys.procedures WHERE name = 'migracion_importe_alquiler')
    DROP PROCEDURE AMCGDD.migracion_monedas;
GO
IF EXISTS(SELECT name FROM sys.procedures WHERE name = 'migracion_estado_alquiler')
    DROP PROCEDURE AMCGDD.migracion_venta_inmuebles;
GO
IF EXISTS(SELECT name FROM sys.procedures WHERE name = 'migracion_pago_alquiler')
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

----------------Creamos las tablas sin PK ni FK, pero aclarando cuáles son PK y FK----------------
--CREACIÓN DE TABLAS---------------------

CREATE TABLE AMCGDD.Alquiler(
	alquiler_id NUMERIC(19,0),
	alquiler_anuncio NVARCHAR(100),
	alquiler_inquilino NUMERIC(19,0),
	alquiler_fecha_inicio DATETIME,
	alquiler_fecha_fin DATETIME,
	alquiler_duracion NUMERIC(19,0),
	alquiler_deposito NUMERIC(18,2),
	alquiler_comision NUMERIC(18,2),
	alquiler_gastos_averiguaciones NUMERIC(18,2),
	alquiler_estado NUMERIC(19,0)
	PRIMARY KEY(alquiler_id)
	--FOREIGN KEY (alquiler_anuncio) REFERENCES AMCGDD.Anuncio(anuncio_codigo),
    --FOREIGN KEY (alquiler_inquilino) REFERENCES AMCGDD.Inquilino(inquilino_id),
    --FOREIGN KEY (alquiler_estado) REFERENCES AMCGDD.Alquiler_estado(estado_id) 
	);

CREATE TABLE AMCGDD.Importe_alquiler(
	importe_id NUMERIC(19,0) IDENTITY(1,1),
	importe_alquiler NUMERIC(18,2),
	importe_periodo_inicio NUMERIC(19,0),
	importe_periodo_fin NUMERIC(19,0),
	importe_precio NUMERIC(18,2),
	importe_moneda	NUMERIC(18,2)
	PRIMARY KEY(importe_id)
	--FOREIGN KEY (importe_alquiler) REFERENCES AMCGDD.Alquiler(alquiler_id)
	);

CREATE TABLE AMCGDD.Estado_alquiler(
	estado_id NUMERIC(19,0) IDENTITY (1,1),
	estado_nombre NVARCHAR(100)
	PRIMARY KEY(estado_id)
	);

CREATE TABLE AMCGDD.Pago_alquiler(
	pago_codigo NUMERIC(19,0),
	pago_alquiler NUMERIC(19,0),
	pago_alquiler_descripcion NVARCHAR(100),
	pago_fecha DATETIME,
	pago_nro_periodo NUMERIC(19,0),
	pago_inicio_periodo DATETIME,
	pago_fin_periodo DATETIME,
	pago_importe NUMERIC(19,0),
	pago_medio_pago NUMERIC(19,0)
	PRIMARY KEY(pago_codigo)
	--FOREIGN KEY (pago_alquiler) REFERENCES AMCGDD.Alquiler(alquiler_id),
    --FOREIGN KEY (pago_importe) REFERENCES AMCGDD.Importe_alquiler(importe_id),
    --FOREIGN KEY (pago_medio_pago) REFERENCES AMCGDD.Medio_de_pago(medio_de_pago_id)
	);

---------------------Foreing keys---------------------
ALTER TABLE AMCGDD.Alquiler
ADD CONSTRAINT fk_anuncio_alquiler
FOREIGN KEY (alquiler_anuncio) REFERENCES AMCGDD.Anuncio

ALTER TABLE AMCGDD.Alquiler
ADD CONSTRAINT fk_inquilino_alquiler
FOREIGN KEY (alquiler_inquilino) REFERENCES AMCGDD.Inquilino

ALTER TABLE AMCGDD.Alquiler
ADD CONSTRAINT fk_estado_alquiler
FOREIGN KEY (alquiler_estado) REFERENCES AMCGDD.Estado_alquiler

ALTER TABLE AMCGDD.Importe_alquiler
ADD CONSTRAINT fk_alquiler_importe
FOREIGN KEY (importe_alquiler) REFERENCES AMCGDD.Alquiler

ALTER TABLE AMCGDD.Pago_alquiler
ADD CONSTRAINT fk_alquiler_pago
FOREIGN KEY (pago_alquiler) REFERENCES AMCGDD.Alquiler

ALTER TABLE AMCGDD.Pago_alquiler
ADD CONSTRAINT fk_importe_pago
FOREIGN KEY (pago_importe) REFERENCES AMCGDD.Importe_alquiler

ALTER TABLE AMCGDD.Pago_alquiler
ADD CONSTRAINT fk_medio_pago_pago
FOREIGN KEY (pago_medio_pago) REFERENCES AMCGDD.Medio_de_pago

---------------------Migración de datos---------------------

IF EXISTS(SELECT name FROM sys.procedures WHERE name = 'migracion_estado_alquiler')
    DROP PROCEDURE AMCGDD.migracion_estado_alquiler;
GO

----------------------ESTADO ALQUILER--------------------------
CREATE PROCEDURE AMCGDD.migracion_estado_alquiler
 AS
  BEGIN
	PRINT '**MIGRACION** Estado Alquiler'
		INSERT INTO AMCGDD.Estado_alquiler(estado_nombre)
		SELECT DISTINCT ALQUILER_ESTADO  FROM gd_esquema.Maestra
		WHERE ALQUILER_ESTADO IS NOT NULL
  END
GO

EXEC AMCGDD.migracion_estado_alquiler
SELECT * FROM AMCGDD.Estado_alquiler


CREATE PROCEDURE AMCGDD.migracion_alquiler
AS
	BEGIN
		PRINT '**MIGRACION** Alquiler'
		INSERT INTO AMCGDD.Alquiler(Alquiler_id, alquiler_anuncio, alquiler_fecha_inicio, alquiler_fecha_fin, alquiler_duracion, 
			alquiler_deposito, alquiler_comision, alquiler_gastos_averiguaciones, alquiler_estado/*, alquiler_inquilino*/)
		SELECT ALQUILER_CODIGO, ANUNCIO_CODIGO/*, inquilino_id De tabla Inquilino*/, ALQUILER_FECHA_INICIO, ALQUILER_FECHA_FIN, 1
			ALQUILER_DEPOSITO, ALQUILER_COMISION, ALQUILER_GASTOS_AVERIGUA, estado_id /* De tabla estado_alquiler*/
		FROM gd_esquema.Maestra 
		--JOIN Inquilino ON Inquilino_DNI = INQUILINO_DNI
		JOIN AMCGDD.Estado_alquiler ON ALQUILER_ESTADO = estado_nombre
		WHERE ALQUILER_CODIGO IS NOT NULL
	END
GO

CREATE PROCEDURE AMCGDD.migracion_importe_alquiler
AS
	BEGIN
		PRINT '**MIGRACION** Importe Alquiler'
		INSERT INTO AMCGDD.Importe_alquiler(Importe_alquiler, importe_periodo_inicio, importe_periodo_fin, importe_precio, importe_moneda)
		SELECT Alquiler_codigo /*De Alquiler*/, DETALLE_ALQ_NRO_PERIODO_INI, DETALLE_ALQ_NRO_PERIODO_FIN, DETALLE_ALQ_PRECIO
		FROM gd_esquema.Maestra


CREATE PROCEDURE AMCGDD.migracion_pago_alquiler
AS
	BEGIN
		PRINT '**MIGRACION** Pago Alquiler'
			INSERT INTO AMCGDD.Pago_alquiler(pago_alquiler, pago_codigo, pago_fecha, pago_inicio_periodo, pago_fin_periodo, pago_alquiler_descripcion,
				pago_nro_periodo, pago_medio_pago, pago_importe)
			SELECT ALQUILER_CODIGO, PAGO_ALQUILER_CODIGO, PAGO_ALQUILER_FECHA, PAGO_ALQUILER_FEC_INI, PAGO_ALQUILER_FEC_FIN, PAGO_ALQUILER_DESC,
				PAGO_ALQUILER_NRO_PERIODO, PAGO_ALQUILER_MEDIO_PAGO, PAGO_ALQUILER_IMPORTE FROM gd_esquema.Maestra



