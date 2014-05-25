## run_analysis.R
##      author: Steve Lovelace
##      last update: 25 May 2014
## 
## This script gets and cleans the UCI HAR dataset found at:
##  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## The output of this script is a tidy data set, 'tidyHARData', containing
## averages of each of the HAR data's computed mean and standard deviation pairs
## for each subject and activity, and a csv file, 'tidyHARData.csv', written
## from the tidy data set into the current working directory.
## 
## NOTE: This script will look in the current working directory for a 
## subdirectory 'UCI HAR Dataset' which must contain the unzipped source 
## dataset. If this subdirectory does not exist, the script will attempt to 
## create it by downloading the dataset from its source. If the download is
## unsuccessful, a 'data not available' error will be thrown.

## if necessary, retrieve the dataset from UCI
if (!file.exists("UCI HAR Dataset")) {
    unlink("tmp_ucihardataz")
    src <- "https://d396qusza40orc.cloudfront.net/"
    src <- paste(src,"getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",sep="")
    stat <- download.file(src, destfile="tmp_ucihardataz", method="curl")
    if (stat != 0 || !file.exists("tmp_ucihardataz")) {
        stop('data not available')
    }
    unzip("tmp_ucihardataz")
    unlink("tmp_ucihardataz")
}


## retrieve the test files and combine the subject, activity and data file to
## make one dataframe
data <- read.table("UCI HAR Dataset/test/X_test.txt")
subj <- read.table("UCI HAR Dataset/test/subject_test.txt", colClasses="integer")
actv <- read.table("UCI HAR Dataset/test/y_test.txt", colClasses="integer")
test <- data.frame(subj, actv, data, stringsAsFactors=FALSE)
rm(data, subj, actv)

## retrieve the train files and combine the subject, activity and data file to
## make one dataframe
data <- read.table("UCI HAR Dataset/train/X_train.txt")
subj <- read.table("UCI HAR Dataset/train/subject_train.txt", colClasses="integer")
actv <- read.table("UCI HAR Dataset/train/y_train.txt", colClasses="integer")
train <- data.frame(subj, actv, data, stringsAsFactors=FALSE)
rm(data, subj, actv)

## combine test and train to make one dataframe
dataraw <- rbind(test, train)
rm(test, train)

## subset to form a dataframe whose columns are subject, activity, and one
## column for each of the calculated stds and means
idxcol <- readLines("UCI HAR Dataset/features.txt")
idxcol <- grep("(mean|std)\\(\\)", idxcol, value=TRUE)
idxcol <- strsplit(idxcol," +")
idx <- sapply(idxcol, function(x) as.numeric(x[1]) + 2)
data <- dataraw[, c(1:2,idx)]
rm(dataraw)

## rename the columns
col <- sapply(idxcol, function(x) x[2])
## fix the 'bodybody'problem
col <- gsub("BodyBody","Body", col)
## replace mean and std strings with 'Mean' and 'Std'
col <- gsub("-mean\\(\\)-?", "Mean", col)
col <- gsub("-std\\(\\)-?", "Std", col)
## replace leading 't' and 'f' with nothing and 'Freq'
col <- gsub("^t","", col)
col <- gsub("^f","Freq", col)
## complete the names with 'Subject' and 'Activity'
col <- c("Subject","Activity", col)
names(data) <- col

## activities use the labels provided with a few substitutions
actlev <- c("WALKING", "ASCENDING", "DESCENDING", "SITTING", "STANDING", "LYING")
data[,2] <- factor(data[,2], labels=actlev)

## create tidy data set by finding the mean of each subject and activity
## and write it out
tidyHARData <- aggregate(data[,3:ncol(data)],
                  by=list(Subject=data[,1], Activity=data[,2]), FUN='mean')
write.csv(tidyHARData, file="tidyHARData.csv", row.names=FALSE)
rm(actlev, col, data, idx, idxcol)
