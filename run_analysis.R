# Step 1 - Read the required Data Sets
# Step 2 - Create most granular data set at subject/activity level
#   Step 2.1 - Create a tidy data set for train data
#   Step 2.2 - Create a tidy data set for test data
#   Step 2.3 - Merge the train and test data sets into one data set
# Step 3 - Create summary average data set at subject/activity level


#############
# Step1 - Read the required Data Sets
#  Check if the source zip file exists. If not download the file 
#  Check if the zip file is unzipped already. If not unzip the file 
#  Note: The directory name in the zipped file is retained. 
#        So this phase checks if the directlry exists and does not check
#        the content of the directory.
#  For Train records
#  - subject_train from subject_train.txt
#  - x_train from train/X_train.txt
#  - y_train from train/y_train.txt
#  For Test records
#  - subject_test from subject_test.txt
#  - x_test from test/X_test.txt
#  - y_test from test/y_test.txt
#  For reference records
#  - features from features.txt
#  - activity from activity_labels.txt
#############

#getwd()
if (!file.exists("UCI_HAR_Dataset.zip")) {
  fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  setInternet2(use = TRUE)
  download.file(fileURL,"UCI_HAR_Dataset.zip",method='internal')
}
if (!file.exists("UCI HAR Dataset")) {
  unzip("UCI_HAR_Dataset.zip")
}

subject_train = read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)
x_train = read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)
y_train = read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)

subject_test = read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)
x_test = read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)
y_test = read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE)

features = read.table("UCI HAR Dataset/features.txt",header=FALSE)
activity = read.table("UCI HAR Dataset/activity_labels.txt",header = FALSE)

#############
# Step 2 - Create most granular data set at subject/activity level
#   Step 2.1 - Create a tidy data set for train data
#   Step 2.2 - Create a tidy data set for test data
#   Step 2.3 - Merge the train and test data sets into one data set
#############
#############
# Build a list of indices for referring to mean and std fields only
#############
mean_vars = grep("mean()",fixed=TRUE,as.character(features[,2]))
std_vars = grep("std()",fixed=TRUE,as.character(features[,2]))
indices = sort(c(mean_vars,std_vars))
#############
# Attach activity description to each train record
#############
y_train_a = merge(y_train,activity,by.x="V1",by.y="V1",all=TRUE)

#############
# Build the train data frame with the below structure:
#  1) type : "Train" (for test records this value will be "Test")
#  2) subject : direct from source
#  3) activity_ID: direct from source
#  4) activity_desc: description of the activity by joining y_train and activity data sets
#  5) 66 variables for mean (33 variables) and std (33 variables) measurement 
#     of the activity per subject
#############
train = data.frame("Train",factor(subject_train$V1),factor(y_train_a$V1),factor(y_train_a$V2),x_train[, indices])
colnames(train) = c("type", "subject","activity_ID","activity_desc",as.character(features[indices,2]))

#############
# Attach activity description to each test record
#############
y_test_a = merge(y_test,activity,by.x="V1",by.y="V1",all=TRUE)
#############
# Repeat the same logic as train for building the test data frame
# No need to rebuild the indices for test as it's the same for train
#############
test = data.frame("Test",factor(subject_test$V1),factor(y_test_a$V1),y_test_a$V2,x_test[, indices])
colnames(test) = c("type", "subject","activity_ID","activity_desc",as.character(features[indices,2]))

# Append train and test data frames into the final tidy data set: final_train_test
final_train_test = rbind(train,test)

# Store the data frame as a .csv file
write.csv(final_train_test,"final_train_test.csv")

#############
# Step 3 - Create summary average data set at subject/activity level
#############
summary.data <- ddply(final_train_test, .(subject, activity_desc), numcolwise(mean))


# Store the summary data frame as a .csv file
write.csv(summary.data,"final_train_test_summ.csv")
