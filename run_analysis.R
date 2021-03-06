#### Creates tidy data from the input by applying various filtering and selection as described in the
#### problem definition of the project (which is copied below).
#### Creates an R script run_analysis.R that does the following:
####
#### 1. Merges the training and the test sets to create one data set.
#### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#### 3. Uses descriptive activity names to name the activities in the data set
#### 4. Appropriately labels the data set with descriptive variable names.
#### 5. From the data set in step 4, creates a second, independent tidy data set 
#### with the average of each variable for each activity and each subject.
####
#### In order to eliminate processing large amounts of unwanted data,
#### merging the data is done after filtering out unwanted data,
#### which is done early for performance reasons.
####
#### Dependency: The script uses data.table and dplyr packages.

#### Define all functions first. the entry point of the script starts at line 56.

#### Read and apply the specified processing on the given dataset.
#### Called with 'test' for test data and 'train' for training data.
read_and_process_data <- function (type) {
    # read all relevant data.
    X <- read.table(generate_path(type, "X"), sep = "", header = F, stringsAsFactors = F)
    y <- read.table(generate_path(type, "y"), sep = "", header = F, stringsAsFactors = F)
    sub <- read.table(generate_path(type, "subject"), sep = "", header = F, stringsAsFactors = F)

    # subset only mean and standard deviation for each measurement.
    X <- X[, mean_or_std_features]

    # Assign column names for the features
    colnames(X) <- features

    # replace activity ids with labels
    y[,1] <- activity_labels[y[,1]]

    # Assign column names for activity and subject
    colnames(y) <- activityLabel
    colnames(sub) <- subjectLabel

    # Bind subject, x & y data
    cbind(sub, y, X)
}

#### Generate path based on type
generate_path <- function(type, name) {
    paste0(dataPath, "/", type, "/", name,"_", type, ".txt")
}
#### End of functions

####
#### Entry point.
####

if (!require("data.table")) {
    install.packages("data.table")
}

if (!require("dplyr")) {
    install.packages("dplyr")
}

require("data.table")
require("dplyr")

#### Global constants: filenames, parameter names etc.
dataPath <- "./UCI HAR Dataset"
activityLabelsFilename <- "activity_labels.txt" 
featureFilename <- "features.txt" 
outputFilename <- "./tidy_data.txt"
activityLabel <- "Activity"
subjectLabel <- "Subject"

#### Read the feature names
features <- read.table(paste0(dataPath, "/", featureFilename), sep = "", header = F, stringsAsFactors = F)
#### We only need the fetaure names. drop the ids.
features <- features[,2]

#### Only extract mean and standard deviation for each measurement.
mean_or_std_features <- grepl("mean|std", features)
features <- features[mean_or_std_features]

#### Read the activity labels
activity_labels <- read.table(paste0(dataPath, "/", activityLabelsFilename), sep = "", header = F, stringsAsFactors = F)
#### We only need the activity names. drop the ids.
activity_labels <- activity_labels [,2]

#### Read and process test and train data
test_data <- read_and_process_data("test")
train_data <- read_and_process_data("train")

#### Merge training and test
merged_data <- rbind(test_data, train_data)

#### Generate tidy data as the final output
tidy_data <- merged_data %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))

#### Finally save the tidy data
write.table(tidy_data, file = outputFilename, row.names = F, sep=",")

#### End script
