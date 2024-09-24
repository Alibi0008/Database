create database lab2;

create table countries(
    country_id serial primary key ,
    country_name varchar(50),
    region_id int,
    population int
);

drop table countries cascade ;

insert into countries(country_name, region_id, population) VALUES ('Kazakhstan', 1,19000000);

insert into countries(country_id,country_name) values (2,'Uzbekistan');

insert into countries(country_name, region_id, population) VALUES ('Kyrgystan',null,65000000);

insert into countries(country_name, region_id, population)
VALUES ('Tajikstan',3,50000),
       ('Japan',4,10000000),
       ('Korea',5,3400000);

alter table countries alter column country_name set default 'Kazakhstan';

insert into countries(region_id,population) values (6,450000);

insert into countries default values ;

create table countries_new(like countries including all );

drop table countries_new;

insert into countries_new select * from countries;

update countries set region_id = 1 where region_id is null;

select country_name, population *1.1 as "New Population" from countries;

delete from countries where population < 100000;

delete from countries_new where country_id in(select country_id from countries) returning *;

delete from countries returning *;

select * from countries;

select * from countries_new;