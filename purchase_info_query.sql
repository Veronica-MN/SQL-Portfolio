select * from 365_course_info;
select * from 365_student_info;
select * from 365_course_ratings;
select * from 365_student_learning;
select * from 365_student_purchases;

-- Retrieveing Purchases Information 
drop view if exists purchases_info;

create view purchases_info AS
	select 
		purchase_id,
        student_id, 
        purchase_type,
        date_purchased as date_start,
		CASE
            WHEN
                purchase_type = 'Monthly'
            THEN
                DATE_ADD(MAKEDATE(YEAR(date_purchased),
                            DAY(date_purchased)),
                    INTERVAL MONTH(date_purchased) MONTH)
            WHEN
                purchase_type = 'Quarterly'
            THEN
                DATE_ADD(MAKEDATE(YEAR(date_purchased),
                            DAY(date_purchased)),
                    INTERVAL MONTH(date_purchased) + 2 MONTH)
            WHEN
                purchase_type = 'Annual'
            THEN
                DATE_ADD(MAKEDATE(YEAR(date_purchased),
                            DAY(date_purchased)),
                    INTERVAL MONTH(date_purchased) + 11 MONTH)
        END AS date_end
    FROM
        365_student_purchases;
