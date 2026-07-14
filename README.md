SQL CASE ANALYSIS:

Query 1: Which City Contributes the Highest Percentage of Total Transaction Amount?


Business Purpose: Management wants to identify the city contribution to the total revenue for strategic planning and resource allocation.

SELECT
    City,
    SUM(Amount) AS Total_Amount,
    ROUND(
        SUM(Amount) * 100.0 /
        (SELECT SUM(Amount)
         FROM CreditCardTransactions),2
    ) AS Contribution_Percentage
FROM CreditCardTransactions
GROUP BY City
ORDER BY Contribution_Percentage DESC;

Query 2: Which Expense Category Shows the Highest Monthly Growth?


Business Purpose: Identify expense categories with increasing customer spending.

WITH MonthlyExpense AS
(
    SELECT
        ExpenseType,
        YEAR(TransactionDate) AS SalesYear,
        MONTH(TransactionDate) AS SalesMonth,
        SUM(Amount) AS MonthlyAmount
    FROM CreditCardTransactions
    GROUP BY
        ExpenseType,
        YEAR(TransactionDate),
        MONTH(TransactionDate)
)

SELECT
    ExpenseType,
    SalesYear,
    SalesMonth,
	MonthlyAmount,
    LAG(MonthlyAmount) OVER
    (
        PARTITION BY ExpenseType
        ORDER BY SalesYear, SalesMonth
    ) AS PreviousMonthAmount,
    MonthlyAmount -
    LAG(MonthlyAmount) OVER
    (
        PARTITION BY ExpenseType
        ORDER BY SalesYear, SalesMonth
    ) AS Growth
FROM MonthlyExpense
ORDER BY ExpenseType, SalesYear, SalesMonth;

Query 3: Which Card Type Performs Best in Each City?\


Business Purpose: Understand customer preferences for card types in different cities.

WITH CardPerformance AS
(
    SELECT
        City,
        CardType,
        SUM(Amount) AS TotalAmount,
        ROW_NUMBER() OVER
        (
            PARTITION BY City
            ORDER BY SUM(Amount) DESC
        ) AS RN
    FROM CreditCardTransactions
    GROUP BY City, CardType
)

SELECT
    City,
    CardType,
    TotalAmount
FROM CardPerformance
WHERE RN = 1
ORDER BY City;

Query 4: Which Month Recorded the Highest Transaction Growth?


Business Purpose: Determine the months with the strongest increase in transaction value.

WITH MonthlySales AS
(
    SELECT
        YEAR(TransactionDate) AS SalesYear,
        MONTH(TransactionDate) AS SalesMonth,
        SUM(Amount) AS MonthlyAmount
    FROM CreditCardTransactions
    GROUP BY
        YEAR(TransactionDate),
        MONTH(TransactionDate)
)

SELECT
    SalesYear,
    SalesMonth,
    MonthlyAmount,
    LAG(MonthlyAmount) OVER
    (
        ORDER BY SalesYear, SalesMonth
		) AS PreviousMonthAmount,
    MonthlyAmount -
    LAG(MonthlyAmount) OVER
    (
        ORDER BY SalesYear, SalesMonth
    ) AS MonthlyGrowth
FROM MonthlySales
ORDER BY SalesYear, SalesMonth;

Query 5: Which Cities Consistently Rank in the Top 3 by Spending?


Business Purpose: Identify cities with consistently high transaction values.

SELECT TOP 3
    City,
    SUM(Amount) AS TotalAmount
FROM CreditCardTransactions
GROUP BY City
ORDER BY TotalAmount DESC;
