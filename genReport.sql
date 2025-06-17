/* 
* CS3425 Database Systems Project Phase 1 genReport.sql
* Authors: Scout Lex and Emily Taylor
*/

delimiter $$ 
drop procedure if exists historic_prices $$
create procedure historic_prices(id int)
begin
    select name, price, time from product_history where product_history.id = id;
end $$
delimiter ;

delimiter $$ 
drop procedure if exists price_time $$
create procedure price_time(start_time timestamp, end_time timestamp)
begin
    select name, min(highest) lowest_price, max(lowest) highest_price from
    (select name, min(price) highest from (select * from product_history where time >= start_time and time <= end_time) l01 group by name) lo
    natural left join
    (select name, max(price) lowest from (select * from product_history where time >= start_time and time <= end_time) hi1 group by name) hi
    group by name;
end $$
delimiter ;


delimiter $$ 
drop procedure if exists quantity_sold $$
create procedure quantity_sold(start_time timestamp, end_time timestamp)
begin
    select name, ifnull(sum(quantity), 0) quantity_sold
		from (product left join buys on product.id = product_id) left join final_order on product.id = final_order.id
        where (time >= start_time and time <= end_time) or time is null
        group by name;
end $$
delimiter ;


delimiter $$ 
drop procedure if exists restock $$
create procedure restock()
begin
    select name, (stock_thresh - stock_actual) restock from product where stock_actual < stock_thresh;
end $$
delimiter ;

call restock();


