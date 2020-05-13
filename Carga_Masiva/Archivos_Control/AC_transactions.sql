LOAD DATA 
	INFILE '/var/lib/mysql-files/ArchivosCSV/transactions.csv'
    INTO TABLE Tmp_Transactions
    FIELDS TERMINATED BY ',' 
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    ;