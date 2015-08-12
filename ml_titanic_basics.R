# When the Titanic sank, 1502 of the 2224 passengers and crew got killed. One of the main reasons for this high level
# of casualties was the lack of lifeboats on this self-proclaimed "unsinkable" ship.

# Those that have seen the movie know that some individuals were more likely to survive the sinking (lucky Rose)
# than others (poor Jack). In this course you will learn how to apply machine learning techniques to predict a
# passenger's chance of surviving using R. 

# Assign the training set
# train <- read.csv(url('http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/train.csv'))
train <- read.csv('ownCloud/Entwicklung/R/ml_titanic/titanic_train.csv', header = TRUE)
  
# Assign the testing set
# test <- read.csv(url('http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/test.csv'))
test <- read.csv('ownCloud/Entwicklung/R/ml_titanic/titanic_test.csv', header = TRUE)
  
# Make sure to have a look at your training and testing set
print(train)
print(test)

# Statistik über die Überlebenden [Absolut/Prozentual] - 0: Gestorben 1: Überlebt
table(train$Survived)
prop.table(table(train$Survived))

table(train$Sex, train$Survived)

# Passengers that survived vs passengers that passed away
table(train$Survived)
prop.table(table(train$Survived))

# Males & females that survived vs males & females that passed away
table(train$Sex, train$Survived )
prop.table(table(train$Sex, train$Survived ), 1)

# Neues Attribut / Spalte erstellen: Kind
train$Child[train$Age < 18] <- 1 
train$Child[train$Age >= 18] <- 0

# Two Way Analysis
table(train$Sex, train$Survived )
prop.table(table(train$Sex, train$Survived ), 1)

# prediction based on gender 
test_one <- test
test_one$Survived [test_one$Sex == 'male'] <- 0
test_one$Survived [test_one$Sex == 'female'] <- 1



