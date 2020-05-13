/*
 * Manejo e implementación de archivos
 * Practica 1
 * 01/04/2020
 * inti
*/

/***********CREACION DE TABLAS TEMPORALES****************/
USE practica1;
CREATE TABLE Tmp_Transactions(
	Transaction_id VARCHAR(50),
    Project_id VARCHAR(50),
    Transaction_isodate VARCHAR(50),
    Transaction_year VARCHAR(50),
    Transaction_value_code VARCHAR(50),
    Transaction_currency VARCHAR(50),
    Transaction_value VARCHAR(50)
);

CREATE TABLE Tmp_Projects(
	Project_id VARCHAR(50),
    Is_geocoded VARCHAR(50),
    Project_title VARCHAR(150),
    Start_actual_isodate VARCHAR(50),
    End_actua_isodate VARCHAR(50),
    Donors VARCHAR(50),
    Donors_iso3 VARCHAR(50),
    Recipients VARCHAR(50),
    Recipients_iso3 VARCHAR(50),
    Transaction_year VARCHAR(50),
    Ad_sector_codes VARCHAR(50),
    Ad_sector_names VARCHAR(255),
    Status_ VARCHAR(50),
    Transactions_start_year VARCHAR(50),
    Transactions_end_year VARCHAR(50),
    Total_commitment VARCHAR(50),
    Total_disbursement VARCHAR(50) DEFAULT NULL
);

CREATE TABLE Tmp_Level_1a(
	Project_id VARCHAR(50),
    Project_location VARCHAR(50),
    Geoname_id VARCHAR(50),
    Transactions_start_year VARCHAR(50),
    Transactions_end_year VARCHAR(50),
    Even_split_commitments VARCHAR(50),
    Even_split_disbursements VARCHAR(50)
);

CREATE TABLE Tmp_Location(
    Location_type_code VARCHAR(150),
	Location_type_name VARCHAR(150)
);

CREATE TABLE Tmp_Geonames(
	Geoname_id VARCHAR(150),
    Place_name VARCHAR(150),
    Latitude VARCHAR(150),
    Longitude VARCHAR(150),
    Location_type_code VARCHAR(150),
    Location_type_name VARCHAR(150),
    Gazetteer_adm_code VARCHAR(150),
    Gazetteer_adm_name VARCHAR(150),
    Location_class VARCHAR(150),
    Geographic_exactness VARCHAR(150)
);

CREATE TABLE Tmp_Country_Cod(
    name_ VARCHAR(50),
    iso2  VARCHAR(50),
    name_name VARCHAR(50),
    name_aiddata_code VARCHAR(50),
    name_aiddata_name VARCHAR(50),
    name_cow_alpha VARCHAR(50),
    name_cow_numeric VARCHAR(50),
    name_fao_cod VARCHAR(50),
    name_fips VARCHAR(50),
    name_geoname_id VARCHAR(50),
    name_imf_code VARCHAR(50),
    name_iso2 VARCHAR(50),
    name_iso3 VARCHAR(50),
    name_iso_number VARCHAR(50),
    name_oecd_code VARCHAR(50),
    name_oecd_name VARCHAR(50),
    name_un_code VARCHAR(50),
    name_wb_code VARCHAR(50)
);



