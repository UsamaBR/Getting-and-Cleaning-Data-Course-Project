# CODEBOOK PROJECT
## GETTING AND CLEANING DATA

This codebook explains the steps taken for the transformation of data from the raw form to the final tidy form. A script is written, specified by the file ‘run_analysis.R’ which is able to download, extract, modify, clean and transform the data until the final form is reached, which is shown in the file ‘tidydata.txt’. Following are the steps taken:


***•	Downloading and unzipping the raw data***

> The dataset, which is required for the script to run can be downloaded from the following URL:
> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

> Details of the data set can be seen here:
> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

> The downloaded dataset is unzipped into the set working directory using R.

***•	Loading the downloaded data into the r environment***

> Once the data is downloaded, the files are loaded into different variables in R. Following is the description of the files’ variables.

>> X_train.txt: The train data for features
>> 
>> y_train.txt: The train data for activities
>> 
>> X_test.txt: The test data for features
>> 
>> y_test.txt: The test data for activities
>> 
>> subject_train.txt: The train data for subjects
>> 
>> subject_test.txt: The test data for subjects
>> 
>> features.txt: The data for features
>> 
>> activity_labels.txt: Activity label list with codes

***•	Merging the training and the test sets to create one data set***

> The data is merged into one data set, based on the common attributes

***•	Mean and standard deviation label extraction***

> From the data, only those variables are extracted which contain either the mean or the standard deviation calculations for our data.

***•	Descriptive activity names to name the activities in the data set***

> The activity codes are changed to activity label names as provided.

***•	Labelling the data set with descriptive variable names***

> The variable names are cleaned, with the removal of extra symbols and the transformation of the names.

***•	Getting the aggregate data***

> The mean data for different variables are obtained by grouping them into activities and subjects.

After the completion of these steps, the final form of dataset is exported to the file ‘tidydata.txt’.
