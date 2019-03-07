library(tidyverse)
library(data.table)

# Let's create a list that will store data tables of student test performance for each class.
unitEightExams <- list()

# Let's get the test information from our csv file. I only want the Names and Percent Scores.The first line is a heading so we can skip it.
for(i in c(2,3,4,5,6,8)){
  unitEightExams[[i]] <- fread(paste("Unit_8_ExamCSV_P",i,".csv", sep=""), skip = 1, select = c("Student Name", "Percent Score"))
}

# Let's change the names so that our data table is a bit easier to work with.
for(i in c(2,3,4,5,6,8)){
  unitEightExams[[i]] <- setnames(unitEightExams[[i]], c('Student Name', 'Percent Score'), c("StudentName","PercentScore"))
}

#Let's change our PercentScore values to percentages.
for(i in c(2,3,4,5,6,8)){
  sapply(unitEightExams[[i]]$PercentScore, function(x) {x*100})
}

# Let's create some scatter plots of the data tables.
for(i in c(2,3,4,5,6,8)){
  percentDp <- ggplot(data = unitEightExams[[i]], aes(x = StudentName, y = PercentScore)) + 
        geom_point() +
        coord_flip() +
        labs(title = paste("Period",i))
  plot(percentDp)
}