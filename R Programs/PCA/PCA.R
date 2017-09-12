setwd("C:\\Users\\Sandesh Nayak\\Desktop\\Study\\Machine Learning Resources\\R Programs\\PCA")
train <- read.csv("Train_UWu5bXk.csv")
test <- read.csv("Test_u94Q5KV.csv")

test$Item_Outlet_Sales <- 1
combi <- rbind(train, test)
combi$Item_Weight[is.na(combi$Item_Weight)] <- median(combi$Item_Weight, na.rm = TRUE)
combi$Item_Visibility <- ifelse(combi$Item_Visibility == 0, median(combi$Item_Visibility),combi$Item_Visibility)
table(combi$Outlet_Size, combi$Outlet_Type)
levels(combi$Outlet_Size)[1] <- "Other"
my_data <- subset(combi, select = -c(Item_Outlet_Sales, Item_Identifier,Outlet_Identifier))
colnames(my_data)
str(my_data)
install.packages("dummies")
library(dummies)
new_my_data <- dummy.data.frame(my_data, names = c("Item_Fat_Content","Item_Type",
                                                   "Outlet_Establishment_Year","Outlet_Size",
                                                   "Outlet_Location_Type","Outlet_Type"))
str(new_my_data)
pca.train <- new_my_data[1:nrow(train),]
pca.test <- new_my_data[-(1:nrow(train)),]
prin_comp <- prcomp(pca.train, scale. = T)
names(prin_comp)
prin_comp$center
prin_comp$scale
prin_comp$rotation[1:5,1:4]
biplot(prin_comp, scale = 0)
std_dev <- prin_comp$sdev
pr_var <- std_dev^2
pr_var[1:10]
prop_varex <- pr_var/sum(pr_var)
prop_varex[1:20]

plot(prop_varex, xlab = "Principal Component",
     ylab = "Proportion of Variance Explained",
     type = "b")

plot(cumsum(prop_varex), xlab = "Principal Component",
     ylab = "Cumulative Proportion of Variance Explained",
     type = "b")

train.data <- data.frame(Item_Outlet_Sales = train$Item_Outlet_Sales, prin_comp$x)
train.data <- train.data[,1:31]

library(rpart)
rpart.model <- rpart(Item_Outlet_Sales ~ .,data = train.data, method = "anova")
rpart.model
test.data <- predict(prin_comp, newdata = pca.test)
test.data <- as.data.frame(test.data)
test.data <- test.data[,1:30]
rpart.prediction <- predict(rpart.model, test.data)

rpart.prediction
sample <- read.csv("SampleSubmission_TmnO39y.csv")
final.sub <- data.frame(Item_Identifier = sample$Item_Identifier, Outlet_Identifier = sample$Outlet_Identifier, Item_Outlet_Sales = rpart.prediction)
write.csv(final.sub, "pca.csv",row.names = F)