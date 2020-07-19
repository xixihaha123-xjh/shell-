说明：

(1) supervisor_proj 脚本读出配置文件组/进程列表信息，实现获取应用状态信息

```
1. 无参数          列出配置文件中所有进程的运行信息
2. -g GroupName   列出GroupName组内的所有进程
3. process_name   列出指定进程的运行信息
```

![app_status使用](https://github.com/xixihaha123-xjh/shell-script/blob/master/01-supervisor_proj/pic/1.app_status%E4%BD%BF%E7%94%A8.png?raw=true)

(2) shell 与 mysql数据库交互

1. `01_operator_mysql.sh `实现shell script执行sql 语句。`01_operator_mysql.sh ` 脚本有两个参数：一个是数据库名，另一个是sql语句
2. `02_inport_mysql_data.sh `实现将txt文件数据导入
3. `03_database_backup.sh` 实现数据库备份，并将备份的数据，通过ftp的方式传送到ftp服务器指定目录。

(3) general_script 通用脚本，会不断更新

(4) vscode中shellcheck，实现shell脚本静态检查