select * from dbo.financial_loan_New


--applicants
select count(id) as Total_Application from financial_loan_New 

select count(id) as MTD_Total_loan_Application from financial_loan_New
where MONTH(issue_date) = 12 and YEAR(issue_date)=2021

select count(id) as PMTD_Total_loan_Application from financial_loan_New
where MONTH(issue_date) = 11 and YEAR(issue_date)=2021


SELECT
    Month11.Total_Loan_Applications AS Month11_Applications,
    Month12.Total_Loan_Applications AS Month12_Applications,
    FORMAT(((1.0 * Month12.Total_Loan_Applications - Month11.Total_Loan_Applications) / NULLIF(Month11.Total_Loan_Applications, 0)) * 100, 'N2') AS MoM_Change_Percentage
FROM
    (SELECT COUNT(id) AS Total_Loan_Applications FROM financial_loan_New WHERE Issue_Date BETWEEN '2021-11-01' AND '2021-11-30') AS Month11,
    (SELECT COUNT(id) AS Total_Loan_Applications FROM financial_loan_New WHERE Issue_Date BETWEEN '2021-12-01' AND '2021-12-31') AS Month12;

--amount funded
select SUM(loan_amount) as total_funded_amount from financial_loan_New

select SUM(loan_amount) as MTD_total_funded_amount from financial_loan_New
where MONTH(issue_date)=12 and YEAR(issue_date)=2021

select SUM(loan_amount) as PMTD_total_funded_amount from financial_loan_New
where MONTH(issue_date)=11 and YEAR(issue_date)=2021

SELECT
    Month11.total_funded_amount AS Month11_Funded_Amount,
    Month12.total_funded_amount AS Month12_Funded_Amount,
    FORMAT(((1.0 * Month12.total_funded_amount - Month11.total_funded_amount) / NULLIF(Month11.total_funded_amount, 0)) * 100, 'N2') AS MoM_Change_Percentage
FROM
    (SELECT SUM(loan_amount) AS total_funded_amount FROM financial_loan_New WHERE Issue_Date BETWEEN '2021-11-01' AND '2021-11-30') AS Month11,
    (SELECT SUM(loan_amount) AS total_funded_amount FROM financial_loan_New WHERE Issue_Date BETWEEN '2021-12-01' AND '2021-12-31') AS Month12;


--received amount
select SUM(total_payment) as total_received_amount from financial_loan_New

select SUM(total_payment) as MTD_total_received_amount from financial_loan_New
where MONTH(issue_date)=12 and YEAR(issue_date)=2021

select SUM(total_payment) as PMTD_total_received_amount from financial_loan_New
where MONTH(issue_date)=11 and YEAR(issue_date)=2021

SELECT
    Month11.total_received_amount AS Month11_Received_Amount,
    Month12.total_received_amount AS Month12_Received_Amount,
    FORMAT(((1.0 * Month12.total_received_amount - Month11.total_received_amount) / NULLIF(Month11.total_received_amount, 0)) * 100, 'N2') AS MoM_Change_Percentage
FROM
    (SELECT SUM(total_payment) AS total_received_amount FROM financial_loan_New WHERE Issue_Date BETWEEN '2021-11-01' AND '2021-11-30') AS Month11,
    (SELECT SUM(total_payment) AS total_received_amount FROM financial_loan_New WHERE Issue_Date BETWEEN '2021-12-01' AND '2021-12-31') AS Month12;


--interest rate
select ROUND(AVG(int_rate),4)*100 as avg_interest_rate from financial_loan_New

select ROUND(AVG(int_rate),4)*100 as MTD_avg_interest_rate from financial_loan_New
where MONTH(issue_date)=12 and YEAR(issue_date)=2021

select ROUND(AVG(int_rate),4)*100 as PMTD_avg_interest_rate from financial_loan_New
where MONTH(issue_date)=11 and YEAR(issue_date)=2021

SELECT
    Month11.avg_interest_rate AS Month11_Interest_rate,
    Month12.avg_interest_rate AS Month12_Interest_rate,
    FORMAT(((1.0 * Month12.avg_interest_rate - Month11.avg_interest_rate) / NULLIF(Month11.avg_interest_rate, 0)), 'N2') AS MoM_Change
FROM
    (SELECT AVG(int_rate) AS avg_interest_rate FROM financial_loan_New WHERE Issue_Date BETWEEN '2021-11-01' AND '2021-11-30') AS Month11,
    (SELECT AVG(int_rate) AS avg_interest_rate FROM financial_loan_New WHERE Issue_Date BETWEEN '2021-12-01' AND '2021-12-31') AS Month12;

--avg dti

select ROUND(AVG(dti),4) * 100 as Avg_DTI from financial_loan_New

select ROUND(AVG(dti),4) * 100 as MTD_Avg_DTI from financial_loan_New
where MONTH(issue_date)=12 and YEAR(issue_date)=2021

select ROUND(AVG(dti),4) * 100 as PMTD_Avg_DTI from financial_loan_New
where MONTH(issue_date)=11 and YEAR(issue_date)=2021

SELECT
    Month11.avg_dti AS Month11_DTI,
    Month12.avg_dti AS Month12_DTI,
    FORMAT(((1.0 * Month12.avg_dti - Month11.avg_dti) / NULLIF(Month11.avg_dti, 0) * 100), 'N2') AS MoM_Change
FROM
    (SELECT AVG(dti) * 100 AS avg_dti FROM financial_loan_New WHERE Issue_Date BETWEEN '2021-11-01' AND '2021-11-30') AS Month11,
    (SELECT AVG(dti) *100 AS avg_dti FROM financial_loan_New WHERE Issue_Date BETWEEN '2021-12-01' AND '2021-12-31') AS Month12;


--Good loan

select (COUNT(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end) * 100)/count(id) as Good_loan_percentage
from financial_loan_New

select count(id) as Good_loan_Application From financial_loan_New
where loan_status = 'Fully Paid' OR loan_status = 'Current'

select sum(loan_amount) as Good_loan_Funded_amount From financial_loan_New
where loan_status = 'Fully Paid' OR loan_status = 'Current'

select sum(total_payment) as Good_loan_Recieved_amount From financial_loan_New
where loan_status = 'Fully Paid' OR loan_status = 'Current'

--Bad loan

SELECT FORMAT((COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / COUNT(id), 'N2') AS bad_loan_percentage
FROM financial_loan_New;

SELECT COUNT(id) AS bad_loan_Application FROM financial_loan_New
WHERE loan_status = 'Charged Off'

SELECT SUM(loan_amount) AS bad_loan_Amount FROM financial_loan_New
WHERE loan_status = 'Charged Off'

SELECT SUM(total_payment) AS bad_loan_Amount_Recieved FROM financial_loan_New
WHERE loan_status = 'Charged Off'


--Grid View 
Select loan_status,
COUNT(id) AS Total_Loan_Application,
SUM(total_payment) as Total_amount_recieved,
SUM(loan_amount) AS Total_Funded_Amount,
Avg(int_rate * 100) as Interest_Rate,
Avg(dti * 100) as DTI
From financial_loan_New
group by loan_status


select loan_status,
sum(total_payment) as MTD_amount_Received,
sum(loan_amount) as MTD_Funded_Amount
From financial_loan_New
Where MONTH(issue_date)=12
group by loan_status

--Montly trend by issue date
Select 
MONTH(issue_date) AS Month_Number,
DATENAME(MONTH,issue_date) AS Month_Name,
COUNT(id) AS Total_Loan_Application,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM financial_loan_New
Group By MONTH(issue_date),DATENAME(MONTH,issue_date)
Order By MONTH(issue_date)

--Regional Analysis by state
Select 
address_state,
COUNT(id) AS Total_Loan_Application,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM financial_loan_New
Group By address_state
Order By SUM(loan_amount) DESC

--Loan Term Analysis
Select 
term,
COUNT(id) AS Total_Loan_Application,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM financial_loan_New
Group By term
Order By term

--Employee length Analysis
Select 
emp_length,
COUNT(id) AS Total_Loan_Application,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM financial_loan_New
Group By emp_length
Order By emp_length

--Loan Purpose Breakdown
Select 
purpose,
COUNT(id) AS Total_Loan_Application,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM financial_loan_New
Group By purpose
Order By COUNT(id) DESC

--Home Ownership analysis
Select 
home_ownership,
COUNT(id) AS Total_Loan_Application,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM financial_loan_New
Group By home_ownership
Order By COUNT(id) DESC