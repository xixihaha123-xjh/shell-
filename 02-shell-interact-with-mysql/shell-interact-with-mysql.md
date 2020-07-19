## 1 shell与mysql交互

(1) mysql命令参数详解

```shell
-u   用户名
-p   用户密码
-h   服务器ip地址
-D   连结的数据库
-N   不输出列信息
-B   使用tab键代替默认交互分隔符
-e   执行sql语句
-E   垂直输出
-H   以html格式输出
-X   以xml格式输出
```

(2) 写一个shell中执行sql语句的脚本，该脚本可以接收二个参数，参数1为数据库名，参数二为需要执行的sql语句。脚本文件：operator_mysql.sh 

(3) 查询mysql任意表的数据，并将查询到的结果保存到html文件中

(4) 查询mysql任意表的数据，并将查询的结果保存到xml文件中

(5) 将文本数据，导入数据库。脚本文件 ` inport_mysql_data.sh`

## 2 备份Mysql

1. mysqldump 常用参数详解：

```powershell
-u   用户名
-p   密码
-h   服务器IP地址
-d   等价于 --no-data 只导出表结构
-t   等价于 --no-create-info 只导出数据,不导出建表语句
-A   等价于 --all-databases
-B   等价于 --database 导出一个或多个数据库
```

2. ftp 

* ftp 服务器搭建
* ftp 常用命令

```
open   与ftp服务器建立连接,例:open 192.168.1.1
user   有权限登录ftp服务器的用户名和密码 ,例: user ftpUser ftpPasswd
put    将本地一个文件传送至远端主机中 put local-file [remote-file]
bye    终止主机ftp 进程,并退出ftp 管理方式
```

3. EOF

* **参考链接   [Linux中EOF自定义终止符介绍]( https://www.linuxprobe.com/linux-eof-diy.html )**

*  EOF 是END Of File的缩写，表示自定义终止符。既然自定义，那么EOF就不是固定的，可以随意设置别名，在linux按ctrl-d就代表EOF。
* 语法

```powershell
<< EOF        // 开始
....
EOF           // 结束
```

```shell
[root@Nihaowa shell]# cat <<  EOF > test.txt
heredoc> who are you?
heredoc> where are you from?
heredoc> where are you going?
heredoc> EOF
[root@Nihaowa shell]# cat test.txt
who are you?
where are you from?
where are you going?
```

4. 需求：将school中的score表备份，并且将备份数据通过 ftp 传输到 192.168.1.1 的 /home/upload  目录下。

脚本文件：`database_backup.sh `

## 3 数据库备份

数据库备份参考 [[学会4种备份MySQL数据库（基本备份方面没问题了）](https://www.cnblogs.com/SQL888/p/5751631.html)

### 3.1 备份方式

在`MySQl`中我们备份数据一般有几种方式

- 热备份：热备份指的是当数据库进行备份时, **数据库的读写操作均不是受影响** 
- 温备份：温备份指的是当数据库进行备份时, **数据库的读操作可以执行, 但是不能执行写操作** 
- 冷备份：冷备份指的是当数据库进行备份时, **数据库不能进行读写操作, 即数据库要下线**

### 3.2 备份策略

1. mysql 备份的4种策略

| 备份方法   | 备份速度 | 恢复速度 | 便捷性                           | 功能 | 一般用于           |
| ---------- | -------- | -------- | -------------------------------- | ---- | ------------------ |
| cp         | 快       | 快       | 一般、灵活性低                   | 很弱 | 少量数据备份       |
| mysqldump  | 慢       | 慢       | 一般、可无视存储引擎的差异       | 一般 | 中小型数据量的备份 |
| lvm2快照   | 快       | 快       | 一般、支持几乎热备、速度快       | 一般 | 中小型数据量的备份 |
| xtrabackup | 较快     | 较快     | 实现innodb热备、对存储引擎有要求 | 强大 | 较大规模的备份     |

2. mysqldump 的使用可参看 [ mysql 官方网站-使用 mysqldump 进行备份]( https://dev.mysql.com/doc/refman/8.0/en/using-mysqldump.html )

### 3.3 数据的备份类型

1. 数据的备份类型根据其自身的特性主要分为以下几组

* 完全备份：完全备份指的是**备份整个数据集( 即整个数据库 )**
* 部分备份：部分备份指的是**备份部分数据集(例如: 只备份一个表)**，而部分备份又分为以下两种

* 增量备份：增量备份指的是**备份自上一次备份以来(增量或完全)以来变化的数据**;  特点: 节约空间、还原麻烦 

* 差异备份：差异备份指的是**备份自上一次完全备份以来变化的数据** 特点: 浪费空间、还原比增量备份简单

## 4 mysql权限管理

(1) mysql 8.0.11 权限管理问题

1. 问题：mysql 8.0.11 当使用` grant 权限列表 on 数据库 to '用户名'@'访问主机' identified by '密码';  `  时会出现"......error 1064 near 'identified by '密码'' at line 1 这个错误

```shell
grant 权限列表 on 数据库 to '用户名'@'访问主机' identified by '密码';
```

2. 原因：因为新版的的mysql版本已经将创建账户和赋予权限的方式分开了

3. 解决办法

```mysql
创建账户: create user '用户名'@'访问主机' identified by '密码';
赋予权限: grant 权限列表 on 数据库.*  to '用户名'@'访问主机';(修改权限时在后面加with grant option)

例;
mysql> CREATE USER 'dbuser'@'localhost' IDENTIFIED BY 'changme';
Query OK, 0 rows affected (0.01 sec)
mysql> GRANT ALL PRIVILEGES ON school.* TO 'dbuser'@'localhost' WITH GRANT OPTION;
Query OK, 0 rows affected (0.01 sec)

% 允许来自任何ip的连接
localhost允许本机的连接
```

(2) 未刷新权限导致问题

1. 问题：mysql创建用户报错 ` ERROR 1396 (HY000): Operation CREATE USER failed for 'root'@'localhost' `

```
(1) 创建用户: create user 'test'@'%' identified by 'test';
显示ERROR 1396 (HY000): Operation CREATE USER failed for 'test'@'%'

(2) 查看是不是存在这个用户
select user from user; 发现没有这个用户。
记得上次有删除过这个用户。可能没有刷新权限 
(3) 刷新权限后 flush privileges; 创建用户还是不行报错ERROR 1396 (HY000): Operation CREATE USER failed for 'test'@'%'

(4) 没办法删除一次：drop user 'test'@'%';
flush privileges;
之后 create user 'test'@'%' identified by 'test';
(5) 成功
```

2. 解决办法：如上
3. 问题原因

```
Assume the user is there, so drop the user
After deleting the user, there is need to flush the mysql privileges
Now create the user.
```

## 5 mysql 操作

1. 依照一个表，创建另一个表

```mysql
create table student like another_student;
```

2. 查看表结构

```
desc another_student;
```

3. 命令行下执行sql文件

```shell
mysql -u'user' -p'passwd' -Ddatabase < test.sql
# mysql -u账号 -p密码 -D数据库名 < sql文件绝对路径
```



