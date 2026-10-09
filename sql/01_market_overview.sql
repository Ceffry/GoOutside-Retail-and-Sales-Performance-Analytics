-- Retailer Count, Quantity and Revenue by Country
SELECT 
    m.`Order method type`,
    r.`Country`,
    COUNT(DISTINCT r.`Retailer code`) AS `Retailer_Count`,
    ROUND(SUM(ds.Quantity), 2) AS `Total_Quantity`,
    ROUND(SUM(ds.Quantity * ds.`Unit sale price`),2) AS `Total_Revenue`
FROM
    `GoOutside.retailers` r
        JOIN
    `GoOutside.daily_sales` ds USING (`Retailer code`)
        JOIN
    `GoOutside.methods` m USING (`Order method code`)
GROUP BY r.Country , m.`Order method type`
ORDER BY `Total_Revenue` DESC;