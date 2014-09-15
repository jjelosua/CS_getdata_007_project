# Import libraries
library(dplyr)
# Read into R the common descriptions data files
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE,col.names=c("activity_id","activity_label"))
measurements_labels <- read.table("UCI HAR Dataset/features.txt",header=FALSE,col.names=c("subject_id","label"))
# Read into R the test data files
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",header = FALSE,col.names=c("subject_id"))
#Same column name for the id ("activity_id") as the activity_labels data set to merge them together easily with dplyr
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt",header = FALSE,col.names=c("activity_id"))
measurements_test <- read.table("UCI HAR Dataset/test/X_test.txt",header = FALSE)
# Read into R the train data files
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",header = FALSE,col.names=c("subject_id"))
#Same column name for the id ("activity_id") as the activity_labels data set to merge them together easily with dplyr
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt",header = FALSE,col.names=c("activity_id"))
measurements_train <- read.table("UCI HAR Dataset/train/X_train.txt",header = FALSE)

# Let's name the variables of our measurements dataset prior to any data manipulation
# that can change the order of our variables
# apply this new labels to the columns of our test and train measurements data sets
names(measurements_test) <- measurements_labels$label
names(measurements_train) <- measurements_labels$label

# Now that we have the names assigned to the measurements 
# we can safely combine the different parts of each dataset
train_dataset <- cbind(subject_train,activity_train,measurements_train)
test_dataset <- cbind(subject_test,activity_test,measurements_test)
# Finally combine both datasets (train and test) into one
data <- rbind(train_dataset,test_dataset)

#Perform the steps of the course project with the help of dplyr and his chain syntax
data %>%
    # Extract only the measurements on the mean and standard deviation for each measurement
    # We are ignoring meanFreq() since it is a weighted average and not a mean
    # does not have a corresponding standard deviation calculation
    # We are also ignoring all the angle columns since it is not a mean of a measurement but 
    # it is using a mean value to calculate an angle between two vectors.
    select(subject_id, activity_id, contains("mean\\(\\)"), contains("std\\(\\)")) %>%
    # Add the appropriate activity label to the dataset
    inner_join(activity_labels,by="activity_id") %>%
    # Generate the new tidy dataset with the average of each variable 
    # for each activity and each subject.
    group_by(subject_id,activity_id,activity_label) %>%
    # Use dplyr summarise_each function to compute the mean 
    # for all the selected measurements
    summarise_each(funs(mean)) %>%
    #Generate the output text file from the tidy dataset
    write.table("./output.txt",row.names=FALSE)