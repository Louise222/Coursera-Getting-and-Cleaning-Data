#Getting and Cleaning Data Project Code Book

This file describes the data, the variables I used for getting a tidy data set.

* The site where the data was obtained:
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  The data for the project:
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* The structure of the data used for this project:
  have a look at data_structure.jpg in this folder.

* The variables in run_analysis.R script:
  1. train_set, train_label and train_subject: they are variables used for store the data.frame loaded from "./data/train" and 
  represent X_train, y_train, and subject_train respectively. 
  2. test_set, test_label and test_subject: they are variables used for store the data.frame loaded from "./data/test" and 
  represent X_test, y_test, and subject_test respectively. 
  3. merged_set, merged_label, merged_subject: they are variables used to merge the data.frame created in the above 2 steps.
  the data from "train" are arranged on upper part and from "test" on lower part.
  4. features: it is a variable used to store the data of features.txt in "./data".
  5. extract_indices: it is the indices represent the rows of features concerns with mean and standard deviation.
  6. extract_set, extract_features: they are extraced data.frame from merged_set and features by extrace_indices.
  7. activity: it is a variable used to store the data of activity_labels.txt in "./data".
  8. merged_data: it is a variable used to merge merged_subject, merged_label and extract_set, in this order. Since I have renamed
  all of them with descripitive names, you can view this data.frame easily.
  9. group_data: group the merged_data by subject, activity, in this order.
  10. tidy_data: a tidy data set with the average of each variable for each activity and each subject.

© Yingjie Cao 2015 All Rights reserved.
