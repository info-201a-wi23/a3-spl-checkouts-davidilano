# Loading required packages
library("tidyverse")
library("dplyr")
library("ggplot2")
library("maps")
library("mapproj")
library("scales")

# Reading the data set into R
my_spl_df <- read.csv("~/Desktop/INFO_201/datasets/spl_my_dataset.csv", stringsAsFactors = FALSE)

# Calculating the number of checkouts in each year
checkouts_per_year <- my_spl_df %>%
  group_by(CheckoutYear) %>%
  summarize(checkouts = sum(Checkouts, na.rm = TRUE))

# Calculating which year had the highest number of checkouts
max_checkouts_year <- checkouts_per_year %>% 
  filter(checkouts == max(checkouts, na.rm = TRUE)) %>% 
  pull(CheckoutYear)

# Calculating which year had the lowest number of checkouts
min_checkouts_year <- checkouts_per_year %>% 
  filter(checkouts == min(checkouts, na.rm = TRUE)) %>% 
  pull(CheckoutYear)

# Calculating the average number of checkouts per year
avg_checkouts <- checkouts_per_year %>% 
  summarize(average_checkouts = round(mean(checkouts, na.rm = TRUE), 0)) %>% 
  pull(average_checkouts)

# Calculating the number of checkouts with MaterialType as "EBOOK" from 2012-2014
ebook_checkouts_firstthree <- my_spl_df %>%
  filter(CheckoutYear == 2012 | CheckoutYear == 2013 | CheckoutYear == 2014) %>% 
  filter(MaterialType == "EBOOK") %>% 
  summarize(checkouts = sum(Checkouts, na.rm = TRUE)) %>% 
  pull(checkouts)

# Calculating the number of checkouts with MaterialType as "EBOOK" from 2020-2022
ebook_checkouts_lastthree <- my_spl_df %>%
  filter(CheckoutYear == 2020 | CheckoutYear == 2021 | CheckoutYear == 2022) %>% 
  filter(MaterialType == "EBOOK") %>% 
  summarize(checkouts = sum(Checkouts, na.rm = TRUE)) %>% 
  pull(checkouts)

# Calculating which publisher was most often used
common_publisher <- my_spl_df %>% 
  group_by(Publisher) %>% 
  summarize(count_publisher = length(Publisher)) %>% 
  filter(count_publisher == max(count_publisher, na.rm = TRUE)) %>% 
  pull(Publisher)