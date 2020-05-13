/*
 * Manejo e implementación de archivos
 * Practica 1
 * 02/04/2020
 * inti
*/

/***********INSERCION EN TABLAS ****************/

-- LOCATION
INSERT INTO LOCATION (location_type_code,location_type_name)
SELECT *
FROM Tmp_Location;


-- GEONAMES

CREATE VIEW VISTA_GEONAMES AS
SELECT g.Place_name,g.Latitude,g.Longitude,l.location_id,g.Gazetteer_adm_code,g.Gazetteer_adm_name,g.Location_class,g.Geographic_exactness,g.Geoname_id FROM Tmp_Geonames g, LOCATION l
WHERE l.location_type_code = g.Location_type_code;

INSERT INTO GEONAME (place_name,latitude,longitude,location_id,gazeteer_adm_code,gazeteer_adm_name,location_clases,geografic_exactness,geoname_code)
SELECT * FROM VISTA_GEONAMES;


-- COUNTRY_CODE
INSERT INTO COUNTRY_CODE (name_,iso2,name_aiddata_code,name_aiddata_name,name_cow_alpha,name_cow_numeric,name_fao_cod,name_fips,name_geoname_id,name_imf_code,name_iso2,name_iso3,name_iso_number,name_oecd_code,name_oecd_name,name_un_code,name_wb_code)
SELECT c.name_,c.iso2,c.name_aiddata_code,c.name_aiddata_name,c.name_cow_alpha,@c.name_cow_numeric,c.name_fao_cod,c.name_fips,c.name_geoname_id,c.name_imf_code,c.name_iso2,c.name_iso3,c.name_iso_number,c.name_oecd_code,c.name_oecd_name,c.name_un_code,c.name_wb_code 
FROM Tmp_Country_Cod c 	
WHERE c.name_<> 'Unspecified';


-- TYPE_STATUS
CREATE VIEW VISTA_STATUS AS
SELECT DISTINCT p.Status_ FROM Tmp_Projects p;

INSERT INTO TYPE_STATUS(description)
SELECT * FROM VISTA_STATUS;


-- PROJECT
CREATE VIEW VISTA_PROJECT AS
SELECT DISTINCT	p.Is_geocoded,
		p.Project_title,
        p.Start_actual_isodate,
        p.End_actua_isodate,
        p.Donors,
        p.Donors_iso3,
        c.country_id,
        p.Ad_sector_codes,
        p.Ad_sector_names,
        t.id_status,
        p.Transactions_start_year,
        p.Transactions_end_year,
        p.Total_commitment,
        p.Total_disbursement,
        p.Project_id
FROM Tmp_Projects p, COUNTRY_CODE c, TYPE_STATUS t
WHERE t.description = p.Status_
AND p.Recipients_iso3= c.name_iso3
;



INSERT INTO PROJECT(is_geocoded,project_title,start_actual_isodate,end_actual_isodate,donors,donors_iso3,country_id,ad_sector_codes,ad_sector_names,status_id,transaction_start_year,transaction_end_year,total_commitments,total_disburments,project_code)
SELECT  DISTINCT Is_geocoded,
        Project_title,
        str_to_date(Start_actual_isodate,'%d/%m/%Y'),
        str_to_date(End_actua_isodate,'%d/%m/%Y'),
        Donors,
        Donors_iso3,
        country_id,
        Ad_sector_codes,
        Ad_sector_names,
        id_status,
        Transactions_start_year,
        Transactions_end_year,
        Total_commitment,
        IF(Total_disbursement='',NULL,CAST(Total_disbursement as decimal(16,6))) as Total_disbursement,
        Project_id
FROM VISTA_PROJECT;

CREATE TEMPORARY TABLE t1
SELECT * FROM PROJECT GROUP BY project_code;
DELETE FROM PROJECT
WHERE project_id NOT IN (SELECT project_id FROM t1);

-- CURRENCY
CREATE VIEW VISTA_CURRENCY AS 
SELECT DISTINCT transaction_currency 
FROM Tmp_Transactions;

INSERT INTO CURRENCY (currency_description)
SELECT * FROM VISTA_CURRENCY;


-- TRANSACTION
CREATE VIEW VISTA_TRANSACTION AS
SELECT 	p.project_id,
		t.Transaction_id,
		t.Transaction_isodate,
		t.Transaction_year,
        t.Transaction_value_code,
        c.currency_id,
        t.transaction_value
FROM 	Tmp_Transactions t, PROJECT p, CURRENCY c
WHERE  	c.currency_description = t.Transaction_currency
AND		p.project_code = t.Project_id
;	

INSERT INTO TRANSACCION (transaction_code,transaction_isodate,transaction_year,transaction_value_code,transaction_currency_id,transaction_value,project_id)
SELECT 	Transaction_id,
		str_to_date(Transaction_isodate,'%d/%m/%Y'),
        Transaction_year,
        Transaction_value_code,
        currency_id,
        transaction_value,
        project_id
FROM VISTA_TRANSACTION;


-- LEVEL_1A

CREATE INDEX index_project ON PROJECT(project_code);
CREATE INDEX index_geoname ON GEONAME(geoname_code);

CREATE VIEW VISTA_LEVEL_1A AS
SELECT  p.project_id,
		l.Project_location,
        g.geoname_id,
        l.Transactions_start_year,
        l.Transactions_end_year,
        l.Even_split_commitments,
        l.Even_split_disbursements
FROM Tmp_Level_1a l
LEFT JOIN PROJECT p ON p.project_code= l.Project_id
LEFT JOIN GEONAME g ON g.geoname_code = l.Geoname_id
group by g.geoname_code, p.project_code,l.Project_id
;

SET SESSION sql_mode = '';

INSERT INTO LEVEL_1A (project_id,project_geoname_id,geoname_id,transaction_start_year,transaction_end_year,even_split_commitments,even_split_disbursement)
SELECT 	project_id,
		Project_location,
		geoname_id,
        Transactions_start_year,
        Transactions_end_year,
        Even_split_commitments,
		Even_split_disbursements
FROM VISTA_LEVEL_1A;
