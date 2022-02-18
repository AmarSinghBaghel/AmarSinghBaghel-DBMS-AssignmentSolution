create database  TravelOnTheGo;
use  travelonthego;
create table PASSENGER (
Passenger_name varchar(50), 
 Category varchar(50),Gender varchar(50),Boarding_City varchar(50),
 Destination_City varchar(50),Distance int,
 Bus_Type varchar(50)
);


insert into PASSENGER values('Sejal','AC','F','Bengaluru','Chennai',350,'Sleeper');
insert into PASSENGER values('Anmol','Non-AC','M','Mumbai','Hyderabad',700,'Sitting');
insert into PASSENGER values('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper');
insert into PASSENGER values('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper');
insert into PASSENGER values('Udit', 'Non-AC', 'M', 'Trivandrum', 'panaji', 1000, 'Sleeper');
insert into PASSENGER values('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting');
insert into PASSENGER values('Hemant', 'Non-AC', 'M', 'panaji','Mumbai', 700, 'Sleeper');
insert into PASSENGER values('Manish', 'Non-AC', 'M', 'Hyderabad' ,'Bengaluru', 500, 'Sitting');
insert into PASSENGER values('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700 ,'Sitting');



create table PRICE (Bus_Type varchar(50),Distance int,Price int);

insert into PRICE values('Sleeper',350,770);
insert into PRICE values('Sleeper',500,1100);
insert into PRICE values('Sleeper',600,1320);
insert into PRICE values('Sleeper',700,1540);
insert into PRICE values('Sleeper',1000,2200);
insert into PRICE values('Sleeper',1200,2640);
insert into PRICE values('Sleeper',1500,2700);
insert into PRICE values('Sitting',500,620);
insert into PRICE values('Sitting',600,744);
insert into PRICE values('Sitting',700,868);
insert into PRICE values('Sitting',1000,1240);
insert into PRICE values('Sitting',1200,1488);
insert into PRICE values('Sitting',1500,1860);

/*3) How many females and how many male passengers travelled for a minimum distance of 
600 KM s?*/

SELECT Gender as Passenger_Gender,COUNT(Gender) as Passenger_count  FROM passenger  WHERE Distance >=600 and gender= 'F'
UNION
SELECT Gender as Passenger_Gender ,COUNT(Gender) as Passenger_count FROM passenger  WHERE Distance >=600 and gender= 'M';


/*4. Find the minimum ticket price for Sleeper Bus.*/

SELECT MIN(price) FROM price WHERE Bus_Type = 'sleeper';


/*5. Select passenger names whose names start with character 'S'.*/

SELECT * FROM passenger WHERE Passenger_name LIKE 's%';

/*6. Calculate price charged for each passenger displaying Passenger name, 
Boarding City, Destination City, Bus_Type, Price in the output.*/

SELECT p1.Passenger_name , p1.Boarding_City, p1.Destination_city, p1.Bus_Type, p2.Price 
FROM passenger p1, price p2 WHERE p1.Distance = p2.Distance and p1.Bus_type = p2.Bus_type;

/*7. What is the passenger name and his/her ticket price who travelled in Sitting bus for a distance of 1000 KMs.*/

SELECT DISTINCT  p1.Passenger_name, p1.Boarding_city, p1.Destination_city, p2.Bus_type, p2.Price ,p1.Distance
FROM passenger p1, price p2 
WHERE p1.Distance = 1000 and p1.Bus_type = 'Sleeper' ;




/*7.What are the passenger name/s and his/her ticket price who travelled in the Sitting bus 
for a distance of 1000 KM s*/
/*ANSWER 7*/
SELECT p1.name,p1.d as distance,price.price as price
from  (select Passenger_name as name ,distance as d,bus_type as t from passenger where bus_type = 'sitting' and distance < 1000) as p1 
Inner Join price on 
Price.distance = p1.d && Price.Bus_Type = p1.t;


/*8. What will be the Sitting and Sleeper bus charge for Pallavi to travel from 
Bangalore to Panaji?*/
/*ANS 8*/
SELECT DISTINCT 
p1.Passenger_name, p1.Boarding_city as Destination_city, p1.Destination_city as 
Boardng_city, p2.Bus_type, p2.Price 
FROM passenger p1, price p2
WHERE Passenger_name = 'Pallavi' and p1.Distance = p2.Distance;


/*9.  List the distances from the "Passenger" table which are unique (non-repeated 
distances) in descending order.*/
/*ANSWER 9*/
SELECT distance FROM passenger 
GROUP BY passenger.distance 
order by Distance desc;

/*10) Display the passenger name and percentage of distance travelled by that passenger 
from the total distance travelled by all passengers without using user variables */
/*ANSWER 10*/

SELECT 
Passenger_name,Distance*100/(select sum(Distance) as s from passenger) As 'Percentage of Distance Travelled (in %)'  
FROM passenger;


/*11) Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise*/
/*ANSWER 11*/

SELECT passenger.distance,price.price,
case
     when price.price >1000 Then 'Expensive'
     when price.price > 500 && price.price < 1000 Then 'Average Cost'
     else 'Supplier should not be considered'
end As  Category from  passenger
Inner Join price on 
Price.distance = passenger.distance && Price.Bus_Type = passenger.Bus_Type;



/*8. Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables.*/
/*ANSWER 8*/
SELECT Passenger_name, Distance * 100.0/ (SELECT SUM(Distance) FROM passenger)FROM passenger GROUP BY Distance;
