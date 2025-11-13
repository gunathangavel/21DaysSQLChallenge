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

/* ** Day 6 ** For each hospital service, calculate the total number of patients admitted, total patients refused, 
and the admission rate (percentage of requests that were admitted). Order by admission rate descending. */ 

select sum(patients_admitted) as total_patients_admitted,
sum(patients_refused) as total_patients_refused ,
round(sum(patients_admitted) * 100.0 / sum(patients_request)) percent_request_admitted
from services_weekly group by service 
order by percent_request_admitted desc;

/* ** Day 7 ** Identify services that refused more than 100 patients in total
and had an average patient satisfaction below 80. 
Show service name, total refused, and average satisfaction.  */ 

select service, sum(patients_refused) as total_refused, 
avg(patient_satisfaction) as avg_satisfaction
from services_weekly group by service
having sum(patients_refused) > 100 and avg(patient_satisfaction) < 80;

/* ** Day 8 **  Create a patient summary that shows patient_id, full name in uppercase, service in lowercase, 
age category (if age >= 65 then 'Senior', if age >= 18 then 'Adult', else 'Minor'), and name length. 
Only show patients whose name length is greater than 10 characters.  */ 

select
patient_id, upper(name) as name, lower(service) as service,
case  when age >=65 then 'Senior'
		when age >=18 then 'Adult'
		else 'Minor'
end as age_category,
length(name) as name_length
from patient;

/* ** Day 9 **  Calculate the average length of stay (in days) for each service, showing only services 
where the average stay is more than 7 days.
Also show the count of patients and order by average stay descending */

select service,count(*), round(avg(departure_date - arrival_date),2) as length_of_stay
from patient group by service  having avg(departure_date - arrival_date)>7
order by length_of_stay;



 