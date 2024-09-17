create  database lab1;

create table users (
    id serial,
    firstname varchar(50),
    lastname varchar(50)
);

drop table users;

alter table users add column isadmin int;

alter table users alter column isadmin type boolean using isadmin::boolean;

alter table users alter column isadmin set default FALSE;

alter table users add primary key (id);

create table tasks (
    id serial,
    name varchar(50),
    user_id int
);

drop table tasks;

drop database lab1;
