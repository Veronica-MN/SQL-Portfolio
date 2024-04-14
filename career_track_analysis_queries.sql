use sql_and_tableau;

select * from career_track_info;
select * from career_track_student_enrollments;



-- subquery + CTE
WITH CTE AS (
	SELECT MAX(days_for_completion) AS max_completion_days
    FROM (
			SELECT DATEDIFF(date_completed, date_enrolled) AS days_for_completion
			FROM career_track_student_enrollments ctse
			JOIN career_track_info ct ON ct.track_id = ctse.track_id 
		  ) a
 )
SELECT *,
CASE 
        WHEN DATEDIFF(date_completed, date_enrolled) = 0 THEN 'Same day'
        WHEN DATEDIFF(date_completed, date_enrolled) BETWEEN 1 AND 7 THEN '1 to 7 days'
        WHEN DATEDIFF(date_completed, date_enrolled) BETWEEN 8 AND 30 THEN '8 to 30 days'
        WHEN DATEDIFF(date_completed, date_enrolled) BETWEEN 31 AND 60 THEN '31 to 60 days'
        WHEN DATEDIFF(date_completed, date_enrolled) BETWEEN 61 AND 90 THEN '61 to 90 days'
        WHEN DATEDIFF(date_completed, date_enrolled) BETWEEN 91 AND 365 THEN '91 to 365 days'
        WHEN DATEDIFF(date_completed, date_enrolled) >= 366 THEN '366+ days'
END AS completion_bucket
-- MAX(days_for_completion) OVER() AS max_completion_days
FROM
(SELECT 
    student_id, 
    track_name, 
    date_enrolled,
    date_completed,
	ROW_NUMBER() OVER (ORDER BY student_id, track_name desc) AS student_track_id,
    CASE 
        WHEN date_completed IS NULL THEN 0 
        ELSE 1
    END AS track_completed,
    DATEDIFF(date_completed, date_enrolled) AS days_for_completion
FROM 
    career_track_student_enrollments ctse
JOIN 
    career_track_info ct ON ct.track_id = ctse.track_id) a
CROSS JOIN CTE
WHERE days_for_completion = max_completion_days;

--
SELECT
	sum(track_completed) as total_tracks_completed
FROM (
SELECT 
    student_id, 
    track_name, 
    date_enrolled,
    date_completed,
	ROW_NUMBER() OVER (ORDER BY student_id, track_name desc) AS student_track_id,
    CASE 
        WHEN date_completed IS NULL THEN 0 
        ELSE 1
    END AS track_completed,
    DATEDIFF(date_completed, date_enrolled) AS days_for_completion
FROM 
    career_track_student_enrollments ctse
JOIN 
    career_track_info ct ON ct.track_id = ctse.track_id
) AS b

