#!/bin/bash

# 该脚本可以接收二个参数，参数1为数据库名，参数二为需要执行的sql语句
# sh operator_mysql.sh school "select * from Course"
user="Nihaowa"
passWord="changme"
dbName="$1"
sql="$2"

mysql -u"$user" -p"$passWord" -D "$dbName" -B -e "$sql"
