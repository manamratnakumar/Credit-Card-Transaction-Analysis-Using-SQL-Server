
Business Insights

Executive Summary:

This project analyzes credit card transaction data to understand customer spending behavior, identify high-performing markets, evaluate card performance, and uncover revenue-driving patterns. Using SQL Server, business-focused queries were developed to generate actionable insights that can help improve customer engagement, marketing strategies, and business growth.

Top Performing City
Finding:

Greater Mumbai, India generated the highest transaction amount of 576,751,476, making it the highest revenue-generating city in the dataset.

Business Impact:

Greater Mumbai is the bank's strongest market with the highest customer spending and transaction activity.

Recommendation:

Increase marketing investments in Greater Mumbai. Launch premium credit card campaigns. Strengthen customer loyalty programs.

Best Performing Card Type
Finding:

The Silver Card generated the highest transaction amount of 1,069,613,713, outperforming all other card types.

Business Impact:

Silver Cards are the most widely used and contribute significantly to the bank's transaction revenue.

Recommendation:

Promote Silver Cards to new customers. Offer loyalty rewards to retain existing cardholders. Analyze customer preferences to improve other card products.

Highest Spending Expense Category
Finding:

The Bills category recorded the highest transaction amount of 907,072,473.

Business Impact:

Customers frequently use credit cards for recurring bill payments, making this an important revenue source.

Recommendation:

Introduce cashback offers for bill payments. Partner with utility providers. Promote automatic bill payment services.

Gender-wise Spending Analysis
Finding:

Female customers generated a total transaction amount of 220,531,130 with an average transaction value of 161,206, exceeding male customers.

Business Impact:

Female customers represent a valuable customer segment with higher spending behavior.

Recommendation:

Launch personalized offers for female customers. Introduce shopping and lifestyle rewards. Improve customer retention programs.

Monthly Spending Trend
Finding:

Monthly spending fluctuates throughout the year. Among the displayed results, August 2014 recorded the highest monthly transaction amount of 218,453,126.

Business Impact:

Seasonal spending trends help forecast customer demand and transaction volumes.

Recommendation:

Launch promotional campaigns before peak spending months. Increase cashback and rewards during high-demand periods. Plan infrastructure to handle peak transaction loads.

Top 5 Performing Cities
Finding:

The top five cities by transaction amount are:

Greater Mumbai
Bengaluru
Ahmedabad
Delhi
Kolkata
Business Impact:

These metropolitan cities contribute a significant share of the bank's total revenue.

Recommendation:

Expand premium banking services. Increase regional marketing campaigns. Build partnerships with local merchants.

Average Transaction Amount by City
Finding:

Thodupuzha recorded the highest average transaction value of 296,684.

Business Impact:

Although transaction volume may be lower, customers in this city make high-value purchases.

Recommendation:

Promote premium credit cards. Offer exclusive banking benefits. Identify and retain high-value customers.

City-wise Revenue Contribution
Finding:

Greater Mumbai contributed 14.15% of the total transaction revenue, followed by Bengaluru (14.05%), Ahmedabad (13.93%), and Delhi (13.67%).

Together, these four cities contributed more than 55% of the total transaction revenue.

Business Impact:

The bank's revenue is concentrated in a few metropolitan cities, making them strategically important markets.

Recommendation:

Focus marketing efforts on top-performing cities. Expand premium banking services. Increase merchant partnerships. Develop growth strategies for lower-performing cities.

Overall Business Recommendations:

Focus marketing campaigns on high-revenue cities. Promote Silver Cards through targeted customer acquisition. Introduce attractive rewards for bill payments. Strengthen customer loyalty programs. Develop personalized offers based on customer demographics. Utilize seasonal spending trends to optimize promotional campaigns. Expand premium banking services for high-value customers. Continue monitoring customer spending behavior for data-driven business decisions.

Conclusion:

This SQL case study demonstrates how raw transaction data can be transformed into meaningful business insights through data cleaning, exploratory analysis, and advanced SQL querying. The analysis identified key revenue-driving cities, customer segments, card types, and spending categories, providing actionable recommendations that can support strategic decision-making and improve business performance.

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
