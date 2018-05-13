# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Load the test and train dataset
2. Load subject id and activity
3. Keep only the the columns with mean or std of test/train dataset and remove rest
4. Merge all datasets
5. Convert Subject_ID and Activity ID into factors
6. Create tidy dataset that consist of mean value of each subject and activity pair

The end result is shown in the file `Cleaned.txt`.
