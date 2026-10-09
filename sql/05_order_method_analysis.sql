-- Total Revenue by Order Method
SELECT 
    `Order method code`,
    `Order method type`,
    ROUND(SUM((Quantity * `Unit sale price`)), 2) AS `Total Revenue`
FROM
    `GoOutside.daily_sales`
        JOIN
    `GoOutside.methods` USING (`Order method code`)
GROUP BY `Order method code` , `Order method type`
ORDER BY `Order method code` ASC;

-- Order Method Type by Country
SELECT 
    Country `Order method code`,
    `Order method type`,
    ROUND(SUM((Quantity * `Unit sale price`)), 2) AS `Total Revenue`
FROM
    `GoOutside.daily_sales`
        JOIN
    `GoOutside.methods` USING (`Order method code`)
        JOIN
    `GoOutside.retailers` USING (`Retailer code`)
GROUP BY Country , `Order method code` , `Order method type`
ORDER BY `Order method code` ASC;

-- Explore the use of sales methods over the years
SELECT 
    EXTRACT(YEAR FROM ds.Date) AS sales_year,
    m.`Order method type` AS method,
    COUNT(*) AS times_used
FROM
    `GoOutside.daily_sales` ds
        JOIN
    `GoOutside.methods` m USING (`Order method code`)
GROUP BY sales_year , method
ORDER BY sales_year , times_used DESC;