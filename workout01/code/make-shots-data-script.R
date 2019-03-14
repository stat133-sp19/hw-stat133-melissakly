## ---------------------------
##
## Title: Data Preparation
##
## description: create a csv data file shots-data.csv that will contain the required variables to be used in the visualization phase
## input(s): CSV files for each player in the data folder - stephen-curry.csv, kevin-durant.csv, klay-thompson.csv, andre-iguodala.csv, draymond-green.csv  
## output(s): Summary of each player's shot data in text files 
## Author: Melissa Ly
##


setwd("~/Desktop/hw-stat133/workout01/data")

curry <- read.csv("stephen-curry.csv", stringsAsFactors = FALSE)
summary(curry)
thompson <- read.csv("klay-thompson.csv")
durant <- read.csv("kevin-durant.csv")
green <- read.csv("draymond-green.csv")
iguodala <- read.csv("andre-iguodala.csv", quote = "", row.names = NULL, stringsAsFactors = FALSE)

curry$name <- "Stephen Curry"
thompson$name <- "Klay Thompson"
durant$name <- "Kevin Durant"
green$name <- "Draymond Green"
iguodala$name <- "Andre Iguodala"

curry$shot_made_flag <- ifelse(curry$shot_made_flag=="y", "shot_yes", "shot_no")
thompson$shot_made_flag <- ifelse(thompson$shot_made_flag=="y", "shot_yes", "shot_no")
durant$shot_made_flag <- ifelse(durant$shot_made_flag=="y", "shot_yes", "shot_no")
green$shot_made_flag <- ifelse(green$shot_made_flag=="y", "shot_yes", "shot_no")
summary(iguodala)
iguodala$shot_made_flag <- ifelse(iguodala$shot_made_flag=="y", "shot_yes", "shot_no")

sink(file = "../output/stephen-curry-summary.txt")
summary(curry)
sink()
sink(file = "../output/klay-thompson-summary.txt")
summary(thompson)
sink()
sink(file = "../output/kevin-durant-summary.txt")
summary(durant)
sink()
sink(file = "../output/draymond-green-summary.txt")
summary(green)
sink()
sink(file = "../output/andre-iguodala-summary.txt")
summary(iguodala)
sink()

stack_players <- rbind(curry, thompson, durant, green, iguodala)
summary(thompson)
write.csv(stack_players, "shots-data.csv")
sink("../output/shots-data-summary.txt")
summary(stack_players)
summary(curry)
sink()

