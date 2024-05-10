select * from 365_course_info;
select * from 365_student_info;
select * from 365_course_ratings;
select * from 365_student_learning;
select * from 365_student_purchases;

-- Retrieving Courses Information 
WITH title_total_minutes AS 
( 
    SELECT 
        course_id, 
        course_title,
        ROUND(SUM(minutes_watched),2) AS total_minutes_watched,
        COUNT(DISTINCT student_id) AS num_students
    FROM
        365_course_info
        JOIN
        365_student_learning using (course_id)
    GROUP BY 
        course_id
),

title_average_minutes AS
(
    SELECT 
        tt.course_id, 
        tt.course_title, 
        tt.total_minutes_watched,
        ROUND(tt.total_minutes_watched / tt.num_students, 2) AS average_minutes
    FROM 
        title_total_minutes tt
),

title_ratings AS 
(
    SELECT 
      ta. *,
        COUNT(course_rating) AS number_of_ratings,
		IF(COUNT(course_rating) != 0, SUM(course_rating) / COUNT(course_rating), 0) AS average_rating
    FROM 
          title_average_minutes ta
    left JOIN 
        365_course_ratings r USING (course_id)
    GROUP BY 
        course_id
)

select * from title_ratings;