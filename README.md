# Getting and Cleaning Data

## Introduction

This is a repository which contains the Course Project "Getting and Cleaning data", part of the Data Science specialization.

## Directory structure
   This directory contains the following 3 files.  
   run_analysis.R - The script that reads the input data, applies transformations, tidies the data and
                    save the tidied data to the output file.  
   Codebook.md - The codebook that explains the variables result data and transformations.  
   README.md - This Readme file.  

## Input data

   The input files that are used consists of the following files which are found in the UCI HAR Dataset directory,  
       - 'features.txt': List of all features.  
       - 'activity_labels.txt': Links the class labels with their activity name.  
       - 'train/X_train.txt': Training set.  
       - 'train/y_train.txt': Training labels. Its range is 1-6.  
       - 'train/subject_train.txt': The subject who performed the training activity. It ranges from 1 to 30.   
       - 'test/X_test.txt': Test set.  
       - 'test/y_test.txt': Test labels. Its range is 1-6.  
       - 'test/subject_test.txt': The subject who performed the test activity. It ranges from 1 to 30.  

   The test data contains 2947 observations and training data contains 7352 observations.  
   There are 561 variables in the test and training set.
      
## Output

   The primary output of the script is the tidy data which is obtained by applying the the necessary transformations
   (explained in the Code book). The output file name is tidy_data.txt

## Script

   The script run_analysis.R is the R script that reads the input data, applies transformations, tidies the merged data
   and saves the output to tidy_data.txt.

## Dependency

   The script uses data.table and dplyr packages.
