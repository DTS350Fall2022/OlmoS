---
title: "Task 19"
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
library(maps)
library(ggrepel)
library(ggsflabel)
library(leaflet)
```


```r
USmap <- sf::st_as_sf(map("state", plot = FALSE, fill = TRUE))
ID <- us_counties(states = "ID")
cities <- us_cities()
```

```
## City populations for contemporary data come from the 2010 census.
```

```r
top3 <- cities %>%
          filter(state_name != "Alaska", state_name != "Hawaii") %>%
          mutate(full_name = str_c(city,",", " ", state_abbr)) %>%
          group_by(state_name) %>%
          arrange(desc(population)) %>%
          slice(1:3)

first <- top3 %>%
          slice(1:1)

second <- top3 %>%
            slice(2:2)

third <- top3 %>%
            slice(3:3)
```


```r
leaflet(data = top3) %>%
  addTiles() %>%
  addMarkers(popup = ~as.character(population), 
             label = ~full_name)
```

```{=html}
<div id="htmlwidget-b44500c28cdf90a7c2ab" style="width:672px;height:480px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-b44500c28cdf90a7c2ab">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"https://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addMarkers","args":[[33.5274441,32.3462512,30.668426,33.5721625,32.1542888,33.4019259,34.7254318,35.3492757,36.0715607,34.0193936,32.8152995,37.2968672,39.7618487,38.8672553,39.6880021,41.1873858,41.3108088,41.7660453,39.7352263,39.1606061,39.677569,38.9041485,30.3370193,25.775163,27.9700861,33.7629088,33.3655309,32.510197,43.5984881,43.582381,43.617852,41.8375511,41.763455,42.2633938,39.7766644,41.0881729,37.9877339,41.5739461,41.9670481,41.5541036,37.6906938,38.8890422,39.1225389,38.1780769,38.0401572,36.9709194,30.0686361,30.4484535,32.4670204,43.663811,44.0895941,44.8306292,39.3002135,39.4330863,39.0836473,42.33196,42.2694781,42.115454,42.3830375,42.961156,42.4929044,44.9633235,44.9488695,44.0154424,32.3158308,30.4160584,34.9508416,39.125212,38.6356988,37.194152,45.7895184,46.8693223,47.5014389,41.2646751,40.8089574,41.1542932,36.2277116,36.0122334,39.4744867,42.9846891,42.7490744,43.2324926,40.7242204,40.7114174,40.9147462,35.1055517,32.3264441,35.2850958,40.6642738,42.8924919,43.1699272,35.2087069,35.8302035,36.0964835,46.8652063,46.8110381,47.9127893,39.9847989,41.4781381,39.1399019,35.4670795,36.1279488,35.2405774,45.5369506,44.0567484,44.9236937,40.0093755,40.4397525,40.5939656,41.8230556,41.7007569,41.7697341,34.0297833,32.8179219,32.9173424,43.5383351,44.0710712,45.4646777,35.1035431,36.1718001,35.9708752,29.7804724,29.4724026,32.794176,40.7785197,40.6884927,40.2453301,44.4919905,44.4364933,43.6096702,36.7793219,36.9230149,36.6793761,47.6204993,47.6735545,47.2521991,38.3486917,38.4106509,39.2613533,43.0633484,43.0878055,44.5206763,41.1521947,42.8405322,41.3102405],[-86.799047,-86.2685927,-88.1002261,-112.0879662,-110.8710622,-111.7173787,-92.358556,-94.370883,-94.1665396,-118.4108248,-117.134993,-121.8193058,-104.8806251,-104.760749,-104.68974,-73.1957339,-72.924953,-72.6833394,-75.5292892,-75.5216585,-75.7573084,-77.0170942,-81.6613021,-80.2086152,-82.4796734,-84.4226745,-82.0734219,-84.874946,-116.2310843,-116.5638753,-116.397129,-87.6818441,-88.290099,-89.0628271,-86.1459355,-85.14388,-87.534703,-93.616708,-91.6777599,-90.6039968,-97.3426776,-94.6905839,-94.7417813,-85.6667077,-84.4584429,-86.4384623,-89.9390074,-91.1258993,-93.7926845,-70.255365,-70.1721851,-68.7923966,-76.6105159,-77.4127579,-77.1556178,-71.0201725,-71.8077831,-72.5399783,-83.1022365,-85.6555701,-83.0250007,-93.2682835,-93.1038552,-92.4772105,-90.2128226,-89.071845,-89.977981,-94.5511362,-90.2445816,-93.2913048,-108.5498909,-114.0103464,-111.299975,-96.0419269,-96.6803544,-95.9328384,-115.2640448,-115.0374619,-119.7765384,-71.4438932,-71.4905435,-71.5612523,-74.1725735,-74.0647599,-74.1628255,-106.6473884,-106.7896951,-106.6988694,-73.9385004,-78.8596862,-77.6168907,-80.8307389,-78.6414394,-79.8271079,-96.8290052,-100.7701017,-97.0750101,-82.9850438,-81.6794861,-84.5064465,-97.5136565,-95.9023162,-97.3453056,-122.649971,-123.1162068,-123.0231194,-75.1333459,-79.9765919,-75.4781595,-71.4187795,-71.4203343,-71.4850489,-80.8965664,-79.9589267,-80.0651497,-96.7319985,-103.2179242,-98.468104,-89.9784984,-86.7850016,-83.9464787,-95.3863425,-98.5251419,-96.7655033,-111.9314142,-112.0117586,-111.6448069,-73.2393625,-73.1826185,-72.9777884,-76.0240202,-76.2446413,-76.3017884,-122.3508761,-117.4165955,-122.4598318,-81.632324,-82.4346886,-81.5433763,-87.9666952,-89.4301208,-87.9841686,-104.7832381,-106.3201684,-105.6096249],null,null,null,{"interactive":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},["212237","205764","195111","1445632","520116","439041","193524","86209","73580","3792621","1307402","945942","600158","416427","325078","144229","129779","124775","70851","36047","31454","601723","821784","399457","335709","420003","195844","189885","205671","81557","75092","2695598","197899","152871","820445","253691","117429","203433","126326","99685","382368","173372","145786","597337","295803","58067","343829","229493","199311","66194","36592","33039","620961","65239","61209","617594","181045","153060","713777","188040","134056","382578","285068","106769","173514","67793","48982","459787","319294","159498","104170","66788","58505","408958","258379","50137","583756","257729","225221","109565","86494","42695","277140","247597","146199","545852","97618","87521","8175133","261310","210565","731424","403892","269666","105549","61272","52838","787033","396815","296943","579999","391906","110925","583776","156185","154637","1526006","305704","118032","178042","82672","80387","129272","120083","97471","153888","67956","26091","646889","601222","178874","2099451","1327407","1197816","186440","129480","112488","42417","17904","16495","437994","242803","222209","608660","208916","198397","51400","49138","31492","594833","233209","104057","59466","55316","30816"],null,null,null,["Birmingham, AL","Montgomery, AL","Mobile, AL","Phoenix, AZ","Tucson, AZ","Mesa, AZ","Little Rock, AR","Fort Smith, AR","Fayetteville, AR","Los Angeles, CA","San Diego, CA","San Jose, CA","Denver, CO","Colorado Springs, CO","Aurora, CO","Bridgeport, CT","New Haven, CT","Hartford, CT","Wilmington, DE","Dover, DE","Newark, DE","Washington, DC","Jacksonville, FL","Miami, FL","Tampa, FL","Atlanta, GA","Augusta, GA","Columbus, GA","Boise, ID","Nampa, ID","Meridian, ID","Chicago, IL","Aurora, IL","Rockford, IL","Indianapolis, IN","Fort Wayne, IN","Evansville, IN","Des Moines, IA","Cedar Rapids, IA","Davenport, IA","Wichita, KS","Overland Park, KS","Kansas City, KS","Louisville, KY","Lexington, KY","Bowling Green, KY","New Orleans, LA","Baton Rouge, LA","Shreveport, LA","Portland, ME","Lewiston, ME","Bangor, ME","Baltimore, MD","Frederick, MD","Rockville, MD","Boston, MA","Worcester, MA","Springfield, MA","Detroit, MI","Grand Rapids, MI","Warren, MI","Minneapolis, MN","St. Paul, MN","Rochester, MN","Jackson, MS","Gulfport, MS","Southaven, MS","Kansas City, MO","St. Louis, MO","Springfield, MO","Billings, MT","Missoula, MT","Great Falls, MT","Omaha, NE","Lincoln, NE","Bellevue, NE","Las Vegas, NV","Henderson, NV","Reno, NV","Manchester, NH","Nashua, NH","Concord, NH","Newark, NJ","Jersey City, NJ","Paterson, NJ","Albuquerque, NM","Las Cruces, NM","Rio Rancho, NM","New York City, NY","Buffalo, NY","Rochester, NY","Charlotte, NC","Raleigh, NC","Greensboro, NC","Fargo, ND","Bismarck, ND","Grand Forks, ND","Columbus, OH","Cleveland, OH","Cincinnati, OH","Oklahoma City, OK","Tulsa, OK","Norman, OK","Portland, OR","Eugene, OR","Salem, OR","Philadelphia, PA","Pittsburgh, PA","Allentown, PA","Providence, RI","Warwick, RI","Cranston, RI","Columbia, SC","Charleston, SC","North Charleston, SC","Sioux Falls, SD","Rapid City, SD","Aberdeen, SD","Memphis, TN","Nashville, TN","Knoxville, TN","Houston, TX","San Antonio, TX","Dallas, TX","Salt Lake City, UT","West Valley City, UT","Provo, UT","Burlington, VT","South Burlington, VT","Rutland, VT","Virginia Beach, VA","Norfolk, VA","Chesapeake, VA","Seattle, WA","Spokane, WA","Tacoma, WA","Charleston, WV","Huntington, WV","Parkersburg, WV","Milwaukee, WI","Madison, WI","Green Bay, WI","Cheyenne, WY","Casper, WY","Laramie, WY"],{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[25.775163,47.9127893],"lng":[-123.1162068,-68.7923966]}},"evals":[],"jsHooks":[]}</script>
```
