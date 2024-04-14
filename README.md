# SQL-Portfolio

This repository contains SQL queries that I have written for data analytics projects I have worked on. 
The sql queries are an integration with data visualisation I created using Tableau. 

# Highlighted Projects

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

   - Age vs Average Probability: There seems to be a a higher probability percentage of employees aged 43 and above to be absent from work as well as employees 28 and possibly younger 
   - Reasons vs Probability: The 1's and 0's indicate whether an individual has or has not been absent for each particular reason. Reason 2 did not contain data for both values only 0s indicating that there was no absenteeism for that reason meaning that none of the 40 observations was away from work because of reason 2. This corresponds with our data source in our .csv file. Therefor this field is excluded from the analysis.

The analysis shows that the probability that an employee would be absent for more than 3 hours due to reason one is above 50% , as seen by the dots marked on the relevant value of 1.
Compared to reason 3, the probability is distributed both in the lower and upper parts of the vertical line with very few observations/employees specified to give reason 3 for excessive absence from work.

Reason 4 is opposite to reason 1. The employees who selected reason for absence have a probability mostly below 50% to be excessively absent from work.

   - Transportation Expenses vs Probability
     
[Tableau Visualisations](https://public.tableau.com/app/profile/veronica.mucha/vizzes)

## Student Enrollments and Completions

In this mini-project, I analyse, as the BI/Data Analyst in the company,  the career track enrollments and achievements of students at a fictional online school focusing on providing Data related courses/career tracks such as Data Science, Data Analytics, Business Analyst as well as AI training, technical expertise, resume building support just to name a few. 

I'll be working with a relatively small [SQL dataset](sql_and_tableau.sql), comprising only two tables and around a thousand rows, to analyse the the career track enrollments and achievements of Students and answer the following questions

   - What is the number of enrolled students monthly? Which is the month with the most enrollments? Speculate about the reason for the increased numbers
   - Which career track do students enroll most in?
   - What is the career track completion rate? Can you say if it’s increasing, decreasing, or staying constant with time?
   - How long does it typically take students to complete a career track? What type of subscription is most suitable for students who aim to complete a career track: monthly, quarterly, or annual?
   - What advice and suggestions for improvement would you give the 365 team to boost engagement, increase the track completion rate, and motivate students to learn more consistently?

I will visualise the results using [Tableau](https://public.tableau.com/app/profile/veronica.mucha/vizzes)

The tracks represent an ordinal sequence of courses that eventually lead to obtaining the skills for one of three job titles: data scientist, data analyst, or business analyst.
To acquire a corresponding career certificate, a student must pass nine course exams (seven compulsory and two elective courses) and sit for a career track exam encompassing topics from all seven required courses.

##### Step 1 Extract the Data with SQL - [Query](career_track_analysis_queries.sql)

Join both tables and extract columns such as the `student_id`, `course/track_name`, `date_enrolled`, `date_completed` and newly created columns such as the `track_completed` and `days_for_completion` into a single query which will help us solve our business questions. 

##### Step 2 Tableau Visualisations - [Charts](https://public.tableau.com/app/profile/veronica.mucha/vizzes)
Here I create 2 charts: 
   - One is a combo chart that represents the number of course enrollments in a given month as well as the fraction of course completions for that month as a percentage of the number of enrollments.
   - The second chart is a bar chart representing the `completion bucket` which is the 'bucket' a students falls into based on the number od days it took them to complete a course, if they have done so
