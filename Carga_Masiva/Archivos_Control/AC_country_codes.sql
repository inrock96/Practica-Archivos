LOAD DATA 
INFILE '/var/lib/mysql-files/ArchivosCSV/country_codes.tsv'
INTO TABLE Tmp_Country_Cod
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
    (name_,iso2,name_name,@name_aiddata_code,name_aiddata_name,@name_cow_alpha,@name_cow_numeric,@name_fao_cod,name_fips,@name_geoname_id,name_imf_code,name_iso2,name_iso3,@name_iso_number,@name_oecd_code,name_oecd_name,@name_un_code,name_wb_code )
	SET 
		name_aiddata_code=nullif(@name_aiddata_code,''),
		name_cow_alpha=nullif(@name_cow_alpha,''),
        name_cow_numeric=nullif(@name_cow_numeric,''),
        name_fao_cod=nullif(@name_fao_cod,''),
        name_oecd_code=nullif(@name_oecd_code,''),
        name_geoname_id=nullif(@name_geoname_id,''),
        name_un_code=nullif(@name_un_code,''),
        name_iso_number=nullif(@name_iso_number,'')
	;
    