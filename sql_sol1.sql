WITH daily_totals AS (
  SELECT
    DATE_TRUNC('day', transaction_time) AS transaction_day,
    SUM(transaction_amount) AS daily_total
  FROM transactions
  WHERE DATE_TRUNC('month', transaction_time) = '2021-01-01'
  GROUP BY 1
), 
rolling_avg AS (
  SELECT
    transaction_day,
    AVG(daily_total) OVER (ORDER BY transaction_day ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_average
  FROM daily_totals
)
SELECT * FROM rolling_avg;
