
create table Student(SID varchar(10),Sname nvarchar(10),Sage datetime,Ssex nvarchar(10));

create table Course(CID varchar(10),Cname nvarchar(10),TID varchar(10));

create table Teacher(TID varchar(10),Tname nvarchar(10));

create table SC(SID varchar(10),CID varchar(10),score decimal(18,1));


insert into Student values('01' , '张三' ,  '1990-01-01' , '男');
insert into Student values('02' , '张四' ,  '1990-12-21' , '男');
insert into Student values('03' , '张五' ,  '1990-05-20' , '男');
insert into Student values('04' , '张六' ,  '1990-08-06' , '男');
insert into Student values('05' , '张七' ,  '1991-12-01' , '女');
insert into Student values('06' , '张八' ,  '1992-03-01' , '女');
insert into Student values('07' , '张九' ,  '1989-07-01' , '女');
insert into Student values('08' , '张十' ,  '1990-01-20' , '女');


insert into Course values('01' , 'chinese' , '02');
insert into Course values('02' , 'math' , '01');
insert into Course values('03' , 'english' , '03');



insert into Teacher values('01' , '张三');
insert into Teacher values('02' , '李四');
insert into Teacher values('03' , '王五');


insert into SC values('01' , '01' , 80);
insert into SC values('01' , '02' , 90);
insert into SC values('01' , '03' , 99);
insert into SC values('02' , '01' , 70);
insert into SC values('02' , '02' , 60);
insert into SC values('02' , '03' , 80);
insert into SC values('03' , '01' , 80);
insert into SC values('03' , '02' , 80);
insert into SC values('03' , '03' , 80);
insert into SC values('04' , '01' , 50);
insert into SC values('04' , '02' , 30);
insert into SC values('04' , '03' , 20);
insert into SC values('05' , '01' , 76);
insert into SC values('05' , '02' , 87);
insert into SC values('06' , '01' , 31);
insert into SC values('06' , '03' , 34);
insert into SC values('07' , '02' , 89);
insert into SC values('07' , '03' , 98);