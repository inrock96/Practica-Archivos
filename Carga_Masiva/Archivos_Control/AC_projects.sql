LOAD DATA 
	INFILE '/var/lib/mysql-files/ArchivosCSV/projects.csv'
    INTO TABLE Tmp_Projects
	FIELDS TERMINATED BY ',' ENCLOSED BY '"'
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
	(project_id, is_geocoded, project_title, start_actual_isodate,End_actua_isodate,donors,donors_iso3,recipients,recipients_iso3,ad_sector_codes,ad_sector_names,status_,transactions_start_year,transactions_end_year,total_commitment,@total_disbursement)
	SET 
		Total_disbursement=nullif(@total_disbursement,'')
	;