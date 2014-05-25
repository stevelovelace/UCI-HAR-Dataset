Title
========================================================

This is an R Markdown document. Markdown is a simple formatting syntax for authoring web pages (click the **Help** toolbar button for more details on using R Markdown).

When you click the **Knit HTML** button a web page will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r}
summary(cars)
```

You can also embed plots, for example:

```{r fig.width=7, fig.height=6}
plot(cars)
```

UCI HAR Dataset
==============================

Human Activity Recognition Using Smartphones Dataset
----------------------------------------------------------
Summarized as Averages of Computed Mean and Standard Deviation Values

This tidy data set is a partial summarization of the data set found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

with more information here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

In brief, data was collected from the accelerometers and gyroscopesof Samsung Galaxy S II smart phones strapped to the waists of 30 volunteers. Data was collected for six activites: walking, walking upstairs, walking downstairs, sitting standing, and lying.

Means and standard deviations of 66 of the values were computed and included in the raw data. These are the values included in the tidy data set and are detailed in the codebook section. Note that all values in the raw data have been normalized on the intervals [-1, 1], so there are negative values. The steps in extracting the tidy data are as follows:

1. read test data (subject, activity, and value files) into a data frame
2. read training data (subject, activity, and value files) into a data frame
3. combine the above into single data frame
4. subset this data frame to include only those values which are computed mean/standard deviation pairs
5. fix the 'bodybody' problem in the headers
    * some column names were malformed, containing 'BodyBody' where 'Body' was meant
6. transform headers for readability, code-friendliness
    * the 't' prefix is eliminated
    * the 'f' prefix becomes 'Freq'
    * the strings indicatig mean and std (which contained dashes and parens) become 'Mean' and 'Std'
7. activity labels are the same with three substitutions
    * WALKING_UPSTAIRS becomes ASCENDING (for brevity, readability)
    * WALKING_DOWNSTAIRS becomes DESCENDING (for brevity, readability)
    * LAYING becomes LYING (grammar correction, although LAYING might have produced some interesting data)
8. the data is aggregated to provide the mean of each value for each subject and activity

These steps are accomlished in the script run_analysis.R
    


CodeBook
------------------------------
The variables in tidyHARData are:
1. Subject
    * subject id, unchanged from the source data
2. Activity
    * factors on the six activities: WALKING, ASCENDING, DESCENDING, SITTING, STANDING, LYING
3. means of the following raw values for computed means and standard deviations, transformed as described above:

"BodyAccMeanX"            "BodyAccMeanY"           
"BodyAccMeanZ"            "BodyAccStdX"             "BodyAccStdY"             "BodyAccStdZ"            
"GravityAccMeanX"         "GravityAccMeanY"         "GravityAccMeanZ"         "GravityAccStdX"         
"GravityAccStdY"          "GravityAccStdZ"          "BodyAccJerkMeanX"        "BodyAccJerkMeanY"       
"BodyAccJerkMeanZ"        "BodyAccJerkStdX"         "BodyAccJerkStdY"         "BodyAccJerkStdZ"        
"BodyGyroMeanX"           "BodyGyroMeanY"           "BodyGyroMeanZ"           "BodyGyroStdX"           
"BodyGyroStdY"            "BodyGyroStdZ"            "BodyGyroJerkMeanX"       "BodyGyroJerkMeanY"      
"BodyGyroJerkMeanZ"       "BodyGyroJerkStdX"        "BodyGyroJerkStdY"        "BodyGyroJerkStdZ"       


