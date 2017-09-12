setwd("C:\\Users\\Sandesh Nayak\\Desktop\\Study\\Machine Learning Resources\\R Programs\\Insurance Data")

################### Read and Analyse Data##################################
library(ggplot2)
insurance_data <- read.csv("Data.csv")
str(insurance_data)
insurance_data[!complete.cases(insurance_data),]
head(insurance_data)
insurance_data$previous_claim <- as.factor(insurance_data$previous_claim)
table(insurance_data$claim)
ggplot(data = insurance_data, aes(x = id, y = previous_claim, colour = claim)) + geom_point()
insurance_data <- insurance_data[-1]
################### Split data into training and test sets###############

samples <- sample(1000,800)
train_data <- insurance_data[samples,]
test_data <- insurance_data[-samples,]
table(train_data$claim)
table(test_data$claim)
################## Train data with Random Forest default parameters ########################

library(randomForest)
set.seed(300)
rf <- randomForest(claim ~ ., data = train_data, mtry = 4)
prediction <- predict(rf, test_data, type = "response")
table(prediction, test_data$claim)

################## Since data set and number of features are small, retry with smaller size tree #############

rf <- randomForest(claim ~ ., data = train_data, ntree = 300) #Error rate increased

################## Retry with larger tree ########################

rf <- randomForest(claim ~ ., data = train_data, ntree = 800) #No significant change in the error rate

##################### Evaluate performance using Caret ############

library(caret)
ctrl_rf <- trainControl(method = "repeatedcv", number = 10, repeats = 10)
grid_rf <- expand.grid(.mtry = c(2,4))
m_rf <- train(claim ~ ., data = train_data, method = "rf", metric = "Kappa", trControl = ctrl_rf, tuneGrid = grid_rf)