#Q1
SELECT *
FROM hotels
WHERE city='Haifa'
ORDER BY hotel_rank
;

#Q2
SELECT distinct hotels.hotel_code, hotel_name, city, room_number, price
FROM hotels, rooms
WHERE price BETWEEN 170 AND 380 AND (hotels.hotel_code=rooms.hotel_code)
ORDER BY hotel_rank ASC, price ASC
;

#Q3
SELECT hotels.hotel_code, hotel_name, city, type, count(room_number)
FROM rooms, hotels
WHERE hotels.hotel_code=rooms.hotel_code
group by hotel_code, type
;

#Q4
SELECT distinct hotels.hotel_code, hotel_name, city, count(room_number>2) above_2_rooms
FROM hotels, rooms
WHERE hotels.hotel_code=rooms.hotel_code AND rooms.price>186
GROUP BY hotels.hotel_code HAVING count(room_number)>2
;

#Q5
SELECT hotel_name, city, room_number, price
FROM hotels, rooms
WHERE hotels.hotel_code=rooms.hotel_code AND price = (SELECT MAX(price) FROM rooms)
;

#Q6
SELECT hotel_name, city, room_number, price
FROM hotels, rooms
WHERE hotels.hotel_code=rooms.hotel_code AND price >= ALL(SELECT price FROM rooms)
;

#Q7
SELECT hotels.hotel_code, hotel_name, city, type, AVG(price) Average_Price
FROM hotels, rooms
WHERE hotels.hotel_code=rooms.hotel_code
GROUP BY hotels.hotel_code, type
;

#Q8
SELECT reservation.hotel_code, hotel_name, hotels.city, name, guests.city
FROM hotels, guests,reservation
WHERE hotels.hotel_code=reservation.hotel_code AND reservation.id=guests.id
AND from_date<='2010-06-28' AND to_date>='2010-06-28'
;

#Q9
SELECT city, count(hotel_code) 4_Stars_Rank
FROM hotels
WHERE hotels.hotel_rank='4'
GROUP BY city
;

#Q10
SELECT rooms.hotel_code, hotel_name, (case
when price<100 then "cheap" 
else "expensive"
end) cheap_or_expensive
FROM hotels, rooms
WHERE hotels.hotel_code=rooms.hotel_code
GROUP BY hotel_code
;

#Q11
SELECT reservation.hotel_code, hotel_name, city, count(reservation.hotel_code) Reservations
FROM hotels, reservation
WHERE hotels.hotel_code=reservation.hotel_code
GROUP BY hotel_code
;


#Q12
SELECT hotel_rank, ABS(AVG(DATEDIFF(reservation.from_date,reservation.to_date)))
FROM reservation, hotels
WHERE reservation.hotel_code=hotels.hotel_code 
GROUP BY hotels.hotel_rank
;

#Q13
SELECT DISTINCT hotels.hotel_code, hotel_name, name
FROM hotels LEFT JOIN reservation ON hotels.hotel_code = reservation.hotel_code LEFT JOIN guests ON guests.id = reservation.id
;
