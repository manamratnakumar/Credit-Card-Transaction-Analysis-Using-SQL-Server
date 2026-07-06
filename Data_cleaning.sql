Query 1: Check Total Records

Business Purpose: Verify that all records have been imported successfully before starting the analysis.

SELECT COUNT(*) AS Total_Records
FROM CreditCardTransactions;

Query 2: Check for NULL Values

Business Purpose: Missing values can affect business reports and lead to inaccurate insights. 

SELECT
    SUM(CASE WHEN TransactionID IS NULL THEN 1 ELSE 0 END) AS Null_TransactionID,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS Null_City,
    SUM(CASE WHEN TransactionDate IS NULL THEN 1 ELSE 0 END) AS Null_TransactionDate,
    SUM(CASE WHEN CardType IS NULL THEN 1 ELSE 0 END) AS Null_CardType,
    SUM(CASE WHEN ExpenseType IS NULL THEN 1 ELSE 0 END) AS Null_ExpenseType,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Null_Gender,
    SUM(CASE WHEN Amount IS NULL THEN 1 ELSE 0 END) AS Null_Amount
FROM CreditCardTransactions;

Query 3: Check Duplicate Transaction IDs

Business Purpose:Every transaction should have a unique Transaction ID. Duplicate IDs may indicate duplicate imports or data quality issues.

SELECT
    TransactionID,
    COUNT(*) AS Duplicate_Count
FROM CreditCardTransactions
GROUP BY TransactionID
HAVING COUNT(*) > 1;

Query 4: Check Invalid Transaction Amounts

Business Purpose:Transaction amounts should always be greater than zero. Zero or negative amounts may indicate incorrect data.

SELECT *
FROM CreditCardTransactions
WHERE Amount <= 0;

Query 5: Check Blank City Names

Business Purpose: Blank city names can affect city-wise analysis and reporting. This query identifies records where City contains empty spaces.

SELECT *
FROM CreditCardTransactions
WHERE LTRIM(RTRIM(City)) = '';

Query 6: Check Future Transaction Dates

Business Purpose:Transaction dates should not be in the future. Future dates may indicate data entry or system errors.

SELECT *
FROM CreditCardTransactions
WHERE TransactionDate > CAST(GETDATE() AS DATE);


