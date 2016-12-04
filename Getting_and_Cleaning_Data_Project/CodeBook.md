# CodeBook for run_analysis.R

Describes data analysis procedure for run_analysis.R in the Getting and Cleaning Data Project.

## Data

Data was obtained from the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The unzipped UCI HAR Dataset directory should be placed in the Getting_and_Cleaning_Data_Project directory - from the root of the project, the filepath should look like datasciencecoursera/Getting_and_Cleaning_Data_Project/UCI HAR Dataset.

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
  * _activities_ - activity_labels.txt
  * _features_ - features.txt
  * _testSubjects_ - test/subject_test.txt
  * _testX_ - test/X_test.txt
  * _testY_ - test/y_test.txt
  * _trainSubjects_ - train/subject_train.txt
  * _trainX_ - train/X_train.txt
  * _trainY_ - train/y_train.txt
* _columnNames_ is used to store the cleaned feature names from _features_.
* _test_ stores the combined _testSubjects_, _testX_, and _testY_ tables.
* _train_ stores the combined _trainSubjects_, _trainX_, and _trainY_ tables.
* _uciHarData_ stores the combined _test_ and _train_ data.
* _summary_ stores the mean / std columns from _uciHarData_.
* _tidyData_ stores a summarization of _summary_, where the data is grouped by subject_id and activity_name and the mean is taken of each column. 

## Transformations

The following steps were taken to transform the raw data into the _summary_ and _tidyData_ tables.
* Each data file was pulled into a data table, as described in the Variables section.
* Descriptive column names from the feature_name column of the _features_ table were added to the _testX_ and _trainX_ tables.
* Columns from the _testX_, _testY_ (activity_id), and _testSubjects_ (subject_id) tables were combined into a single table - _test_.
* Columns from the _trainX_, _trainY_ (activity_id), and _trainSubjects_ (subject_id) tables were combined into a single table - _train_.
* Rows from the _train_ table were joined in a SQL UNION to the rows of the _test_ table to create a new table with the complete dataset - _uciHarData_.
* The table _summary_ was generated from the subject_id and activity_id columns of _uciHarData_, along with any column containing the strings "mean" or "std".
* In the _summary_ table, the activity_id column was replaced with the activity_name, using an inner join to the _activities_ table.
* The _tidyData_ table was generated from the _summary_ table by grouping the rows by subject_id and activity_id, and then taking the mean of each column.
