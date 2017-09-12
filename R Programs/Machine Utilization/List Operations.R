setwd("C:\\Users\\Sandesh Nayak\\Desktop\\Study\\Machine Learning Resources\\R Programs\\Machine Utilization")
machine <- read.csv("Machine-Utilization.csv",na.strings = "NA")
head(machine,12)
str(machine)
summary(machine)

#Derive utilization
machine$utilization <- 1-machine$Percent.Idle
tail(machine)

machine$PosixTime <- as.POSIXct(machine$Timestamp,format = "%d/%m/%Y %H:%M")
head(machine,12)

summary(machine)

machine$Timestamp <- NULL

machine <- machine[,c(4,1,2,3)]

RL1 <- machine[machine$Machine=="RL1",]
summary(RL1)
RL1$Machine <- factor(RL1$Machine)

#Construct list



util_stats_rl1 <- c(min(RL1$utilization, na.rm = T),mean(RL1$utilization, na.rm = T),max(RL1$utilization, na.rm = T))
length(which(RL1$utilization < 0.90))

util_under_90_flag <- as.logical(length(which(RL1$utilization < 0.90)))

list_rl1 <- list("RL1",util_stats_rl1,util_under_90_flag)

names(list_rl1) <- c("Machine","Stats","LowThreshold")
rm(list_rl1)

list_rl1 <- list(Machine="RL1",Stats=util_stats_rl1,LowThreshold=util_under_90_flag)


#Extract values

list_rl1[1]
list_rl1[[1]]
list_rl1$Machine


typeof(list_rl1[[2]])
typeof(list_rl1[2])
typeof(list_rl1$Stats)

#Access 3rd element of the vector

list_rl1
list_rl1[[2]][3]
list_rl1$Stats[3]

list_rl1$LowThreshold
list_rl1[[3]]
list_rl1[3]

typeof(list_rl1$LowThreshold)
typeof(list_rl1[[3]])
typeof(list_rl1[3])

#Adding and Deleting list items

list_rl1
list_rl1[4] <- "New Information"
RL1

list_rl1$UnknownHours <- RL1[is.na(RL1$utilization),"PosixTime"]

list_rl1

#Remove a component

list_rl1[4] = NULL
list_rl1[4]

list_rl1$Data <- RL1

summary(list_rl1)

list_rl1$UnknownHours

list_rl1[c(1,5)]

summary(list_rl1)
list_rl1[c("Machine","UnknownHours")]

#Timeseries Plot

library(ggplot2)

p <- ggplot(data=machine)
myplot <- p+geom_line(aes(x=PosixTime,y=utilization,colour=Machine),size=1.2) + facet_grid(Machine~.) +
  geom_hline(yintercept = 0.9,colour="Gray",size=1.2,linetype=3)

myplot

list_rl1$Plot <- myplot
str(list_rl1)
summary(list_rl1)