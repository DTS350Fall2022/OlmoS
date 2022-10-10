library(tidyverse) 
library(readr)
library(stringr)

RandomLetters <- read_lines("https://github.com/WJC-Data-Science/DTS350/raw/master/randomletters.txt")
RandomLetters_wnumbers <- read_lines("https://github.com/WJC-Data-Science/DTS350/raw/master/randomletters_wnumbers.txt")

my_text <- str_sub(RandomLetters, start = 1, end = 1)
for(i in seq(1, floor(str_length(RandomLetters)/1700))) {
  my_text <- str_c(my_text, str_sub(RandomLetters, start = i*1700, 
                                    end = i*1700))
}
writeLines(my_text)
str_split(my_text, "\\.")[[1]][1]

num <- str_extract_all(RandomLetters_wnumbers, ("\\d+"))
text <- c()
for(i in  seq(1, length(num[[1]]))) {
  text[i] = letters[as.numeric(num[[1]][i])]
}
str_flatten(text)

str_extract_all(RandomLetters, "(.)(.)(.)(.)\\4\\3\\2\\1")

NoSpace <- RandomLetters %>%
            str_remove_all("[ ]") %>%
            str_remove_all("[.]") 

str_extract_all(NoSpace, ("[aeiou]{7}"))


