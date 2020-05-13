LOAD DATA 
	INFILE '/var/lib/mysql-files/ArchivosCSV/level_1a.csv'
    INTO TABLE Tmp_Level_1a
    FIELDS TERMINATED BY ',' 
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    ;