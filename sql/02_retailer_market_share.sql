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