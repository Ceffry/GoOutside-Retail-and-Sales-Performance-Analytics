-- Sales Quantity By Retailer Type
SELECT 
    Type, Country, ROUND(SUM(Quantity), 2) AS `Total_Quantity`
FROM
    `GoOutside.retailers`
        JOIN
    `GoOutside.daily_sales` USING (`Retailer code`)
GROUP BY Type , Country
ORDER BY `Total_Quantity` DESC;

-- Total Amount of Retailers by Type
SELECT 
    Type,
    Country,
    ROUND(COUNT(DISTINCT `Retailer code`), 2) AS `Retailer_Total`
FROM
    `GoOutside.retailers`
GROUP BY Type , Country
ORDER BY `Retailer_Total` DESC;


-- Total Revenue of Retailers by Type
SELECT 
    Type,
    Country,
    ROUND(SUM(Quantity * `Unit sale price`), 2) AS `Total_Revenue`,
    ROUND(SUM(Quantity * (`Unit sale price` - `Unit Cost`)),2) AS Gross_Profit_Total
FROM
    `GoOutside.daily_sales`
        JOIN
    `GoOutside.retailers` USING (`Retailer code`)
        JOIN
    `GoOutside.products` USING (`Product number`)
GROUP BY Type , Country
ORDER BY `Total_Revenue` DESC;


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


-- Percentage per Country
WITH retailer_market AS
  (SELECT
    r.Type,
    r.`Country`,
    r.`Retailer code` AS Retailer_Code, 
    ROUND(SUM(ds.Quantity * ds.`Unit sale price`), 2) AS `Retailer_Revenue`
  FROM `GoOutside.retailers` r
  JOIN `GoOutside.daily_sales` ds USING (`Retailer code`)
  GROUP BY r.Type, r.`Country`, r.`Retailer code`
  )
  
SELECT
  Type,
  `Country`,
  `Retailer_Code`,
  `Retailer_Revenue`,
  ROUND(`Retailer_Revenue` / SUM(`Retailer_Revenue`) OVER (PARTITION BY Country) * 100, 2) AS `Retailer_Market`
FROM retailer_market;
