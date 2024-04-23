#Напишите SELECT-запрос, который выводит название товара, производителя и цену для товаров, количество которых превышает 2
SELECT
product_name,
manufacturer,
price,
product_count 
FROM smartphones 
WHERE product_count > 2;

#Выведите SELECT-запросом весь ассортимент товаров марки “Samsung”
SELECT * 
FROM smartphones 
WHERE manufacturer = 'Samsung';

#С помощью SELECT-запроса с оператором LIKE / REGEXP найти:
#Товары, в которых есть упоминание "Iphone"
SELECT * 
FROM smartphones 
WHERE product_name LIKE '%iPhone%';

#Товары, в которых есть упоминание "Samsung"
SELECT * 
FROM smartphones 
WHERE manufacturer LIKE '%Samsung%';

#Товары, в названии которых есть ЦИФРЫ
SELECT *
FROM smartphones
WHERE product_name REGEXP '[0-9]';

#Товары, в названии которых есть ЦИФРА "8"
SELECT *
FROM smartphones
WHERE  product_name LIKE '%8%';