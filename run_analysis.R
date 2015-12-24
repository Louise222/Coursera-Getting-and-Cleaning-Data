# Download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# unzip this file and rename it "data", put it in Home so if you run this analysis, the data can be visited directly

# 1.Merges the training and the test sets to create one data set.
train_set<-read.table("data/train/X_train.txt")
dim(train_set)  # 7352 rows and 561 columuns
train_label<-read.table("data/train/y_train.txt")
table(train_label)
train_subject<-read.table("data/train/subject_train.txt")
table(train_subject)
test_set<-read.table("data/test/X_test.txt")
dim(test_set)  # 2947 rows and 561 columns
test_label<-read.table("data/test/y_test.txt")
table(test_label)
test_subject<-read.table("data/test/subject_test.txt")
table(test_subject)
# merge the train and test 
merged_set<-rbind(train_set,test_set)
dim(merged_set)   # 10299 rows and 561 columns
merged_label<-rbind(train_label,test_label)
merged_subject<-rbind(train_subject,test_subject)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
features<-read.table("data/features.txt")
dim(features)  # 561 rows and 2 columns
extract_indices<-grep("mean\\(\\)|std\\(\\)",features[,2])
# explain for expression above: the true mean or std must be independent  
# rather than expressions like "fBodyAccMag-meanFreq()"
extract_set<-merged_set[,extract_indices]
dim(extract_set)  # 10299 rows and 66 columns
extract_features<-features[extract_indices,]
dim(extract_features)  # 66 rows and 2 columns

# 3.Uses descriptive activity names to name the activities in the data set.
activity<-read.table("data/activity_labels.txt")
activity[,2]<-tolower(sub("_","",activity[,2]))
activity[2,2]<-substr(activity[2,2],8,nchar(activity[2,2])) # using upstairs to raplace walkingupstairs
activity[3,2]<-substr(activity[3,2],8,nchar(activity[3,2]))  # using downstairs to raplace walkingdownstairs
merged_label[,1]<-activity[merged_label[,1],2]  # using activtity names to rename numbers in merged_label
names(merged_label)<-"activity"

# 4.Appropriately labels the data set with descriptive variable names.
extract_features[,2]<-gsub("\\(\\)","",extract_features[,2])  # remove () 
extract_features[,2]<-gsub("mean","Mean",extract_features[,2])  # repace mean with Mean
extract_features[,2]<-gsub("std","Std",extract_features[,2])  # remove std with Std
extract_features[,2]<-gsub("-","",extract_features[,2])  # remove all the "-"
names(extract_set)<-t(extract_features[,2])

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of
# each variable for each activity and each subject.
names(merged_subject)<-"subject"
merged_data<-cbind(merged_subject,merged_label,extract_set)
dim(merged_data)  # 10299 rows and 68 columns
library(dplyr)
group_data<-group_by(merged_data,subject,activity) # group with subject first and then activity
tidy_data<-summarize_each(group_data,funs(mean))
dim(tidy_data)  # 180 rows and 68 columns
write.table(tidy_data,file = "tidydata.txt",row.names = FALSE)
