create database assi2 ;
 use assi2;
-- //1


  create table test_table 
 (Record_number int,
 Curren_date Date );
 

 DELIMITER //
create procedure insert_records()
 Begin
    declare i Int default 1;
    While i <= 50 do 
       insert into test_table(Record_number , Curren_date)
       values ( i , CURDATE()) ;
      set i = i+1 ;
      End while ; 
      
end

 DELIMITER ; 
 select * from test_table;
 


-- //2

create table products (
 ProductID Int primary key ,
category char(3) ,
detail varchar(60) ,
 price Int,
 stock int
 ) ;
INSERT INTO products (ProductID, category, detail, price, stock) VALUES (101, 'ELE', 'Electric Kettle', 1500.00, 50);
INSERT INTO products (ProductID, category, detail, price, stock) VALUES (102, 'APP', 'Apple iPhone', 70000.00, 20);
INSERT INTO products (ProductID, category, detail, price, stock) VALUES (103, 'APP', 'AirPods Pro', 25000.00, 15);
INSERT INTO products (ProductID, category, detail, price, stock) VALUES (104, 'ELE', 'Blender', 2000.00, 30);
INSERT INTO products (ProductID, category, detail, price, stock) VALUES (105, 'FUR', 'Office Chair', 5000.00, 25);


select * from products ;
set sql_safe_updates = false ;

delimiter //
create  procedure increment( in x Int , in y char(3) ) 
   Begin
   set sql_safe_updates = false ;
   update products 
   set price = price + (price *(x/100) )
   where category = y ;
    commit ;
	end //	
 delimiter ; 
 
CALL increment( 50 , 'APP') ;
CALL increment(10 ,'ELE');
select * from products ;



