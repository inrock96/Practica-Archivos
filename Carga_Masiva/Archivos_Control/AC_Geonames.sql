LOAD DATA 
	INFILE '/var/lib/mysql-files/ArchivosCSV/geonames.csv'
    INTO TABLE Tmp_Geonames
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    ;