Getting and cleaning data - course project
==========================================

First of all I would like to thank David Hood for his excellent [FAQ thread][1] that guided and inspired my reasoning process.
[1]: https://class.coursera.org/getdata-007/forum/thread?thread_id=49

##Initial settings:
We will make use of the dplyr library functions (chain,select,etc) so you need to install that package if you still don't have it in order to be able to run the code

I assume that the run_analysis.R script is in the working directory.

I also assume that the original dataset has been unzipped in the working directory where the run_analysis.R is so for example to read the test X_test.txt file you can do that by invoking:
```
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE,col.names=c("activity_id","activity_label"))
```

##Running the script code

Once you have made sure that your initial settings are in place you can run the code to generate the tidy data set by sourcing the run_analysis.R file
```
source("run_analysis.R")
```
##Output file

After you run the code a file called "output.txt" will be created with the new tidy dataset in your working directory

You can check that from R using:
```
dir()
```


##Reading the output file back into R

To read the output file into R you can use the following commands
```
data <- read.table(file_path_to_output_file, header = TRUE)
View(data)
```