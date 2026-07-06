Query 1: Total Transaction Amount

Business Purpose: Calculate the total value of all credit card transactions to understand the overall business volume.

SELECT
    SUM(Amount) AS Total_Transaction_Amount
FROM CreditCardTransactions;

Query 2: Average Transaction Amount

Business Purpose : Determine the average amount spent per transaction.

SELECT
    AVG(Amount) AS Average_Transaction_Amount
FROM CreditCardTransactions;

Query 3: Highest Transaction Amount

Business Purpose: Identify the largest transaction recorded.

SELECT
    MAX(Amount) AS Highest_Transaction
FROM CreditCardTransactions;

Query 4: Lowest Transaction Amount

Business Purpose: Identify the smallest transaction amount.

SELECT
    MIN(Amount) AS Lowest_Transaction
FROM CreditCardTransactions;

Query 5: Total Number of Cities

Business Purpose: Find the number of unique cities where transactions occurred.

SELECT
    COUNT(DISTINCT City) AS Total_Cities
FROM CreditCardTransactions;

Query 6: Total Card Types

Business Purpose: Find the different card types available.

SELECT
    COUNT(DISTINCT CardType) AS Total_Card_Types
FROM CreditCardTransactions;

Query 7: Total Expense Types

Business Purpose:Find the different spending categories.

SELECT
    COUNT(DISTINCT ExpenseType) AS Total_Expense_Types
FROM CreditCardTransactions;

Query 8: Gender Distribution

Business Purpose: Understand how many transactions were made by each gender.

SELECT
    Gender,
    COUNT(*) AS Total_Transactions
FROM CreditCardTransactions
GROUP BY Gender;