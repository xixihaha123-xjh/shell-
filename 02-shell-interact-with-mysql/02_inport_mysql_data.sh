#!/bin/bash

user="Nihaowa"
passWord="changme"
mysql_conn="mysql -u$user -p$passWord"

cat data.txt | while read -r SID Sname Sage Ssex
do
	if [ "$SID" -gt 12 ]; then
    	$mysql_conn -e "insert school.Student values('$SID', '$Sname', '$Sage', '$Ssex')"
    fi
done