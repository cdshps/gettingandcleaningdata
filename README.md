# Read Me

The "run_analysis.R" script file performs the analysis required in the Week 4 course project of the Coursera "Getting and Cleaning Data" course. The dataset is taken from

*Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012*

and consists of measurements (and functions computed on them) of the gyroscope and accelerometer of a Samsung Galaxy S smartphone of 30 subjects while performing six activities (walking, walking upstairs, walking downstairs, sitting, standing, laying).

---

The URL to download the data can be taken from the "run_analysis.R" script file; downloading and unzipping the data is contained as a first step in the script. After that, the required analysis is performed. In particular:

* The training and test data is read into R separately. The training data consists of the features contained in training_x, which are themselves functions computed on the original signals measured by the scientists above; the labels specifying the activity performed, contained in training_y; and the subject that was performing the activity, contained in training_subject. The same holds for the test set with "training" replaced by "test" in each instance.
* The original feature names and activity labels are also read into R, since they are needed for the clear descriptions of the tidy data later on.
* After that, the three data frames containing the training data are merged together, with the subject and activity inserted as first two columns before the columns containing the (functions of the) signals. The same is done for the test set.
* Training set and test set are now merged together, with the test set being appended rowwise to the training set. The first two columns containing the subject and activity are named appropriately.
* As specified in the assignment, the features containing the mean and standard deviation of the original signals are now extracted. We chose to extract only those features exactly containing the "mean()" or "std()" strings, so features containing "meanFreq" and similar strings are discarded. The data is then being restricted to only those features (and the subject and activity columns).
* For later convenience, the resulting data is then ordered with respect to the subject and activity.
* The numbers serving as placeholders for the activity names are replaced by the concrete activity (with the strings specifying the activities transformed into lower case words separated by dots).
* The feature names contained in the features data frame are now altered to make them better readable. In particular, the initial abbreviations "t" and "f" are replaced by "time" and "frequency"; "mean()" and "std()" are changed to "mean" and "standard.deviation"; periods are being inserted between the words, with hyphens also replaced by periods; everything is cast to lower case; the abbreviations "acc", "gyro" and "mag" are replaced by "accelerometer", "gyroscope" and "magnitude".
* The columns containing the features are now being renamed using the readable feature names mentioned above.
* An new tidy data frame is created: The data is being grouped according to all possible combinations (=180) of subject (=30) and activity (=6), and then the mean is taken for each group separately. The result is a data frame with 180 rows (for each of the combinations) and 68 columns (2 columns for subject and activity, and 66 columns for the extracted features).
* This data frame is then saved in a text file "tidy_data.txt".

---

The tidy data required in the assignment is contained in the text file "tidy_data.txt" and can be read into R using the command *read.table("tidy_data.txt")*, provided the file is located in the working directory. For a description of the variables see the Code Book.