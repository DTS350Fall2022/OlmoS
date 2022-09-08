---
title: "Task 4"
author: "Sabrina Olmo"
date: "9/6/2022"
output: 
  html_document:
    keep_md:  TRUE 
editor_options: 
  chunk_output_type: console
---


```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
## ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
## ✓ tibble  3.1.6     ✓ dplyr   1.0.8
## ✓ tidyr   1.2.0     ✓ stringr 1.4.0
## ✓ readr   2.1.2     ✓ forcats 0.5.1
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(knitr)
library(tibble)
?iris

as_tibble(iris)
```

```
## # A tibble: 150 × 5
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
##           <dbl>       <dbl>        <dbl>       <dbl> <fct>  
##  1          5.1         3.5          1.4         0.2 setosa 
##  2          4.9         3            1.4         0.2 setosa 
##  3          4.7         3.2          1.3         0.2 setosa 
##  4          4.6         3.1          1.5         0.2 setosa 
##  5          5           3.6          1.4         0.2 setosa 
##  6          5.4         3.9          1.7         0.4 setosa 
##  7          4.6         3.4          1.4         0.3 setosa 
##  8          5           3.4          1.5         0.2 setosa 
##  9          4.4         2.9          1.4         0.2 setosa 
## 10          4.9         3.1          1.5         0.1 setosa 
## # … with 140 more rows
```

```r
arrange(iris, Sepal.Length) %>%
  head(iris, n = 10)
```

```
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1           4.3         3.0          1.1         0.1  setosa
## 2           4.4         2.9          1.4         0.2  setosa
## 3           4.4         3.0          1.3         0.2  setosa
## 4           4.4         3.2          1.3         0.2  setosa
## 5           4.5         2.3          1.3         0.3  setosa
## 6           4.6         3.1          1.5         0.2  setosa
## 7           4.6         3.4          1.4         0.3  setosa
## 8           4.6         3.6          1.0         0.2  setosa
## 9           4.6         3.2          1.4         0.2  setosa
## 10          4.7         3.2          1.3         0.2  setosa
```

```r
testdat <- select(iris, Species, Petal.Width)

species_mean <- group_by(iris, Species) %>% 
          summarise(avg_SL = mean(Sepal.Length), avg_SW = mean(Sepal.Width), 
                    avg_PL = mean(Petal.Length), avg_PW = mean(Petal.Width))

iris_min <- filter(iris, Sepal.Length >= 3, Petal.Width != 2.5)

iris_size <- mutate(iris, size = case_when(Sepal.Length < 5 ~ 'small',
                                           Sepal.Length >= 5 & Sepal.Length < 6.5  ~ 'medium',
                                           Sepal.Length >= 6.5 ~ 'large'))

iris_rank <- select(iris, Petal.Length) %>%
  arrange(Petal.Length) %>%
  mutate(rank = min_rank(Petal.Length))

?summarise_all()

species_mean_sd <- group_by(iris, Species) %>% 
          summarise(avg_SL = mean(Sepal.Length), avg_SW = mean(Sepal.Width), 
                    avg_PL = mean(Petal.Length), avg_PW = mean(Petal.Width),
                    sd_SL = sd(Sepal.Length), sd_SW = sd(Sepal.Width), 
                    sd_PL = sd(Petal.Length), sd_PW = sd(Petal.Width)) 
```

Have the rates of Covid tests gone down since the vaccine was administered?

How many jobs have been affected by the covid pandemic, going remote, hybrid, fully in person?

I received feedback from 6 people and each of them were interested in the two questions I posed. One specific piece of feedback was that my second question was not specific enough at first so I made a modification to it by adding the three different job types.
