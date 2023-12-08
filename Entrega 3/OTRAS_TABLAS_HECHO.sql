USE GD2C2023
GO
CREATE PROCEDURE AMCGDD.CREACION_TABLAS_BI AS
BEGIN

CREATE TABLE AMCGDD.BI_DIMENSION_TIEMPO(
	TIEMPO_ID NUMERIC(19,0) IDENTITY,
	ANIO INT,
	MES INT,
	CUATRIMESTRE INT,
	PRIMARY KEY (TIEMPO_ID)
)

CREATE TABLE AMCGDD.BI_DIMENSION_TIPO_MONEDA(
	MONEDA_NOMBRE NVARCHAR(100)
	PRIMARY KEY (MONEDA_NOMBRE)
)

CREATE TABLE AMCGDD.BI_DIMENSION_TIPO_OPERACION(
	TIPO_OPERACION_ID NVARCHAR(20)
	PRIMARY KEY (TIPO_OPERACION_ID)
)

CREATE TABLE AMCGDD.BI_DIMENSION_SUCURSAL(
	SUCURSAL_ID NUMERIC(19,0),
	SUCURSAL_NOMBRE NVARCHAR(100),
	PRIMARY KEY (SUCURSAL_ID)
)

CREATE TABLE AMCGDD.BI_HECHOS_CONTRATO (
	TIPO_OPERACION NVARCHAR(20),
	TIEMPO_ID NUMERIC(19,0),
	SUCURSAL_ID NUMERIC(19,0),
	GASTOS_ADMINISTRATIVOS NUMERIC(18,2),
	ANUNCIO NUMERIC(19,0)
);

ALTER TABLE AMCGDD.BI_HECHOS_CONTRATO
ADD CONSTRAINT FK_BI_CONTRATO_TIPO_OPERACION
FOREIGN KEY (TIPO_OPERACION) REFERENCES AMCGDD.BI_DIMENSION_TIPO_OPERACION (TIPO_OPERACION_ID)

ALTER TABLE AMCGDD.BI_HECHOS_CONTRATO
ADD CONSTRAINT FK_BI_CONTRATO_TIEMPO
FOREIGN KEY (TIEMPO_ID) REFERENCES AMCGDD.BI_DIMENSION_TIEMPO (TIEMPO_ID)

ALTER TABLE AMCGDD.BI_HECHOS_CONTRATO
ADD CONSTRAINT FK_BI_CONTRATO_SUCURSAL
FOREIGN KEY (SUCURSAL_ID) REFERENCES AMCGDD.BI_DIMENSION_SUCURSAL (SUCURSAL_ID)

CREATE TABLE AMCGDD.BI_HECHOS_PAGO_VENTA (

	TIEMPO_ID NUMERIC(19,0),
	FECHA DATETIME,
	SUCURSAL_ID NUMERIC(19,0),
	ANUNCIO NUMERIC(19,0),
	IMPORTE_PAGADO NUMERIC(18,2),
	MONEDA_NOMBRE NVARCHAR(100) 
);

ALTER TABLE AMCGDD.BI_HECHOS_PAGO_VENTA
ADD CONSTRAINT FK_BI_PAGO_VENTA_TIPO_OPERACION
FOREIGN KEY (TIEMPO_ID) REFERENCES AMCGDD.BI_DIMENSION_TIEMPO (TIEMPO_ID)

ALTER TABLE AMCGDD.BI_HECHOS_PAGO_VENTA
ADD CONSTRAINT FK_BI_PAGO_VENTA_TIEMPO
FOREIGN KEY (MONEDA_NOMBRE) REFERENCES AMCGDD.BI_DIMENSION_TIPO_MONEDA (MONEDA_NOMBRE)

ALTER TABLE AMCGDD.BI_HECHOS_PAGO_VENTA
ADD CONSTRAINT FK_BI_PAGO_VENTA_SUCURSAL
FOREIGN KEY (SUCURSAL_ID) REFERENCES AMCGDD.BI_DIMENSION_SUCURSAL (SUCURSAL_ID)

CREATE TABLE AMCGDD.BI_HECHOS_PAGO_ALQUILER (

	TIEMPO_ID NUMERIC(19,0),
	FECHA DATETIME,
	SUCURSAL_ID NUMERIC(19,0),
	ANUNCIO NUMERIC(19,0),
	IMPORTE_PAGADO NUMERIC(18,2),
	MONEDA_NOMBRE NVARCHAR(100),
	VENCIDO BIT,
	IMPORTE_SIGUIENTE_PERIODO NUMERIC(18,2),
	HUBO_AUMENTO BIT 
);

ALTER TABLE AMCGDD.BI_HECHOS_PAGO_ALQUILER
ADD CONSTRAINT FK_BI_PAGO_ALQUILER_TIPO_OPERACION
FOREIGN KEY (TIEMPO_ID) REFERENCES AMCGDD.BI_DIMENSION_TIEMPO (TIEMPO_ID)

ALTER TABLE AMCGDD.BI_HECHOS_PAGO_ALQUILER
ADD CONSTRAINT FK_BI_PAGO_ALQUILER_TIEMPO
FOREIGN KEY (MONEDA_NOMBRE) REFERENCES AMCGDD.BI_DIMENSION_TIPO_MONEDA (MONEDA_NOMBRE)

ALTER TABLE AMCGDD.BI_HECHOS_PAGO_ALQUILER
ADD CONSTRAINT FK_BI_PAGO_ALQUILER_SUCURSAL
FOREIGN KEY (SUCURSAL_ID) REFERENCES AMCGDD.BI_DIMENSION_SUCURSAL (SUCURSAL_ID)

END
GO
CREATE PROCEDURE AMCGDD.LIMPIEZA_TABLAS AS
BEGIN
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_HECHOS_CONTRATO')
DROP TABLE AMCGDD.BI_HECHOS_CONTRATO

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_HECHOS_PAGO_VENTA')
DROP TABLE AMCGDD.BI_HECHOS_PAGO_VENTA

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_HECHOS_PAGO_ALQUILER')
DROP TABLE AMCGDD.BI_HECHOS_PAGO_ALQUILER

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_DIMENSION_TIEMPO')
DROP TABLE AMCGDD.BI_DIMENSION_TIEMPO

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_DIMENSION_TIPO_MONEDA')
DROP TABLE AMCGDD.BI_DIMENSION_TIPO_MONEDA

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_DIMENSION_TIPO_OPERACION')
DROP TABLE AMCGDD.BI_DIMENSION_TIPO_OPERACION

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_DIMENSION_SUCURSAL')
DROP TABLE AMCGDD.BI_DIMENSION_SUCURSAL
END


GO
