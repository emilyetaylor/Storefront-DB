/*
* CS3425 Database Systems Project Phase 1 insertdata.sql
* Authors: Scout Lex and Emily Taylor
*/

 # Insertion of employees
call create_employee('eetaylor', 'eetaylor@mtu.edu', 'myPass1');
call create_employee('srlex', 'srlex@mtu.edu', 'myPass2');

# Insertion of customers
insert into customer(username, email, password, first, last, address) values 
('epicShopper1', 'susiemiller@gmail.com', sha2('myPass3', 256), 'Susie', 'Miller', '1701 Townsend Dr.');
insert into customer(username, email, password, first, last, address) values 
('epicShopper2', 'johndoe@gmail.com', sha2('myPass4', 256), 'John', 'Doe', '1801 Townsend Dr.');
insert into customer(username, email, password, first, last, address) values 
('epicShopper3', 'janedoe@gmail.com', sha2('myPass5', 256), 'Jane', 'Doe', '1703 Townsend Dr.');

# Inserting Categories
call insert_category('Fruit', 'Natural, Yummy Products');
call insert_category('Vegetables', 'Natural, Yummy Greens');
call insert_category('Meat', 'Natural, Yummy Animal Products');
call insert_category('Dairy', 'Natural, Yummy Cow Products');

# Inserting Products

call insert_product('Mango', 'Sweet, Creamy Ice-Cream-Like Fruit', 1.50, 64, 124, 'C:\Users\emily\CS3425\Mango.jpeg', "Fruit");
call insert_product('Banana', 'Oblong, Yellow Fruit', 0.05, 102, 164, "C:\Users\emily\CS3425\Banana.jpg", 'Fruit');
call insert_product('Pomegranate', 'Sweet and Tart Seeds', 1.25, 32, 64, "C:\Users\emily\CS3425\pomegranate.jpg", 'Fruit');
call insert_product('Zucchini', 'Long, Green Vegetable', 0.67, 24, 12, "C:\Users\emily\CS3425\zucchini.jpg",'Vegetable');
call insert_product('Carrot', 'Crunchy, Orange Vegetable', 1.00, 56, 52, "C:\Users\emily\CS3425\carrot.jpg", 'Vegetable');
call insert_product('Lettuce', 'Round, Green, Crunchy Vegetable', 2.50, 72, 80, "C:\Users\emily\CS3425\lettuce.jpg", 'Vegetable');
call insert_product('Filet Mignon (6 oz.)', 'The most tender cut', 50, 10, 15, "C:\Users\emily\CS3425\filet mignon.jpg", 'Meat');
call insert_product('Rotisserie Chicken', 'Cooked and Seasoned Whole Chicken', 6, 15, 25, "C:\Users\emily\CS3425\rotisserie chicken.jpg", 'Meat');
call insert_product('Milk', 'Creamy, White Liquid from a Cow', 2, 13, 25, "C:\Users\emily\CS3425\milk.jpg", 'Dairy');
call insert_product('Cottage Cheese', 'Mild Curdled Milk Mixture', 4, 40, 60, "C:\Users\emily\CS3425\cottage cheese.jpg", 'Dairy');
select * from product;

update product set image = 'Mango.jpeg' where name = "Mango";
update product set image = 'Banana.jpg' where name = "Banana";
update product set image = 'pomegranate.jpg' where name= "Pomegranate";
update product set image = 'zucchini.jpg' where name= "Zucchini";
update product set image = 'carrot.jpg' where name= "Carrot";
update product set image = 'lettuce.jpg' where name= "Lettuce";
update product set image = 'filet_mignon.jpg' where name= "Filet Mignon (6 oz.)";
update product set image = 'rotisserie_chicken.jpg' where name= "Rotisserie Chicken";
update product set image = 'milk.jpg' where name= "Milk";
update product set image = 'cottage_cheese.jpg' where name= "Cottage Cheese";



select insert_order(1, 100, 1);
select insert_order_item(50, 1, 1, 9, 2.00);

select * from buys;
select * from customer;

update customer set password = sha2("hello", 256) where username = "epicShopper1";

select * from customer where password = sha2("hello", 256) and username = "epicShopper1";

select * from in_cart;




