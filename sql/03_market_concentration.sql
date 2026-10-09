-- Retailers in Market
WITH retailer_sales AS (
  SELECT
    r.Country,
    r.`Retailer code` AS Retailer_Code,
    r.`Retailer name` AS Retailer_Name,
    ROUND(SUM(ds.Quantity * ds.`Unit sale price`), 2) AS `Total_Revenue`
  FROM `GoOutside.retailers` r
  JOIN `GoOutside.daily_sales`ds USING(`Retailer code`)
  GROUP BY r.Country, r.`Retailer code`, r.`Retailer name`
),

ranked_retailer_sales AS (
  SELECT
    *,
    ROW_NUMBER() OVER(PARTITION BY Country ORDER BY `Total_Revenue` DESC) AS `Retailer_Rank`
  FROM retailer_sales
)

SELECT
  Country,
  Retailer_Code,
  Retailer_Name,
  Total_Revenue,
  Retailer_Rank
FROM ranked_retailer_sales
WHERE `Retailer_Rank` <= 5
ORDER BY Country, `Retailer_Rank`;