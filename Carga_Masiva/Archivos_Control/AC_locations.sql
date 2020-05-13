LOAD DATA 
INFILE '/var/lib/mysql-files/ArchivosCSV/locations.csv'
INTO TABLE Tmp_Location
    FIELDS TERMINATED BY '\t'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
;