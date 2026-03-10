CREATE DATABASE trader_project;
USE trader_project;
-- top_10_traders_by_net_pnl.csv
SELECT tr.name, tr.trader_id, SUM(account_balance) AS total_balance, ROUND (sum(
                      CASE 
                            WHEN (t.trade_type)= "SELL" THEN (t.quantity*t.price)
							WHEN (t.trade_type) = "BUY" THEN -(t.quantity * t.price)
							ELSE 0
		               END ),2 ) AS net_pnl
 FROM traders tr
 INNER JOIN trades t
 ON tr.trader_id = t.trader_id 
 GROUP BY tr.trader_id , tr.name 
 ORDER BY net_pnl  DESC
 LIMIT 10;
 
 -- best_performing_month_by_net profit 
  SELECT
  YEAR (trade_date) AS year,
  MONTH(trade_date) AS month,
  ROUND(SUM(
       CASE 
           WHEN trade_type = 'SELL' THEN (quantity * price )
           WHEN trade_type = 'BUY' THEN -(quantity * price) 
           ELSE 0 
		END ),2) AS net_profit 
FROM trades 
GROUP BY year,month
ORDER BY net_profit DESC
LIMIT 10;

-- top_month_by total_trades
 SELECT 
       YEAR(trade_date) AS year,
       MONTH (trade_date) AS month,
       COUNT(*) AS total_trades,
	   SUM(
			CASE 
                WHEN trade_type = 'SELL' THEN (quantity * price )
                WHEN trade_type = 'BUY' THEN -(quantity * price)
                ELSE 0 
                END) AS net_profit 
FROM trades 
GROUP BY  YEAR(trade_date),MONTH (trade_date)
ORDER BY  total_trades DESC 
LIMIT 10;

-- total_net_profit
SELECT COUNT(*) AS total_trader,
      ROUND(SUM(
			CASE 
                WHEN trade_type = 'SELL' THEN (quantity * price )
                WHEN trade_type = 'BUY' THEN -(quantity * price )
                ELSE 0 
			END),2) AS total_net_profit
FROM  trades;

 -- total_SELL_value 
 SELECT ROUND(SUM(quantity* price), 2) 
 FROM trades
 WHERE trade_type = 'SELL';
 
 -- total_BUY_value  
 SELECT SUM(quantity * price)
 FROM trades
 WHERE trade_type = 'BUY';

 