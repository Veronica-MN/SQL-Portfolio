# SQL-Portfolio

This repository contains SQL queries that I have written for data analytics projects I have worked on. 
The sql queries are an integration with data visualisation I created using Tableau. 

# Highlighted Projects

## Analysing and Visualising Customer (Student) Engagement, including key metrics, in a 3 page Dashboard

In this project, I am analysing the student engagament in an educational platform that offeres various tech courses. The project includes SQL queries to extract the data needed to create the visualisation and analysis, as well as key metrics that help identify critical areas of improvement within the educational platform.

### Objective
The questions to be answered in this project are as follows:

- Which courses are the most watched by students and how are they rated
- How many students register each month
- How is the student engagement: minutes watched and average minutes watched based on the different plans provided ( paid and free plan)
- Which countries have the most registered students and does this number scale proportionally to the number of minutes watched per country

1. Retrieving Student Information with SQL
   The [student_info_query](student_info_query.sql) can be found here
2. Retrieving Courses Information with SQL
   The [courses_info_query](course_info_query.sql) can be found here
3. Retrieving Purchasing Information with SQL
   The [purchase_info_query](purchase_info_query.sql) can be found here

### Analysing the Results

[Page 3](https://public.tableau.com/app/profile/veronica.mucha/viz/CustomerEngagement-Final/Page1) of the Dashboard shows the Top 5 most watched courses by students. This is rated by total minutes watched, Averagerage minutes, number of ratings and average rating. The Introduction to Data and Data Science course is the most popular/wached course amongst students. This would imply that the Data Science course is what most students are looking to embark on as a career. 

## Analyse Employees in a Company throughout the years of 1980s to 1990s at a fictional company

- [SQL](Business_Tasks.sql): In this project, I used a big dataset found on [github](https://github.com/datacharmer/test_db/tree/master?tab=readme-ov-file) to Perform data analysis and answer 4 business questions combining SQL and Tableau [visualisations](https://public.tableau.com/app/profile/veronica.mucha/vizzes)
   - What is the breakdown between male and female employees working in the company each year, starting from 1990
   - Compare the number of male managers to the number of female managers from different departments for each year, starting from 1990
   - Compare the average salary of female versus male employees in the entire company until year 2002, per department
   - The average male and female salary per department within a certain salary range

![EER_diagram](EER_diagram.png)

- Analyse the Absenteeism at a fictional company during work time.
- The data used is data provided as .csv files also from this github [repository](https://github.com/datacharmer/test_db/tree/master?tab=readme-ov-file))
   - Problem:
      -  The business environment nowadays is competetive, which leads to increased pressure in the workplace
      -  Unachievable business goals lead to higher stress levels
      -  Risk of unemployment can also be detrimental to a person's health
The above can result in minor or even major illnesses which may or may not develop into a long term condition for instance depression or anxiety.

In this project, I look more into predicting absenteeism from work meaning clarifying whether or not an employee can be expected to miss work for a specific number of hours in any given workday resulting in temporary incapacity to do regular working activity.
How is this beneficial to know: Knowing this information in advance can help a company reorganise the work processes in a manner that allows the company to avoid a lack of productivity and increase the quality of work.

Overall: As a BI/Data Analyst I would like to know for how many working hours can an employee be away from work based on information such as 

   - How many children the employee has
   - How far does the employee live from the office
   - How many pets does the employee have
   - Does the employee have higher education or not
   - The age of the employee

## Absenteeism Prediction of Employees in a Company

As a BI/Data Analyst I want to be able to:
   - gather relevant employee data
   - run a model
   - get results that will clearly show whether or not each employee (from my observations) is expected to be absent for more than 3 hours during a work day

In this project, we assume that the data science or Machine Learning Engineers have developed the necessary Python model containing the code that will run the machine learning code, which is not part of the objective of a BI/Data analyst.
The model in this case is the [abseenteeism module](absenteeism_module.py), additionally, there is the scaler and model files that contain the information needed for the module to use the machine learning, then our cleaned dataset, [Absenteeism_new_data.csv file](Absenteeism_new_data.csv)

The necessary programming steps to create and run the module are not necessary for me to understand a BI/Data Analyst. All I have to do is insert the name of the file that I have processed and cleaned and retrieve the new observation from and run the cell in my jupyter notebook. This will give me the probablity that a certain individual will be absent from work for more than 3 hours as seen [here](Absenteeism_predictions.ipynb). 

#### Integration of Python & SQL
In order for me to analyse and visualise the data in Tableau, I make use of the integration of Python, SQL and Tableau. First is to create a connection between Python & SQL in order to transfer the data from [Jupiter Notebook](Absenteeism_Prediction_Project.ipynb) to [MySQL workbench](predicted_outputs_table.sql)

Steps:
   - Create a database e.g predicted_outputs database
   - Connect SQL & Python (jupiter) using pymsql and import pymsql to establish the connection between the two
   - Open the connection to mysql in Jupiter notebook
   - Create a table whose structure corresponds to the dataframe I want to import
   - Reconnect to the database
   - Transfer data from Python to MySQl ( create a loop that will iterate over both rows and columns and use .execute method)
   - Close connection

The data is stored as a .csv file which I can then use in Tableau to analyse the data. 

#### Integration of SQL and Tableau
Here we use the predicted_outputs_table which is based on 40 new observations obtained from the prediction model, to analyse the data 

   - Age vs Average Probability:

There seems to be a a higher probability percentage of employees aged 43 and above to be absent from work as well as employees 28 and possibly younger 
   - Reasons vs Probability:

The 1's and 0's indicate whether an individual has or has not been absent for each particular reason. Reason 2 did not contain data for both values only 0s indicating that there 
was no absenteeism for that reason meaning that none of the 40 observations was away from work because of reason 2. This corresponds with our data source in our .csv file. 
Therefor this field is excluded from the analysis.

The analysis shows that the probability that an employee would be absent for more than 3 hours due to reason one is above 50% , as seen by the dots marked on the relevant value of 1.
Compared to reason 3, the probability is distributed both in the lower and upper parts of the vertical line with very few observations/employees specified to give reason 3 for excessive absence from work.

Reason 4 is opposite to reason 1. The employees who selected reason for absence have a probability mostly below 50% to be excessively absent from work.

   - Transportation Expenses & Chldren
If we filter the data using the children filter, we can see that the employees with no children do not exhibit a high probability for excessive absence also none of them have high transportation expenses. This could be that they live closer to their work place.
If we click on Children:1, The probability that this group is expected to be excessively absent varies across observations however most of the data is around the average transportation expense spending whihc is between $200 and $240 a month.

Childre:2, the distribution is similar to that of employees with 1 child. If we look at employees with 1 child and employees with 2 children we observe that they both generally do no spend more than $240 on transportation per month. Only 5 observations are over the $240 mark.
Children:3 only one observation is shown deducing that not many individuals have 3 children therefore we can exclude it since it can't affect the analysis of the 40 observations. 
     
[Tableau Visualisations](https://public.tableau.com/app/profile/veronica.mucha/vizzes)

## Student Enrollments and Completions

In this mini-project, I analyse, as the BI/Data Analyst in the company,  the career course enrollments and achievements of students at a fictional online school focusing on providing Data related courses/career tracks such as Data Science, Data Analytics, Business Analyst as well as AI training, technical expertise, resume building support just to name a few. The analysis is of data between January 2022 - December 2022.

**Course Career** - To acquire a corresponding career certificate, a student must pass nine course exams (seven compulsory and two elective courses) and sit for a career course exam encompassing topics from all seven required courses.

I'll be working with a relatively small [SQL dataset](sql_and_tableau.sql), comprising only two tables and around a thousand rows, to analyse the the career course enrollments and achievements of Students. 

I will visualise the results using [Tableau](https://public.tableau.com/app/profile/veronica.mucha/vizzes)

The tracks represent an ordinal sequence of courses that eventually lead to obtaining the skills for one of three job titles: data scientist, data analyst, or business analyst.
To acquire a corresponding career certificate, a student must pass nine course exams (seven compulsory and two elective courses) and sit for a career track exam encompassing topics from all seven required courses.

#### Step 1 Extract the Data with SQL - [Query](career_track_analysis_queries.sql)

Join both tables and extract columns such as the `student_id`, `course/track_name`, `date_enrolled`, `date_completed` and newly created columns such as the `track_completed` and `days_for_completion` into a single query which will help us solve our business questions. 

#### Step 2 Tableau Visualisations - [Charts](https://public.tableau.com/app/profile/veronica.mucha/vizzes)
Here I create 2 charts: 
   - One is a combo chart that represents the number of course enrollments in a given month as well as the fraction of course completions for that month as a percentage of the number of enrollments.
   - The second chart is a bar chart representing the `completion bucket` which is the 'bucket' a students falls into based on the number od days it took them to complete a course, if they have done so

#### Step 3 Analysing the Results

**What is the number of enrolled students monthly? Which is the month with the most enrollments?**
     
The bars demonstrate the fluctuating number of people enrolling monthly which is arounf 800 and 1200. August registered the highest number of enrollments. There could be a number 
of reason possibly promotions or discounts on courses, material or access to the online platform.
The number of enrollments went up on this month as well as the completion rate. The enrollmentand completion dropped the following month possibly due to the end of the free 
access or free services/products.
       
**Which career course do students enroll most in?**

The Data Analyst course  saw a higher number of enrollment as compared to the other courses. The Data Science course was the second most enrolled course and last was the Business 
Analyst course.
     
**What is the career track completion rate? Does it increase, decrease, or stay constant with time?**

The Line Chart in the combo chart, the numbers fluctuate. The passing rate of 2% is relatively low with numbers varying between the different courses. It is difficult to conclude 
with certainty whether the completion rate increases or decreases or stays constant.

**How long does it typically take students to complete a career course? What type of subscription is most suitable for students who aim to complete a career course: monthly, 
     quarterly, or annual?**

The second chart `Duration for Course Completion` shows that students tend to need more time to complete a course, mostly ranging from 91 - 365 days. More data would have to 
collected over a longer period of time in order to know for certainty if this is indeed the duration it takes to complete an online course. 
     
**Suggestions to boost engagement, increase the course completion rate, and motivate students to learn more consistently?**

Since the pass rate of 2% in completing a career course, is relatively low, this tells us that it takes quite a lot of time and dedication for students to complete a course.
A career course takes, nine courses to complete and pass with 7 compulsory courses. This can be overwhelming and discouraging.

A rewards systems for completing each phase of the courses could help incentivise completing the course. Q&A hub that is helpful and supportive to students who may need more 
motivation and a Newsfeed hub to share their thoughts and learning progress and encourage each other. 
     
