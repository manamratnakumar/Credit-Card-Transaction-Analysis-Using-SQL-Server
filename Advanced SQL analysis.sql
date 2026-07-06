Query 1: Rank Cities by Total Transaction Amount

Business Purpose: Rank cities based on total transaction amount to identify the best-performing markets.

SELECT
    City,
    SUM(Amount) AS Total_Amount,
    RANK() OVER(ORDER BY SUM(Amount) DESC) AS City_Rank
FROM CreditCardTransactions
GROUP BY City;

Query 2: Running Total of Transactions

Business Purpose: Track cumulative transaction amount over time.

SELECT
    TransactionDate,
    Amount,
    SUM(Amount) OVER(
        ORDER BY TransactionDate
    ) AS Running_Total
FROM CreditCardTransactions;

Query 3: Previous Transaction Amount 

Business Purpose: Compare the current transaction with the previous one.

SELECT
    TransactionDate,
    Amount,
    LAG(Amount) OVER(
        ORDER BY TransactionDate
    ) AS Previous_Transaction
FROM CreditCardTransactions;

Query 4: Top Transaction in Each City

Business Purpose: Identify the highest transaction for every city.

WITH CityTransactions AS
(
    SELECT
        City,
        TransactionID,
        Amount,
        ROW_NUMBER() OVER
        (
            PARTITION BY City
            ORDER BY Amount DESC
        ) AS Row_Num
    FROM CreditCardTransactions
)

SELECT *
FROM CityTransactions
WHERE Row_Num = 1;

Query 5: Classify Transactions Using CASE


Business Purpose: Categorize transactions into Low, Medium, and High value.

SELECT
    TransactionID,
    Amount,
    CASE
        WHEN Amount < 1000 THEN 'Low'
        WHEN Amount BETWEEN 1000 AND 5000 THEN 'Medium'
        ELSE 'High'
    END AS Transaction_Category
FROM CreditCardTransactions;

Query 6: Top Spending Cities Using CTE

Business Purpose: Find cities with transaction amounts greater than the overall average.

WITH CitySpending AS
(
    SELECT
        City,
        SUM(Amount) AS Total_Spending
    FROM CreditCardTransactions
    GROUP BY City
)

SELECT *
FROM CitySpending
WHERE Total_Spending >
(
    SELECT AVG(Total_Spending)
    FROM CitySpending
);

Query 7: Percentage Contribution by Card Type

Business Purpose: Determine how much each card type contributes to total spending.

SELECT
    CardType,
    SUM(Amount) AS Total_Amount,
    ROUND(
        SUM(Amount) * 100.0 /
        (SELECT SUM(Amount)
         FROM CreditCardTransactions),2
    ) AS Contribution_Percentage
FROM CreditCardTransactions
GROUP BY CardType
ORDER BY Contribution_Percentage DESC;

Query 8: Dense Rank Expense Categories

Business Purpose: Rank expense categories without skipping rank numbers.

SELECT
    ExpenseType,
    SUM(Amount) AS Total_Amount,
    DENSE_RANK() OVER
    (
        ORDER BY SUM(Amount) DESC
    ) AS Expense_Rank
FROM CreditCardTransactions
GROUP BY ExpenseType;