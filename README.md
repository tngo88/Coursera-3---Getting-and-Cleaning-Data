OVERVIEW (as obtained from http://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones)
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

HOW TO EXECUTE THE SCRIPT:
- OPTIONAL: Install latest version of the 'dplyr' library
- Uncomment line #8 in the script 'run_analysis.R'
- Replace <YOUR_WORKING_DIRECTORY> by your working directory
- Run the script 'run_analysis.R'

EXECUTE the script 'run_analysis.R' will generate an independent tidy data set called 'tidy_data.txt' with the average of each variable for each activity and each subject.