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

/* Day 10 ** Create a service performance report showing service name, total patients admitted,
and a performance category based on the following: 'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 
'Fair' if >= 65, otherwise 'Needs Improvement'. 
Order by average satisfaction descending. */

select service,sum(patients_admitted) AS total_patients_admitted,
round(avg(patient_satisfaction),2) AS avg_satisfaction,
case when avg(patient_satisfaction) >= 85 then 'Excellent'
	 when avg(patient_satisfaction) >= 75 then 'Good'
	 when avg(patient_satisfaction) >= 65 then 'Fair'
	 else 'Needs Improvement'
end	 AS performance_category
from services_weekly group by service
order by avg(patient_satisfaction) desc;

/* Day 11 ** Find all unique combinations of service and event type from the services_weekly table
where events are not null or none, along with the count of occurrences for each combination. 
Order by count descending */

select service, event , count(*) from services_weekly
where event is not null and event <> 'none'
group by service, event
order by count(*) desc;

/*  ** Day 12 ** Analyze the event impact by comparing weeks with events vs weeks without events. 
Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, 
and average staff morale. 
Order by average patient satisfaction descending. */

select count(*) as event_count, round(avg(patient_satisfaction)) as avg_pt_satisfaction, 
round(avg(staff_morale)) as avg_staff_morale,
case when event = 'none' then 'No Event' else 'With Event' end as event_type 
from services_weekly
group by event_type order by avg_pt_satisfaction;

/* ** Day 13 ** Create a comprehensive report showing patient_id, patient name, age, service, 
and the total number of staff members available in their service. Only include patients from services
that have more than 5 staff members. Order by number of staff descending, then by patient name. */

select patient_id, name ,age,p.service, count(s.staff_id) as staff_count 
from patient p join staff s on p.service = s.service
group by patient_id,name , age,p.service 
having count(s.staff_id) > 5 order by staff_count desc, name;

/* Day 14 ** Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service)
and the count of weeks they were present (from staff_schedule). 
Include staff members even if they have no schedule records. 
Order by weeks present descending. */

select s.staff_id,s.staff_name,s.role,s.service, 
count(case when ss.present =false then ss.week end) as week_count
from staff s left join staff_schedule ss on s.staff_id = ss.staff_id
group by s.staff_id,s.staff_name,s.role,s.service;

