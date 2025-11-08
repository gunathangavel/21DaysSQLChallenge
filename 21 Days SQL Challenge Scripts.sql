-- 21 Days challenge by Indian Data club

-- ** Day 1 Challenge ** List all unique hospital services available in the hospital
select distinct service from services_weekly;

/* ** Day 2 Challege -  Find all patients admitted to 'Surgery' service with a satisfaction score below 70, 
showing their patient_id, name, age, and satisfaction score */

select patient_id, name, age,  satisfaction  from patient where service='surgery' and satisfaction < 70;

/* Day 3 Retrieve the top 5 weeks with the highest patient refusals across all services,
showing week, service, patients_refused, and patients_request. 
Sort by patients_refused in descending order*/
select week, service, patients_refused, 
patients_request from services_weekly order by patients_refused desc limit 5;

/* Day 4 Find the 3rd to 7th highest patient satisfaction scores from the patients table, showing patient_id, 
name, service, and satisfaction. Display only these 5 records */
select  patient_id,  name, service,  satisfaction 
from patient order by satisfaction  desc offset 2 limit 10;

/* ** Day 5 ** Calculate the total number of patients admitted, total patients refused,
and the average patient satisfaction across all services and weeks.
Round the average satisfaction to 2 decimal places. */
 
select sum(patients_admitted) as patients_admitted ,sum(patients_refused) as patients_refused,
 round(avg(patient_satisfaction),2) avg_satisfaction from services_weekly;

 