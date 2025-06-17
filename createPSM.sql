/*
* CS3425 Database Systems Project Phase 1 createPSM.sql
* Authors: Scout Lex and Emily Taylor
*/

# Create_employee(): creates employee account which requires password to
# be reset upon first login

delimiter $$ 
drop procedure if exists create_employee $$
create procedure create_employee(username char(20), email char(50), password BLOB)
begin
	declare hashPass char(200);
    set hashPass = sha2(password, 256);
    insert into employee(username, email, password) values (username, email, hashPass);
end $$
delimiter $$

# Insert_category(): Create a new category

delimiter $$

drop procedure if exists insert_category $$
create procedure insert_category (name char(30), description char(200) )
begin
insert into category values (name, description);
end $$

delimiter $$


# Insert_product(): create a new product

delimiter $$

drop procedure if exists insert_product $$
create procedure insert_product (name char(30), description char(200), price numeric(8,2), stock_thresh int, stock_actual int, image varchar(15000), category_name char(30))
begin
		insert into product(name, description, price, stock_thresh, stock_actual, image, category_name) values (name, description, price, stock_thresh, stock_actual, image, category_name);
end $$

delimiter ;

# Update_product_price(): update the product with new price

delimiter $$

drop procedure if exists update_product_price $$
create procedure update_product_price (new_name char(30), new_id char(9), new_price numeric(8,2), empl_id int)

begin
update product set price = price + new_price where name = new_name and id = new_id;
update product_history set emp_id = empl_id where name = new_name and id = new_id and price = (select price from product where name = new_name and id = new_id);
end $$

delimiter $$


# Restock_product(): update the product's quantity with the new
# restocking amount

delimiter $$

drop procedure if exists restock_product $$
create procedure restock_product (new_name char(30), new_id char(9), new_stock_actual int, empl_id int)

begin
update product set stock_actual = stock_actual + new_stock_actual where name = new_name and id = new_id;
update product_history set emp_id = empl_id where name = new_name and id = new_id and stock_quantity = (select stock_actual from product where name = new_name and id = new_id);
end $$

delimiter $$

# Functions

# Insert_order(): Creates a new order and returns the new order id

delimiter $$ 
drop function if exists insert_order $$
create function insert_order(total numeric(8,2), id int)
	returns char(9)
begin
	declare time datetime;
    set time = (select current_timestamp());
    insert into final_order(time, total, id, order_status) values (time, total, id, "Placed");
    return last_insert_id();
end $$
delimiter ;

# Insert_order_item(): will insert a new row in the existing order, and update the remaining stock accordingly

delimiter $$ 
drop function if exists insert_order_item $$
create function insert_order_item(quantity int, id int, order_number int, product_id int, price numeric(8,2))
	returns int
begin
	declare new_stock int;
    set new_stock = (select stock_actual from product where product.id = product_id);
    set new_stock = new_stock - quantity;
    insert into buys values (product_id, order_number, price, id, quantity);
    update product set stock_actual = new_stock where product.id = product_id;
    return new_stock;
end $$
delimiter ;

# Triggers

# After insert, insert the action in the product history

delimiter $$
drop trigger if exists after_insert $$
create trigger after_insert
	after insert on product
	for each row
begin
	declare time datetime;
    set time = (select current_timestamp());
	insert into product_history values (NEW.name, NEW.description, NEW.id, time, NEW.price, null);
end $$
delimiter ;

# After update, insert the action in the product history

delimiter $$
drop trigger if exists after_update $$
create trigger after_update
	after update on product
	for each row
begin
	declare time datetime;
    set time = (select current_timestamp());
	insert into product_history values (NEW.name, NEW.description, OLD.id, time, NEW.price, NEW.stock_actual, null);
end $$
delimiter ;

# Before update, raise SQL error to reject the update if product id is changed

delimiter $$
drop trigger if exists before_update $$
create trigger before_update
	before update on product
	for each row
begin
	if NEW.id != OLD.id
		then signal sqlstate '45000'
			set message_text = ' The prod id is not allowed to be changed ';
	end if;
end $$
delimiter ;

# Before delete raise SQL error to reject the delete

delimiter $$
drop trigger if exists before_delete $$
create trigger before_delete
	before delete on product
	for each row
begin
	signal sqlstate '45000'
		set message_text = ' Products cannot be deleted ';
end $$
delimiter ;
