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
    count(rental_id), concat(first_name, ' ' , last_name)
FROM
    customer
        JOIN
    rental USING (customer_id)
    group by count(rental_id);



SELECT 
    *
FROM
    customer
        JOIN
    rental USING (customer_id);
