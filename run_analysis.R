#---------------------------------------------------------------------------------------------------
# Loading the required libraries before the script is run.
library(dplyr)

#---------------------------------------------------------------------------------------------------
## DOWNLOADING AND UNZIPPING THE RAW DATA

# In the set working directory, checking if the folder "data" exists, else, creating it.
if(!file.exists("./data"))
        {dir.create("./data")}

# Setting the URL of the file.
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Downloading the file in the specified directory.
download.file(fileUrl,
              destfile = "./data/Datafiles.zip",
              method = "curl")

# Unzipping the downloaded files.
unzip(zipfile = "./data/Datafiles.zip",
      exdir = "./data")

# Specifying the path for the data folder
filepath <- file.path("./data" , "UCI HAR Dataset")

#---------------------------------------------------------------------------------------------------
## LOADING THE DOWNLOADED DATA INTO THE R ENVIRONMENT

# Test and train data for features
xTest_Feat  <- read.table(file = file.path(filepath, "test" , "X_test.txt" ),
                          header = FALSE)
xTrain_Feat <- read.table(file = file.path(filepath, "train", "X_train.txt"),
                          header = FALSE)

# Test and train data for activity
yTest_Activity  <- read.table(file = file.path(filepath, "test" , "Y_test.txt" ),
                              header = FALSE)
yTrain_Activity <- read.table(file = file.path(filepath, "train", "Y_train.txt"),
                              header = FALSE)

# Test and train data for subjects
subTrain <- read.table(file = file.path(filepath, "train", "subject_train.txt"),
                       header = FALSE)
subTest  <- read.table(file = file.path(filepath, "test" , "subject_test.txt"),
                       header = FALSE)


#---------------------------------------------------------------------------------------------------
## STEP 1: MERGING THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET

# Row binding the test and train features data into one.
features <- rbind(xTrain_Feat, 
                 xTest_Feat)

# Row binding the test and train activity data into one.
activity<- rbind(yTrain_Activity, 
                 yTest_Activity)

# Row binding the test and train subject data into one.
subject <- rbind(subTrain, 
                 subTest)

# Column binding the three data
mergedData <- cbind(features,
                    subject,
                    activity)

# Setting the column names
labSubject <- "subject"
labActivity <- "activity"
labFeatures <- read.table(file = file.path(filepath, "features.txt"),
                          header = FALSE)
labFeatures <- labFeatures$V2
colnames(mergedData) <- c(labFeatures,
                          labSubject,
                          labActivity)

#---------------------------------------------------------------------------------------------------
## STEP 2: MEAN AND STANDARD DEVIATION EXTRACTION

# Using grepl to find the required columns
dataTidy <- mergedData[, grepl("mean|std|subject|activity", 
                                   colnames(mergedData))]


#---------------------------------------------------------------------------------------------------
## STEP 3: DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET

# Reading the activity labels
actLabs <- read.table(file = file.path(filepath, 
                                       "activity_labels.txt"),
                      header = FALSE)

# Modifying the activity labels in the dataset
dataTidy$activity <- actLabs[dataTidy$activity, 2]

#---------------------------------------------------------------------------------------------------
## STEP 4: LABELLING THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES

# Changing 't' to 'Time'
names(dataTidy) <- gsub(pattern = "^t",
                        replacement = "Time", 
                        x = names(dataTidy))

# Changing 'f' to 'Frequency'
names(dataTidy) <- gsub(pattern = "^f", 
                        replacement = "Frequency", 
                        x = names(dataTidy))

# Changing 'Acc' to 'Accellarator'
names(dataTidy) <- gsub(pattern = "Acc",
                        replacement =  "Accelerometer", 
                        x = names(dataTidy))

# Removing '-'
names(dataTidy) <- sub(pattern = "-", 
                       replacement = "", 
                       x = names(dataTidy))

# Removing '()'
names(dataTidy) <- gsub(pattern = "\\(|\\)", 
                        replacement = "", 
                        x = names(dataTidy))

names(dataTidy) <- sub(pattern = "mean", 
                       replacement = "Mean", 
                       x = names(dataTidy))

# Changing 'std' to 'Std'
names(dataTidy) <- sub(pattern = "std", 
                       replacement = "Std", 
                       x = names(dataTidy))

# Changing 'Gyro' to 'Gyroscope'
names(dataTidy) <- gsub(pattern = "Gyro", 
                        replacement = "Gyroscope", 
                        x = names(dataTidy))

# Changing 'Mag' to 'Magnitude'
names(dataTidy) <- gsub(pattern = "Mag", 
                        replacement = "Magnitude", 
                        x = names(dataTidy))

# Removing the repitition of 'Body'
names(dataTidy) <- gsub(pattern = "BodyBody", 
                        replacement = "Body", 
                        x = names(dataTidy))

# Viewing the names
names(dataTidy)

#---------------------------------------------------------------------------------------------------
## STEP 5: GETTING THE AGGREGATE DATA

# Taking the mean
dataAgg <- dataTidy %>% 
  group_by(subject, activity) %>% 
  summarise_each(funs(mean))

# Viewing the data
head(dataAgg, 5)

# Outputting the data in the form of a file
write.table(x = dataAgg, 
            file = "tidydata.txt", 
            row.name=FALSE)
