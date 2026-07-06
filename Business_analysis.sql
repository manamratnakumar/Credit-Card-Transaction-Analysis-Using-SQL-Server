Query 1: Which city generated the highest transaction amount?

Business Purpose: Management wants to identify the city contributing the highest transaction value to focus marketing and business strategies.

SELECT
    City,
    SUM(Amount) AS Total_Transaction_Amount
FROM CreditCardTransactions
GROUP BY City
ORDER BY Total_Transaction_Amount DESC;

Query 2: Which card type generates the highest transaction amount?

Business Purpose: Understand which card type is most profitable.

SELECT
    CardType,
    SUM(Amount) AS Total_Transaction_Amount
FROM CreditCardTransactions
GROUP BY CardType
ORDER BY Total_Transaction_Amount DESC;

Query 3: Which expense category has the highest spending?

Business Purpose: Identify where customers spend the most.

SELECT
    ExpenseType,
    SUM(Amount) AS Total_Transaction_Amount
FROM CreditCardTransactions
GROUP BY ExpenseType
ORDER BY Total_Transaction_Amount DESC;

Query 4: Gender-wise Spending Analysis

Business Purpose: Compare spending behavior between male and female customers.

SELECT
    Gender,
    SUM(Amount) AS Total_Transaction_Amount,
    AVG(Amount) AS Average_Transaction
FROM CreditCardTransactions
GROUP BY Gender;

Query 5: Monthly Spending Trend

Business Purpose: Analyze spending patterns over time.

SELECT
    YEAR(TransactionDate) AS Year,
    MONTH(TransactionDate) AS Month,
    SUM(Amount) AS Monthly_Spending
FROM CreditCardTransactions
GROUP BY
    YEAR(TransactionDate),
    MONTH(TransactionDate)
ORDER BY
    Year,
    Month;

Query 6: Top 5 Cities by Transaction Amount

Business Purpose: Find the top-performing cities.

SELECT TOP 5
    City,
    SUM(Amount) AS Total_Transaction_Amount
FROM CreditCardTransactions
GROUP BY City
ORDER BY Total_Transaction_Amount DESC;

Query 7: Average Transaction Amount by City

Business Purpose: Understand customer spending behavior across cities.

SELECT
    City,
    AVG(Amount) AS Average_Transaction
FROM CreditCardTransactions
GROUP BY City
ORDER BY Average_Transaction DESC;

Query 8: Most Frequently Used Card Type

Business Purpose: Identify which card type customers use most often.

SELECT
    CardType,
    COUNT(*) AS Total_Transactions
FROM CreditCardTransactions
GROUP BY CardType
ORDER BY Total_Transactions DESC;

Query 9: Highest Spending Month

Business Purpose: Determine the month with the highest spending.

SELECT
    MONTH(TransactionDate) AS Month,
    SUM(Amount) AS Total_Spending
FROM CreditCardTransactions
GROUP BY MONTH(TransactionDate)
ORDER BY Total_Spending DESC;

Query 10: City Contribution to Total Revenue

Business Purpose: Measure each city  contribution to the total transaction amount.

SELECT
    City,
    SUM(Amount) AS Total_Amount,
    ROUND(
        SUM(Amount) * 100.0 /
        (SELECT SUM(Amount) FROM CreditCardTransactions),2
    ) AS Contribution_Percentage
FROM CreditCardTransactions
GROUP BY City
ORDER BY Contribution_Percentage DESC;

Query 11: Top 5 Highest Transactions

Business Purpose: Identify the largest individual transactions.

SELECT TOP 5
    TransactionID,
    City,
    CardType,
    ExpenseType,
    Amount
FROM CreditCardTransactions
ORDER BY Amount DESC;

Query 12: City-wise Transaction Count

Business Purpose: Understand transaction volume across cities.

SELECT
    City,
    COUNT(*) AS Total_Transactions
FROM CreditCardTransactions
GROUP BY City
ORDER BY Total_Transactions DESC;