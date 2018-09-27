run_analysis <- function()
{
    # Load the packages needed
    
    library(dplyr)
    
    
    
    # Download and unzip data
    
    file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url=file_url, destfile="UCI_HAR_Dataset.zip")
    unzip(zipfile="UCI_HAR_Dataset.zip")
    
    
    
    # Read data
    
        # Training data
    
    training_x <- read.table("./UCI HAR Dataset/train/X_train.txt")
    training_y <- read.table("./UCI HAR Dataset/train/Y_train.txt")
    training_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    
        # Test data
    
    test_x <- read.table("./UCI HAR Dataset/test/X_test.txt")
    test_y <- read.table("./UCI HAR Dataset/test/Y_test.txt")
    test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    
        # Feature names
    
    features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
    
        # Activity names
    
    activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
    
    
    
    # Merge the data
    
    data_training <- cbind(subject=training_subject, activity=training_y, training_x)
    data_test <- cbind(subject=test_subject, activity=test_y, test_x)
    
    data <- rbind(data_training, data_test)
    colnames(data)[1] <- "subject"
    colnames(data)[2] <- "activity"
    
    
    
    # Get indices of features on the mean and standard deviation of measurements
    
    indices_mean <- grep("mean()", features[,2], fixed=TRUE)
    indices_std <- grep("std()", features[,2], fixed=TRUE)
    
        # Extract first two columns (subject, activity) and the mean-/std-features (thus +2 for the indices)
    
    indices <- c(indices_mean, indices_std)
    data <- data[,c(1,2,indices+2)]
    
        # Order the data with respect to the subject (and after that, activity)
    
    data <- data[order(data[,1], data[,2]),]
    
    
    
    # Descriptive variable names for the activities:
    
        # Transform activity labels into a better readable form
    
    activity_labels[,2] <- tolower(gsub("_", ".", activity_labels[,2]))
    
        # Replace numbers representing the activity by activity name
    
    data[,2] <- activity_labels[data[,2],2]
    
    
    
    # Make feature names better readable (we need this only for the -mean() and -std() features)
    
        # Replace initial "t" by "time", initial "f" by "frequency"
    
    features[,2] <- sub("^t", "time", features[,2])
    features[,2] <- sub("^f", "frequency", features[,2])
    
        # Replace "-mean()" and "-std()" by ".mean" und ".standard.deviation"
    
    features[,2] <- sub("-mean\\(\\)", ".mean", features[,2])
    features[,2] <- sub("-std\\(\\)", ".standard.deviation", features[,2])
    
        # Insert periods between words starting with capital letters and delete hyphens
    
    features[,2] <- gsub("([A-Z])", ".\\1", features[,2])
    features[,2] <- gsub("-", "", features[,2])
    
        # Only use lower cases
    
    features[,2] <- tolower(features[,2])
    
        # Replace abbreviations ("acc", "mag" and so on)
    
    features[,2] <- gsub("acc", "accelerometer", features[,2])
    features[,2] <- gsub("gyro", "gyroscope", features[,2])
    features[,2] <- gsub("mag", "magnitude", features[,2])
    
    
    
    # Rename the columns (except for the initial two (subject, activity)) appropriately
    
    colnames(data)[3:ncol(data)] <- features[indices,2]
    
    
    
    # Compute the mean of the observations for every combination of subject/activity
    
    data_summarized <- summarize_each(group_by(data, subject, activity), funs(mean))
    
        # Save this independant tidy data set
    
    write.table(data_summarized, file="tidy_data.txt")
}