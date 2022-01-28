.header on
.width 0 10 10 10 10 5 5 5
.mode column

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Purchase;

Create Table If Not Exists Customer(
  Customer_Id Int Primary key,
  Cust_Name Text NOT NULL,
  Contact Numeric(10) NOT NULL UNIQUE,
  City Text,
  Country Char(20) NOT NULL );

Create Table If Not Exists Purchase(
  Order_Id Int Primary key,
  Amount Int NOT NULL,
  Order_Date Text NOT NULL,
  Customer_Id Int References Customer(Customer_Id) on Delete Cascade );

Insert into Customer(Customer_Id,Cust_Name,Contact,City,Country) values(1,'Ravindra',9146718588,'Pune','India');

/*We can change insert order if we mention it*/
Insert into Customer(Customer_Id,Contact,Cust_Name,City,Country) values(2,8177836014,'Tejas','Pune','India');

/*We can skip the col with NOT NULL Constraint not specified only when we mention cols with Table Name*/
Insert into Customer(Customer_Id,Contact,Cust_Name,Country) values(3,'Akash',7776020793,'India');

/*This method also works*/
Insert into Customer values(4,'Mayur',8823467761,'Satara','India');

Insert into Customer values
(5,'Sunny',7723467761,'Jalor','India'),
(6,'Mohit',7723234761,'Jalor','India'),
(7,'Joseph',9723467761,'London','England'),
(8,'Thomas',9823467761,'London','England'),
(9,'Arthur',7123467761,'Paris','France'),
(10,'Changreta',7523467761,'Berlin','Germany');

Insert into Purchase values
(1,5000,'23-01-2022',1),
(2,1000,'18-01-2022',2),
(3,17000,'18-01-2022',3),
(4,2000,'22-01-2022',2),
(5,5000,'23-01-2022',4),
(6,6000,'22-01-2022',3),
(7,500,'21-01-2022',5),
(8,12000,'22-01-2022',9),
(9,7000,'23-01-2022',10),
(10,3400,'19-01-2022',2),
(11,5600,'20-01-2022',4),
(12,6700,'21-01-2022',2);

/*select * from Customer;
select Order_Date,Customer_Id from Purchase;*/

select * from Customer where Country='India' AND City='Pune';
/*
1|Ravindra|9146718588|Pune|India
2|Tejas|8177836014|Pune|India*/

select Cust_Name from Customer where City='London' OR Country='France';
/*Joseph
Thomas
Arthur*/

select Cust_Name from Customer where City='London' OR Country='France' AND(NOT Cust_Name='Arthur');
/*Joseph
Thomas*/ 

select *,Country,City,count(*) from Customer Group By Customer.Country Order by Customer_Id;
/*
1|Ravindra|9146718588|Pune|India|India|Pune|6
7|Joseph|9723467761|London|England|England|London|2
9|Arthur|7123467761|Paris|France|France|Paris|1
10|Changreta|7523467761|Berlin|Germany|Germany|Berlin|1
*/

select Country,City,count(*) from Customer Group By Customer.City Order by Customer_Id;
/*
India|Pune|2
India||1
India|Satara|1
India|Jalor|2
England|London|2
France|Paris|1
Germany|Berlin|1
*/

select *,Country,City,count(*) from Customer Group By Customer.Country and Customer.City Order by Customer_Id;
/*1|Ravindra|9146718588|Pune|India|India|Pune|10*/

Update Customer Set City='Birmingham' where Cust_Name='Thomas';

Delete From Customer where Customer_Id=3;

select count(*) from Purchase where Amount>4000; 
/* 8 */

select max(Amount) from Purchase; /* 17000 */
select min(Amount) from Purchase; /*500*/
select avg(Amount) from Purchase; /*5933.33*/
select sum(Amount) from Purchase; /*71200 */

select * from Purchase Group by Customer_Id Having max(Amount);
/*
1|5000|23-01-2022|1
12|6700|21-01-2022|2
3|17000|18-01-2022|3
11|5600|20-01-2022|4
7|500|21-01-2022|5
8|12000|22-01-2022|9
9|7000|23-01-2022|10*/

select * from Purchase Group by Customer_Id Having Amount>avg(Amount);
/*3|17000|18-01-2022|3*/
/* Prints whose avg amount > Total avg*/

select * from Purchase where Amount Between 5500 And 6000;
/*6|6000|22-01-2022|3
11|5600|20-01-2022|4*/

select * from Customer where Cust_Name LIKE '_o%';
/*6|Mohit|7723234761|Jalor|India
7|Joseph|9723467761|London|England*/

select * from Customer where City LIKE 'P%';
/*1|Ravindra|9146718588|Pune|India
2|Tejas|8177836014|Pune|India
9|Arthur|7123467761|Paris|France*/

Update Purchase set Amount= Amount+(Amount)*(0.2) where Amount>=10000;

select * from Purchase where Amount>=10000;
/*3|20400|18-01-2022|3
8|14400|22-01-2022|9*/

select Customer.Customer_Id,Customer.Cust_Name,Customer.Country,Purchase.Amount,Purchase.Order_Date from Customer INNER JOIN Purchase ON Customer.Customer_Id=Purchase.Customer_Id; 
/*1|Ravindra|India|5000|23-01-2022
2|Tejas|India|1000|18-01-2022
2|Tejas|India|2000|22-01-2022
4|Mayur|India|5000|23-01-2022
5|Sunny|India|500|21-01-2022
9|Arthur|France|14400|22-01-2022
10|Changreta|Germany|7000|23-01-2022
2|Tejas|India|3400|19-01-2022
4|Mayur|India|5600|20-01-2022
2|Tejas|India|6700|21-01-2022*/

select Customer.Customer_Id,Customer.Cust_Name,Customer.Country,Purchase.Amount,Purchase.Order_Date from Purchase INNER JOIN Customer ON Customer.Customer_Id=Purchase.Customer_Id;
/* same as Above*/

select Customer.Customer_Id,Customer.Cust_Name,Customer.Country,Purchase.Amount,Purchase.Order_Date from Purchase JOIN Customer ON Customer.Customer_Id=Purchase.Customer_Id;
/*same as above*/

select Customer.Customer_Id,Customer.Cust_Name,Customer.Country,Purchase.Amount,Purchase.Order_Date from Purchase LEFT JOIN Customer ON Customer.Customer_Id=Purchase.Customer_Id;
/*
1|Ravindra|India|5000|23-01-2022
2|Tejas|India|1000|18-01-2022
|||20400|18-01-2022
2|Tejas|India|2000|22-01-2022
4|Mayur|India|5000|23-01-2022
|||6000|22-01-2022
5|Sunny|India|500|21-01-2022
9|Arthur|France|14400|22-01-2022
10|Changreta|Germany|7000|23-01-2022
2|Tejas|India|3400|19-01-2022
4|Mayur|India|5600|20-01-2022
2|Tejas|India|6700|21-01-2022
*/

select Customer.Customer_Id,Customer.Cust_Name,Customer.Country,Purchase.Amount,Purchase.Order_Date from Customer LEFT JOIN Purchase ON Customer.Customer_Id=Purchase.Customer_Id;
/*
1|Ravindra|India|5000|23-01-2022
2|Tejas|India|1000|18-01-2022
2|Tejas|India|2000|22-01-2022
2|Tejas|India|3400|19-01-2022
2|Tejas|India|6700|21-01-2022
4|Mayur|India|5000|23-01-2022
4|Mayur|India|5600|20-01-2022
5|Sunny|India|500|21-01-2022
6|Mohit|India||
7|Joseph|England||
8|Thomas|England||
9|Arthur|France|14400|22-01-2022
10|Changreta|Germany|7000|23-01-2022*/

select * from Customer where City IN('Pune','Paris');
/*1|Ravindra|9146718588|Pune|India
2|Tejas|8177836014|Pune|India
9|Arthur|7123467761|Paris|France*/

select * from Customer where City NOT IN('Pune','Paris');
/*4|Mayur|8823467761|Satara|India
5|Sunny|7723467761|Jalor|India
6|Mohit|7723234761|Jalor|India
7|Joseph|9723467761|London|England
8|Thomas|9823467761|Birmingham|England
10|Changreta|7523467761|Berlin|Germany*/

