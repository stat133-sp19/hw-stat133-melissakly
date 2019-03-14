## ---------------------------
##
## Title: Data Preparation
##
## description: create shot charts for each player
## input(s): data frames creates in the previous question: stephen-curry.csv, kevin-durant.csv, klay-thompson.csv, andre-iguodala.csv, draymond-green.csv  
## output(s): A visualization of each player's shot data saved in outputs folder
## Author: Melissa Ly
##

library(ggplot2)
library(grid)
library(jpeg)
library(dplyr)
setwd("~/Desktop/hw-stat133/workout01/data")

# court image (to be used as background of plot)
court_file <- "../images/nba-court.jpg"
# create raste object
court_image <- rasterGrob(readJPEG(court_file), width = unit(1, "npc"), height = unit(1, "npc"))

klay_scatterplot <- ggplot(data = thompson) + geom_point(aes(x = x, y = y, color = shot_made_flag))

pdf(file = "../images/klay-thompson-shot-chart.pdf", width = 6.5, height = 5)
klay_shot_chart <- ggplot(data = thompson) + annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle("Shot Chart: Klay Thompson (2016 season)") + 
  theme_minimal()
dev.off()

pdf(file = "../images/andre-iguodala-shot-chart.pdf",
    width = 6.5, height = 5)
iguodala_shot_chart <- ggplot(data = iguodala) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle("Shot Chart: Draymond Green (2016 season)") + 
  theme_minimal()

pdf(file = "../images/stephen-curry-shot-chart.pdf",
    width = 6.5, height = 5)
curry_shot_chart <- ggplot(data = curry) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle("Shot Chart: Stephen Curry (2016 season)") + theme_minimal()
curry_shot_chart

pdf(file = "../images/kevin-durant-shot-chart.pdf",
    width = 6.5, height = 5)
durant_shot_chart <- ggplot(data = durant) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle("Shot Chart: Kevin Durant (2016 season)") + 
  theme_minimal()
durant_shot_chart

pdf(file = "../images/draymond-green-shot-chart.pdf",
    width = 6.5, height = 5)
green_shot_chart <- ggplot(data = green) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle("Shot Chart: Draymond Green (2016 season)") + 
  theme_minimal()
green_shot_chart

pdf(file = "../images/gsw-shot-charts.pdf",
    width = 8, height = 7)
pdf(file = "../images/gsw-shot-charts.png",
    width = 8, height = 7)
gsw_shot_chart <- ggplot(data = stack_players) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle("Shot Chart: All (2016 season)") + theme_minimal()

final <- gsw_shot_chart + facet_wrap( ~ name, ncol = 3)
