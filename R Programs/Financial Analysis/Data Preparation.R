getwd()
setwd("C:\\Users\\Sandesh Nayak\\Desktop\\Study\\Machine Learning Resources\\R Programs\\Financial Analysis")

#Basic
#data <- read.csv("Future-500.csv")
data <- read.csv("Future-500.csv",na.strings = c(""))
str(data)
head(data)

#Changing from non factor to factor

data$ID <- factor(data$ID)
data$Inception <- factor(data$Inception)

#Factor Variable Trap
a <- c("12","13","14","12","12")
b <- as.numeric(a)

z <- factor(c("12","13","14","12","12"))
z

y <- as.numeric(z)

#Correct way to convert factor to numeric
y <- as.numeric(as.character(z))
y

data$Profit <- factor(data$Profit)
str(data)

data$Profit <- as.numeric(as.character(data$Profit))
str(data)
data$Profit

data$Expenses <- gsub(" Dollars","",data$Expenses)
data$Revenue <- gsub("\\$","",data$Revenue)
data$Revenue <- gsub("\\,","",data$Revenue)
data$Expenses <- gsub(",","",data$Expenses)
head(data)

data$Growth <- gsub("%","",data$Growth)

str(data)
data$Revenue <- as.numeric(data$Revenue)
data$Expenses <- as.numeric(data$Expenses)
data$Growth <- as.numeric(data$Growth)

summary(data)

head(data,24)

data[!complete.cases(data),]

data[which(data$Revenue==9746272),]
data[data$Employees==45,]
data[which(data$Employees==45),]
data[is.na(data$Revenue),]

data[is.na(data$State),]

data[!complete.cases(data),]

data_backup <- data

data[!complete.cases(data),]
data[is.na(data$Revenue),]
data <- data_backup
data <- data[!is.na(data$Industry),]

tail(data)
data[is.na(data$State) & data$City=="New York","State"] <- "NY"
data[is.na(data$State) & data$City=="San Francisco","State"] <- "CA"

retail <- data[which(data$Industry=="Retail"),]
financial <- data[which(data$Industry=="Financial Services"),]
construction <- data[which(data$Industry=="Construction"),]
median_employee_retail <- median(retail$Employees,na.rm = TRUE)
median_employee_financial <- median(financial$Employees,na.rm = TRUE)
median_growth_construction <- median(construction$Growth,na.rm = TRUE)
median_revenue_construction <- median(construction$Revenue,na.rm = TRUE)
median_expenses_construction <- median(construction$Expenses,na.rm = TRUE)
data_backup <- data

data[is.na(data$Employees) & data$Industry=="Retail","Employees"] <- median_employee_retail
data[is.na(data$Employees) & data$Industry == "Financial Services","Employees"] <- median_employee_financial
data[is.na(data$Growth) & data$Industry == "Construction","Growth"] <- median_growth_construction
data[is.na(data$Revenue) & data$Industry == "Construction","Revenue"] <- median_revenue_construction
data[is.na(data$Expenses) & data$Industry == "Construction","Expenses"] <- median_expenses_construction
data[is.na(data$Profit) & data$Industry == "Construction","Profit"] <- median_revenue_construction - median_expenses_construction
data[is.na(data$Expenses) & data$Industry == "IT Services","Expenses"] <- data[is.na(data$Expenses) & data$Industry == "IT Services","Revenue"] - data[is.na(data$Expenses) & data$Industry == "IT Services","Profit"]
data[data$ID==17,]

library(ggplot2)

ggplot(data = data, aes(x=Revenue,y=Expenses,size=Profit,colour=Industry)) + geom_point()
ggplot(data = data, aes(x=Revenue,y=Expenses,colour=Industry)) + geom_point() + geom_smooth(fill=NA,size=1.2)
ggplot(data = data, aes(x=Industry,y=Growth,colour=Industry)) + geom_jitter()+geom_boxplot(alpha=0.5,outlier.color = NA)
