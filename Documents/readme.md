
Code Book for Coursera Getting and Cleaning Data Course Project

6/21/2015

Kris Rao

Section 1

Reads in raw data from UCI HAR Dataset.

xtrain, xtest -  observations
ytrain, ytest - activity codes.
subtrain, subtest - subject codes.
features - feature names of the variables in xtrain and xtest.
activities - activity names corresponding to activity codes in ytrain and ytest.

Section 2

Combines each of x, y and sub files using rbind.

xcombined, ycombined and subcombined

Section 3

Uses grep function to determine which feature names include either mean or standard deviation.
Modifies xcombined to include only those columns corresponding to the 81 mean or standard deviation variables.  Applies the actual feature names of these 81 variables to the columns of x combined.

Section 4  

Renames ycombined and subcombined columns by the descriptives "Activity" and "Subject", respectively.

Section 5

Modifies ycombined to replace the numeric codes with the corresponding activity names (laying, walking, etc.)

Section 6

Uses cbind function to combine subcombined, ycombined, and xcombined (all as modified above) into one large data frame, 
combineddata.

Section 7

Uses aggregate function from the plyr package to calculate the means of each of the 81 xcombined variables by two factors, subject and activity.  Since there are 30 subjects for which observations are taken and 6 activities, the result is 180 mean observations on the 81 variables.

The resulting data frame is stored as 
averalldata

Section 8

averalldata is written to the file 
tidydata.txt


