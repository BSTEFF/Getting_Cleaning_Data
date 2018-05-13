


library(plyr)


# read and combine x-test and x-train set
x_test = read.csv(file = "UCI HAR Dataset/test/x_test.txt",header = FALSE, sep = "")
x_train = read.csv(file = "UCI HAR Dataset/train/x_train.txt",header = FALSE, sep = "")
x_merge = rbind(x_test, x_train)

# read and combine  y-test and y-train set
y_test = read.csv(file = "UCI HAR Dataset/test/y_test.txt",header = FALSE)
y_train = read.csv(file = "UCI HAR Dataset/train/y_train.txt",header = FALSE)
y_merge = rbind(y_test, y_train)
#y_merge$V1 = as.factor(y_merge$V1)

# read and combine  subject-test and subject-train set
subject_test = read.csv(file = "UCI HAR Dataset/test/subject_test.txt",header = FALSE)
subject_train = read.csv(file = "UCI HAR Dataset/train/subject_train.txt",header = FALSE)
subject_merge = rbind(subject_test, subject_train)
names(subject_merge) = "Subject_ID"

#read features and activity vector labels
features = read.csv(file = "UCI HAR Dataset/features.txt", header = FALSE, sep = "")
features = features[2]
features$V2 = as.character(features$V2)

activity_labels = read.csv(file = "UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "")

#give correct names to x_merge columns 
names(x_merge) = features$V2

#Extracting columns which include mean and std measurements
x_merge_mean_std = grep(pattern = "mean|std",x = names(x_merge))
x_merge_mean_std = x_merge[,x_merge_mean_std]

#Descriptive Activity Names
Activities = join(y_merge,activity_labels)
names(Activities) = c("Activities_ID","Activities")

#Melted & cleaned dataset
Dataset_cleaned = cbind(subject_merge,Activities,x_merge_mean_std)

Dataset_cleaned$Activities <- factor(Dataset_cleaned$Activities, levels = Dataset_cleaned$Activities_ID, labels = Dataset_cleaned$Activities)

Dataset_cleaned$Subject_ID = as.factor(Dataset_cleaned$Subject_ID)
Dataset_cleaned$Activities_ID = as.factor(Dataset_cleaned$Activities_ID)
Dataset_cleaned_merged = melt(data = Dataset_cleaned)

#Mean calculation
Dataset_cleaned_merged_mean <- dcast(Dataset_cleaned_merged, Subject_ID + Activities_ID ~ variable, mean)

#output
write.table(Dataset_cleaned_merged_mean, "Cleaned.txt", row.names = FALSE, quote = FALSE)



```


