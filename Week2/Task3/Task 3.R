library(tidyverse)

?iris

str(iris)
head(iris)

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species, shape = Species)) + 
  geom_point()

ggplot(data = iris, aes(x = Petal.Width, y = Petal.Length, color = Species, shape = Species)) +
  geom_point() +
  facet_wrap(~Species) 

ggplot(data = iris, aes(x = Petal.Length, y = Petal.Width, color = Species, shape = Species)) +
  geom_point(inherit.aes = TRUE) +
  geom_smooth(aes(x=Petal.Length, y=Petal.Width), method = lm, se = FALSE, inherit.aes = FALSE) 

ggplot(data = iris, mapping = aes(x = Sepal.Length, fill = Species)) +
  geom_bar(alpha = 1, color = "black", position = "stack") +
  geom_vline(xintercept = mean(iris$Sepal.Length), linetype = "dashed", color = "grey")

#What patterns can we observe about the different dimensions of each type of flower?
#We can clearly see that each species of flower sits in its own section of the 
#plot which allows us to make some kind of conclusion. Visualizations can help us draw 
#conclusions without actually having to do any kind of calculations.