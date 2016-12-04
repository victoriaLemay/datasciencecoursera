# CodeBook for run_analysis.R

Describes data analysis procedure for run_analysis.R in the Getting and Cleaning Data Project.

## Data

Data was obtained from (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The unzipped UCI HAR Dataset directory should be placed in the Getting_and_Cleaning_Data_Project directory - from the root of the project, the filepath should look like datasciencecoursera/Getting_and_Cleaning_Data_Project/UCI HAR Dataset.

The run_analysis.R script makes use of the following files in the UCI HAR Dataset:
* activity_labels.txt
* features.txt
* test/subject_test.txt
* test/X_test.txt
* test/y_test.txt
* train/subject_train.txt
* train/X_train.txt
* train/y_train.txt

## Variables

* All filepaths to data files are stored in variables ending with "Filepath"
* Each file is pulled into a table:
** activities - activity_labels.txt
** features - features.txt
** testSubjects - test/subject_test.txt
** testX - test/X_test.txt
** testY - test/y_test.txt
** trainSubjects - train/subject_train.txt
** trainX - train/X_train.txt
** trainY - train/y_train.txt
* The variable "columnNames" is used to store the cleaned feature names from "features".
* The variable "test" stores the combined "testSubjects", "testX", and "testY" tables.
* The variable "train" stores the combined "trainSubjects", "trainX", and "trainY" tables.
* The variable "uciHarData" stores the combined "test" and "train" data.
* The variable "summary" stores the mean / std columns from "uciHarData".
* The variable "tidyData" stores a summarization of "summary", where the data is grouped by subject_id and activity_name and the mean is taken of each column. 

## Transformations

The following steps were taken to transform the raw data into the "summary" and "tidyData" tables.
* Each data file was pulled into a data table, as described in the Variables section.
* Descriptive column names from the "feature_name" column of the "features" table were added to the "testX" and "trainX" tables.
* Columns from the "testX", "testY" (activity_id), and "testSubjects" (subject_id) tables were combined into a single table - "test".
* Columns from the "trainX", "trainY" (activity_id), and "trainSubjects" (subject_id) tables were combined into a single table - "train".
* Rows from the "train" table were joined in a SQL UNION to the rows of the "test" table to create a new table with the complete dataset - "uciHarData".
* The table "summary" was generated from the subject_id and activity_id columns of "uciHarData", along with any column containing the strings "mean" or "std".
* In the "summary" table, the activity_id column was replaced with the activity_name, using an inner join to the "activities" table.
* The "tidyData" table was generated from the "summary" table by grouping the rows by subject_id and activity_id, and then taking the mean of each column.
