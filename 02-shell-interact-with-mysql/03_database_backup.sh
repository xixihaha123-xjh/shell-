#!/bin/bash

dbUser="Nihaowa"
dbPasswd="changme"

dbName="school"
dbTable="Student"

ftpHost="192.168.1.1"
ftpUser="ftp_user"
ftpPasswd="ftp_passwd"

timeDate=$(date +%Y%m%d%H%M%S)

# 数据库备份文件目录
srcDir="/home/src/backup"
fileName="${dbName}_${dbTable}_${timeDate}.sql"
# 目标ftp目录
dstDir="/home/upload"

# EOF必须顶格写
function auto_ftp
{
	ftp -niv << EOF
		open $ftpHost
		user $ftpUser $ftpPasswd
		cd $dstDir
		put $1
		bye
EOF
# EOF必须顶格写
}

mysqldump -u"$dbUser" -p"$dbPasswd" "$dbName" "$dbTable" > ./"$fileName" && auto_ftp ./"$fileName"

# ftp -in << EOF
#		open 192.168.1.1
#		user ftp_user ftp_passwd
#		cd /home/upload
#		put school.sql
#		bye
#EOF