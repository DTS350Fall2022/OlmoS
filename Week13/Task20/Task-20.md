---
title: "Task 20"
author: "Sabrina Olmo"
date: "11/15/2022"
output:
  html_document:
    keep_md: yes
    code_folding: hide
  pdf_document: default
editor_options:
  chunk_output_type: console
---


```r
library(tidyverse)
library(gapminder)
library(ggplot2)
library(gganimate)
library(gifski)
library(tidyquant)
library(lubridate)
```


```r
stocks <- tq_get(c("AMZN", "AAPL"), get = "stock.prices", from = "2021-10-01", to = today())
plot <- ggplot(stocks) +
          geom_line(aes(x = date, y = adjusted, color = symbol)) +
          labs(title = "Date: {frame_along}",
               x = "Date",
               y = "Adjusted Value") +
               theme_bw()
plot
```

![](Task-20_files/figure-html/Plot-1.png)<!-- -->

```r
plot + transition_reveal(date)
```

```
## geom_path: Each group consists of only one observation. Do you need to adjust
## the group aesthetic?
## geom_path: Each group consists of only one observation. Do you need to adjust
## the group aesthetic?
```

![](Task-20_files/figure-html/Plot-1.gif)<!-- -->

```r
anim_save("Myanimation.gif")
```
