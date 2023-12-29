library(ggplot2)
library(tidyverse)
library(dplyr)
library(tidyr)
library(lubridate)
library(data.table)
library(janitor)
library(skimr)

#datasets will be a list that contains each file containing data
file_list <- list.files(path = "Fitabase Data 4.12.16-5.12.16/", full.names = TRUE)
datasets <- lapply(file_list, fread)
names(datasets) <- gsub('.{11}$', '', basename(file_list))

#create a summary of the datasets and their relevant comparative statistics
ds_summary <- data.frame(
  sapply(datasets, nrow),
  sapply(datasets, ncol),
  sapply(datasets, FUN = function(x) {sum(is.na(x))}),
  sapply(datasets, FUN = function(x) {n_distinct(x[[1]])}),
  sapply(datasets, FUN = function(x) {sum(duplicated(x))})
)
names(ds_summary) <- c("# Rows", "# Columns", "# NA", "# Distinct ID", "# Duplicated")

ds_summary

#duplicates in weightLogInfo - figure out where
sapply(datasets$weightLogInfo, FUN = function(x) {sum(is.na(x))})

#duplicates in Fat column
datasets$weightLogInfo <- select(datasets$weightLogInfo, -Fat)
datasets$weightLogInfo

#duplicated in minuteSleep and sleepDay
datasets$sleepDay <- unique(datasets$sleepDay)
datasets$minuteSleep <- unique(datasets$minuteSleep) 

datasets$sleepDay

ds_summary

test = datasets$dailyActivity

test$ActivityDate = as.POSIXct(activity$ActivityDate, format="%m/%d/%Y", tz=Sys.timezone())
test$date <- format(test$ActivityDate, format="%m%d%Y")

head(test)

activity$ActivityDate=as.POSIXct(activity$ActivityDate, format="%m/%d/%Y", tz=Sys.timezone())
activity$date <- format(activity$ActivityDate, format = "%m/%d/%y")

colnames(activity)
