-- 21 Days challenge by Indian Data club

-- ** Day 1 Challenge ** List all unique hospital services available in the hospital
select distinct service from services_weekly;

/* ** Day 2 Challege -  Find all patients admitted to 'Surgery' service with a satisfaction score below 70, 
showing their patient_id, name, age, and satisfaction score */

select patient_id, name, age,  satisfaction  from patient where service='surgery' and satisfaction < 70;