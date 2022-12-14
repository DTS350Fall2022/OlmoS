---
title: "Task 10"
author: "Sabrina Olmo"
date: "9/27/2022"
output: 
  html_document:
    keep_md:  TRUE 
    code_folding: 'hide'
editor_options: 
  chunk_output_type: console
---


```r
library(tidyverse)
library(knitr)
```




```r
ChildData <- Healthcare %>%
              select(year, country, continent, child_mort) %>%
              drop_na(continent, child_mort)

ggplot(ChildData) +
  geom_histogram(aes(x = child_mort, fill = continent), bins = 20, col = I("black")) +
  facet_wrap(~continent, nrow = 3, scale = "free") +
  labs(title = "Child Mortality Rates by Continent",
       subtitle = "Child mortality refers to death of children under the age of 5",
       x = "Numer of Child Mortalities",
       y = "Number of Times Mortalities Occured") +
  theme_bw() +
  theme(legend.position = "none") 
```

![](Task-10_files/figure-html/HealthcarePlot-1.png)<!-- -->
I chose to make a histogram to show the frequency of child mortality rates. Using a histogram allows us to compare the frequency of a certain range of events happening. I wanted to facet the graph by continent, and by doing this, we can see that the continent of Africa has the overall highest quantity of child mortalities, with around 400 child mortalities happening over 2000 times over the last 200 plus years. We can also see that the continent of Oceania has by far the lowest occurrences of child mortalities. These numbers can say a lot about a continent's economic status, and it is clear which continents are doing better than others.
