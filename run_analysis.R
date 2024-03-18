##############################################################################
#   This script is used to produce a clean data set in a file called "tidy_data.txt"
#   using the data collected from the accelerometers from the Samsung Galaxy S 
#   smartphone.
##############################################################################

# Set working directory
# setwd('<YOUR_WORKING_DIRECTORY>')

# List of library
library(dplyr)

# Getting data by downloading the zip file containing data if it has not been downloaded
myUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
myZip <- "UCI HAR Dataset.zip"
if (!file.exists(myZip)) {
  download.file(myUrl, myZip, mode = "wb")
}

# Unzip the downloaded zip file if not already done before
myPath <- "./UCI HAR Dataset"
if (!file.exists(myPath)) {
  unzip(myZip)
}

# Read training data
subjectTrain <- read.table(file.path(myPath, "train", "subject_train.txt"))
xTrain <- read.table(file.path(myPath, "train", "X_train.txt"))
yTrain <- read.table(file.path(myPath, "train", "y_train.txt"))

# Read test data
subjectTest <- read.table(file.path(myPath, "test", "subject_test.txt"))
xTest <- read.table(file.path(myPath, "test", "X_test.txt"))
yTest <- read.table(file.path(myPath, "test", "y_test.txt"))

# Read features and store into myFeature variable
myFeature <- read.table(file.path(myPath, "features.txt"), as.is = TRUE)

# Read activity labels and store into myActivity variable
myActivity <- read.table(file.path(myPath, "activity_labels.txt"))
colnames(myActivity) <- c("activityId", "activityLabel")

# Merge the training and test sets to create a human activity data set table
humanActivity <- rbind(
  cbind(subjectTrain, xTrain, yTrain),
  cbind(subjectTest, xTest, yTest)
)

# Remove unused tables to save memory
rm(subjectTrain, xTrain, yTrain, subjectTest, xTest, yTest)

# Assign column names
colnames(humanActivity) <- c("subject", myFeature[, 2], "activity")

# Extracts only the measurements on the mean and standard deviation for each measurement
columnsToKeep <- grepl("subject|activity|mean|std", colnames(humanActivity))
humanActivity <- humanActivity[, columnsToKeep]

# Use descriptive activity names to name the activities in the data set
humanActivity$activity <- factor(humanActivity$activity, 
                                 levels = myActivity[, 1], labels = myActivity[, 2])

# Remove special characters in all of human activity column names
humanActivityCols <- colnames(humanActivity)
humanActivityCols <- gsub("[\\(\\)-]", "", humanActivityCols)

# Labels the data set with descriptive variable names
humanActivityCols <- gsub("^f", "freqDomain", humanActivityCols)
humanActivityCols <- gsub("^t", "timeDomain", humanActivityCols)
humanActivityCols <- gsub("Acc", "Accelerometer", humanActivityCols)
humanActivityCols <- gsub("Gyro", "Gyroscope", humanActivityCols)
humanActivityCols <- gsub("Mag", "Magnitude", humanActivityCols)
humanActivityCols <- gsub("Freq", "Frequency", humanActivityCols)
humanActivityCols <- gsub("mean", "Mean", humanActivityCols)
humanActivityCols <- gsub("std", "StandardDeviation", humanActivityCols)

# Remove duplicate word
humanActivityCols <- gsub("BodyBody", "Body", humanActivityCols)

# Assign new labels to column names
colnames(humanActivity) <- humanActivityCols

# Group by subject and activity then apply summarise through the use of mean to
# create a second, independent tidy data set with the average of each variable
# for each activity and each subject
humanActivityAverage <- humanActivity %>% group_by(subject, activity) %>% 
                                        summarise(across(everything(), mean))

# Print output to an independent tidy data set called "tidy_data.txt"
write.table(humanActivityAverage, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)