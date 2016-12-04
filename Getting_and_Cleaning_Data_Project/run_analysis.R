# install tidyr and dplyr libraries
install.packages("dplyr")
install.packages("tidyr")
library(dplyr)
library(tidyr)

# paths to UCI HAR Dataset data files
activitiesFilepath <- "./UCI HAR Dataset/activity_labels.txt"
featuresFilepath <- "./UCI HAR Dataset/features.txt"

testSubjectFilepath <- "./UCI HAR Dataset/test/subject_test.txt"
testXFilepath <- "./UCI HAR Dataset/test/X_test.txt"
testYFilepath <- "./UCI HAR Dataset/test/y_test.txt"

trainSubjectFilepath <- "./UCI HAR Dataset/train/subject_train.txt"
trainXFilepath <- "./UCI HAR Dataset/train/X_train.txt"
trainYFilepath <- "./UCI HAR Dataset/train/y_train.txt"

# read data files into tables
activities <- read.table(file = activitiesFilepath, 
                       stringsAsFactors = FALSE,
                       col.names = c('activity_id', 'activity_name'))

features <- read.table(file = featuresFilepath,
                       stringsAsFactors = FALSE,
                       col.names = c('feature_id', 'feature_name'))

testSubjects <- read.table(file = testSubjectFilepath,
                           stringsAsFactors = FALSE,
                           col.names = c('subject_id'))
testX <- read.table(file = testXFilepath)
testY <- read.table(file = testYFilepath, col.names = c('activity_id'))

trainSubjects <- read.table(file = trainSubjectFilepath,
                            stringsAsFactors = FALSE,
                            col.names = c('subject_id'))
trainX <- read.table(file = trainXFilepath)
trainY <- read.table(file = trainYFilepath, col.names = c('activity_id'))

# add column names to test and train data tables
columnNames <- make.names(names = features[["feature_name"]], 
                                 unique=TRUE, 
                                 allow_ = TRUE)
names(testX) <- columnNames
names(trainX) <- columnNames

# combine test data tables into one - test
test <- testX
test$subject_id <- testSubjects[["subject_id"]]
test$activity_id <- testY[["activity_id"]]

# combine train data tables into one - train
train <- trainX
train$subject_id <- trainSubjects[["subject_id"]]
train$activity_id <- trainY[["activity_id"]]

# combine test and train into one dataset - uciHarData
uciHarData <- rbind(test, train)

# make summary table from mean / std columns
summary <- uciHarData %>%
              select(subject_id, activity_id, matches("(mean|std)"))

# replace activity_id with activity_name
summary <- summary %>% 
              inner_join(activities) %>%
              select(-activity_id)

# create tidy data set with average of each variable by activity and subject
tidyData <- summary %>%
              group_by(subject_id, activity_name) %>%
              summarise_each(funs(mean))
