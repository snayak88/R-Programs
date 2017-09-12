#===========================Data============================================
setwd("C:\\Users\\Sandesh Nayak\\Desktop\\Study\\Machine Learning Resources\\R Programs\\Movie Ratings")
movies <- read.csv("Movie-Ratings.csv")
head(movies)
str(movies)
summary(movies)

colnames(movies) <- c("Film","Genre","CriticRatings","AudienceRatings","BudgetMillions","Year")

movies$Year <- as.factor(movies$Year)
summary(movies)

#===========================Aesthetics=======================================
library(ggplot2)

ggplot(data=movies,aes(x=CriticRatings,y=AudienceRatings))

#==========================Geometry==========================================

ggplot(data=movies,aes(x=CriticRatings,y=AudienceRatings))+
  geom_point()

#================Add colour================================================

ggplot(data=movies,aes(x=CriticRatings,y=AudienceRatings,colour=Genre))+
  geom_point()

#===============Add size============================================


ggplot(data=movies,aes(x=CriticRatings,y=AudienceRatings,colour=Genre,size=BudgetMillions))+
  geom_point()

p <- ggplot(data=movies,aes(x=CriticRatings,y=AudienceRatings,colour=Genre,size=BudgetMillions))
p+geom_line()+geom_point()

#=================Overriding Aesthetics==============================

p <- ggplot(data=movies,aes(x=CriticRatings,y=AudienceRatings,colour=Genre,size=BudgetMillions))
p+geom_point()

p+geom_point(aes(size=CriticRatings))
p+geom_point(aes(colour=BudgetMillions))

p+geom_point()

p+geom_point(aes(x=BudgetMillions))

#================Reduce line size==================================

p <- ggplot(data=movies,aes(x=CriticRatings,y=AudienceRatings,colour=Genre,size=BudgetMillions))
p+geom_line(size=1)+geom_point()

p <- ggplot(data=movies,aes(x=BudgetMillions,y=AudienceRatings,colour=Genre,size=BudgetMillions))
p+geom_point()

#===============Mapping vs Setting================================

p+geom_point(aes(x=BudgetMillions))+xlab("Budget in Millions")

r <- ggplot(data=movies,aes(x=CriticRatings,y=AudienceRatings))
r+geom_point()

#============Add color===========================================

#1. Mapping

r+geom_point(aes(colour=Genre))

#2. Setting

r+geom_point(colour="DarkGreen")

r+geom_point(aes(size=BudgetMillions,colour=Genre),colour="Black")

#===================Histogram============================

s <- ggplot(data=movies,aes(x=BudgetMillions))
s+geom_histogram(binwidth=10)
s+geom_density(aes(fill=Genre),position = "stack")

#========================================================

t <- ggplot(data=movies,aes(x=AudienceRatings))
t+geom_histogram(binwidth=10,fill="White",colour="Blue")

t <- ggplot(data=movies,aes(x=CriticRatings))
t+geom_histogram(aes(binwidth = 10),fill="White", colour="Blue")

#==========Facets=========================================

v <- ggplot(data=movies,aes(x=BudgetMillions))
v+geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")+
  facet_grid(Genre~.)

v+geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")+
  facet_grid(Genre~.,scales = "free")

w <-  ggplot(data=movies,aes(x=CriticRatings,y=AudienceRatings,colour=Genre))
w+geom_point()+facet_grid(Genre~.)

w+geom_point()+facet_grid(.~Year)

w+geom_point(aes(size=BudgetMillions))+geom_smooth()+facet_grid(Genre~Year)

#==========Co ordinates======================================

m <- ggplot(data=movies,aes(x=CriticRatings,y=AudienceRatings,size=BudgetMillions,colour=Genre))

m+geom_point()

m+geom_point()+
  xlim(50,100)+ylim(50,100)

#Wont work well
n <- ggplot(data=movies,aes(x=BudgetMillions))
n+geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")+coord_cartesian(ylim=c(50,100))
#Works well
w <-  ggplot(data=movies,aes(x=CriticRatings,y=AudienceRatings,colour=Genre))
w+geom_point(aes(size=BudgetMillions))+geom_smooth()+facet_grid(Genre~Year)+coord_cartesian(ylim=c(0,100))

#==============================Theme============================

n <- ggplot(data=movies,aes(x=BudgetMillions))
h <- n+geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")
h + xlab("Money Axis")+
  ylab("Number of Movies")+
  theme(axis.title.x = element_text(colour="Dark Green",size=30),
        axis.title.y = element_text(colour="Dark Green",size=30))

h + xlab("Money Axis")+
  ylab("Number of Movies")+
  theme(axis.title.x = element_text(colour="Dark Green",size=30),
        axis.title.y = element_text(colour="Dark Green",size=30),
        axis.text.x = element_text(size = 20),
        axis.text.y = element_text(size = 20))


h + xlab("Money Axis")+
  ylab("Number of Movies")+
  ggtitle("Movie Budget Distribution")+
  theme(axis.title.x = element_text(colour="Dark Green",size=30),
        axis.title.y = element_text(colour="Dark Green",size=30),
        axis.text.x = element_text(size = 20),
        axis.text.y = element_text(size = 20),
        legend.title = element_text(size = 20),
        legend.text = element_text(size=20),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        plot.title = element_text(size=40,colour="Dark Blue"))

#===================Statistics=====================================

u <- ggplot(data=movies,aes(x=CriticRatings, y=AudienceRatings,colour=Genre))
u+geom_point()+geom_smooth(fill=NA)

u <- ggplot(data=movies,aes(x=Genre, y=CriticRatings,colour=Genre))
u+geom_jitter()+geom_boxplot(alpha=0.5)

