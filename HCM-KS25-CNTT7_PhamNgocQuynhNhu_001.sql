create database hackathon;
use hackathon;

drop table Payment ;
drop table LiveSession ;
drop table Studio;
drop table Creator;

create table Creator (
	creator_id varchar(5) primary key not null,
    creator_name varchar(100) not null,
    creator_email varchar(100) not null unique,
    creator_phone varchar(10) not null unique,
    creator_platform varchar(50) not null
);

create table Studio (
	studio_id varchar(5) primary key not null,
    studio_name varchar(100) not null,
    studio_location varchar(100) not null,
    hourly_price decimal(10,2) not null,
    studio_status varchar(20) not null
);

create table LiveSession (
	session_id int primary key auto_increment not null,
    creator_id varchar(5) not null,
    studio_id varchar(5) not null,
    session_date date not null,
    duration_hours int not null,
    foreign key (creator_id) references Creator(creator_id),
    foreign key (studio_id) references Studio(studio_id)
);

create table Payment (
	payment_id int primary key auto_increment not null,
    session_id int not null,
    payment_method varchar(50) not null,
    payment_amount decimal(10,2) not null,
    payment_date date not null,
    foreign key (session_id) references LiveSession(session_id)
);

insert into Creator 
values
('CR01','Nguyen Van A', 'a@live.com', 0901111111,'Tiktok'),
('CR02','Tran Thi B', 'b@live.com', 0902222222,'Youtube'),
('CR03','Le Minh C', 'c@mail.com',0903333333,'Facebook'),
('CR04','Pham Thi D', 'd@live.com',0904444444,'Tiktok'),
('CR05','Vu Hoang E', 'e@live.com', 0905555555, 'Shopee live');

insert into Studio
values
('ST01','Studio A','Ha Noi',20.00,'Available'),
('ST02','Studio B','HCM',25.00,'Available'),
('ST03','Studio C','Danang',30.00,'Booked'),
('ST04','Studio D','Ha Noi',22.00,'Available'),
('ST05','Studio E','Can Tho',18.00,'Maintenance');

insert into LiveSession (creator_id,studio_id,session_date,duration_hours)
values
('CR01','ST01','2025-05-01',3),
('CR02','ST02','2025-05-02',4),
('CR03','ST03','2025-05-03',2),
('CR04','ST04','2025-05-04',5),
('CR05','ST05','2025-05-05',1);

insert into Payment
values
(1,1,'Cash',60.00,'2025-05-01'),
(2,2,'Credit Card',100.00,'2025-05-02'),
(3,3,'Bank Transfer',60.00,'2025-05-03'),
(4,4,'Credit Card',60.00,'2025-05-04'),
(5,5,'Cash',25.00,'2025-05-05');

update Creator
set creator_platform = 'YouTube'
where creator_id = 'CR03';

update Studio
set studio_status = 'Available' 
where studio_id = 'ST05';
update Studio
set hourly_price = hourly_price * 0.9
where studio_id = 'ST05';

set sql_safe_updates = 0;

delete from Payment
where payment_method = 'Cash';
delete from Payment
where payment_date < '2025-05-03';

select * from Studio
where studio_status = 'Available' and hourly_price > 20;

select creator_name, creator_phone from Creator
where creator_platform = 'Tiktok';

select studio_id, studio_name, hourly_price from Studio
order by hourly_price desc;

select * from Payment
where payment_method = 'Credit Card'
limit 3;

select creator_id, creator_name from Creator
limit 2 offset 2;

-- 3.1
select l.session_id, c.creator_name, s.studio_name, l.duration_hours, p.payment_amount
from  LiveSession l 
join Creator c on l.creator_id = c.creator_id
join Studio s on l.studio_id = s.studio_id
join Payment p on l.session_id = p.session_id;

-- 3.3
select payment_method, sum(payment_amount) total_payment
from Payment p
group by payment_method;

-- 3.4
select c.creator_name, count(p.session_id) total_session
from Creator c
join LiveSession l
on l.creator_id = c.creator_id
join Payment p
on p.session_id = l.session_id
group by l.session_id
having total_session >= 2;

-- 3.5
select * from Studio 
where hourly_price > (select avg(hourly_price) from  Studio);

-- 3.6
select c.creator_name, c.creator_email 
from Creator c
join LiveSession l on l.creator_id = c.creator_id
join Studio s on s.studio_id = l.studio_id
where s.studio_id = 'ST02';

-- 3.7
select l.session_id, c.creator_name, s.studio_name, p.payment_method, p.payment_amount
from LiveSession l
join Creator c on l.creator_id = c.creator_id
join Studio s on l.studio_id = s.studio_id
join Payment p on l.session_id = p.session_id;






