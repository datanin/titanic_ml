# In the previous chapter you did all the slicing and dicing yourself to find subsets that have a higher chance of
# surviving. A decision tree automates will automate this process for you, and outputs a flowchart-like structure
# that is easy to interpret (you'll make one yourself in the next exercise).

# Conceptually, the decision tree algorithm starts with all the data at the root node and scans all the variables
# for the best one to split on. Once a variable is chosen, you do the split and go down one level (or one node) and
# repeat. The final nodes at the bottom of the decision tree are known as terminal nodes, and the majority vote of
# the observations in that bucket determine how to predict for new observations that end up in that terminal node.

# Bibliotheken laden
library(rpart)
library(rattle)
library(RColorBrewer)
library(rpart.plot)

# Assign the training set
# train <- read.csv(url('http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/train.csv'))
train <- read.csv('ownCloud/Entwicklung/R/ml_titanic/titanic_train.csv', header = TRUE)

# Assign the testing set
# test <- read.csv(url('http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/test.csv'))
test <- read.csv('ownCloud/Entwicklung/R/ml_titanic/titanic_test.csv', header = TRUE)

# Build the first decision tree
my_tree <- rpart(Survived ~ Sex + Age, data=train, method="class")

#plot(my_tree)
#text(my_tree)
fancyRpartPlot(my_tree)

# Build the second decision tree
my_tree_two <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train, method="class")
plot(my_tree_two)
text(my_tree_two)
fancyRpartPlot(my_tree_two)

# Make your prediction using the test set
my_prediction <- predict(my_tree_two, test, type = "class")
  
# Create a data frame with two columns: PassengerId & Survived. Survived contains your predictions
my_solution <- data.frame(PassengerId = test$PassengerId, Survived = my_prediction)

# Check that your data frame has 418 entries
nrow(my_solution)

# Write your solution to a csv file with the name my_solution.csv
write.csv(my_solution, file = 'ownCloud/Entwicklung/R/ml_titanic/my_solution.csv', row.names = FALSE)

my_tree_three <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train, method="class", control=rpart.control(minsplit=50, cp=0))

fancyRpartPlot(my_tree_three)

# ----------------------------------------- Eigene predictive Variablen hinzufügen

train_two <- train
train_two$family_size <- train_two$SibSp + train_two$Parch + 1
my_tree_four <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + family_size, data=train_two, method="class", control=rpart.control(minsplit=50, cp=0))

# Visualize your new decision tree
fancyRpartPlot(my_tree_four)
