SELECT TOP (1000) [Claim_ID]
      ,[Claim_Date]
      ,[Payer]
      ,[Service_Type]
      ,[Insurance_Type]
      ,[Claim_Amount]
      ,[Paid_Amount]
      ,[Patient_Responsibility]
      ,[Claim_Status]
      ,[Denial_Reason]
      ,[Days_Outstanding]
  FROM [DATAANALYIST].[dbo].[Claims_Data$]
  select* from Claims_Data$;

    ----FIND TOTAL NUMBER OF SALES.....///
select count(*) as Total_Claims
from  Claims_Data$
---Business meaning
--In your Healthcare Claims project, this tells you the total number of claims received/recorded in the dataset
--I used COUNT(*) to calculate the total number of claims in the claims dataset.

---FIND TOTAL CLAIMS AMOUNTS....////
select sum(claim_Amount) as Total_Claims_Amount
from Claims_Data$;
---Business meaning
--It tells you the total monetary value of all claims submitted.
--I used SUM(Claim_Amount) to calculate the total financial value of all claims in the dataset.

---FIND TOTAL PAID AMOUNT..///
select sum(Paid_Amount) as Total_Paid
from Claims_Data$;
--Business meaning
--The total amount that was paid for all claims in the dataset.

----FIND AVERAGE CLAIM AMOUNT....///
select avg(Claim_Amount) as Average_Claim_Amount
from Claims_Data$;
--Business meaning
--It tells you the average monetary value of a claim in your healthcare claims dataset.
--I used AVG(Claim_Amount) to calculate the average claim value, which helps understand the typical claim amount in the dataset.

----Count Claims by Status......//
SELECT 
    [Claim_Status],
    COUNT(*) AS Claim_Count
FROM [DATAANALYIST].[dbo].[Claims_Data$]
GROUP BY [Claim_Status]
ORDER BY Claim_Count DESC;
--Business meaning
--This helps a healthcare company understand the distribution of claims by status and identify which status has the largest number of claims.

-----find Denied Claims....///
SELECT *
FROM [DATAANALYIST].[dbo].[Claims_Data$]
WHERE [Claim_Status] = 'Denied';
--Business meaning
--This query helps you identify individual denied claims so you can investigate things.

---Count denied claims...///
SELECT 
    COUNT(*) AS Denied_Claims
FROM [DATAANALYIST].[dbo].[Claims_Data$]
WHERE [Claim_Status] = 'Denied';
--Business meaning
--This is an important claims KPI because you can further analyze why those claims were denied

----find most common denial reason...///

select Denial_Reason, 
count(*) as Denial_Count
 FROM [DATAANALYIST].[dbo].[Claims_Data$]
 where[Claim_Status]='Denied'
 group by Denial_Reason
 order by Denial_Count desc;
 --Business meaning
 --That could help the healthcare organization investigate documentation processes and potentially reduce future denials.

 ---ANALYZE CLAIMS BY PAYER....///
 select payer,
 count(*) as Claim_count,
 sum(Claim_Amount) as Total_Claims,
 sum(Paid_Amount) as Total_Paid
 FROM [DATAANALYIST].[dbo].[Claims_Data$]
 group by payer
 order by Total_Claims desc;
 --Business meaning
 --This query helps a healthcare organization compare payer-wise claim volume and financial value.

 ---CALCULATE PAYMENT RATE BY PAYER...///
 SELECT 
    Payer,
    ROUND(
        SUM(Paid_Amount) * 100.0 / NULLIF(SUM(Claim_Amount), 0),
        2
    ) AS Payment_Rate
FROM [DATAANALYIST].[dbo].[Claims_Data$]
GROUP BY Payer
ORDER BY Payment_Rate DESC;
--Business meaning

 ---This analysis tells a healthcare organization what percentage of the claimed amount each payer actually paid.

---FIND CLAIMS OUTSTANDING FOR MORE THAN 60 DAYS...///
select * from  [DATAANALYIST].[dbo].[Claims_Data$]
where Days_Outstanding > 60
order by Days_outstanding desc;

--Business meaning

--This query helps a healthcare/claims company identify claims that have been pending
--for more than 60 days, with the oldest outstanding claims appearing first.

---FIND TOP 10 LARGEST CLAIMS...//
select top 10
Claim_ID,
payer,
Claim_Amount,
Claim_Status
FROM [DATAANALYIST].[dbo].[Claims_Data$]
order by Claim_Amount desc;
--Business meaning
--This analysis helps identify high-value claims that may need closer attention.
--I identified the top 10 highest-value claims by sorting Claim_Amount in descending order.

---ANALYZE CLAIMS BY INSURANCE TYPE....///
select Insurance_Type,
count(*) as Claim_count,
sum(Claim_Amount) as Total_Claim_Amount,
sum(Paid_Amount) as Total_Paid
From [DATAANALYIST].[dbo].[Claims_Data$]
group by Insurance_Type;
--Business meaning
--This analysis helps compare the volume and financial value of claims across different insurance types.

--FIND UPAID CLAIMS...///
select * From [DATAANALYIST].[dbo].[Claims_Data$]
where Paid_Amount = 0;
--Business meaning
--This can help identify claims where no payment has been made, which may require investigation.

--FIND CLAIMS WITH OUTSTANDING BALANCE..//
SELECT 
    Claim_ID,
    Payer,
    Claim_Amount,
    Paid_Amount,
    Claim_Amount - Paid_Amount AS Outstanding_Amount
FROM [DATAANALYIST].[dbo].[Claims_Data$]
WHERE Claim_Amount - Paid_Amount > 500
ORDER BY Outstanding_Amount DESC;
--Business meaning
--This query identifies claims with more than ₹500 still outstanding and prioritizes the claims with the largest unpaid amounts.


