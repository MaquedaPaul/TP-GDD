﻿USE GD2C2023
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_FACT_ANUNCIOS')
DROP TABLE AMCGDD.BI_FACT_ANUNCIOS

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_DIMENSION_TIPO_MONEDA')
DROP TABLE AMCGDD.BI_DIMENSION_TIPO_MONEDA

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_DIMENSION_TIPO_OPERACION')
DROP TABLE AMCGDD.BI_DIMENSION_TIPO_OPERACION

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_DIMENSION_TIPO_INMUEBLE')
DROP TABLE AMCGDD.BI_DIMENSION_TIPO_INMUEBLE

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_DIMENSION_TIEMPO')
DROP TABLE AMCGDD.BI_DIMENSION_TIEMPO

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_DIMENSION_RANGO_M2')
DROP TABLE AMCGDD.BI_DIMENSION_RANGO_M2

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_DIMENSION_RANGO_ETARIO')
DROP TABLE AMCGDD.BI_DIMENSION_RANGO_ETARIO

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_DIMENSION_AMBIENTES')
DROP TABLE AMCGDD.BI_DIMENSION_AMBIENTES

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_DIMENSION_SUCURSAL')
DROP TABLE AMCGDD.BI_DIMENSION_SUCURSAL

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_DIMENSION_UBICACION')
DROP TABLE AMCGDD.BI_DIMENSION_UBICACION

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_BARRIO')
DROP TABLE AMCGDD.BI_BARRIO


IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_LOCALIDAD')
DROP TABLE AMCGDD.BI_LOCALIDAD

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_PROVINCIA')
DROP TABLE AMCGDD.BI_PROVINCIA



-----------LIMPIAMOS FUNCIONES

IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'CUATRIMESTREDE')
DROP FUNCTION AMCGDD.CUATRIMESTREDE
GO
IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'DURACION')
DROP FUNCTION AMCGDD.DURACION
GO
IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'FUECONCRETADO')
DROP FUNCTION AMCGDD.FUECONCRETADO
GO
IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'RANGOETARIO')
DROP FUNCTION AMCGDD.RANGOETARIO
GO
IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'RANGOM2')
DROP FUNCTION AMCGDD.RANGOM2
GO

IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'COMISION')
DROP FUNCTION AMCGDD.COMISION
GO

IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'SUMAMONTO')
DROP FUNCTION AMCGDD.SUMAMONTO
GO

-----------LIMPIAMOS PROCEDIMIENTOS
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRACION_DIMENSION_TIPO_MONEDA')
	DROP PROCEDURE AMCGDD.MIGRACION_DIMENSION_TIPO_MONEDA
GO
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRACION_BI_PROVINCIA')
	DROP PROCEDURE AMCGDD.MIGRACION_BI_PROVINCIA
GO
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRACION_BI_LOCALIDAD')
	DROP PROCEDURE AMCGDD.MIGRACION_BI_LOCALIDAD
GO
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRACION_BI_BARRIO')
	DROP PROCEDURE AMCGDD.MIGRACION_BI_BARRIO
GO
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRACION_DIMENSION_UBICACION')
	DROP PROCEDURE AMCGDD.MIGRACION_DIMENSION_UBICACION
GO
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRACION_DIMENSION_RANGO_ETARIO')
	DROP PROCEDURE AMCGDD.MIGRACION_DIMENSION_RANGO_ETARIO
GO
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRACION_DIMENSION_RANGO_M2')
	DROP PROCEDURE AMCGDD.MIGRACION_DIMENSION_RANGO_M2
GO
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRACION_DIMENSION_TIPO_INMUEBLE')
	DROP PROCEDURE AMCGDD.MIGRACION_DIMENSION_TIPO_INMUEBLE
GO
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRACION_DIMENSION_TIPO_OPERACION')
	DROP PROCEDURE AMCGDD.MIGRACION_DIMENSION_TIPO_OPERACION
GO
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRACION_DIMENSION_SUCURSAL')
	DROP PROCEDURE AMCGDD.MIGRACION_DIMENSION_SUCURSAL
GO
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRACION_DIMENSION_AMBIENTES')
	DROP PROCEDURE AMCGDD.MIGRACION_DIMENSION_AMBIENTES
GO
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRACION_DIMENSION_TIEMPO')
	DROP PROCEDURE AMCGDD.MIGRACION_DIMENSION_TIEMPO
GO

-----LIMPIAMOS PROCEDIMIENTOS DE FACT TABLES
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRACION_FACT_ANUNCIOS')
	DROP PROCEDURE AMCGDD.MIGRACION_FACT_ANUNCIOS
GO

---LIMPIAMOS LAS VISTAS
IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'duracionPromedioPublicacion')
    DROP VIEW AMCGDD.duracionPromedioPublicacion
GO
IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'precioPromedioInmueblesSegunOperacion')
    DROP VIEW AMCGDD.precioPromedioInmueblesSegunOperacion
GO
IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'valorPromedioComisionSegunOperacion')
    DROP VIEW AMCGDD.valorPromedioComisionSegunOperacion
GO
IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'porcentajeOperacionesConcretadasPorSucursal')
    DROP VIEW AMCGDD.porcentajeOperacionesConcretadasPorSucursal
GO
IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'montoTotalDeCierreDeContratosPorOperacion')
    DROP VIEW AMCGDD.montoTotalDeCierreDeContratosPorOperacion
GO

----CREACION TABLAS

CREATE TABLE AMCGDD.BI_DIMENSION_TIPO_MONEDA(
	MONEDA_NOMBRE NVARCHAR(100)
	PRIMARY KEY (MONEDA_NOMBRE)
)

CREATE TABLE AMCGDD.BI_DIMENSION_TIPO_OPERACION(
	TIPO_OPERACION_ID NVARCHAR(20)
	PRIMARY KEY (TIPO_OPERACION_ID)
)

CREATE TABLE AMCGDD.BI_DIMENSION_TIPO_INMUEBLE(
	INMUEBLE_TIPO_ID NVARCHAR(100)
	PRIMARY KEY (INMUEBLE_TIPO_ID)
)

CREATE TABLE AMCGDD.BI_DIMENSION_TIEMPO(
	TIEMPO_ID NUMERIC(19,0) IDENTITY,
	ANIO INT,
	MES INT,
	CUATRIMESTRE INT,
	PRIMARY KEY (TIEMPO_ID)
)

CREATE TABLE AMCGDD.BI_DIMENSION_RANGO_M2(
	RANGO_M2_ID NVARCHAR(20)
	PRIMARY KEY (RANGO_M2_ID)
)

CREATE TABLE AMCGDD.BI_DIMENSION_RANGO_ETARIO(
	RANGO_ETARIO_ID NVARCHAR(20)
	PRIMARY KEY (RANGO_ETARIO_ID)
)

CREATE TABLE AMCGDD.BI_DIMENSION_AMBIENTES(
	AMBIENTE_ID NVARCHAR(100)
	PRIMARY KEY (AMBIENTE_ID)
)

CREATE TABLE AMCGDD.BI_DIMENSION_SUCURSAL(
	SUCURSAL_ID NUMERIC(19,0),
	SUCURSAL_NOMBRE NVARCHAR(100),
	PRIMARY KEY (SUCURSAL_ID)
)

CREATE TABLE AMCGDD.BI_DIMENSION_UBICACION(
	UBICACION_ID NUMERIC(19,0) IDENTITY,
	BARRIO_ID NUMERIC(19,0),
	LOCALIDAD_ID NUMERIC(19,0),
	PROVINCIA_ID NUMERIC(19,0),
	PRIMARY KEY (UBICACION_ID)
)


CREATE TABLE AMCGDD.BI_LOCALIDAD(
	LOCALIDAD_ID NUMERIC(19,0),
	LOCALIDAD_NOMBRE NVARCHAR(100),
	LOCALIDAD_PROVINCIA NUMERIC(19,0),
	PRIMARY KEY (LOCALIDAD_ID)
)

CREATE TABLE AMCGDD.BI_PROVINCIA(
	PROVINCIA_ID NUMERIC(19,0),
	PROVINCIA_NOMBRE NVARCHAR(100),
	PRIMARY KEY (PROVINCIA_ID)
)

CREATE TABLE AMCGDD.BI_BARRIO(
	BARRIO_ID NUMERIC(19,0),
	BARRIO_NOMBRE NVARCHAR(100),
	BARRIO_LOCALIDAD_ID NUMERIC(19,0),
	PRIMARY KEY (BARRIO_ID)
)

-----CREAMOS FACT TABLES
CREATE TABLE AMCGDD.BI_FACT_ANUNCIOS(
	TIEMPO_ID NUMERIC(19,0) NOT NULL,
	UBICACION_ID NUMERIC(19,0) NOT NULL,
	SUCURSAL_ID NUMERIC(19,0) NOT NULL,
	RANGO_ETARIO_AGENTE_ID NVARCHAR(20) NOT NULL,
	TIPO_INMUEBLE_ID NVARCHAR(100) NOT NULL,
	AMBIENTES_ID NVARCHAR(100) NOT NULL,
	RANGO_M2_ID NVARCHAR(20) NOT NULL,
	TIPO_OPERACION_ID NVARCHAR(20) NOT NULL,
	TIPO_MONEDA_ID NVARCHAR(100) NOT NULL,
	ANUNCIO_DURACION_DIAS_PROMEDIO NUMERIC(18,2),
	ANUNCIO_PRECIO_PROMEDIO NUMERIC(18,2),
	--ALQUILER_FECHA_INICIO
	INMUEBLE_SUPERIFICIE_TOTAL_PROMEDIO DECIMAL(18,2),
	COMISION NUMERIC(18,2),
	TOTAL_ANUNCIOS INT,
	CONCRETADOS INT,
	MONTO_TOTAL_CIERRE NUMERIC (18,2)
)

CREATE TABLE AMCGDD.BI_HECHOS_PAGO_VENTA (
	
	TIEMPO_ID NUMERIC(19,0),
	IMPORTE_TOTAL NUMERIC(18,2),
	MONEDA_NOMBRE NVARCHAR(100),
	M2_TOTALES NUMERIC(18,2),
	LOCALIDAD_ID NUMERIC(19,0),
	TIPO_INMUEBLE NVARCHAR(100)
);

-----AGREGAMOS CONSTRAINTS

ALTER TABLE AMCGDD.BI_BARRIO
ADD CONSTRAINT FK_BI_LOCALIDAD_ID
FOREIGN KEY (BARRIO_LOCALIDAD_ID) REFERENCES AMCGDD.BI_LOCALIDAD

ALTER TABLE AMCGDD.BI_LOCALIDAD
ADD CONSTRAINT FK_BI_PROVINCIA_ID
FOREIGN KEY (LOCALIDAD_PROVINCIA) REFERENCES AMCGDD.BI_PROVINCIA

----AHORA CONSTRAINTS A LAS FACT TABLES
ALTER TABLE AMCGDD.BI_FACT_ANUNCIOS
ADD PRIMARY KEY 
(TIEMPO_ID, UBICACION_ID, SUCURSAL_ID, RANGO_ETARIO_AGENTE_ID,
 TIPO_INMUEBLE_ID, AMBIENTES_ID, RANGO_M2_ID, TIPO_OPERACION_ID,
 TIPO_MONEDA_ID)


ALTER TABLE AMCGDD.BI_FACT_ANUNCIOS
ADD CONSTRAINT FK_TIEMPO_ID
FOREIGN KEY (TIEMPO_ID) REFERENCES AMCGDD.BI_DIMENSION_TIEMPO

ALTER TABLE AMCGDD.BI_FACT_ANUNCIOS
ADD CONSTRAINT FK_UBICACION_ID
FOREIGN KEY (UBICACION_ID) REFERENCES AMCGDD.BI_DIMENSION_UBICACION

ALTER TABLE AMCGDD.BI_FACT_ANUNCIOS
ADD CONSTRAINT FK_SUCURSAL_ID
FOREIGN KEY (SUCURSAL_ID) REFERENCES AMCGDD.BI_DIMENSION_SUCURSAL

ALTER TABLE AMCGDD.BI_FACT_ANUNCIOS
ADD CONSTRAINT FK_RANGO_ETARIO_INQUILINO_ID
FOREIGN KEY (RANGO_ETARIO_AGENTE_ID) REFERENCES AMCGDD.BI_DIMENSION_RANGO_ETARIO

ALTER TABLE AMCGDD.BI_FACT_ANUNCIOS
ADD CONSTRAINT FK_TIPO_INMUEBLE_ID
FOREIGN KEY (TIPO_INMUEBLE_ID) REFERENCES AMCGDD.BI_DIMENSION_TIPO_INMUEBLE

ALTER TABLE AMCGDD.BI_FACT_ANUNCIOS
ADD CONSTRAINT FK_AMBIENTES_ID
FOREIGN KEY (AMBIENTES_ID) REFERENCES AMCGDD.BI_DIMENSION_AMBIENTES

ALTER TABLE AMCGDD.BI_FACT_ANUNCIOS
ADD CONSTRAINT FK_RANGO_M2_ID
FOREIGN KEY (RANGO_M2_ID) REFERENCES AMCGDD.BI_DIMENSION_RANGO_M2

ALTER TABLE AMCGDD.BI_FACT_ANUNCIOS
ADD CONSTRAINT FK_TIPO_OPERACION_ID
FOREIGN KEY (TIPO_OPERACION_ID) REFERENCES AMCGDD.BI_DIMENSION_TIPO_OPERACION

ALTER TABLE AMCGDD.BI_FACT_ANUNCIOS
ADD CONSTRAINT FK_TIPO_MONEDA_ID
FOREIGN KEY (TIPO_MONEDA_ID) REFERENCES AMCGDD.BI_DIMENSION_TIPO_MONEDA

-- CONSTRAINTS DE HECHOS PAGO VENTA
ALTER TABLE AMCGDD.BI_HECHOS_PAGO_VENTA
ADD CONSTRAINT FK_BI_PAGO_VENTA_TIPO_OPERACION
FOREIGN KEY (TIEMPO_ID) REFERENCES AMCGDD.BI_DIMENSION_TIEMPO (TIEMPO_ID)

ALTER TABLE AMCGDD.BI_HECHOS_PAGO_VENTA
ADD CONSTRAINT FK_BI_PAGO_VENTA_TIEMPO
FOREIGN KEY (MONEDA_NOMBRE) REFERENCES AMCGDD.BI_DIMENSION_TIPO_MONEDA (MONEDA_NOMBRE)

ALTER TABLE AMCGDD.BI_HECHOS_PAGO_VENTA
ADD CONSTRAINT FK_BI_PAGO_VENTA_LOCALIDAD
FOREIGN KEY (LOCALIDAD_ID) REFERENCES AMCGDD.BI_LOCALIDAD (LOCALIDAD_ID)

ALTER TABLE AMCGDD.BI_HECHOS_PAGO_VENTA
ADD CONSTRAINT FK_BI_PAGO_VENTA_TIPO_INMUEBLE
FOREIGN KEY (TIPO_INMUEBLE) REFERENCES AMCGDD.BI_DIMENSION_TIPO_INMUEBLE (INMUEBLE_TIPO_ID)


----CREAMOS FUNCIONES

GO
CREATE FUNCTION AMCGDD.CUATRIMESTREDE(@fecha DATETIME)
RETURNS INT
AS
BEGIN
    DECLARE @cuatrimestre INT
    SET @cuatrimestre = 
        CASE 
            WHEN MONTH(@fecha) BETWEEN 1 AND 4 THEN 1
            WHEN MONTH(@fecha) BETWEEN 5 AND 8 THEN 2
            WHEN MONTH(@fecha) BETWEEN 9 AND 12 THEN 3
            ELSE 0
			 -- En caso de fechas que no estén en un rango válido
        END
    RETURN @cuatrimestre
END
GO


CREATE FUNCTION AMCGDD.DURACION(@anuncio_fecha DATETIME, @anuncio_finalizacion DATETIME)
RETURNS INT
AS
BEGIN
	DECLARE @duracionEnDias INT
	SET @duracionEnDias = DATEDIFF(DAY, @anuncio_fecha, @anuncio_finalizacion)
	RETURN @duracionEnDias
END
GO

CREATE FUNCTION AMCGDD.FUECONCRETADO(@anuncio_estado NVARCHAR(100))
RETURNS INT
AS
BEGIN
	IF @anuncio_estado = 'VENDIDO'
		RETURN 1
	IF @anuncio_estado = 'ALQUILADO'
		RETURN 1
	RETURN 0
END
GO


CREATE FUNCTION AMCGDD.RANGOETARIO(@fecha_nac DATETIME)
RETURNS NVARCHAR(20)
AS
BEGIN
	DECLARE @Edad INT;
	SET @Edad = DATEDIFF(YEAR, @fecha_nac, GETDATE());
	DECLARE @RangoEtario VARCHAR(20);

	SET @RangoEtario = 
    CASE 
        WHEN @Edad < 25 THEN '<25'
        WHEN @Edad BETWEEN 25 AND 35 THEN '25-35'
        WHEN @Edad BETWEEN 36 AND 50 THEN '35-50'
		WHEN @Edad IS NULL THEN '-'
        ELSE '>50'
    END
	RETURN @RangoEtario
END
GO

GO


CREATE FUNCTION AMCGDD.RANGOM2(@SuperficieTotal NUMERIC(18, 2))
RETURNS NVARCHAR(20)
AS
BEGIN
	DECLARE @RangoSuperficie VARCHAR(20);
	SET @RangoSuperficie = 
		CASE  
			WHEN @SuperficieTotal < 35 THEN '<35'
			WHEN @SuperficieTotal BETWEEN 35 AND 55 THEN '35-55'
			WHEN @SuperficieTotal BETWEEN 55 AND 75 THEN '55-75'
			WHEN @SuperficieTotal BETWEEN 75 AND 100 THEN '75-100'
			ELSE '>100'
    END
	RETURN @RangoSuperficie
END
GO


CREATE FUNCTION AMCGDD.COMISION(@alquiler_comision NUMERIC(18,2), @venta_comision NUMERIC(18,2))
RETURNS NUMERIC(18,2)
AS
BEGIN
	IF @alquiler_comision IS NOT NULL
		RETURN @alquiler_comision
	IF @venta_comision IS NOT NULL
		RETURN @venta_comision
	RETURN 0
END
GO

CREATE FUNCTION AMCGDD.SUMAMONTO(@venta_monto NUMERIC(18,2), @alquiler_monto NUMERIC(18,2))
RETURNS NUMERIC(18,2)
AS
BEGIN
	IF @alquiler_monto IS NOT NULL
		RETURN @alquiler_monto
	IF @venta_monto IS NOT NULL
		RETURN @venta_monto
	RETURN 0
END
GO

------CREAMOS PROCEDIMIENTOS

GO
CREATE PROCEDURE AMCGDD.MIGRACION_DIMENSION_TIPO_MONEDA
AS
BEGIN
	PRINT 'MIGRACION TIPO MONEDA'
	INSERT INTO AMCGDD.BI_DIMENSION_TIPO_MONEDA
	SELECT MONEDA_NOMBRE FROM AMCGDD.MONEDA
END

GO
CREATE PROCEDURE AMCGDD.MIGRACION_BI_PROVINCIA
AS
BEGIN
	PRINT 'MIGRACION BI_PROVINCIA'
	INSERT INTO AMCGDD.BI_PROVINCIA
	SELECT * FROM AMCGDD.PROVINCIA
END

GO
CREATE PROCEDURE AMCGDD.MIGRACION_BI_LOCALIDAD
AS
BEGIN
	PRINT 'MIGRACION BI_LOCALIDAD'
	INSERT INTO AMCGDD.BI_LOCALIDAD
	SELECT * FROM AMCGDD.LOCALIDAD
END

GO
CREATE PROCEDURE AMCGDD.MIGRACION_BI_BARRIO
AS
BEGIN
	PRINT 'MIGRACION BI_BARRIO'
	INSERT INTO AMCGDD.BI_BARRIO
	SELECT * FROM AMCGDD.BARRIO
END
GO


CREATE PROCEDURE AMCGDD.MIGRACION_DIMENSION_UBICACION
AS
BEGIN 
	PRINT 'MIGRACION DIMENSION UBICACION'
	INSERT INTO BI_DIMENSION_UBICACION(BARRIO_ID, LOCALIDAD_ID, PROVINCIA_ID)
	SELECT BARRIO_ID, LOCALIDAD_ID, PROVINCIA_ID FROM AMCGDD.BI_BARRIO
	JOIN AMCGDD.BI_LOCALIDAD ON LOCALIDAD_ID = BARRIO_LOCALIDAD_ID
	JOIN AMCGDD.BI_PROVINCIA ON PROVINCIA_ID = LOCALIDAD_PROVINCIA
END
GO

CREATE PROCEDURE AMCGDD.MIGRACION_DIMENSION_RANGO_ETARIO
AS
BEGIN
	PRINT 'MIGRACION DIMENSION RANGO ETARIO'
	INSERT INTO AMCGDD.BI_DIMENSION_RANGO_ETARIO
	VALUES('<25'),('25-35'),('35-50'),('>50')
END

GO
CREATE PROCEDURE AMCGDD.MIGRACION_DIMENSION_RANGO_M2
AS
BEGIN
	PRINT 'MIGRACION DIMENSION RANGO M2'
	INSERT INTO AMCGDD.BI_DIMENSION_RANGO_M2
	VALUES('<35'),('35-55'),('55-75'),('75-100'),('>100')
END

GO
CREATE PROCEDURE AMCGDD.MIGRACION_DIMENSION_TIPO_INMUEBLE
AS
BEGIN
	PRINT 'MIGRACION DIMENSION TIPO INMUEBLE'
	INSERT INTO AMCGDD.BI_DIMENSION_TIPO_INMUEBLE
	SELECT NOMBRE FROM AMCGDD.TIPO
END

GO
CREATE PROCEDURE AMCGDD.MIGRACION_DIMENSION_TIPO_OPERACION
AS
BEGIN
	PRINT 'MIGRACION DIMENSION TIPO OPERACION'
	INSERT INTO AMCGDD.BI_DIMENSION_TIPO_OPERACION
	SELECT * FROM AMCGDD.ANUNCIO_TIPOS
END

GO
CREATE PROCEDURE AMCGDD.MIGRACION_DIMENSION_SUCURSAL
AS
BEGIN
	PRINT 'MIGRACION DIMENSION SUCURSAL'
	INSERT INTO AMCGDD.BI_DIMENSION_SUCURSAL 
	SELECT SUCURSAL_ID, SUCURSAL_NOMBRE FROM AMCGDD.SUCURSAL
END

GO
CREATE PROCEDURE AMCGDD.MIGRACION_DIMENSION_AMBIENTES
AS
BEGIN
	PRINT 'MIGRACION DIMENSION AMBIENTES'
	INSERT INTO AMCGDD.BI_DIMENSION_AMBIENTES
	SELECT nombre FROM AMCGDD.INMUEBLE_AMBIENTE
END

GO
CREATE PROCEDURE AMCGDD.MIGRACION_DIMENSION_TIEMPO
AS
BEGIN
	PRINT 'MIGRACION DE FECHAS'
---FECHAS ANUNCIOS
	INSERT INTO AMCGDD.BI_DIMENSION_TIEMPO (ANIO, MES, CUATRIMESTRE)
	SELECT DISTINCT YEAR(anuncio_fecha), 
	DATEPART(MONTH, anuncio_fecha), 
	AMCGDD.CUATRIMESTREDE(anuncio_fecha) 
	FROM AMCGDD.ANUNCIOS
	WHERE NOT EXISTS
		(SELECT 1 FROM AMCGDD.BI_DIMENSION_TIEMPO
		 WHERE ANIO = YEAR(anuncio_fecha) AND 
		 MES = DATEPART(MONTH, anuncio_fecha))

	INSERT INTO AMCGDD.BI_DIMENSION_TIEMPO (ANIO, MES, CUATRIMESTRE)
	SELECT DISTINCT YEAR(anuncio_finalizacion), 
	DATEPART(MONTH, anuncio_finalizacion), 
	AMCGDD.CUATRIMESTREDE(anuncio_finalizacion) 
	FROM AMCGDD.ANUNCIOS
	WHERE NOT EXISTS
		(SELECT 1 FROM AMCGDD.BI_DIMENSION_TIEMPO
		 WHERE ANIO = YEAR(anuncio_finalizacion) AND 
		 MES = DATEPART(MONTH, anuncio_finalizacion))

---FECHAS ALQUILERES
	INSERT INTO AMCGDD.BI_DIMENSION_TIEMPO (ANIO, MES, CUATRIMESTRE)
	SELECT DISTINCT YEAR(alquiler_fecha_inicio), 
	DATEPART(MONTH, alquiler_fecha_inicio), 
	AMCGDD.CUATRIMESTREDE(alquiler_fecha_inicio) 
	FROM AMCGDD.ALQUILER
	WHERE NOT EXISTS 
		(SELECT * FROM AMCGDD.BI_DIMENSION_TIEMPO
		 WHERE ANIO = YEAR(alquiler_fecha_inicio) AND 
		 MES = DATEPART(MONTH, alquiler_fecha_inicio))
	
	INSERT INTO AMCGDD.BI_DIMENSION_TIEMPO (ANIO, MES, CUATRIMESTRE)
	SELECT DISTINCT YEAR(alquiler_fecha_fin), 
	DATEPART(MONTH, alquiler_fecha_fin), 
	AMCGDD.CUATRIMESTREDE(alquiler_fecha_fin) 
	FROM AMCGDD.ALQUILER
	WHERE NOT EXISTS 
		(SELECT * FROM AMCGDD.BI_DIMENSION_TIEMPO
		 WHERE ANIO = YEAR(alquiler_fecha_fin) AND 
		 MES = DATEPART(MONTH, alquiler_fecha_fin))

	INSERT INTO AMCGDD.BI_DIMENSION_TIEMPO (ANIO, MES, CUATRIMESTRE)
	SELECT DISTINCT YEAR(pago_fecha), 
	DATEPART(MONTH, pago_fecha), 
	AMCGDD.CUATRIMESTREDE(pago_fecha) 
	FROM AMCGDD.PAGO_ALQUILER
	WHERE NOT EXISTS
		(SELECT 1 FROM AMCGDD.BI_DIMENSION_TIEMPO
		 WHERE ANIO = YEAR(pago_fecha) AND 
		 MES = DATEPART(MONTH, pago_fecha))

	INSERT INTO AMCGDD.BI_DIMENSION_TIEMPO (ANIO, MES, CUATRIMESTRE)
	SELECT DISTINCT YEAR(pago_inicio_periodo), 
	DATEPART(MONTH, pago_inicio_periodo), 
	AMCGDD.CUATRIMESTREDE(pago_inicio_periodo) 
	FROM AMCGDD.PAGO_ALQUILER
	WHERE NOT EXISTS
		(SELECT 1 FROM AMCGDD.BI_DIMENSION_TIEMPO
		 WHERE ANIO = YEAR(pago_inicio_periodo) AND 
		 MES = DATEPART(MONTH, pago_inicio_periodo))

	INSERT INTO AMCGDD.BI_DIMENSION_TIEMPO (ANIO, MES, CUATRIMESTRE)
	SELECT DISTINCT YEAR(pago_fin_periodo), 
	DATEPART(MONTH, pago_fin_periodo), 
	AMCGDD.CUATRIMESTREDE(pago_fin_periodo) 
	FROM AMCGDD.PAGO_ALQUILER
	WHERE NOT EXISTS
		(SELECT 1 FROM AMCGDD.BI_DIMENSION_TIEMPO
		 WHERE ANIO = YEAR(pago_fin_periodo) AND 
		 MES = DATEPART(MONTH, pago_fin_periodo))

	INSERT INTO AMCGDD.BI_DIMENSION_TIEMPO (ANIO, MES, CUATRIMESTRE)
	SELECT DISTINCT YEAR(pago_fecha_vencimiento), 
	DATEPART(MONTH, pago_fecha_vencimiento), 
	AMCGDD.CUATRIMESTREDE(pago_fecha_vencimiento) 
	FROM AMCGDD.PAGO_ALQUILER
	WHERE NOT EXISTS
		(SELECT 1 FROM AMCGDD.BI_DIMENSION_TIEMPO
		 WHERE ANIO = YEAR(pago_fecha_vencimiento) AND 
		 MES = DATEPART(MONTH, pago_fecha_vencimiento))

---FECHAS VENTAS
	INSERT INTO AMCGDD.BI_DIMENSION_TIEMPO (ANIO, MES, CUATRIMESTRE)
	SELECT DISTINCT YEAR(VENTA_FECHA), 
	DATEPART(MONTH, VENTA_FECHA), 
	AMCGDD.CUATRIMESTREDE(VENTA_FECHA) 
	FROM AMCGDD.VENTA_INMUEBLE
	WHERE NOT EXISTS
		(SELECT 1 FROM AMCGDD.BI_DIMENSION_TIEMPO
		 WHERE ANIO = YEAR(VENTA_FECHA) AND 
		 MES = DATEPART(MONTH, VENTA_FECHA))
END
GO


-----MIGRACION DE LAS TABLAS DE HECHOS

GO
CREATE PROCEDURE AMCGDD.MIGRACION_FACT_ANUNCIOS
AS
BEGIN 
	PRINT 'MIGRACION A LA TABLA DE HECHOS DE ANUNCIOS' 
	INSERT INTO AMCGDD.BI_FACT_ANUNCIOS
	SELECT 
	TIEMPO_ID, 
	UBICACION_ID,
	SUCURSAL_ID,
	AMCGDD.RANGOETARIO(usuario_fecha_nac) AS 'Rango Etario Agente',
	t.NOMBRE,
	ia.nombre, 
	AMCGDD.RANGOM2(SUPERFICIE_TOTAL) AS 'Rango Superficie Inmueble', 
	anuncio_tipo, 
	mo.MONEDA_NOMBRE,
	AVG(AMCGDD.DURACION(anuncio_fecha, anuncio_finalizacion)) AS DURACION,
	AVG(anuncio_precio) AS PRECIO_PROMEDIO, 
	AVG(i.SUPERFICIE_TOTAL) AS SUPERFICIE_PROMEDIO,
    AVG(AMCGDD.COMISION(alq.alquiler_comision, VENTA_COMISION)) AS COMISION,
	COUNT(*),
	SUM(AMCGDD.FUECONCRETADO(anuncio_estado)),
	SUM(AMCGDD.SUMAMONTO(venta_precio, importe_precio))
	FROM AMCGDD.ANUNCIOS
	JOIN AMCGDD.BI_DIMENSION_TIEMPO ON YEAR(anuncio_fecha) = ANIO AND
	MONTH(anuncio_fecha) = MES 
	JOIN AMCGDD.AGENTES ON anuncio_agente = agente_id
	JOIN AMCGDD.SUCURSAL ON SUCURSAL_ID = agente_sucursal
	JOIN AMCGDD.USUARIOS ON usuario_id = agente_usuario
	JOIN AMCGDD.INMUEBLE i ON anuncio_inmueble = INMUEBLE_ID
	JOIN AMCGDD.BARRIO b ON b.BARRIO_ID = i.BARRIO_ID
	JOIN AMCGDD.LOCALIDAD lo ON lo.LOCALIDAD_ID = BARRIO_LOCALIDAD_ID
	JOIN AMCGDD.PROVINCIA pro ON pro.PROVINCIA_ID = LOCALIDAD_PROVINCIA_ID
	JOIN AMCGDD.BI_DIMENSION_UBICACION du ON 
	du.LOCALIDAD_ID = lo.LOCALIDAD_ID AND
	pro.PROVINCIA_ID = du.PROVINCIA_ID AND b.BARRIO_ID = du.BARRIO_ID
	JOIN AMCGDD.TIPO t ON t.TIPO_ID = i.TIPO_ID
	JOIN AMCGDD.INMUEBLE_AMBIENTE ia ON i.AMBIENTE_ID = ia.AMBIENTE_ID
	JOIN AMCGDD.MONEDA mo ON mo.MONEDA_CODIGO = anuncio_moneda
	LEFT JOIN AMCGDD.ALQUILER alq ON alq.alquiler_anuncio = anuncio_codigo
	LEFT JOIN AMCGDD.IMPORTE_ALQUILER ON importe_alquiler = alquiler_id
	LEFT JOIN AMCGDD.VENTA_INMUEBLE ON VENTA_ANUNCIO = anuncio_codigo
	GROUP BY TIEMPO_ID, UBICACION_ID, SUCURSAL_ID, AMCGDD.RANGOETARIO(usuario_fecha_nac),
	t.NOMBRE, ia.nombre, AMCGDD.RANGOM2(SUPERFICIE_TOTAL), anuncio_tipo,
	MONEDA_NOMBRE
END
GO

GO
CREATE PROCEDURE AMCGDD.MIGRACION_BI_HECHOS_PAGO_VENTA
AS
BEGIN

	INSERT INTO AMCGDD.BI_HECHOS_PAGO_VENTA
	SELECT 
		dt.TIEMPO_ID AS TIEMPO,
		SUM(v.VENTA_PRECIO) AS IMPORTE_TOTAL_VENTAS,
		dm.MONEDA_NOMBRE AS MONEDA,
		SUM(i.SUPERFICIE_TOTAL) AS M2_TOTALES,
		du.LOCALIDAD_ID AS LOCALIDAD,
		ti.INMUEBLE_TIPO_ID AS TIPO_INMUEBLE
	FROM AMCGDD.PAGO_VENTA pv
	JOIN AMCGDD.VENTA_INMUEBLE v
		ON pv.PAGO_VENTA_VENTA = v.VENTA_CODIGO 
	JOIN AMCGDD.ANUNCIOS a
		ON v.VENTA_ANUNCIO = a.anuncio_codigo
	JOIN AMCGDD.AGENTES ag
		ON a.anuncio_agente = ag.agente_id
	JOIN AMCGDD.MONEDA m
		ON pv.PAGO_VENTA_MONEDA = m.MONEDA_CODIGO
	JOIN AMCGDD.BI_DIMENSION_TIPO_MONEDA dm
		ON m.MONEDA_NOMBRE = dm.MONEDA_NOMBRE
	JOIN AMCGDD.BI_DIMENSION_TIEMPO dt
		ON YEAR(v.VENTA_FECHA) = dt.ANIO
		AND MONTH(v.VENTA_FECHA) = dt.MES
	JOIN AMCGDD.INMUEBLE i
		ON a.anuncio_inmueble = i.INMUEBLE_ID
	JOIN AMCGDD.BI_DIMENSION_UBICACION du
		ON i.BARRIO_ID = du.BARRIO_ID
	JOIN AMCGDD.TIPO t
		ON t.TIPO_ID = i.TIPO_ID
	JOIN AMCGDD.BI_DIMENSION_TIPO_INMUEBLE ti
		ON t.NOMBRE = ti.INMUEBLE_TIPO_ID
	GROUP BY dm.MONEDA_NOMBRE,
		du.LOCALIDAD_ID,
		ti.INMUEBLE_TIPO_ID,
		dt.TIEMPO_ID
	ORDER BY TIEMPO_ID
END

CREATE PROCEDURE AMCGDD.MIGRACION_BI_HECHOS_ALQUILERES
AS
BEGIN
INSERT INTO AMCGDD.BI_HECHOS_ALQUILERES
SELECT AMCGDD.RANGOETARIO(u.usuario_fecha_nac) AS RANGO_ETARIO, dt.TIEMPO_ID, im.BARRIO_ID, COUNT(im.BARRIO_ID) AS CANTIDAD_DE_ALQUILERES
FROM AMCGDD.ALQUILER a
JOIN AMCGDD.INQUILINOS i
	ON a.alquiler_inquilino = i.inquilino_id
JOIN AMCGDD.USUARIOS u
	ON i.inquilino_usuario = u.usuario_id
JOIN AMCGDD.BI_DIMENSION_TIEMPO dt
	ON YEAR(alquiler_fecha_inicio) = dt.ANIO
	AND MONTH(alquiler_fecha_inicio) = dt.MES
JOIN AMCGDD.ANUNCIOS an
	ON a.alquiler_anuncio = an.anuncio_codigo
JOIN AMCGDD.INMUEBLE im
	ON an.anuncio_inmueble = im.INMUEBLE_ID
GROUP BY AMCGDD.RANGOETARIO(u.usuario_fecha_nac), im.BARRIO_ID, dt.TIEMPO_ID
ORDER BY AMCGDD.RANGOETARIO(u.usuario_fecha_nac), dt.TIEMPO_ID, COUNT(im.BARRIO_ID) DESC
END

---////VISTA 1////
GO
CREATE VIEW AMCGDD.duracionPromedioPublicacion AS
SELECT ANIO, CUATRIMESTRE, BARRIO_ID, TIPO_OPERACION_ID, AMBIENTES_ID, AVG(ANUNCIO_DURACION_DIAS_PROMEDIO) AS DURACION_DIAS_PROMEDIO 
FROM AMCGDD.BI_FACT_ANUNCIOS fa
JOIN AMCGDD.BI_DIMENSION_TIEMPO dt ON fa.TIEMPO_ID = dt.TIEMPO_ID
JOIN AMCGDD.BI_DIMENSION_UBICACION du ON du.UBICACION_ID = fa.UBICACION_ID
GROUP BY ANIO, CUATRIMESTRE, BARRIO_ID, TIPO_OPERACION_ID, AMBIENTES_ID 
GO

---////VISTA 2////
CREATE VIEW AMCGDD.precioPromedioInmueblesSegunOperacion AS
SELECT ANIO, CUATRIMESTRE, TIPO_OPERACION_ID, TIPO_INMUEBLE_ID, RANGO_M2_ID, AVG(ANUNCIO_PRECIO_PROMEDIO) AS DURACION_DIAS_PROMEDIO 
FROM AMCGDD.BI_FACT_ANUNCIOS fa
JOIN AMCGDD.BI_DIMENSION_TIEMPO dt ON fa.TIEMPO_ID = dt.TIEMPO_ID
GROUP BY ANIO, CUATRIMESTRE, TIPO_OPERACION_ID, TIPO_INMUEBLE_ID, RANGO_M2_ID
GO
---////VISTA 3////  ---> SE TIENE QUE HACER CON LA DE HECHOS DE ALQUILERES
/*

 Los 5 barrios más elegidos para alquilar en función del rango etario de los inquilinos para cada cuatrimestre/año. 
 Se calcula en función de los alquileres dados de alta en dicho periodo
*/

-- BARRIO
-- RANGO ETARIO INQUILINO
-- TIEMPO ID (FECHA DADO DE ALTA)



---////VISTA 4//// ---> SE TIENE QUE HACER CON LA DE HECHOS DE ALQUILERES
/*Porcentaje de incumplimiento de pagos de alquileres en término por cada mes/año. 
Se calcula en función de las fechas de pago y fecha de vencimiento del mismo. El porcentaje es en función del total de pagos en dicho periodo
*/

--  

---////VISTA 5//// ---> SE TIENE QUE HACER CON LA DE HECHOS DE ALQUILERES
/*
5. Porcentaje promedio de incremento del valor de los alquileres para los contratos en curso por mes/año. 
Se calcula tomando en cuenta el último pago con respecto al del mes en curso, únicamente de aquellos alquileres que hayan tenido aumento y están activos
*/
-- PROMEDIO -> AVG ()
-- SOLO CON AUMENTO Y ACTIVOS

---////VISTA 6//// ---> SE TIENE QUE HACER CON LA DE HECHOS DE VENTAS
/*
6. Precio promedio de m2 de la venta de inmuebles según el tipo de inmueble y la localidad para cada cuatrimestre/año. Se calcula en función de las ventas concretadas.
*/

CREATE VIEW AMCGDD.precioPromedioM2 AS
SELECT 
	dt.ANIO AS ANIO,
	dt.CUATRIMESTRE AS CUATRIMESTRE,
	pv.TIPO_INMUEBLE AS 'TIPO INMUEBLE',
	pv.LOCALIDAD_ID AS LOCALIDAD,
	SUM(pv.IMPORTE_TOTAL)/SUM(pv.M2_TOTALES) AS 'PRECIO PROMEDIO M2' 
FROM AMCGDD.BI_HECHOS_PAGO_VENTA pv
JOIN AMCGDD.BI_LOCALIDAD bl
	ON pv.LOCALIDAD_ID = bl.LOCALIDAD_ID
JOIN AMCGDD.BI_DIMENSION_TIPO_INMUEBLE bt
	ON pv.TIPO_INMUEBLE = bt.INMUEBLE_TIPO_ID
JOIN AMCGDD.BI_DIMENSION_TIEMPO dt
	ON pv.TIEMPO_ID = dt.TIEMPO_ID
GROUP BY dt.ANIO,
	dt.CUATRIMESTRE,
	pv.TIPO_INMUEBLE,
	pv.LOCALIDAD_ID

SELECT * FROM AMCGDD.precioPromedioM2
---////VISTA 7////
GO
CREATE VIEW AMCGDD.valorPromedioComisionSegunOperacion AS
SELECT AVG(COMISION) AS 'Valor promedio comision', TIPO_OPERACION_ID, SUCURSAL_ID, CUATRIMESTRE, ANIO  
FROM AMCGDD.BI_FACT_ANUNCIOS fa
JOIN AMCGDD.BI_DIMENSION_TIEMPO dt ON fa.TIEMPO_ID = dt.TIEMPO_ID
GROUP BY TIPO_OPERACION_ID, SUCURSAL_ID, CUATRIMESTRE, ANIO  
GO

---////VISTA 8////
GO
CREATE VIEW AMCGDD.porcentajeOperacionesConcretadasPorSucursal AS
SELECT 100* SUM(CONCRETADOS)/SUM(TOTAL_ANUNCIOS) AS 'Porcentaje Operaciones Concretadas', SUCURSAL_ID, RANGO_ETARIO_AGENTE_ID, ANIO  
FROM AMCGDD.BI_FACT_ANUNCIOS fa
JOIN AMCGDD.BI_DIMENSION_TIEMPO dt ON fa.TIEMPO_ID = dt.TIEMPO_ID
GROUP BY SUCURSAL_ID, RANGO_ETARIO_AGENTE_ID, ANIO    
GO

---////VISTA 9////
 GO
CREATE VIEW AMCGDD.montoTotalDeCierreDeContratosPorOperacion AS
SELECT SUM(MONTO_TOTAL_CIERRE) AS 'Monto Total', TIPO_OPERACION_ID, SUCURSAL_ID, CUATRIMESTRE, TIPO_MONEDA_ID 
FROM AMCGDD.BI_FACT_ANUNCIOS fa
JOIN AMCGDD.BI_DIMENSION_TIEMPO dt ON fa.TIEMPO_ID = dt.TIEMPO_ID
GROUP BY TIPO_OPERACION_ID, SUCURSAL_ID, CUATRIMESTRE, TIPO_MONEDA_ID   
GO

USE GD2C2023
GO
EXEC AMCGDD.MIGRACION_DIMENSION_TIPO_MONEDA
EXEC AMCGDD.MIGRACION_BI_PROVINCIA
EXEC AMCGDD.MIGRACION_BI_LOCALIDAD
EXEC AMCGDD.MIGRACION_BI_BARRIO
EXEC AMCGDD.MIGRACION_DIMENSION_UBICACION
EXEC AMCGDD.MIGRACION_DIMENSION_RANGO_ETARIO
EXEC AMCGDD.MIGRACION_DIMENSION_RANGO_M2
EXEC AMCGDD.MIGRACION_DIMENSION_TIPO_INMUEBLE
EXEC AMCGDD.MIGRACION_DIMENSION_TIPO_OPERACION
EXEC AMCGDD.MIGRACION_DIMENSION_SUCURSAL
EXEC AMCGDD.MIGRACION_DIMENSION_AMBIENTES
EXEC AMCGDD.MIGRACION_DIMENSION_TIEMPO
EXEC AMCGDD.MIGRACION_FACT_ANUNCIOS
