/*===========================================================
                    LOAN APPROVAL ANALYSIS
=============================================================

Project  : Loan Approval Analysis
Author   : Pranav Sagar
Database : LoanApprovalDB

Description:
This project analyzes 52,000 loan applications using SQL
Server. The objective is to answer business questions and
generate insights that will later be visualized in Power BI.
===========================================================*/
/*-----------------------------------------------------------
QUERY 1

Business Question:
How many loan applications are present in the dataset?

Objective:
Find the total number of records in the loan dataset.

SQL Concepts Used:
• SELECT
• COUNT()

Expected Output:
Total number of applications.

Business Insight:
Shows the size of the dataset before analysis.

-----------------------------------------------------------*/

USE LoanApprovalDB;
GO

SELECT COUNT(*) AS Total_Applications
FROM dbo.clean_loan_data;


/*-----------------------------------------------------------
QUERY 2

Business Question:
Can we verify that the data has been imported correctly?

Objective:
Display the first 10 rows of the dataset.

SQL Concepts Used:
• SELECT
• TOP

Expected Output:
First 10 records of the table.

Business Insight:
Helps verify that the data was imported successfully and the
columns contain the expected values.

-----------------------------------------------------------*/

SELECT TOP 10 *
FROM dbo.clean_loan_data;

/*-----------------------------------------------------------
QUERY 3

Business Question:
How many loan applications were approved and rejected?

Objective:
Count the number of approved and rejected loan applications.

SQL Concepts Used:
• SELECT
• COUNT()
• GROUP BY

Expected Output:
Loan_Approval_Status = 0 → Rejected Loans
Loan_Approval_Status = 1 → Approved Loans

Business Insight:
This helps understand the overall approval distribution of the
bank.

-----------------------------------------------------------*/

SELECT
    Loan_Approval_Status,
    COUNT(*) AS Total_Applicants
FROM dbo.clean_loan_data
GROUP BY Loan_Approval_Status;


/*-----------------------------------------------------------
QUERY 4

Business Question:
How many loan applications were approved?

Objective:
Find the total number of approved loan applications.

SQL Concepts Used:
• SELECT
• WHERE
• COUNT()

Expected Output:
Total approved loan applications.

Business Insight:
Shows the total successful approvals in the dataset.

-----------------------------------------------------------*/

SELECT COUNT(*) AS Approved_Loans
FROM dbo.clean_loan_data
WHERE Loan_Approval_Status = 1;

/*-----------------------------------------------------------
QUERY 5

Business Question:
What is the average annual income of all applicants?

Objective:
Calculate the average annual income.

SQL Concepts Used:
• SELECT
• AVG()
• CAST()

Expected Output:
Average annual income.

Business Insight:
Helps understand the income profile of loan applicants.

-----------------------------------------------------------*/

SELECT
AVG(CAST(Annual_Income AS DECIMAL(18,2))) AS Average_Income
FROM dbo.clean_loan_data;

/*-----------------------------------------------------------
QUERY 6

Business Question:
Does annual income influence loan approval?

Objective:
Compare the average annual income of approved and rejected
applicants.

SQL Concepts Used:
• AVG()
• GROUP BY
• CAST()

Expected Output:
Average income for approved and rejected applicants.

Business Insight:
Helps determine whether income is associated with loan
approval.

-----------------------------------------------------------*/

SELECT
    Loan_Approval_Status,
    AVG(CAST(Annual_Income AS DECIMAL(18,2))) AS Average_Income
FROM dbo.clean_loan_data
GROUP BY Loan_Approval_Status;

/*-----------------------------------------------------------
QUERY 7

Business Question:
Do applicants with higher credit scores have a higher chance
of loan approval?

Objective:
Compare the average credit score of approved and rejected
applicants.

SQL Concepts Used:
• SELECT
• AVG()
• GROUP BY
• CAST()

Expected Output:
Average credit score for approved and rejected applicants.

Business Insight:
Helps determine whether credit score influences loan approval.

-----------------------------------------------------------*/

SELECT
    Loan_Approval_Status,
    AVG(CAST(Credit_Score AS DECIMAL(10,2))) AS Average_Credit_Score
FROM dbo.clean_loan_data
GROUP BY Loan_Approval_Status;

/*-----------------------------------------------------------
QUERY 8

Business Question:
Which loan purpose receives the highest number of applications?

Objective:
Count applications for each loan purpose.

SQL Concepts Used:
• COUNT()
• GROUP BY
• ORDER BY

Expected Output:
Loan purposes ranked from highest to lowest applications.

Business Insight:
Identifies the most common reason customers apply for loans.

-----------------------------------------------------------*/

SELECT
    Loan_Purpose,
    COUNT(*) AS Total_Applications
FROM dbo.clean_loan_data
GROUP BY Loan_Purpose
ORDER BY Total_Applications DESC;

/*-----------------------------------------------------------
QUERY 9

Business Question:
Which education level has the highest loan approval rate?

Objective:
Compare approval rates across education levels.

SQL Concepts Used:
• COUNT()
• SUM()
• CAST()
• GROUP BY
• ORDER BY
• ROUND()

Expected Output:
Approval percentage for each education category.

Business Insight:
Shows whether education level is associated with loan approval.

-----------------------------------------------------------*/

SELECT
    Education,
    COUNT(*) AS Total_Applicants,
    SUM(CAST(Loan_Approval_Status AS INT)) AS Approved_Applicants,
    ROUND(
        SUM(CAST(Loan_Approval_Status AS FLOAT)) * 100.0 / COUNT(*),
        2
    ) AS Approval_Percentage
FROM dbo.clean_loan_data
GROUP BY Education
ORDER BY Approval_Percentage DESC;

/*-----------------------------------------------------------
QUERY 10

Business Question:
Which occupation has the highest loan approval rate?

Objective:
Compare loan approval rates across different occupations.

SQL Concepts Used:
• COUNT()
• SUM()
• CAST()
• GROUP BY
• ORDER BY
• ROUND()

Expected Output:
Approval percentage for each occupation.

Business Insight:
Identifies occupations that are more likely to receive loan
approval.

-----------------------------------------------------------*/

SELECT
    Occupation_Type,
    COUNT(*) AS Total_Applicants,
    SUM(CAST(Loan_Approval_Status AS INT)) AS Approved_Applicants,
    ROUND(
        SUM(CAST(Loan_Approval_Status AS FLOAT)) * 100.0 / COUNT(*),
        2
    ) AS Approval_Rate
FROM dbo.clean_loan_data
GROUP BY Occupation_Type
ORDER BY Approval_Rate DESC;

/*-----------------------------------------------------------
QUERY 11

Business Question:
Which education category has the highest average annual income?

Objective:
Compare average income across education levels.

SQL Concepts Used:
• AVG()
• CAST()
• GROUP BY
• ORDER BY

Expected Output:
Average annual income for each education category.

Business Insight:
Shows whether education is associated with higher income.

-----------------------------------------------------------*/

SELECT
    Education,
    AVG(CAST(Annual_Income AS DECIMAL(18,2))) AS Average_Income
FROM dbo.clean_loan_data
GROUP BY Education
ORDER BY Average_Income DESC;

/*-----------------------------------------------------------
QUERY 12

Business Question:
Which education category has the highest average credit score?

Objective:
Compare average credit scores across education levels.

SQL Concepts Used:
• AVG()
• CAST()
• GROUP BY
• ORDER BY

Expected Output:
Average credit score by education.

Business Insight:
Determines whether education level is associated with better
credit scores.

-----------------------------------------------------------*/

SELECT
    Education,
    AVG(CAST(Credit_Score AS DECIMAL(10,2))) AS Average_Credit_Score
FROM dbo.clean_loan_data
GROUP BY Education
ORDER BY Average_Credit_Score DESC;

/*-----------------------------------------------------------
QUERY 13

Business Question:
Which loan purpose has the highest average requested loan
amount?

Objective:
Compare average requested loan amounts across loan purposes.

SQL Concepts Used:
• AVG()
• CAST()
• GROUP BY
• ORDER BY

Expected Output:
Average loan amount by purpose.

Business Insight:
Shows which loan category generally requires the highest
funding.

-----------------------------------------------------------*/

SELECT
    Loan_Purpose,
    AVG(CAST(Loan_Amount_Requested AS DECIMAL(18,2)))
        AS Average_Loan_Amount
FROM dbo.clean_loan_data
GROUP BY Loan_Purpose
ORDER BY Average_Loan_Amount DESC;

/*-----------------------------------------------------------
QUERY 14

Business Question:
Who are the top 10 applicants with the highest annual income?

Objective:
Identify the highest income applicants.

SQL Concepts Used:
• TOP
• ORDER BY DESC

Expected Output:
Top 10 applicants by annual income.

Business Insight:
Identifies the highest earning customers.

-----------------------------------------------------------*/

SELECT TOP 10
    Applicant_ID,
    Annual_Income,
    Occupation_Type,
    Education
FROM dbo.clean_loan_data
ORDER BY Annual_Income DESC;

/*-----------------------------------------------------------
QUERY 15

Business Question:
Which occupation requests the highest average loan amount?

Objective:
Compare average requested loan amounts across occupations.

SQL Concepts Used:
• AVG()
• GROUP BY
• ORDER BY

-----------------------------------------------------------*/

SELECT
    Occupation_Type,
    AVG(CAST(Loan_Amount_Requested AS DECIMAL(18,2)))
        AS Average_Loan_Amount
FROM dbo.clean_loan_data
GROUP BY Occupation_Type
ORDER BY Average_Loan_Amount DESC;

/*-----------------------------------------------------------
QUERY 16

Business Question:
Which loan type has the highest average interest rate?

Objective:
Compare interest rates across loan types.

SQL Concepts Used:
• AVG()
• GROUP BY
• ORDER BY

-----------------------------------------------------------*/

SELECT
    Loan_Type,
    AVG(Interest_Rate) AS Average_Interest_Rate
FROM dbo.clean_loan_data
GROUP BY Loan_Type
ORDER BY Average_Interest_Rate DESC;

/*-----------------------------------------------------------
QUERY 17

Business Question:
How many applicants have a credit score above 750?

Objective:
Find applicants with excellent credit scores.

SQL Concepts Used:
• WHERE
• COUNT()

-----------------------------------------------------------*/

SELECT
    COUNT(*) AS Excellent_Credit_Applicants
FROM dbo.clean_loan_data
WHERE Credit_Score > 750;

/*-----------------------------------------------------------
QUERY 18

Business Question:
How many applicants have more than two dependents?

Objective:
Count applicants with larger families.

SQL Concepts Used:
• WHERE
• COUNT()

-----------------------------------------------------------*/

SELECT
    COUNT(*) AS Applicants_With_More_Than_Two_Dependents
FROM dbo.clean_loan_data
WHERE Dependents > 2;


/*---- KPI ANALYSIS FOR POWER BI DASHBOARD ------
-----------------------------------------------*/
/*-----------------------------------------------------------
QUERY 19

KPI:
Total Loan Applications

Business Question:
How many loan applications were received?

-----------------------------------------------------------*/

SELECT COUNT(*) AS Total_Applications
FROM dbo.clean_loan_data;

/*-----------------------------------------------------------
QUERY 20

KPI:
Approved Loan Applications

Business Question:
How many loans were approved?

-----------------------------------------------------------*/

SELECT COUNT(*) AS Approved_Loans
FROM dbo.clean_loan_data
WHERE Loan_Approval_Status = 1;

/*-----------------------------------------------------------
QUERY 21

KPI:
Rejected Loan Applications

Business Question:
How many loans were rejected?

-----------------------------------------------------------*/

SELECT COUNT(*) AS Rejected_Loans
FROM dbo.clean_loan_data
WHERE Loan_Approval_Status = 0;

/*-----------------------------------------------------------
QUERY 22

KPI:
Loan Approval Rate

Business Question:
What percentage of loan applications were approved?

-----------------------------------------------------------*/

SELECT
ROUND(
COUNT(CASE WHEN Loan_Approval_Status = 1 THEN 1 END)
*100.0/COUNT(*),2)
AS Approval_Rate
FROM dbo.clean_loan_data;

/*-----------------------------------------------------------
QUERY 23

KPI:
Average Credit Score

Business Question:
What is the average credit score of all applicants?

-----------------------------------------------------------*/

SELECT
AVG(CAST(Credit_Score AS DECIMAL(10,2)))
AS Average_Credit_Score
FROM dbo.clean_loan_data;


/*-----------------------------------------------------------
QUERY 24

Business Question:
What is the gender distribution of loan applicants?

Objective:
Find the number of male and female applicants.

SQL Concepts Used:
• COUNT()
• GROUP BY
• ORDER BY

Expected Output:
Total applicants by gender.

Business Insight:
Helps understand the customer demographics.

-----------------------------------------------------------*/

SELECT
    Gender,
    COUNT(*) AS Total_Applicants
FROM dbo.clean_loan_data
GROUP BY Gender
ORDER BY Total_Applicants DESC;

/*-----------------------------------------------------------
QUERY 25

Business Question:
What is the marital status distribution of applicants?

Objective:
Count married and unmarried applicants.

SQL Concepts Used:
• COUNT()
• GROUP BY

-----------------------------------------------------------*/

SELECT
    Marital_Status,
    COUNT(*) AS Total_Applicants
FROM dbo.clean_loan_data
GROUP BY Marital_Status;

/*-----------------------------------------------------------
QUERY 26

Business Question:
How many applicants are employed, self-employed and unemployed?

Objective:
Analyze employment status.

SQL Concepts Used:
• COUNT()
• GROUP BY

-----------------------------------------------------------*/

SELECT
    Employment_Status,
    COUNT(*) AS Total_Applicants
FROM dbo.clean_loan_data
GROUP BY Employment_Status
ORDER BY Total_Applicants DESC;

/*-----------------------------------------------------------
QUERY 27

Business Question:
What is the residential status of applicants?

Objective:
Find whether applicants own or rent their residence.

SQL Concepts Used:
• COUNT()
• GROUP BY

-----------------------------------------------------------*/

SELECT
    Residential_Status,
    COUNT(*) AS Total_Applicants
FROM dbo.clean_loan_data
GROUP BY Residential_Status;

/*-----------------------------------------------------------
QUERY 28

Business Question:
Which loan type is the most popular?

Objective:
Count applications for each loan type.

SQL Concepts Used:
• COUNT()
• GROUP BY
• ORDER BY

-----------------------------------------------------------*/

SELECT
    Loan_Type,
    COUNT(*) AS Total_Applications
FROM dbo.clean_loan_data
GROUP BY Loan_Type
ORDER BY Total_Applications DESC;


/*-----------------------------------------------------------
QUERY 29

Business Question:
Which education categories have more than 10,000 applicants?

Concepts Used:
GROUP BY
HAVING

-----------------------------------------------------------*/

SELECT
    Education,
    COUNT(*) AS Total_Applicants
FROM dbo.clean_loan_data
GROUP BY Education
HAVING COUNT(*) > 10000;

/*-----------------------------------------------------------
QUERY 30

Business Question:
Which different loan purposes exist in the dataset?

Concepts Used:
DISTINCT

-----------------------------------------------------------*/

SELECT DISTINCT Loan_Purpose
FROM dbo.clean_loan_data;

/*-----------------------------------------------------------
QUERY 31

Business Question:
What are the minimum and maximum annual incomes?

Concepts Used:
MIN()
MAX()

-----------------------------------------------------------*/

SELECT
MIN(Annual_Income) AS Minimum_Income,
MAX(Annual_Income) AS Maximum_Income
FROM dbo.clean_loan_data;

/*-----------------------------------------------------------
QUERY 32

Business Question:
Classify applicants based on credit score.

Concepts Used:
CASE

-----------------------------------------------------------*/

SELECT
Applicant_ID,
Credit_Score,

CASE

WHEN Credit_Score >=750 THEN 'Excellent'

WHEN Credit_Score >=650 THEN 'Good'

ELSE 'Needs Improvement'

END AS Credit_Category

FROM dbo.clean_loan_data;