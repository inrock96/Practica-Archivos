/*
 * Manejo e implementación de archivos
 * Practica 1
 * 02/04/2020
 * inti
*/

/***********CREACION DE TABLAS****************/
SET SESSION SQL_SAFE_UPDATES=0;
SET SESSION sql_mode='';
CREATE TABLE TYPE_STATUS(
	id_status INTEGER auto_increment NOT NULL,
    description VARCHAR(50),
	CONSTRAINT PK_type_status PRIMARY KEY (id_status)
);
CREATE TABLE LOCATION(
	location_id INTEGER auto_increment NOT NULL,
    location_type_code VARCHAR(50),
    location_type_name VARCHAR(50),
    CONSTRAINT PK_location_id PRIMARY KEY(location_id)
);
CREATE TABLE GEONAME(
	geoname_id INTEGER auto_increment NOT NULL,
    place_name VARCHAR(255),
    latitude FLOAT,
    longitude FLOAT,
    location_id INTEGER NOT NULL,
    gazeteer_adm_code VARCHAR(255),
    gazeteer_adm_name VARCHAR(255),
    location_clases INTEGER,
    geografic_exactness INTEGER,
    geoname_code VARCHAR(50),
    CONSTRAINT PK_geoname_id PRIMARY KEY(geoname_id),
    CONSTRAINT FK_geoname_location FOREIGN KEY (location_id)
    REFERENCES LOCATION(location_id)
);


CREATE TABLE COUNTRY_CODE(
	country_id INTEGER auto_increment NOT NULL,
    name_ VARCHAR(50),
    iso2  VARCHAR(3),
    name_aiddata_code INTEGER,
    name_aiddata_name VARCHAR(50),
    name_cow_alpha VARCHAR(50),
    name_cow_numeric INTEGER,
    name_fao_cod INTEGER,
    name_fips VARCHAR(50),
    name_geoname_id INTEGER,
    name_imf_code VARCHAR(50),
    name_iso2 VARCHAR(3),
    name_iso3 VARCHAR(20),
    name_iso_number INTEGER,
    name_oecd_code INTEGER,
    name_oecd_name VARCHAR(50),
    name_un_code INTEGER,
    name_wb_code VARCHAR(50),
    CONSTRAINT PK_cod_country PRIMARY KEY(country_id)
);


CREATE TABLE CURRENCY(
	currency_id INTEGER auto_increment NOT NULL,
    currency_description VARCHAR(20),
    CONSTRAINT PK_currency PRIMARY KEY(currency_id)
);


CREATE TABLE PROJECT(
	project_id INTEGER auto_increment NOT NULL,
    is_geocoded INTEGER,
    project_title VARCHAR(150),
    start_actual_isodate DATE,
    end_actual_isodate DATE,
    donors VARCHAR(50),
    donors_iso3 VARCHAR(50),
    country_id INTEGER NOT NULL,
    ad_sector_codes VARCHAR(50),
    ad_sector_names VARCHAR(255),
    status_id INTEGER NOT NULL,
    transaction_start_year INTEGER,
    transaction_end_year INTEGER,
    total_commitments FLOAT,
    total_disburments DECIMAL(16,6),
    project_code VARCHAR(50),
    CONSTRAINT PK_project_id PRIMARY KEY(project_id),
    CONSTRAINT FK_project_country_id FOREIGN KEY(country_id)
    REFERENCES COUNTRY_CODE(country_id),
    CONSTRAINT FK_project_status_id FOREIGN KEY(status_id)
    REFERENCES TYPE_STATUS(id_status)
);



CREATE TABLE LEVEL_1A(
	project_id INTEGER NOT NULL,
    project_geoname_id VARCHAR(150),
    geoname_id INTEGER NOT NULL,
    transaction_start_year INTEGER,
    transaction_end_year INTEGER,
    even_split_commitments DECIMAL(16,2),
    even_split_disbursement DECIMAL(16,2),
    CONSTRAINT FK_level_project_id FOREIGN KEY(project_id)
    REFERENCES PROJECT(project_id),
    CONSTRAINT FK_level_geoname_id FOREIGN KEY(geoname_id)
    REFERENCES GEONAME(geoname_id),
    CONSTRAINT PK_level_1a PRIMARY KEY(project_id,geoname_id)
);


CREATE TABLE TRANSACCION(
	transaction_id INTEGER auto_increment NOT NULL,
    transaction_code VARCHAR(50),
    transaction_isodate DATE,
    transaction_year INTEGER,
    transaction_value_code VARCHAR(50),
    transaction_currency_id INTEGER NOT NULL,
    transaction_value DECIMAL(16,6),
    project_id INTEGER,
    CONSTRAINT PK_transaccion PRIMARY KEY(transaction_id),
    CONSTRAINT FK_transaccion_currency_id FOREIGN KEY (transaction_currency_id)
    REFERENCES CURRENCY(currency_id),
    CONSTRAINT FK_transaccion_project_id FOREIGN KEY (project_id)
    REFERENCES PROJECT(project_id)
);
