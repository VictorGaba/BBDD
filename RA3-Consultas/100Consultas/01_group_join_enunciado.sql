use sakila;
-- ==============================================
-- SECCIÓN A) 30 CONSULTAS CON JOIN DE 2 TABLAS
-- ==============================================
-- 1:  Para cada actor, muestra el número total de películas en las que aparece; es decir, cuenta cuántas filas de film_actor corresponden a cada actor.
-- tablas : actor, film_actor

SELECT 
    COUNT(film_id) AS N_PELIS, CONCAT(first_name, ' ', last_name) AS NOMBRE
FROM
    actor
        JOIN
    film_actor USING (actor_id)
GROUP BY actor_id;

-- 2:  Lista solo los actores que participan en 20 o más películas (umbral alto) con su conteo.

-- tablas : actor, film_actor
SELECT 
    COUNT(film_id) AS N_PELIS, CONCAT(first_name, ' ', last_name) AS NOMBRE
FROM
    actor
        JOIN
    film_actor USING (actor_id)
GROUP BY actor_id
HAVING COUNT(film_id) >= 20;

-- 3:  Para cada idioma, indica cuántas películas están catalogadas en ese idioma.

-- tablas: languaje, film, film category

SELECT 
    COUNT(film_id) AS N_pelis, name
FROM
    language
        JOIN
    film USING (language_id)
GROUP BY (language_id);
    
    
-- 4:  Muestra el promedio de duración (length) de las películas por idioma y filtra aquellos idiomas con duración media estrictamente mayor a 110 minutos.

-- tablas : language, film 

SELECT 
    AVG(length), name
FROM
    language
        JOIN
    film USING (language_id)
GROUP BY (language.name)
HAVING AVG(length) > 110;

-- 5:  Para cada película, muestra cuántas copias hay en el inventario.

-- tablas : film , inventory

SELECT 
    film_id, title, count(inventory_id) as INVENTARIO
FROM
    film
        JOIN
    inventory USING (film_id)
    group by (film_id);
    
   
-- 6:  Lista solo las películas que tienen al menos 5 copias en inventario.


SELECT 
    film_id, title, count(inventory_id) as INVENTARIO
FROM
    film
        JOIN
    inventory USING (film_id)
    group by (film_id)
    having count(inventory_id) >= 5;
    
-- 7:  Para cada artículo de inventario, cuenta cuántos alquileres se han realizado.

-- tablas : inventory, rental

SELECT 
   inventory_id as ID_INVENTARIO,  count(rental_id) AS ALQUILERES
FROM
    inventory
        JOIN
    rental USING (inventory_id)
    group by inventory_id;
    
    
-- 8:  Para cada cliente, muestra cuántos alquileres ha realizado en total.

-- TABLAS : customer , rental  

SELECT 
    COUNT(rental_id), CONCAT(first_name, ' ', last_name)
FROM
    customer
        JOIN
    rental USING (customer_id)
GROUP BY COUNT(rental_id);



SELECT 
    *
FROM
    customer
        JOIN
    rental USING (customer_id);


-- 9:  Lista los clientes con 30 o más alquileres acumulados.

-- tablas: customer , rental

SELECT 
    concat(first_name, ' ', last_name) AS NOMBRE, customer_id as ID_CLIENTE, count(rental_id) AS ALQUILERES
FROM
    customer
        JOIN
    rental USING (customer_id)
    group by customer_id;
    
    SELECT 
    *
FROM
    customer
        JOIN
    rental USING (customer_id);

-- 10:  Para cada cliente, muestra el total de pagos (suma en euros/dólares) que ha realizado.

-- tablas : customer, paymnent

SELECT 
    concat(first_name, ' ', last_name) AS NOMBRE, customer_id, sum(amount)
FROM
    customer
        JOIN
    payment USING (customer_id)
    group by customer_id;

    
-- 11:  Muestra los clientes cuyo importe total pagado es al menos 200.

-- tablas : customer , payment

SELECT 
    concat(first_name, ' ', last_name) AS NOMBRE, customer_id, sum(amount)
FROM
    customer
        JOIN
    payment USING (customer_id)
    group by customer_id
    having sum(amount) > 200;

-- 12:  Para cada empleado (staff), muestra el número de pagos que ha procesado.

-- tablas : staff , payment

SELECT 
    staff_id, concat(first_name, ' ', last_name) AS NOMBRE, count(payment_id)
FROM
    staff
        JOIN
    payment USING (staff_id)
    group by staff_id;
    
    
    
-- 13:  Para cada empleado, muestra el importe total procesado.

-- tablas : staff , payment

SELECT 
     staff_id, concat(first_name, ' ', last_name) AS NOMBRE, sum(amount)
FROM
    staff
        JOIN
    payment USING (staff_id)
		group by staff_id;


-- 14:  Para cada tienda, cuenta cuántos artículos de inventario tiene.

-- tablas : store , invemtory 

SELECT 
    store_id, count(inventory_id)
FROM
    store
        JOIN
    inventory USING (store_id)
    group by store_id;

-- 15:  Para cada tienda, cuenta cuántos clientes tiene asignados.
-- tablas : store , customers

SELECT 
    store_id, count(customer_id)
FROM
    store
        JOIN
    customer USING (store_id)
    group by store_id;



SELECT 
    *
FROM
    store
        JOIN
    customer USING (store_id);

-- 16:  Para cada tienda, cuenta cuántos empleados (staff) tiene asignados.

-- tablas : store , staff

SELECT 
    store_id, count(staff_id)
FROM
    store
        JOIN
    staff USING (store_id)
    group by  store_id;
    
    
-- 17:  Para cada dirección (address), cuenta cuántas tiendas hay ubicadas ahí (debería ser 0/1 en datos estándar).

-- tablas : address , store

SELECT 
    address_id, address, count(store_id)
FROM
    address
        JOIN
    store USING (address_id)
    group by address_id ;

-- 18:  Para cada dirección, cuenta cuántos empleados residen en esa dirección.

-- tablas : address, staff 

SELECT 
   address_id, address, count(staff_id)
FROM
    address
        JOIN
    staff USING (address_id)
 group by address_id;

-- 19:  Para cada dirección, cuenta cuántos clientes residen ahí.

-- tablas: address, customers



SELECT 
    address_id, address, count(customer_id)
FROM
    address
        JOIN
    customer USING (address_id)
    group by customer_id;



-- 20:  Para cada ciudad, cuenta cuántas direcciones hay registradas.

-- tablas : country , address

SELECT 
    city_id, city, count(address_id) 
FROM
    city 
        JOIN
    address USING (city_id)
    group by address_id
    order by city_id asc;

-- 21:  Para cada país, cuenta cuántas ciudades existen.

-- tablas : country , city 


SELECT 
   country_id, country, count(city_id)
FROM
    country
        JOIN
    city USING (country_id)
    group by country_id;

    
    
    
-- 22:  Para cada idioma, calcula la duración media de películas y muestra solo los idiomas con media entre 90 y 120 inclusive.
-- tablas : language, film 
SELECT 
    language_id, name, avg(length)
FROM
    language					
        JOIN
    film USING (language_id)
    group by language_id;
    
    
    
-- 23:  Para cada película, cuenta el número de alquileres que se han hecho de cualquiera de sus copias (usando inventario).

-- tablas : film, rental

   SELECT 
    film_id, title, COUNT(rental_id) AS total_alquileres
FROM
    film
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
GROUP BY film_id;
    


-- 24:  Para cada cliente, cuenta cuántos pagos ha realizado en 2005 (usando el año de payment_date).

-- tablas : customer , payment 


 SELECT 
   customer_id, concat(first_name, ' ' , last_name), count(payment_date)
FROM
    customer
        JOIN
    payment USING (customer_id)
    where year(payment_date) = 2005 
    group by customer_id ;
    
    
 

-- 25:  Para cada película, muestra el promedio de tarifa de alquiler (rental_rate) de las copias existentes (es un promedio redundante pero válido).

-- tablas : film , rental ,

SELECT
    film_id,
    title,
    AVG(rental_rate) AS promedio_tarifa
FROM film
JOIN inventory USING (film_id)
GROUP BY film_id, title;
    
-- 26:  Para cada actor, muestra la duración media (length) de sus películas.

-- tablas : actor, film_actor, film

SELECT 
    actor_id, concat(first_name, ' ', last_name), avg(length) 
FROM
    ACTOR
        JOIN
    FILM_ACTOR USING (actor_id)
        JOIN
    FILM USING (film_id)
    group by actor_id;
    
    -- 27:  Para cada ciudad, cuenta cuántos clientes hay (usando la relación cliente->address->city requiere 3 tablas; aquí contamos direcciones por ciudad).
    
    -- tablas : city , address , city 
    
    SELECT 
    city_id, city, active
FROM
    customer
        JOIN
    address USING (address_id)
        JOIN
    city USING (city_id)
    order by city_id asc;

-- 28:  Para cada película, cuenta cuántos actores tiene asociados.

-- tablas : film , film_actor  

SELECT 
    film_id , title , count(actor_id)
FROM
    film
        JOIN
    film_actor USING (film_id)
group by film_id;

-- 29:  Para cada categoría (por id), cuenta cuántas películas pertenecen a ella (sin nombre de categoría para mantener 2 tablas).

-- tablas : category , film_category

SELECT 
    category_id, count(film_id)
FROM
    category
        JOIN
    film_category USING (category_id)
    group by category_id;
    
-- 30:  Para cada tienda, cuenta cuántos alquileres totales se originan en su inventario.

-- tablas : store, inventory

SELECT 
    store_id, count(rental_id)
FROM
    store
        JOIN
    inventory USING (store_id)
        JOIN
    rental USING (inventory_id)
    group by store_id;


-- ==============================================
-- SECCIÓN B) 30 CONSULTAS CON JOIN DE 3 TABLAS
-- ==============================================
-- 31:  Para cada actor, cuenta cuántas películas tiene y muestra solo los que superan 15 películas.

-- tablas : actor , film_actor, film 

SELECT 
    actor_id , concat(first_name, ' ', last_name), count(language_id)
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
    group by actor_id
    order by actor_id asc limit 15;
    
-- 32:  Para cada categoría (por nombre), cuenta cuántas películas hay en esa categoría.

SELECT 
    category_id, name, COUNT(film_id) AS total_peliculas
FROM
    category
        JOIN
    film_category USING (category_id)
GROUP BY category_id , name;

-- 33:  Para cada película, cuenta cuántos alquileres se han hecho de sus copias.

SELECT 
    film_id, title , count(rental_id)
FROM
    film
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
    group by film_id;
    
-- 34:  Para cada cliente, suma el importe pagado en 2005 y filtra clientes con total >= 150.

SELECT 
    customer_id,
    CONCAT(first_name, ' ', last_name) AS cliente,
    SUM(amount) AS total
FROM
    customer
        JOIN
    payment USING (customer_id)
WHERE
    YEAR(payment_date) = 2005
GROUP BY customer_id , first_name , last_name
HAVING SUM(amount) >= 150;
    
    
-- 35:  Para cada tienda, suma el importe cobrado por todos sus empleados.

SELECT 
    store_id, sum(amount) as COBRADO
FROM
    store
        JOIN
    staff USING (store_id)
        JOIN
    payment USING (staff_id)
    group by store_id;
    
    
-- 36:  Para cada ciudad, cuenta cuántos empleados residen ahí (staff -> address -> city).

SELECT 
    city_id, city, count(staff_id)
FROM
    staff
        JOIN
    address USING (address_id)
        JOIN
    city USING (city_id)
    group by city_id;
    
    
-- 37:  Para cada ciudad, cuenta cuántas tiendas existen (store -> address -> city).

SELECT 
    city_id , city, count(store_id) as TIENDAS
FROM
    store
        JOIN
    address USING (address_id)
        JOIN
    city USING (city_id)
    group by city_id;
    
-- 38:  Para cada actor, calcula la duración media de sus películas del año 2006.

SELECT 
    actor_id, concat(first_name, ' ' , last_name), avg(length)
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
    where release_year = 2006
    group by actor_id;
    
  
-- 39:  Para cada categoría, calcula la duración media y muestra solo las que superan 120.

SELECT 
    category_id, name, AVG(length)
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
GROUP BY category_id , name
HAVING AVG(length) > 120;
    
-- 40:  Para cada idioma, suma las tarifas de alquiler (rental_rate) de todas sus películas.

SELECT 
    language_id, name, sum(rental_rate)
FROM
    language
        JOIN
    film USING (language_id)
        JOIN
    inventory USING (film_id)
    group by language_id;
    
    
    
-- 41:  Para cada cliente, cuenta cuántos alquileres realizó en fines de semana (SÁB-DO) usando DAYOFWEEK (1=Domingo).

SELECT 
    customer_id, concat(first_name, ' ', last_name), count(rental_id)
FROM
    customer
        JOIN
    rental USING (customer_id)
	where DAYOFWEEK(rental_date) = 1 OR DAYOFWEEK(rental_date) = 7
    group by customer_id;
   

-- 42:  Para cada actor, muestra el total de títulos distintos en los que participa (equivale a COUNT DISTINCT, sin subconsulta).

SELECT 
    actor_id, concat(first_name, ' ', last_name), count(distinct title) as Titulos
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
    group by actor_id;


-- 43:  Para cada ciudad, cuenta cuántos clientes residen ahí (customer -> address -> city).

SELECT 
    city_id , city, count(customer_id)
FROM
    customer
        JOIN
    address USING (address_id)
        JOIN
    city USING (city_id)
    group by city_id;
    
    
-- 44:  Para cada categoría, muestra cuántos actores distintos participan en películas de esa categoría.

SELECT 
    category_id, name , count(distinct actor_id)
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
        JOIN
    film_actor USING (film_id)
    group by category_id;
    
	
    
-- 45:  Para cada tienda, cuenta cuántas copias totales (inventario) tiene de películas en 2006.

SELECT 
    customer.customer_id, CONCAT(customer.first_name, ' ', customer.last_name) , SUM(payment.amount)
FROM
    customer
        JOIN
    rental ON customer.customer_id = rental.customer_id
        JOIN
    payment ON rental.rental_id = payment.rental_id
        JOIN
    staff ON payment.staff_id = staff.staff_id
WHERE
    staff.store_id = 1
GROUP BY customer_id;

-- 47:  Para cada película, cuenta cuántos actores tienen el apellido de longitud >= 5.

SELECT 
    film_id, title, COUNT(actor_id)
FROM
    film
        JOIN
    film_actor USING (film_id)
        JOIN
    actor USING (actor_id)
    where CHAR_LENGTH(last_name) >= 5
    group by film_id;
    
    
-- 48:  Para cada categoría, suma la duración total (length) de sus películas.

SELECT 
    category_id, sum(length), name
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
    group by category_id;
    
    
-- 49:  Para cada ciudad, suma los importes pagados por clientes que residen en esa ciudad.

-- 50:  Para cada idioma, cuenta cuántos actores distintos participan en películas de ese idioma.
-- 51:  Para cada tienda, cuenta cuántos clientes activos (active=1) tiene.
-- 52:  Para cada cliente, cuenta en cuántas categorías distintas ha alquilado (aprox. vía film_category; requiere 4 tablas, aquí contamos películas 2006 por inventario).

-- 53:  Para cada empleado, cuenta cuántos clientes diferentes le han pagado.

SELECT 
    staff_id, concat(s.first_name, ' ', s.last_name), count(distinct customer_id)
   FROM
    staff s
        JOIN
    payment p USING (staff_id)
        JOIN
    customer c USING (customer_id)
    group by staff_id;
    
    
-- 54:  Para cada ciudad, cuenta cuántas películas del año 2006 han sido alquiladas por residentes en esa ciudad.

SELECT 
    city_id, city, count(i.film_id)
FROM
    city c 
        JOIN
    address a USING (city_id)
        JOIN
    customer cu USING (address_id)
        JOIN
    rental r USING (customer_id)
        JOIN
    inventory i USING (inventory_id)
        JOIN
    film f USING (film_id)
    where release_year = 2006
    group by city_id;
    
-- 55:  Para cada categoría, calcula el promedio de replacement_cost de sus películas. 

SELECT 
    category_id , name, avg(replacement_cost)
FROM
    category c
        JOIN
    film_category fc USING (category_id)
        JOIN
    film f USING (film_id)
    group by category_id;
    
    
-- 56:  Para cada tienda, suma los importes cobrados en 2006 (vía empleados de esa tienda).

SELECT 
    store_id, sum(amount)
FROM
    store
        JOIN
    staff USING (store_id)
        JOIN
    payment USING (staff_id)
    where year(payment_date) = 2006
    group by store_id;
    
    
-- 57:  Para cada actor, cuenta cuántas películas tienen título de más de 12 caracteres.

SELECT 
    actor_id , concat(first_name , ' ', last_name), count(film_id)
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
    where CHAR_LENGTH(title) > 12
    group by actor_id;
    
    
-- 58:  Para cada ciudad, calcula la suma de pagos de 2005 y filtra las ciudades con total >= 300.

SELECT 
    city_id, city, sum(amount)
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    staff USING (address_id)
        JOIN
    payment USING (staff_id)
    where year(payment_date) = 2005 and (city_id) >= 300
    group by city_id;
    
    
-- 59:  Para cada categoría, cuenta cuántas películas tienen rating 'PG' o 'PG-13'.

SELECT 
    category_id, name, count(rating)
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
    WHERE rating = 'PG' OR rating = 'PG-13'
    group by category_id;
    
-- 60:  Para cada cliente, calcula el total pagado en pagos procesados por el empleado 2.

SELECT
    c.customer_id , concat(c.first_name, ' ', c.last_name), sum(p.amount) 
FROM customer 
	JOIN 
payment 
    on c.customer_id = p.customer_id
JOIN staff s
    on p.staff_id = s.staff_id
where s.staff_id = 2
group by c.customer_id;
-- ==============================================
-- SECCIÓN C) 20 CONSULTAS CON JOIN DE 4 TABLAS
-- ==============================================
-- 61:  Para cada ciudad, cuenta cuántos clientes hay y muestra solo ciudades con 10 o más clientes.

SELECT 
    city_id, city , count(customer_id)
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
    where customer_id > 10
    group by city_id;
    
    
-- 62:  Para cada actor, cuenta cuántos alquileres totales suman todas sus películas.

-- tablas actor, rental, fil

SELECT 
    actor_id, concat(first_name, ' ' , last_name), count(rental_id)
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
    group by actor_id;
    
    
-- 63:  Para cada categoría, suma los importes pagados derivados de películas de esa categoría.

SELECT 
    category_id, name, sum(amount)
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
        JOIN
    payment USING (rental_id)
    group by category_id;
    
    
-- 64:  Para cada ciudad, suma los importes pagados por clientes residentes en esa ciudad en 2005.

SELECT
    city_id, city, sum(amount)
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
        JOIN
    payment USING (customer_id)
    where year(payment_date) = 2005
    group by city_id;
    
    
-- 65:  Para cada tienda, cuenta cuántos actores distintos aparecen en las películas de su inventario.

SELECT 
    store_id, count(distinct actor_id)
FROM
    store
        JOIN
    inventory USING (store_id)
        JOIN
    film USING (film_id)
    join film_actor using (film_id)
    group by store_id;
    
    
-- 66:  Para cada idioma, cuenta cuántos alquileres totales se han hecho de películas en ese idioma.

SELECT 
    language_id, name, count(rental_id)
FROM
    language
        JOIN
    film USING (language_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
    group by language_id;
    
    
-- 67:  Para cada cliente, cuenta en cuántos meses distintos de 2005 realizó pagos (meses distintos).

SELECT 
    customer_id, concat(first_name, ' ' , last_name), count(distinct month(payment_date))
FROM
    customer
        JOIN
    payment USING (customer_id)
    where year(payment_date) = 2005
    group by customer_id;
    
    
-- 68:  Para cada categoría, calcula la duración media de las películas alquiladas (considerando solo películas alquiladas).

SELECT 
    category_id, name, avg(length)
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
    group by category_id;
    
    
-- 69:  Para cada país, cuenta cuántos clientes hay (country -> city -> address -> customer).

SELECT 
    country_id, country, count(customer_id)
FROM
    country
        JOIN
    city USING (country_id)
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
    group by country_id
    order by country_id asc;
    
    
-- 70:  Para cada país, suma los importes pagados por sus clientes.

SELECT 
    country_id , country , sum(amount)
FROM
    country
        JOIN
    city USING (country_id)
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
        JOIN
    payment USING (customer_id)
    group by country_id;
    
    
-- 71:  Para cada tienda, cuenta cuántas categorías distintas existen en su inventario.

SELECT 
    store_id, count(distinct category_id)
FROM
    store
        JOIN
    inventory USING (store_id)
        JOIN
    film USING (film_id)
        JOIN
    film_category USING (film_id)
        JOIN
    category USING (category_id)
    group by store_id;
    
    
    
-- 72:  Para cada tienda, suma la recaudación por categoría (resultado agregado por tienda y categoría).

SELECT 
    s.store_id, cat.category_id ,cat.name ,SUM(p.amount) 
FROM
    store s
        JOIN
    staff st USING (store_id)
        JOIN
    payment p USING (staff_id)
        JOIN
    rental r USING (rental_id)
        JOIN
    inventory i USING (inventory_id)
        JOIN
    film f USING (film_id)
        JOIN
    film_category fc USING (film_id)
        JOIN
    category cat USING (category_id)
GROUP BY s.store_id, CATEGORY_ID;
    
-- 73:  Para cada actor, cuenta en cuántas tiendas distintas se han alquilado sus películas.
-- 74:  Para cada categoría, cuenta cuántos clientes distintos han alquilado películas de esa categoría.
-- 75:  Para cada idioma, cuenta cuántos actores distintos participan en películas alquiladas en ese idioma.
-- 76:  Para cada país, cuenta cuántas tiendas hay (país->ciudad->address->store).
-- 77:  Para cada cliente, cuenta los alquileres en los que la devolución (return_date) fue el mismo día del alquiler.
-- 78:  Para cada tienda, cuenta cuántos clientes distintos realizaron pagos en 2005.
-- 79:  Para cada categoría, cuenta cuántas películas con título de longitud > 15 han sido alquiladas.
-- 80:  Para cada país, suma los pagos procesados por los empleados de las tiendas ubicadas en ese país.
-- ==============================================
-- SECCIÓN D) 20 CONSULTAS EXTRA (DIFICULTAD +), <=4 JOINS
-- ==============================================
-- 81:  Para cada cliente, muestra el total pagado con IVA teórico del 21% aplicado (total*1.21), redondeado a 2 decimales.
-- 82:  Para cada hora del día (0-23), cuenta cuántos alquileres se iniciaron en esa hora.
-- 83:  Para cada tienda, muestra la media de length de las películas alquiladas en 2005 y filtra las tiendas con media >= 100.
-- 84:  Para cada categoría, muestra la media de replacement_cost de las películas alquiladas un domingo.
-- 85:  Para cada empleado, muestra el importe total por pagos realizados entre las 00:00 y 06:00 (inclusive 00:00, exclusivo 06:00).
-- 86:  Para cada actor, cuenta cuántas de sus películas tienen un título que contiene la palabra 'LOVE' (mayúsculas).
-- 87:  Para cada idioma, muestra el total de pagos de alquileres de películas en ese idioma.
-- 88:  Para cada cliente, cuenta en cuántos días distintos de 2005 realizó algún alquiler.
-- 89:  Para cada categoría, calcula la longitud media de títulos (número de caracteres) de sus películas alquiladas.
-- 90:  Para cada tienda, cuenta cuántos clientes distintos alquilaron en el primer trimestre de 2006 (enero-marzo).
-- 91:  Para cada país, cuenta cuántas categorías diferentes han sido alquiladas por clientes residentes en ese país.
-- 92:  Para cada cliente, muestra el importe medio de sus pagos redondeado a 2 decimales, solo si ha hecho al menos 10 pagos.
-- 93:  Para cada categoría, muestra el número de películas con replacement_cost > 20 que hayan sido alquiladas al menos una vez.
-- 94:  Para cada tienda, suma los importes pagados en fines de semana.
-- 95:  Para cada actor, cuenta cuántas películas suyas fueron alquiladas por al menos 5 clientes distintos (se cuenta alquileres y luego se filtra por HAVING).
-- 96:  Para cada idioma, muestra el número de películas cuyo título empieza por la letra 'A' y que han sido alquiladas.
-- 97:  Para cada país, suma el importe total de pagos realizados por clientes residentes y filtra países con total >= 1000.
-- 98:  Para cada cliente, cuenta cuántos días han pasado entre su primer y su último alquiler en 2005 (diferencia de fechas), mostrando solo clientes con >= 5 alquileres en 2005.
--     (Se evita subconsulta calculando sobre el conjunto agrupado por cliente y usando MIN/MAX de rental_date en 2005).
-- 99:  Para cada tienda, muestra la media de importes cobrados por transacción en el año 2006, con dos decimales.
-- 100:  Para cada categoría, calcula la media de duración (length) de películas alquiladas en 2006 y ordénalas descendentemente por dicha media.



