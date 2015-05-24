# Getting-and-Cleaning-Data-Course - Project
## Purpose: 
The code processes a number of individual but related data files related to six different physical activities of 30 
volunteers captured by Samsung Galaxy S II smartphone. The purpose of the code is to read and organize the data elements 
stored in several files into one tidy data set (and one summarized data set) which are easy to read, interpret and process by 
further analysis on certain characteristics of the experiment.

## Input: 
8 individual data sets as described in the link above and summarized below:
Two files (features.txt and activity_labels.txt) are storing description of the coded variables in other six files. So they 
can be considered as “Reference” data.
Six files are grouped into two groups: Three files for Train data and three files for Test data. The structure for each 
corresponding file for both train and test files are identical. However the contents are not. Train data sets are related to 
the data captured as “train” data set for 21 individuals and Test data sets are related to the data captured as “test” data 
set for 9 other individuals.

## Output:
There are two data frames created by the code and two equivalent .csv files stored in the working directory
* final_train_test: Subject and activity level data for both train and test data
*	final_train_test_summary: Aggregated data set with average of all measurement 

## Code profile:
* Developed in R Studio 0.98
Platform (using output of version function):
i386-w64-mingw32
i386
mingw32
i386, mingw32

3
1.3
2015
03
09
67962
R version 3.1.3 (2015-03-09)
Smooth Sidewalk

Refer to CodeBook.docx in this repository for further details.
