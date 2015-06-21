library(data.table)
library(plyr)

# 1.  Reading in the data, variables 

xtrain <- read.table("C:/Users/kris/Desktop/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("C:/Users/kris/Desktop/UCI HAR Dataset/train/y_train.txt")
subjecttrain <- read.table("C:/Users/kris/Desktop/UCI HAR Dataset/train/subject_train.txt")

xtest <- read.table("C:/Users/kris/Desktop/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("C:/Users/kris/Desktop/UCI HAR Dataset/test/y_test.txt")
subjecttest <- read.table("C:/Users/kris/Desktop/UCI HAR Dataset/test/subject_test.txt")

features <- read.table("C:/Users/kris/Desktop/UCI HAR Dataset/features.txt")
activities <- read.table("C:/Users/kris/Desktop/UCI HAR Dataset/activity_labels.txt")

# 2. Merge the data into combined variables for x, y and subject
xcombined <- rbind(xtrain, xtest)
ycombined <- rbind(ytrain, ytest)
subcombined <- rbind(subjecttrain, subjecttest)


#3.  Finding Columns with only Means and Std. Deviation data

colswithmeanorstddev <- grep("mean|std", features[,2])
xcombined<-xcombined[,colswithmeanorstddev]
names(xcombined)<-features[colswithmeanorstddev,2]

#4.  Name Subject and Activity columns
names(subcombined)<-c("Subject")
names(ycombined)<-c("Activity")

#5.  Change Activity Entries to Descriptive Activity Names

ycombined[, 1] <- activities[ycombined[, 1], 2]

#6.  Combine All of the Data in one data frame

combineddata<-cbind(subcombined, ycombined, xcombined)

#7.  Calculate Average of each variable by subject and activity

averalldata<-aggregate(combineddata[,3:81], list(combineddata$Subject, combineddata$Activity), mean)

#8.  Write to tidy data file

write.table(averalldata, "./tidydata.txt", row.name=FALSE)



