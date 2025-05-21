Create database HR_Data_Analyst;
use hr_data_analyst;
select* from hr;
desc hr;

# Employee Count:
select sum(employee_count) as Employee_Count from hr;

# Attrition Count:
select count(attrition) from hr where attrition='Yes';

# Attrition Rate:
select 
round (((select count(attrition) from hr where attrition='Yes')/ 
sum(employee_count)) * 100,2) as Attrition_Rate
from hr;

# Active Employee:
select sum(employee_count) - (select count(attrition) from hr  where attrition='Yes') as Active_Employee from hr;

# Average Age:
select round(avg(age),0) from hr;

# Attrition by Gender
select gender, count(attrition) as attrition_count from hr
where attrition='Yes'
group by gender
order by count(attrition) desc;

# No of Employee by Age Group
SELECT age,  sum(employee_count) AS employee_count FROM hr
GROUP BY age
order by age;

# Education Field wise Attrition:
select education_field, count(attrition) as attrition_count from hr
where attrition='Yes'
group by education_field
order by count(attrition) desc;

# Attrition Rate by Gender for different Age Group
SELECT 
    age_group, 
    gender, 
    COUNT(*) AS attrition_count, 
    ROUND(
        (COUNT(*) * 100.0) / SUM(COUNT(*)) OVER, 
	2
    ) AS attrition_percentage
FROM (
    SELECT 
        attrition, 
        gender, 
        CASE 
            WHEN age BETWEEN 18 AND 24 THEN '18-24'
            WHEN age BETWEEN 25 AND 34 THEN '25-34'
            WHEN age BETWEEN 35 AND 44 THEN '35-44'
            WHEN age BETWEEN 45 AND 54 THEN '45-54'
            WHEN age >= 55 THEN '55+'
        END AS age_group
    FROM hr
) AS grouped_data
WHERE attrition = 'Yes'
GROUP BY age_group, gender
ORDER BY age_group, gender;


