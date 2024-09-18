use BANK_ANALYTICS;

select*from Finance_1
select*from Finance_2

KPI
--Year wise loan amount Stats
--Grade and sub grade wise revol_bal
--Total Payment for Verified Status Vs Total Payment for Non Verified Status
--State wise and month wise loan status
--Home ownership Vs last payment date stats

--KPI1--YEAR WISE LOAN AMOUNT
SELECT
       Datename(Year,issue_d)as year,
      SUM(loan_amnt)as Total_Loan_Amount
from Bank_Loan_Data
Group by Datename(Year,issue_d)
Order by Datename(Year,issue_d)


--KPI2--Grade and sub grade wise revol_bal
select 
      grade as grade,
	  sub_grade as sub_grade,
	  SUM(revol_bal)as Revolve_Balance
from Bank_Loan_Data
Group By grade,sub_grade
Order by grade,sub_grade

--KPI3--Total Payment for Verified Status Vs Total Payment for Non Verified Status
SELECT
      verification_status as verification_status,
	  ROUND(sum(total_pymnt),2)As Total_Payment
from Bank_Loan_Data
Group By verification_status
Order By verification_status

--KPI4--State wise and month wise loan status
select
	   MONTH(issue_d)As Month_Number,
	  Datename(month,issue_d)As Month_Name,
	  addr_state as States,
	  loan_status as Loan_Status
from Bank_Loan_Data
Group By MONTH(issue_d) ,Datename(month,issue_d),addr_state,loan_status
Order By MONTH(issue_d) ,Datename(month,issue_d),addr_state,loan_status

--KPI5--Home ownership Vs last payment date stats
SELECT
      home_ownership as Home_Ownership,
	  Datename(Year,last_pymnt_d)as Last_Payment_Date
from Bank_Loan_Data
Group By home_ownership ,Datename(Year,last_pymnt_d)
Order By home_ownership

select* from Bank_Loan_Data

--Total Loan Applications
select count(id) as Total_Loan_Applications from Bank_Loan_Data

--MTD_Total _Loan Applications
select count(id) as MTD_Total_Loan_Applications from Bank_Loan_Data
WHERE YEAR(issue_d)=2011 and MONTH(issue_d)=12

--PMTD_Total _Loan Applications
select count(id) as PMTD_Total_Loan_Applications from Bank_Loan_Data
WHERE YEAR(issue_d)=2011 and MONTH(issue_d)=11


--Total Funded amount 
select SUM(funded_amnt) as Total_Funded_Amount from Bank_Loan_Data


--MTD_Total Funded amount 
select SUM(funded_amnt) as MTD_Total_Funded_Amount from Bank_Loan_Data
WHERE YEAR(issue_d)=2011 and MONTH(issue_d)=12

--PMTD_Total Funded amount 
select SUM(funded_amnt) as PMTD_Total_Funded_Amount from Bank_Loan_Data
WHERE YEAR(issue_d)=2011 and MONTH(issue_d)=11

--Total Amount Received
select SUM(total_pymnt) as Total_Amount_Received from Bank_Loan_Data

--MTD_Total Amount Received
select SUM(total_pymnt) as MTD_Total_Amount_Received from Bank_Loan_Data
WHERE year(issue_d)=2011 and MONTH(issue_d)=12

--PMTD_Total Amount Received
select SUM(total_pymnt) as PMTD_Total_Amount_Received from Bank_Loan_Data
WHERE year(issue_d)=2011 and MONTH(issue_d)=11

--Average Interest Rate
select ROUND(avg(int_rate),4)*100 as Average_Interest_Rate from Bank_Loan_Data

--MTD_Average_Interest_Rate
select ROUND(avg(int_rate),4)*100 as MTD_Average_Interest_Rate from Bank_Loan_Data
where YEAR(issue_d)=2011 and MONTH(issue_d)=12

--PMTD_Average_Interest_Rate
select ROUND(avg(int_rate),4)*100 as PMTD_Average_Interest_Rate from Bank_Loan_Data
where YEAR(issue_d)=2011 and MONTH(issue_d)=11

--Average Dti rate
select ROUND(avg(dti),4)*100 as Average_Dti_Rate from Bank_Loan_Data

--MTD_Average_Dti_rate
select ROUND(avg(dti),4)*100 as MTD_Average_Dti_Rate from Bank_Loan_Data
where YEAR(issue_d)=2011 and MONTH(issue_d)=12

--PMTD_Average_Dti_rate
select ROUND(avg(dti),4)*100 as PMTD_Average_Dti_Rate from Bank_Loan_Data
where YEAR(issue_d)=2011 and MONTH(issue_d)=11

--Good_Loan_Percentage
select
(COUNT(case when loan_status='Fully Paid' or loan_status='Current' then id end)*100)
/
COUNT(id) as Good_Loan_Percentage
from Bank_Loan_Data

--Bad_Loan_Percentage
select
(COUNT(case when loan_status='Charged Off' then id end)*100)
/
COUNT(id) as Bad_Loan_Percentage
from Bank_Loan_Data

--Good Loan Applications
select COUNT(id) as Good_Loan_Applications from	Bank_Loan_Data
where loan_status='Fully Paid' or loan_status='Current'

--Bad Loan Applications
select COUNT(id) as Bad_Loan_Applications from	Bank_Loan_Data
where loan_status='Charged Off'

--Good Loan Funded Amount
select sum(funded_amnt)as Good_Loan_funded_Amount from Bank_Loan_Data
where loan_status='Fully Paid' or loan_status='Current'

--Bad Loan Funded Amount
select SUM(funded_amnt)as Bad_Loan_funded_Amount from Bank_Loan_Data
where loan_status='Charged Off'

--Good Loan  Amount received
select SUM(total_pymnt)as Good_Loan_Amount_Received from Bank_Loan_Data
where loan_status='Fully Paid' or loan_status='Current'

--Bad Loan Amount Received
select SUM(total_pymnt)as Bad_Loan_Amount_Received from Bank_Loan_Data
where loan_status='Charged Off'


--Loan Status Grid View
select 
       loan_status,
	   COUNT(id)as Total_Loan_Applications,
	   SUM(funded_amnt)as Total_funded_Amount,
	   SUM(total_pymnt)as Total_Amount_Recieved,
	   AVG(int_rate*100)as Interest_Rate,
	   AVG(dti*100)as DTI
   FROM
       Bank_Loan_Data
  Group By
     loan_status

--MTD_Loan Status Grid View
select 
       loan_status,
	   SUM(funded_amnt)as MTD_Total_funded_Amount,
	   SUM(total_pymnt)as MTD_Total_Amount_Recieved
FROM Bank_Loan_Data
WHERE YEAR(issue_d)=2011 and MONTH(issue_d)=12
Group By loan_status

--Total Loan Applications, Total Loan Amount, Total Amount Recieved by Month
select
        MONTH(issue_d)as Month_Number,
        Datename(Month,issue_d)as Month_Name,
		count(id)as Total_Loan_Applications,
		SUM(funded_amnt)as Total_Funded_Amount,
		SUM(total_pymnt)as Total_Amount_Recieved
from Bank_Loan_Data
GROUP By MONTH(issue_d), Datename(Month,issue_d)
Order By MONTH(issue_d)

--Total Loan Applications, Total Loan Amount, Total Amount Recieved by STATE
select
        addr_state,
		count(id)as Total_Loan_Applications,
		SUM(funded_amnt)as Total_Funded_Amount,
		SUM(total_pymnt)as Total_Amount_Recieved
from Bank_Loan_Data
GROUP By addr_state
Order By SUM(funded_amnt) desc

--Total Loan Applications, Total Loan Amount, Total Amount Recieved by Term
select
        term,
		count(id)as Total_Loan_Applications,
		SUM(funded_amnt)as Total_Funded_Amount,
		SUM(total_pymnt)as Total_Amount_Recieved
from Bank_Loan_Data
GROUP By Term
Order By Term

--Total Loan Applications, Total Loan Amount, Total Amount Recieved by Employee Length
select
        emp_length,
		count(id)as Total_Loan_Applications,
		SUM(funded_amnt)as Total_Funded_Amount,
		SUM(total_pymnt)as Total_Amount_Recieved
from Bank_Loan_Data
GROUP By emp_length
Order By emp_length

--Total Loan Applications, Total Loan Amount, Total Amount Recieved by Purpose
select
        purpose,
		count(id)as Total_Loan_Applications,
		SUM(funded_amnt)as Total_Funded_Amount,
		SUM(total_pymnt)as Total_Amount_Recieved
from Bank_Loan_Data
GROUP By purpose
Order By purpose

--Total Loan Applications, Total Loan Amount, Total Amount Recieved by Home Ownership
select
        home_ownership,
		count(id)as Total_Loan_Applications,
		SUM(funded_amnt)as Total_Funded_Amount,
		SUM(total_pymnt)as Total_Amount_Recieved
from Bank_Loan_Data
where grade='A' AND addr_state='CA'
GROUP By home_ownership
Order By home_ownership