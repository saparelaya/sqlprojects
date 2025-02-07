-- Create Database
create Database Hospital_Data;

-- Switch to the database
\c hospital_data; DROP TABLE IF EXISTS hospital;

-- Create Tables
CREATE TABLE hospitals (
    Hospital_Name VARCHAR(50),
	Location VARCHAR(50),
	Department VARCHAR(50),
	Doctors_Count INT,	
	Patients_Count INT,
	Admission_Date DATE,
	Discharge_Date DATE,
	Medical_Expenses NUMERIC(10,2)
);

select * from hospitals;

COPY hospitals(Hospital_Name, Location, Department, Doctors_Count,	Patients_Count,	Admission_Date,	Discharge_Date,	Medical_Expenses
) 
FROM '‪‪C:\Program Files\PostgreSQL\17\Hospital_Data.csv' 
CSV HEADER;

--1.Total Number of Patients, Write an SQL query to find the total number of patients across all hospitals.
 select count(*) total_patients 
 from hospitals;

--2.Average Number of Doctors per Hospital. Retrieve the average count of doctors available in each hospital.
SELECT hospital_name, AVG(doctors_count) AS avg_doctors 
FROM hospitals
GROUP BY hospital_name;

--3.Top 3 Departments with the Highest Number of Patients. Find the top 3 hospital departments that have the highest number of patients.
SELECT department, COUNT(Patients_Count) as Patients_count 
FROM Hospitals
GROUP BY department
order by Patients_count desc limit 3;

--4.Hospital with the Maximum Medical Expenses. Identify the hospital that recorded the highest medical expenses.
SELECT  Hospital_Name, sum(Medical_Expenses) as Max_medical_expenses 
FROM Hospitals
GROUP BY Hospital_Name
order by Max_medical_expenses desc limit 1;

--5.Daily Average Medical Expenses. Calculate the average medical expenses per day for each hospital.
SELECT Hospital_name, AVG(Medical_Expenses) AS daily_avg_expenses
FROM hospitals
GROUP BY hospital_name;

--6.Longest Hospital Stay. Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date.
SELECT patients_count, admission_date, discharge_date,
       (discharge_date - admission_date) AS days_stayed
FROM hospitals
ORDER BY days_stayed DESC
LIMIT 1;

--7.Total Patients Treated Per City. Count the total number of patients treated in each city.
SELECT location, count(patients_count) AS total_patients
FROM hospitals
GROUP BY location;

--8.Average Length of Stay Per Department. Calculate the average number of days patients spend in each department.
SELECT department, AVG(Discharge_date -Admission_date) AS avg_stay_days
FROM Hospitals
GROUP BY department;

--9.Identify the Department with the Lowest Number of Patients. Find the department with the least number of patients.
SELECT department, COUNT(patients_count) AS No_of_patients
FROM Hospitals
GROUP BY department
ORDER BY No_of_patients ASC
LIMIT 1;

--10.Monthly Medical Expenses Report. Group the data by month and calculate the total medical expenses for each month.
SELECT EXTRACT(MONTH FROM Admission_date) AS month, 
       SUM(medical_expenses) AS total_expenses
FROM Hospitals
GROUP BY month
ORDER BY month;
