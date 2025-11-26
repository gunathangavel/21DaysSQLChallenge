-- CEO has been found dead in their office on October 15, 2025, at 9:00 PM.
--Investigating Steps 
-- step:1 Identify where and when the crime happened 
select employee_id,room,entry_time,exit_time from keycard_logs where room='CEO Office';

-- step:2 Analyze who accessed critical areas at the time
select e.employee_id,e.name,department,room, entry_time,exit_time 
from employees e join keycard_logs k on e.employee_id = k.employee_id
where entry_time between '2025-10-15 08:50:00' and  '2025-10-15 09:00:00';

--Cross-check alibis with actual logs
select e.employee_id,name,claimed_location , room as actual_location, entry_time, exit_time
from alibis a join keycard_logs k on a.employee_id = k.employee_id
 join employees e on k.employee_id = e.employee_id
where claimed_location <> room;

--Investigate suspicious calls made around the time
select cal.name as caller,rec.name as receiver,
call_time,duration_sec, claimed_location,claim_time 
from calls c join alibis a on c.caller_id = employee_id
JOIN employees cal ON cal.employee_id = c.caller_id
JOIN employees rec ON rec.employee_id = c.receiver_id
where call_time between '2025-10-15 20:50:00' and  '2025-10-15 21:00:00';

--Match evidence with movements and claims
select em.employee_id, em.name as employee_name, k.room as actual_location,description as evidence,
found_time as evidence_time, entry_time , exit_time
from evidence e join keycard_logs k on e.room = k.room
join employees em on em.employee_id = k.employee_id
where entry_time >= '2025-10-15 08:50:00';


select e.employee_id,name, department,role,call_time, duration_sec, claimed_location,claim_time,
k.room as actual_location, k.entry_time, k.exit_time 
from employees e join calls c on e.employee_id = c.caller_id
join alibis a on  e.employee_id =  a.employee_id
join keycard_logs k on e.employee_id = k.employee_id
where call_time >= '2025-10-15 20:50:00' and call_time <= '2025-10-15 21:00:00'
and  k.entry_time >= '2025-10-15 20:50:00' and  k.entry_time <= '2025-10-15 21:00:00';

-- Revealing the killer name 
select  name as killer
from employees e join calls c on e.employee_id = c.caller_id
join alibis a on  e.employee_id =  a.employee_id
join keycard_logs k on e.employee_id = k.employee_id
where call_time >= '2025-10-15 20:50:00' and call_time <= '2025-10-15 21:00:00'
and  k.entry_time >= '2025-10-15 20:50:00' and  k.entry_time <= '2025-10-15 21:00:00';

-- case solved