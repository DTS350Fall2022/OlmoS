---
title: "Case Study 2"
author: "Sabrina Olmo"
date: "9/3/2022"
output: 
  html_document:
    theme: cosmo
    keep_md:  TRUE 
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
urlfile = "https://github.com/WJC-Data-Science/DTS350/raw/master/coral.csv"
dat <- read_csv(url(urlfile))
```

```
## Rows: 370 Columns: 5
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (3): Entity, Code, Event
## dbl (2): Year, Value
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
str(dat)
```

```
## spec_tbl_df [370 × 5] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
##  $ Entity: chr [1:370] "Australasia" "Australasia" "Australasia" "Australasia" ...
##  $ Code  : chr [1:370] NA NA NA NA ...
##  $ Year  : num [1:370] 1980 1980 1981 1981 1982 ...
##  $ Event : chr [1:370] "Moderate bleaching events (1-30% bleached)" "Severe bleaching events (>30% bleached)" "Moderate bleaching events (1-30% bleached)" "Severe bleaching events (>30% bleached)" ...
##  $ Value : num [1:370] 3 0 1 0 0 0 3 1 1 0 ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   Entity = col_character(),
##   ..   Code = col_character(),
##   ..   Year = col_double(),
##   ..   Event = col_character(),
##   ..   Value = col_double()
##   .. )
##  - attr(*, "problems")=<externalptr>
```

```r
summary(dat)
```

```
##     Entity              Code                Year         Event          
##  Length:370         Length:370         Min.   :1980   Length:370        
##  Class :character   Class :character   1st Qu.:1989   Class :character  
##  Mode  :character   Mode  :character   Median :1998   Mode  :character  
##                                        Mean   :1998                     
##                                        3rd Qu.:2007                     
##                                        Max.   :2016                     
##      Value       
##  Min.   : 0.000  
##  1st Qu.: 0.000  
##  Median : 1.000  
##  Mean   : 3.268  
##  3rd Qu.: 4.000  
##  Max.   :57.000
```

```r
head(dat)
```

```
## # A tibble: 6 × 5
##   Entity      Code   Year Event                                      Value
##   <chr>       <chr> <dbl> <chr>                                      <dbl>
## 1 Australasia <NA>   1980 Moderate bleaching events (1-30% bleached)     3
## 2 Australasia <NA>   1980 Severe bleaching events (>30% bleached)        0
## 3 Australasia <NA>   1981 Moderate bleaching events (1-30% bleached)     1
## 4 Australasia <NA>   1981 Severe bleaching events (>30% bleached)        0
## 5 Australasia <NA>   1982 Moderate bleaching events (1-30% bleached)     0
## 6 Australasia <NA>   1982 Severe bleaching events (>30% bleached)        0
```


```r
ggplot() +
  geom_col(dat, mapping = aes(x = Year, y = Value, fill = Event)) +
  facet_wrap(~Entity, ncol = 2) +
  scale_fill_manual(values=c("Light Sky Blue", "Light Coral"))
```

![](Case-Study-2_files/figure-html/unnamed-chunk-2-1.png)<!-- -->


```r
ggplot() +
  geom_smooth(dat, mapping = aes(x = Year, y = Value, fill = Entity, color = Entity)) +
  facet_wrap(~Entity) 
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Case-Study-2_files/figure-html/unnamed-chunk-3-1.png)<!-- -->
  
  
