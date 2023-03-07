-- kommentaar
-- teeb andmbeaasi e db
create database TARpe22

-- tabeli loomine
create table Gender(
Id int not null primary key,
Gender nvarchar(10) not null
)
---- andmete sisestamine
insert into Gender (Id, Gender)
values (2, 'Male')
insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)
values (3, 'Unknown')

--- sama Id v��rtusega rida ei saa sisestada
select * from Gender

--- teeme uue tabeli
create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

--- vaatame Person tabeli sisu
select * from Person

--- andmete sisestamine
insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 'superman@mail.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (2, 'Wonderwoman', 'ww@mail.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (3, 'Batman', 'b@b.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (4, 'Aquaman', 'a@a.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (5, 'Catwoman', 'c@c.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (6, 'Antman', 'ant"ant.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (7, 'Ironman', 'i@i.com', 2)

select * from Person

-- v��rv�tme �henduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderID_FK
foreign key (GenderId) references Gender(Id)

--- kui sisestad uue rea andmeid ja ei ole sisestatud GenderId all v��rtust, siis
--- see automaatselt sisestab tabelisse v��rtuse 3 ja selleks on Unknown
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

insert into Person (Id, Name, Email)
values (9, 'Ironman', 'i@i.com')

select * from Person

-- piirangu maha v�tmine
alter table Person
drop constraint DF_Persons_GenderId

--- lisame uue veeru
alter table Person
add Age nvarchar(10)

--- lisame vanuse piirangu sisestamisel
--- ei saa lisada suuremat v��rtust kui 801
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 801)

-- kui paned vale id, siis ei muuda midagi
delete from Person where Id = 9

select * from Person

-- kuidas uuendada andmeid tabelis
update Person
set Age = 50 
where Id = 1

-- lisame juurde uue veeru 
alter table Person
add City nvarchar(50)

-- k�ik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
-- k�ik, kes ei Gothami linnas 
select * from Person where City != 'Gotham'
-- teine variant
select * from Person where City not 'Gotham'
-- kolmas variant
select * from Person where city <> 'Gotham'

-- n�itab teatud vanusega inimesi
select * from Person where Age = 800 or Age = 35 or Age = 27
select * from Person where Age in (800, 35, 27)

-- n�itab teatud vanusevahemikus olevaid inimesi
select * from Person where Age between 20 and 35

-- wildcard e n�itab k�ik g-t�hega linnad
select * from Person where City like 'g%'
-- n�itan emailid, milles @
select * from Person where Email like '%@%'

--- n�itab k�iki, kellel ei ole @-m�rki emailis
select * from Person where Email not like '%@%'

--- n�itab, kelles on emailis ees ja peale @-m�rki
-- ainult �ks t�ht 
select * from Person where Email like '_@_.com'

-- K�ik, kellel ei ole nimes esimene t�ht W, A , C
select * from Person where Name like '[^WAC]%'

--- kes elavad Gothamis ja New Yorkis
select * from Person where (City = 'Gotham' or City = 'New York')

-- k�ik kes elavad gothamis ja new yorkis ning 
-- alla 30 eluaastat
select * from Person where
(City = 'Gotham' or City = 'New York')
and Age >= 30

--- kuvab t�hestikulises j�rjekorras inimesi 
--- ja v�tab aluseks nime

select * from Person order by Name
-- kuvab vastupidises j�rjekorras 
select * from Person order by Name desc

--v�tab kolm esimest rida
select top 3 * from Person 

--- j�tkub