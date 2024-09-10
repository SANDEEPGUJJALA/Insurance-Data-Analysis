#Customer Demographics Analysis:


#How many male versus female customers are there in the dataset? Which gender is more likely to have a policy?sql
SELECT Gender, COUNT(*) AS NumberOfCustomers
FROM InsuranceDataset
GROUP BY Gender;

#What is the distribution of customers by age group? Which age group has the highest number of customers?
SELECT
    CASE
        WHEN Age < 20 THEN 'Under 20'
        WHEN Age BETWEEN 20 AND 29 THEN '20-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS AgeGroup,
    COUNT(*) AS NumberOfCustomers
FROM InsuranceDataset
GROUP BY AgeGroup;


#Policy and Insurance Insights:

#How many customers have previously been insured?
SELECT COUNT(*) AS PreviouslyInsured
FROM InsuranceDataset
WHERE Previously_Insured = 1;


#What percentage of customers who have not been previously insured own a vehicle with previous damage?
SELECT 
    COUNT(*) AS UninsuredWithDamage,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM InsuranceDataset WHERE Previously_Insured = 0) AS Percentage
FROM InsuranceDataset
WHERE Previously_Insured = 0 AND Vehicle_Damage = 'Yes';

#Vehicle Age and Insurance Analysis:

#What is the distribution of customers based on vehicle age?
SELECT Vehicle_Age, COUNT(*) AS NumberOfCustomers
FROM InsuranceDataset
GROUP BY Vehicle_Age;

#How does vehicle age impact the likelihood of having previous damage?
SELECT Vehicle_Age, 
    COUNT(*) AS NumberOfVehiclesWithDamage,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM InsuranceDataset WHERE Vehicle_Age = ID.Vehicle_Age) AS DamagePercentage
FROM InsuranceDataset AS ID
WHERE Vehicle_Damage = 'Yes'
GROUP BY Vehicle_Age;


#Sales Channel Performance:

#Which sales channels are most effective in terms of the number of policies sold?
SELECT Policy_Sales_Channel, COUNT(*) AS PoliciesSold
FROM InsuranceDataset
GROUP BY Policy_Sales_Channel
ORDER BY PoliciesSold DESC;

#What is the average annual premium across different sales channels?
SELECT Policy_Sales_Channel, AVG(Annual_Premium) AS AveragePremium
FROM InsuranceDataset
GROUP BY Policy_Sales_Channel;
#

#Customer Engagement and Response:
#What percentage of customers responded positively (i.e., agreed to the callback for insurance)?
SELECT 
    COUNT(*) AS PositiveResponses,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM InsuranceDataset) AS ResponseRatePercentage
FROM InsuranceDataset
WHERE Response = 1;


#Is there a correlation between customer age and positive response rates?
SELECT 
    CASE
        WHEN Age < 20 THEN 'Under 20'
        WHEN Age BETWEEN 20 AND 29 THEN '20-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS AgeGroup,
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN Response = 1 THEN 1 ELSE 0 END) AS PositiveResponses,
    SUM(CASE WHEN Response = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS PositiveResponseRate
FROM InsuranceDataset
GROUP BY AgeGroup;


#Premium and Coverage Insights:

#What is the average annual premium paid by customers across different age groups?
SELECT 
    CASE
        WHEN Age < 20 THEN 'Under 20'
        WHEN Age BETWEEN 20 AND 29 THEN '20-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS AgeGroup,
    AVG(Annual_Premium) AS AveragePremium
FROM InsuranceDataset
GROUP BY AgeGroup;

#How does the annual premium vary for customers with and without previous insurance?
SELECT 
    Previously_Insured,
    AVG(Annual_Premium) AS AveragePremium
FROM InsuranceDataset
GROUP BY Previously_Insured;

## Conclusion
    
These SQL queries are designed to extract key insights from the insurance dataset, covering customer demographics, policy performance, vehicle characteristics, and sales channel effectiveness.
By executing these queries, you can gain valuable information to understand customer behavior, optimize marketing strategies, improve sales channel efficiency, and enhance customer engagement in the insurance industry.
