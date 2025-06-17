/* 
* CS3425 Database Systems Project Phase 1 createTable.sql
* Authors: Scout Lex and Emily Taylor
*/

drop table if exists employee;
create table employee(
	username char(20),
    id int primary key not null auto_increment, 
    email char(50),
    password BLOB
);

drop table if exists product;
create table product(
	name char(30),
    id int primary key not null auto_increment,
    description char(200),
    price numeric(8,2),
    stock_thresh int,
    stock_actual int,
    image varbinary (15000),
    category_name char(30) references category(name)
);


grant all privileges on eetaylor.* to 'srlex'@'%';


drop table if exists category;
create table category(
	name char(30) primary key,
    decription char(200)
);

drop table if exists customer;
create table customer(
	username char(20),
    id int primary key not null auto_increment,
    email char(50),
    password BLOB,
    first char(30),
    last char(30),
    address char(200)
);

drop table if exists final_order;
create table final_order(
	order_number int primary key not null auto_increment,
    time datetime,
    total numeric(8,2),
    id int references customer(id),
    order_status char(20)
);

drop table if exists product_history;
create table product_history(
	name char(30) references product(name),
    description char(200) references product(description),
    id int references product(id),
    time datetime,
    price numeric(8,2),
    stock_quantity int,
    emp_id int references employee(id)
);

drop table if exists stocks;
create table stocks(
	name char(30) primary key references product(name),
    id int references product(id),
	employee_id int references employee(id),
    employee_username char(20) references employee(username)
);

drop table if exists in_cart;
create table in_cart(
	name char(30) references product(name),
    id int references customer(id),
    quantity int,
    primary key (name, id)
);

drop table if exists buys;
create table buys(
	product_id int not null,
    order_number int references final_order(order_number),
    price numeric(8,2),
    id int references customer(id),
    quantity int not null
);