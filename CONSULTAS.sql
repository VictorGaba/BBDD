-- 48:  Para cada categoría, suma la duración total (length) de sus películas.

SELECT 
    category_id, name, sum(length) 
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
    group by category_id;
    
    
-- 49:  Para cada ciudad, suma los importes pagados por clientes que residen en esa ciudad.

SELECT 
    city_id, city, SUM(amount)
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
        JOIN
    payment USING (customer_id)
GROUP BY city_id
ORDER BY city_id ASC;
    
    
-- 50:  Para cada idioma, cuenta cuántos actores distintos participan en películas de ese idioma.

SELECT 
    language_id, name, count(distinct actor_id)
FROM
    language
        JOIN
    film USING (language_id)
        JOIN
    film_actor USING (film_id)
    group by language_id;


-- 51:  Para cada tienda, cuenta cuántos clientes activos (active=1) tiene.

SELECT 
    store_id, count(active)
FROM
    store
        JOIN
    customer USING (store_id)
    where active > 0
    group by store_id;


-- 52:  Para cada cliente, cuenta en cuántas categorías distintas ha alquilado (aprox. vía film_category; requiere 4 tablas, aquí contamos películas 2006 por inventario).

SELECT
    customer_id, concat(first_name , ' ' , last_name), count(distinct fc.category_id) 
FROM
    customer c
        JOIN
    rental r USING (customer_id)
        JOIN
    inventory i USING (inventory_id)
        JOIN
    film f USING (film_id)
        JOIN
    film_category fc USING (film_id)
    group by customer_id
    ;
    
-- 53:  Para cada empleado, cuenta cuántos clientes diferentes le han pagado.
-- 54:  Para cada ciudad, cuenta cuántas películas del año 2006 han sido alquiladas por residentes en esa ciudad.
-- 55:  Para cada categoría, calcula el promedio de replacement_cost de sus películas.
-- 56:  Para cada tienda, suma los importes cobrados en 2006 (vía empleados de esa tienda).
-- 57:  Para cada actor, cuenta cuántas películas tienen título de más de 12 caracteres.
-- 58:  Para cada ciudad, calcula la suma de pagos de 2005 y filtra las ciudades con total >= 300.
-- 59:  Para cada categoría, cuenta cuántas películas tienen rating 'PG' o 'PG-13'.
-- 60:  Para cada cliente, calcula el total pagado en pagos procesados por el empleado 2.