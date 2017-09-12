setwd("C:\\Users\\Sandesh Nayak\\Desktop\\Study\\Machine Learning Resources\\R Programs\\Movie Ratings")
movies <- read.csv("Section6-Homework-Data.csv")
str(movies)

colnames(movies) <- c("DayOfWeek","Director","Genre","MovieTitle","ReleaseDate","Studio","AdjustedGrossMillions","BudgetMillions",
                      "GrossMillions","IMDBRating","MovieLensRating","OverseasGrossMillions","OverseasGrossPercentage","ProfitMillions",
                      "ProfitPercentage","RuntimeMinutes","USGrossMillions","USGrossPercentage")

library(ggplot2)
movies <- movies[movies$Genre=="action" | movies$Genre=="adventure" | movies$Genre=="animation" | movies$Genre=="comedy" | movies$Genre=="drama",]
movies <- movies[movies$Studio=="Buena Vista Studios" | movies$Studio=="Fox" | movies$Studio=="Paramount Pictures" | movies$Studio=="Sony" | movies$Studio=="WB" | movies$Studio=="Universal",]
p <- ggplot(data=movies,aes(x=Genre,y=USGrossPercentage))
p <- p + geom_jitter(aes(colour=Studio,size=BudgetMillions))+geom_boxplot(alpha=0.5,outlier.colour = NA)
p$labels$size = "Budget $Millions"
p + xlab("Genre") + ylab("Gross % US")+
  ggtitle("Domestic Gross % by Genre")+
  theme(axis.title.x = element_text(colour = "Blue", size = 30, family = "Comic Sans MS"),
        axis.title.y = element_text(colour = "Blue", size = 30, family = "Comic Sans MS"),
        axis.text.x = element_text(size=15),
        axis.text.y = element_text(size=15),
        plot.title = element_text(size = 30),
        legend.title = element_text(size = 20),
        legend.text = element_text(size=10),
        text = element_text(family = "Comic Sans MS"))

