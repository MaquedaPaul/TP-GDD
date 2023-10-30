USE GD2C2023
go
CREATE SCHEMA AMCGDD
go
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'ANUNCIOS')
DROP TABLE AMCGDD.ANUNCIOS

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'ANUNCIO_TIPOS')
DROP TABLE AMCGDD.ANUNCIO_TIPOS

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'ESTADOS_ANUNCIO')
DROP TABLE AMCGDD.ESTADOS_ANUNCIO

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'PERIODO_TIPOS')
DROP TABLE AMCGDD.PERIODO_TIPOS

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'PROPIETARIOS')
DROP TABLE AMCGDD.PROPIETARIOS

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'AGENTES')
DROP TABLE AMCGDD.AGENTES

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'COMPRADORES')
DROP TABLE AMCGDD.COMPRADORES

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'INQUILINOS')
DROP TABLE AMCGDD.INQUILINOS

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'USUARIOS')
DROP TABLE AMCGDD.USUARIOS

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'MIGRACION_USUARIOS')
DROP PROCEDURE AMCGDD.MIGRACION_USUARIOS

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'MIGRACION_SUBTIPOS_USUARIO')
DROP PROCEDURE AMCGDD.MIGRACION_SUBTIPOS_USUARIO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'MIGRACION_ANUNCIOS')
DROP PROCEDURE AMCGDD.MIGRACION_ANUNCIOS

IF EXISTS (SELECT name FROM sys.all_objects s WHERE name = 'FORMATO_TIPO_PERIODO' AND s.type='FN')
DROP FUNCTION AMCGDD.FORMATO_TIPO_PERIODO

IF EXISTS (SELECT name FROM sys.all_objects s WHERE name = 'FORMATO_ANUNCIO_TIPO' AND s.type='FN')
DROP FUNCTION AMCGDD.FORMATO_ANUNCIO_TIPO

IF EXISTS (SELECT name FROM sys.all_objects s WHERE name = 'FORMATO_ANUNCIO_TIPO' AND s.type='FN')
DROP FUNCTION AMCGDD.ID_INQUILINO

IF EXISTS (SELECT name FROM sys.all_objects s WHERE name = 'FORMATO_ANUNCIO_TIPO' AND s.type='FN')
DROP FUNCTION AMCGDD.ID_COMPRADOR

IF EXISTS (SELECT name FROM sys.all_objects s WHERE name = 'FORMATO_ANUNCIO_TIPO' AND s.type='FN')
DROP FUNCTION AMCGDD.ID_PROPIETARIO
/*============================== USUARIOS Y DERIVADOS ==============================*/

CREATE TABLE AMCGDD.USUARIOS (
	usuario_id numeric(19,0) PRIMARY KEY NOT NULL IDENTITY(1,1),
	usuario_nombre nvarchar(100) NOT NULL,
	usuario_apellido nvarchar(100) NOT NULL,
	usuario_fecha_nac datetime not null,
	usuario_mail nvarchar(100) NOT NULL,
	usuario_telefono numeric(18,0) not null,
	usuario_dni numeric(18,0) not null,
	usuario_fecha_registro datetime not null
);

CREATE TABLE AMCGDD.PROPIETARIOS (
	propietario_id numeric(19,0) PRIMARY KEY NOT NULL IDENTITY(1,1),
	propietario_usuario numeric(19,0) NOT NULL
);

CREATE TABLE AMCGDD.AGENTES (
	agente_id numeric(19,0) PRIMARY KEY NOT NULL IDENTITY(1,1),
	agente_usuario numeric(19,0) NOT NULL,
	agente_sucursal numeric(19,0) not null
);

CREATE TABLE AMCGDD.COMPRADORES (
	comprador_id numeric(19,0) PRIMARY KEY NOT NULL IDENTITY(1,1),
	comprador_usuario numeric(19,0) NOT NULL
);

CREATE TABLE AMCGDD.INQUILINOS (
	inquilino_id numeric(19,0) PRIMARY KEY NOT NULL IDENTITY(1,1),
	inquilino_usuario numeric(19,0) NOT NULL
);

ALTER TABLE AMCGDD.PROPIETARIOS
ADD CONSTRAINT fk_propietario_usuario FOREIGN KEY (propietario_usuario) 
REFERENCES AMCGDD.USUARIOS (usuario_id)

ALTER TABLE AMCGDD.AGENTES
ADD CONSTRAINT fk_agente_usuario FOREIGN KEY (agente_usuario) 
REFERENCES AMCGDD.USUARIOS (usuario_id)

ALTER TABLE AMCGDD.AGENTES
ADD CONSTRAINT fk_agente_sucursal FOREIGN KEY (agente_sucursal) 
REFERENCES AMCGDD.SUCURSALES (sucursal_id)

ALTER TABLE AMCGDD.COMPRADORES
ADD CONSTRAINT fk_comprador_usuario FOREIGN KEY (comprador_usuario) 
REFERENCES AMCGDD.USUARIOS (usuario_id)

ALTER TABLE AMCGDD.INQUILINOS
ADD CONSTRAINT fk_inquilino_usuario FOREIGN KEY (inquilino_usuario) 
REFERENCES AMCGDD.USUARIOS (usuario_id)


/*============================== FIN USUARIOS Y DERIVADOS ==============================*/


/*============================== ANUNCIOS ==============================*/

CREATE TABLE AMCGDD.ESTADOS_ANUNCIO ( 
	estado_nombre NVARCHAR(100) PRIMARY KEY NOT NULL
);

CREATE TABLE AMCGDD.PERIODO_TIPOS (
	periodo_nombre NVARCHAR(100) PRIMARY KEY NOT NULL
);

CREATE TABLE AMCGDD.ANUNCIO_TIPOS (
	anuncio_tipo_nombre NVARCHAR(100) PRIMARY KEY NOT NULL
);

CREATE TABLE AMCGDD.ANUNCIOS (
	anuncio_codigo NUMERIC(19,0) PRIMARY KEY NOT NULL,
	anuncio_fecha datetime NOT NULL,
	anuncio_agente NUMERIC(19,0) NOT NULL,
	anuncio_tipo NVARCHAR(100) NOT NULL,
	anuncio_inmueble NUMERIC(19,0) NOT NULL,
	anuncio_precio NUMERIC(18,2) NOT NULL,
	anuncio_moneda NUMERIC(19,0) NOT NULL,
	anuncio_periodo_tipo NVARCHAR(100) NOT NULL,
	anuncio_finalizacion DATETIME NOT NULL,
	anuncio_costo_publicacion NUMERIC(18,2) NOT NULL,
	anuncio_estado NVARCHAR(100) NOT NULL,
	anuncio_propietario NUMERIC(19,0) NOT NULL,
);

ALTER TABLE AMCGDD.ANUNCIOS
ADD CONSTRAINT fk_anuncio_agente FOREIGN KEY (anuncio_agente) 
REFERENCES AMCGDD.AGENTES (agente_id)

ALTER TABLE AMCGDD.ANUNCIOS
ADD CONSTRAINT fk_anuncio_tipo FOREIGN KEY (anuncio_tipo) 
REFERENCES AMCGDD.ANUNCIO_TIPOS (anuncio_tipo_nombre)

ALTER TABLE AMCGDD.ANUNCIOS
ADD CONSTRAINT fk_anuncio_periodo FOREIGN KEY (anuncio_periodo_tipo) 
REFERENCES AMCGDD.PERIODO_TIPOS (periodo_nombre)

ALTER TABLE AMCGDD.ANUNCIOS
ADD CONSTRAINT fk_anuncio_estado FOREIGN KEY (anuncio_estado) 
REFERENCES AMCGDD.ESTADOS_ANUNCIO (estado_nombre)

ALTER TABLE AMCGDD.ANUNCIOS
ADD CONSTRAINT fk_anuncio_propietario FOREIGN KEY (anuncio_propietario) 
REFERENCES AMCGDD.PROPIETARIOS (propietario_id)

/*============================== FIN ANUNCIOS ==============================*/

/*============================== FUNCIONES DE FORMATO ==============================*/

go
CREATE FUNCTION AMCGDD.FORMATO_TIPO_PERIODO(@periodo NVARCHAR(100))
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @result NVARCHAR(100);
    
    IF @periodo = '0'
        SET @result = '-';
    ELSE
        SET @result = RTRIM(LTRIM(UPPER(SUBSTRING(@periodo, 9, 100))));
    
    RETURN @result;
END;


go
CREATE FUNCTION AMCGDD.FORMATO_ANUNCIO_TIPO(@tipo NVARCHAR(100))
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @result NVARCHAR(100);
    
    SET @result = RTRIM(LTRIM(UPPER(SUBSTRING(@tipo, 15, 100))));
   
    RETURN @result;
END;

/*============================== FIN FUNCIONES DE FORMATO ==============================*/

/*============================== FUNCIONES DE OBTENCION ==============================*/
GO
CREATE FUNCTION AMCGDD.ID_INQUILINO(@dni NUMERIC(19,0))
RETURNS NUMERIC(19,0)
AS
BEGIN
	RETURN (
		SELECT TOP 1 inquilino_id FROM
		AMCGDD.INQUILINOS i
		JOIN AMCGDD.USUARIOS  u
		ON i.inquilino_usuario = u.usuario_id
		WHERE u.usuario_dni = @dni
	);
END

GO
CREATE FUNCTION AMCGDD.ID_COMPRADOR(@dni NUMERIC(19,0))
RETURNS NUMERIC(19,0)
AS
BEGIN
	RETURN (
		SELECT TOP 1 comprador_id FROM
		AMCGDD.COMPRADORES c
		JOIN AMCGDD.USUARIOS  u
		ON c.comprador_usuario = u.usuario_id
		WHERE u.usuario_dni = @dni
	);
END

GO
CREATE FUNCTION AMCGDD.ID_PROPIETARIO(@dni NUMERIC(19,0))
RETURNS NUMERIC(19,0)
AS
BEGIN
	RETURN (
		SELECT TOP 1 propietario_id FROM
		AMCGDD.PROPIETARIOS p
		JOIN AMCGDD.USUARIOS  u
		ON p.propietario_usuario = u.usuario_id
		WHERE u.usuario_dni = @dni
	);
END

/*============================== FIN FUNCIONES DE OBTENCION ==============================*/

/*============================== MIGRACIONES ==============================*/

GO
CREATE PROCEDURE AMCGDD.MIGRACION_USUARIOS 
AS
	BEGIN

		/* MIGRACION INQUILINOS (12842 FILAS)*/

		INSERT INTO AMCGDD.USUARIOS (
			usuario_nombre, 
			usuario_apellido, 
			usuario_dni, 
			usuario_mail, 
			usuario_fecha_nac, 
			usuario_fecha_registro,
			usuario_telefono) 

		SELECT DISTINCT 
			RTRIM(LTRIM(INQUILINO_NOMBRE)),
			RTRIM(LTRIM(UPPER(INQUILINO_APELLIDO))), 
			RTRIM(LTRIM(INQUILINO_DNI)), 
			RTRIM(LTRIM(INQUILINO_MAIL)), 
			INQUILINO_FECHA_NAC, 
			INQUILINO_FECHA_REGISTRO, 
			RTRIM(LTRIM(INQUILINO_TELEFONO)) 
		FROM gd_esquema.Maestra
		WHERE INQUILINO_NOMBRE IS NOT NULL;

		PRINT '**MIGRACION** USUARIOS INQUILINOS AGREGADOS'

		/* MIGRACION AGENTES (3 FILAS)*/

		INSERT INTO AMCGDD.USUARIOS (
			usuario_nombre, 
			usuario_apellido, 
			usuario_dni, 
			usuario_mail, 
			usuario_fecha_nac, 
			usuario_fecha_registro,
			usuario_telefono) 

		SELECT DISTINCT 
			RTRIM(LTRIM(AGENTE_NOMBRE)),
			RTRIM(LTRIM(UPPER(AGENTE_APELLIDO))), 
			RTRIM(LTRIM(AGENTE_DNI)), 
			RTRIM(LTRIM(AGENTE_MAIL)), 
			RTRIM(LTRIM(AGENTE_FECHA_NAC)), 
			RTRIM(LTRIM(AGENTE_FECHA_REGISTRO)), 
			RTRIM(LTRIM(AGENTE_TELEFONO))
		FROM gd_esquema.Maestra
		WHERE AGENTE_NOMBRE IS NOT NULL

		PRINT '**MIGRACION** USUARIOS AGENTES AGREGADOS'

		/* MIGRACION COMPRADORES (4058 FILAS) */

		INSERT INTO AMCGDD.USUARIOS (
			usuario_nombre, 
			usuario_apellido, 
			usuario_dni, 
			usuario_mail, 
			usuario_fecha_nac, 
			usuario_fecha_registro,
			usuario_telefono) 
 

		SELECT DISTINCT 
			RTRIM(LTRIM(COMPRADOR_NOMBRE)),
			RTRIM(LTRIM(UPPER(COMPRADOR_APELLIDO))), 
			RTRIM(LTRIM(COMPRADOR_DNI)), 
			RTRIM(LTRIM(COMPRADOR_MAIL)), 
			RTRIM(LTRIM(COMPRADOR_FECHA_NAC)), 
			RTRIM(LTRIM(COMPRADOR_FECHA_REGISTRO)), 
			RTRIM(LTRIM(COMPRADOR_TELEFONO))
		FROM gd_esquema.Maestra
		WHERE COMPRADOR_NOMBRE IS NOT NULL
			AND NOT EXISTS (
				SELECT * 
				FROM AMCGDD.USUARIOS 
				WHERE RTRIM(LTRIM(UPPER(usuario_nombre))) = RTRIM(LTRIM(UPPER(COMPRADOR_NOMBRE))) 
					AND RTRIM(LTRIM(UPPER(usuario_apellido))) = RTRIM(LTRIM(UPPER(COMPRADOR_APELLIDO))) 
					AND usuario_dni = COMPRADOR_DNI
				)

		PRINT '**MIGRACION** USUARIOS COMPRADORES AGREGADOS'
	
		/* MIGRACION PROPIETARIOS (8152 FILAS) */
		INSERT INTO AMCGDD.USUARIOS (
			usuario_nombre, 
			usuario_apellido, 
			usuario_dni, 
			usuario_mail, 
			usuario_fecha_nac, 
			usuario_fecha_registro,
			usuario_telefono) 


		SELECT DISTINCT 
			RTRIM(LTRIM(PROPIETARIO_NOMBRE)),
			RTRIM(LTRIM(UPPER(PROPIETARIO_APELLIDO))), 
			RTRIM(LTRIM(PROPIETARIO_DNI)), 
			RTRIM(LTRIM(PROPIETARIO_MAIL)), 
			RTRIM(LTRIM(PROPIETARIO_FECHA_NAC)), 
			RTRIM(LTRIM(PROPIETARIO_FECHA_REGISTRO)), 
			RTRIM(LTRIM(PROPIETARIO_TELEFONO))
		FROM gd_esquema.Maestra
		WHERE PROPIETARIO_NOMBRE IS NOT NULL
			AND NOT EXISTS (
				SELECT * 
				FROM AMCGDD.USUARIOS 
				WHERE RTRIM(LTRIM(UPPER(usuario_nombre))) = RTRIM(LTRIM(UPPER(PROPIETARIO_NOMBRE))) 
					AND RTRIM(LTRIM(UPPER(usuario_apellido))) = RTRIM(LTRIM(UPPER(PROPIETARIO_APELLIDO))) 
					AND usuario_dni = PROPIETARIO_DNI
				)
		PRINT '**MIGRACION** USUARIOS PROPIETARIOS AGREGADOS'
END

GO

CREATE PROCEDURE AMCGDD.MIGRACION_SUBTIPOS_USUARIO
AS
BEGIN

	INSERT INTO AMCGDD.AGENTES

	SELECT DISTINCT usuario_id, 1 FROM 
	gd_esquema.Maestra m JOIN
	AMCGDD.USUARIOS u
	ON m.AGENTE_NOMBRE = u.usuario_nombre
	AND m.AGENTE_APELLIDO = u.usuario_apellido
	AND m.AGENTE_DNI = u.usuario_dni
	AND m.AGENTE_NOMBRE IS NOT NULL
	
	PRINT '**MIGRACION** AGENTES AGREGADOS'

	INSERT INTO AMCGDD.PROPIETARIOS

	SELECT DISTINCT usuario_id FROM 
	gd_esquema.Maestra m JOIN
	AMCGDD.USUARIOS u
	ON m.PROPIETARIO_NOMBRE = u.usuario_nombre
	AND m.PROPIETARIO_APELLIDO = u.usuario_apellido
	AND m.PROPIETARIO_DNI = u.usuario_dni
	AND m.PROPIETARIO_NOMBRE IS NOT NULL

	PRINT '**MIGRACION** PROPIETARIOS AGREGADOS'

	INSERT INTO AMCGDD.INQUILINOS

	SELECT DISTINCT usuario_id FROM 
	gd_esquema.Maestra m JOIN
	AMCGDD.USUARIOS u
	ON m.INQUILINO_NOMBRE = u.usuario_nombre
	AND m.INQUILINO_APELLIDO = u.usuario_apellido
	AND m.INQUILINO_DNI = u.usuario_dni
	AND m.INQUILINO_NOMBRE IS NOT NULL

	PRINT '**MIGRACION** INQUILINOS AGREGADOS'

	INSERT INTO AMCGDD.COMPRADORES

	SELECT DISTINCT usuario_id FROM 
	gd_esquema.Maestra m JOIN
	AMCGDD.USUARIOS u
	ON m.COMPRADOR_NOMBRE = u.usuario_nombre
	AND m.COMPRADOR_APELLIDO = u.usuario_apellido
	AND m.COMPRADOR_DNI = u.usuario_dni
	AND m.COMPRADOR_NOMBRE IS NOT NULL

	PRINT '**MIGRACION** COMPRADORES AGREGADOS'
END
GO

CREATE PROCEDURE AMCGDD.MIGRACION_ANUNCIOS
AS
BEGIN

	/* MIGRACION ESTADOS ANUNCIO */

	INSERT INTO AMCGDD.ESTADOS_ANUNCIO

	SELECT DISTINCT RTRIM(LTRIM(UPPER(m.ANUNCIO_ESTADO)))
	FROM gd_esquema.Maestra m
	WHERE m.ANUNCIO_ESTADO IS NOT NULL

	PRINT '**MIGRACION** ESTADOS DE ANUNCIO AGREGADOS'
	/* MIGRACION PERIODOS*/

	INSERT INTO AMCGDD.PERIODO_TIPOS

	SELECT DISTINCT AMCGDD.FORMATO_TIPO_PERIODO(g.ANUNCIO_TIPO_PERIODO)
	FROM gd_esquema.Maestra g
	WHERE g.ANUNCIO_TIPO_PERIODO IS NOT NULL

	PRINT '**MIGRACION** PERIODOS AGREGADOS'
	/* MIGRACION TIPOS DE ANUNCIO */

	INSERT INTO AMCGDD.ANUNCIO_TIPOS

	SELECT DISTINCT AMCGDD.FORMATO_ANUNCIO_TIPO(g.ANUNCIO_TIPO_OPERACION)
	FROM gd_esquema.Maestra g
	WHERE ANUNCIO_TIPO_OPERACION IS NOT NULL
	
	PRINT '**MIGRACION** TIPOS DE ANUNCIO AGREGADOS'
	/* MIGRACION ANUNCIOS */

	INSERT INTO AMCGDD.ANUNCIOS

	SELECT 
		ANUNCIO_CODIGO, 
		ANUNCIO_FECHA_PUBLICACION, 
		agente_id, 
		AMCGDD.FORMATO_ANUNCIO_TIPO(ANUNCIO_TIPO_OPERACION), 
		INMUEBLE_CODIGO, 
		ANUNCIO_PRECIO_PUBLICADO, 
		AMCGDD.OBTENER_ID_MONEDA(ANUNCIO_MONEDA), 
		AMCGDD.FORMATO_TIPO_PERIODO(ANUNCIO_TIPO_PERIODO), 
		ANUNCIO_FECHA_FINALIZACION,
		ANUNCIO_COSTO_ANUNCIO,
		RTRIM(LTRIM(UPPER(ANUNCIO_ESTADO))), 
		p.propietario_id
	FROM AMCGDD.AGENTES a
	JOIN AMCGDD.USUARIOS u
		ON a.agente_usuario = u.usuario_id
	JOIN gd_esquema.Maestra g
		ON g.AGENTE_NOMBRE = usuario_nombre
			AND AGENTE_APELLIDO = usuario_apellido
			AND AGENTE_DNI = usuario_dni
	JOIN AMCGDD.USUARIOS u2
		ON PROPIETARIO_NOMBRE = u2.usuario_nombre
			AND PROPIETARIO_APELLIDO = u2.usuario_apellido
			AND PROPIETARIO_DNI = u2.usuario_dni
	JOIN AMCGDD.PROPIETARIOS p
		ON p.propietario_usuario = u2.usuario_id

	PRINT '**MIGRACION** ANUNCIOS AGREGADOS'
END

go

/*============================== FIN MIGRACIONES ==============================*/

USE GD2C2023

EXEC AMCGDD.MIGRACION_USUARIOS
EXEC AMCGDD.MIGRACION_SUBTIPOS_USUARIO
EXEC AMCGDD.MIGRACION_ANUNCIOS


