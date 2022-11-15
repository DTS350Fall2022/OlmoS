---
title: "Case Study 11"
author: "Sabrina Olmo"
date: "11/8/2022"
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
library(USAboundaries)
library(sf)
library(ggrepel)
library(ggsflabel)
library(leaflet)
```


```r
dat <- tempfile()
download.file("https://github.com/WJC-Data-Science/DTS350/raw/master/permits.csv", "dat")
permit <- read_csv("dat")
```

```
## New names:
## Rows: 327422 Columns: 8
## ── Column specification
## ──────────────────────────────────────────────────────── Delimiter: "," chr
## (3): StateAbbr, countyname, variable dbl (5): ...1, state, county, year, value
## ℹ Use `spec()` to retrieve the full column specification for this data. ℹ
## Specify the column types or set `show_col_types = FALSE` to quiet this message.
## • `` -> `...1`
```

```r
PA_permit <- permit %>%
              filter(StateAbbr == "PA", year == 2010) %>%
              group_by(countyname, county) %>%
              summarise(permits = sum(value))
```

```
## `summarise()` has grouped output by 'countyname'. You can override using the
## `.groups` argument.
```

```r
PA_counties <- read_csv("PACounty.csv")
```

```
## Rows: 68 Columns: 6
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (3): County Name, County Code text, Georeferenced Latitude & Longitude
## dbl (3): County Code Number, Longitude, Latitude
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
PA_counties <- PA_counties %>%
                rename("countyname" = "County Name",
                       "county" = "County Code Number")
PA_data <- full_join(PA_permit, PA_counties, by = "county") %>%
            arrange(desc(permits)) %>%
            drop_na()

PA_data$rank <- cut(PA_data$permits, quantile(PA_data$permits), include.lowest = TRUE, labels = FALSE)

topcounty <-  PA_data %>%
                filter(row_number() == 1)
Q1 <- PA_data[-1,] %>%
        filter(rank == 4)
Q2 <- PA_data %>%
        filter(rank == 3)
Q3 <- PA_data %>%
        filter(rank == 2)
Q4 <- PA_data %>%
        filter(rank == 1)
worstcounty <- PA_data %>%
                filter(row_number() == 33)
```


```r
leaflet() %>%
  addTiles() %>%
  addCircleMarkers(data = topcounty,
                   label = ~countyname.x,
                   popup = ~as.character(permits),
                   color = "blue",
                   fillOpacity = 1) %>%
  addCircleMarkers(data = Q1,
                   label = ~countyname.x,
                   popup = ~as.character(permits),
                   color = "green",
                   fillOpacity = 1) %>%
  addCircleMarkers(data = Q2,
                   label = ~countyname.x,
                   popup = ~as.character(permits),
                   color = "orange",
                   fillOpacity = 1) %>%
  addCircleMarkers(data = Q3,
                   label = ~countyname.x,
                   popup = ~as.character(permits),
                   color = "yellow",
                   fillOpacity = 1) %>%
  addCircleMarkers(data = Q4,
                   label = ~countyname.x,
                   popup = ~as.character(permits),
                   color = "red",
                   fillOpacity = 1) %>%
  addCircleMarkers(data = worstcounty,
                   label = ~countyname.x,
                   popup = ~as.character(permits),
                   color = "purple",
                   fillOpacity = 1)
```

```{=html}
<div id="htmlwidget-2ed13ce84b39f478ff38" style="width:672px;height:480px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-2ed13ce84b39f478ff38">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"https://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addCircleMarkers","args":[40.81509526,-79.47316899,10,null,null,{"interactive":true,"className":"","stroke":true,"color":"blue","weight":5,"opacity":0.5,"fill":true,"fillColor":"blue","fillOpacity":1},null,null,"2865",null,"Allegheny County",{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addCircleMarkers","args":[[39.92487511,41.34459792,41.30237777,40.85150926,40.77113737,41.04912086,41.000429],[-78.11485045,-77.06942457,-80.26009411,-76.71188423,-77.07255968,-76.4100218,-78.47558343],10,null,null,{"interactive":true,"className":"","stroke":true,"color":"green","weight":5,"opacity":0.5,"fill":true,"fillColor":"green","fillOpacity":1},null,null,["2497","1876","1467","1389","1197","1106","978"],null,["Chester County","Cumberland County","Dauphin County","Erie County","Franklin County","Butler County","Bucks County"],{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addCircleMarkers","args":[[41.51357876,40.49127491,41.06091787,40.48555024,39.87209565,40.00444354,40.91936701,39.97487056],[-79.23780995,-78.71894174,-75.34083603,-78.34907687,-77.22224271,-75.140236,-75.71107039,-75.75626498],10,null,null,{"interactive":true,"className":"","stroke":true,"color":"orange","weight":5,"opacity":0.5,"fill":true,"fillColor":"orange","fillOpacity":1},null,null,["931","895","735","706","634","488","365","354"],null,["Centre County","Berks County","Delaware County","Beaver County","Adams County","Fayette County","Blair County","Bradford County"],{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addCircleMarkers","args":[[41.99413787,41.13139091,40.99325035,40.16759839,40.61464794,40.33501133,41.40341259,40.19109663],[-80.0407591,-79.00101814,-80.33754114,-77.26866271,-75.60099481,-75.11291241,-79.76286561,-80.25180083],10,null,null,{"interactive":true,"className":"","stroke":true,"color":"yellow","weight":5,"opacity":0.5,"fill":true,"fillColor":"yellow","fillOpacity":1},null,null,["298","248","246","234","228","226","204","190"],null,["Carbon County","Clearfield County","Columbia County","Cambria County","Crawford County","Bedford County","Huntingdon County","Indiana County"],{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addCircleMarkers","args":[[40.310315,40.00737536,40.416105,41.77333834,39.92192531,41.02801824,41.43910064,41.4480994,41.74420644],[-79.47134118,-78.49116474,-77.9827661,-77.25788076,-76.72576052,-76.66470527,-75.61218345,-76.5147922,-77.89879229],10,null,null,{"interactive":true,"className":"","stroke":true,"color":"red","weight":5,"opacity":0.5,"fill":true,"fillColor":"red","fillOpacity":1},null,null,["186","120","94","82","82","72","62","48","20"],null,["Jefferson County","Armstrong County","Clarion County","Greene County","Juniata County","Elk County","Clinton County","Fulton County","Forest County"],{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addCircleMarkers","args":[41.74420644,-77.89879229,10,null,null,{"interactive":true,"className":"","stroke":true,"color":"purple","weight":5,"opacity":0.5,"fill":true,"fillColor":"purple","fillOpacity":1},null,null,"20",null,"Forest County",{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[39.87209565,41.99413787],"lng":[-80.33754114,-75.11291241]}},"evals":[],"jsHooks":[]}</script>
```
I can advise my friend that Allegheny County is the best county in Pennsylvania in terms of the number of permits in the year 2010. The worst county in terms of the number of permits is Forest County. The green markers on the map represent the top 25 percentile of permits in Pennsylvania if my friend can not move directly into Allegheny County. I would advise my friend to stay away from the red markers because they represent the bottom 25th percentile in permits. 
