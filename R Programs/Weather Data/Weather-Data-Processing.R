setwd("C:\\Users\\Sandesh Nayak\\Desktop\\Study\\Machine Learning Resources\\R Programs\\Weather Data")
Chicago <- read.csv("Chicago-F.csv",row.names = 1)
Houston <- read.csv("Houston-F.csv",row.names = 1)
NewYork <- read.csv("NewYork-F.csv",row.names = 1)
SanFrancisco <- read.csv("SanFrancisco-F.csv",row.names = 1)

is.matrix(Chicago)

Chicago <- as.matrix(Chicago)
Houston <- as.matrix(Houston)
NewYork <- as.matrix(NewYork)
SanFrancisco<- as.matrix(SanFrancisco)

Weather <- list(Chicago=Chicago,Houston=Houston,NewYork=NewYork,SanFrancisco=SanFrancisco)

Weather$Chicago

#apply family of function

apply(Chicago,1,mean)

mean(Chicago["DaysWithPrecip",])
apply(Chicago,1,max)

apply(Chicago,1,mean)
apply(Houston,1,mean)
apply(NewYork,1,mean)
apply(SanFrancisco,1,mean)

#Recreate apply function with loops

output <- NULL
for(i in 1:5) {
  output[i] <- mean(Chicago[i,])
}

names(output) <- row.names(Chicago)

apply(Chicago,1,mean)

?lapply

tWeather <- lapply(Weather,t)
list <- lapply(Weather,rbind,Newrow=1:12)

rowAverages <- lapply(Weather,rowMeans)

lapply(Weather,"[",1,1)

lapply(Weather,"[",1,3)

lapply(Weather,"[",1,3)

#Nesting custom functions in apply

lapply(Weather, function(X) { X[5,]})

Weather

lapply(Weather, function(X) { X[,12]})

lapply(Weather, function(X) { round((X[1,] - X[2,])/X[2,],2)})

lapply(Weather, function(X) { round((X[1,] ))})

lapply(Weather,"[",1,7)

sapply(Weather,"[",1,7)

lapply(Weather,"[",1,10:12)
sapply(Weather,"[",1,10:12)

round(sapply(Weather,rowMeans),2)

sapply(Weather,function(z) { (round((z[1,] - z[2,]/z[2,1]),2))})

#Nesting apply functions

lapply(Weather,rowMeans)
apply(Chicago,1,max)

lapply(Weather,function(X) apply(X,1,max))
lapply(Weather,apply,1,max)

sapply(Weather,apply,1,max)

#which.max and which.min

which.max(Chicago[1,])

names(which.max(Chicago[1,]))

apply(Chicago,1,function(X) names(which.max(X)))

lapply(Weather, function(X) apply(X,1,function(Z) names(which.max(Z))))

lapply(Weather, function(X) apply(X,1,function(Z) names(which.min(Z))))