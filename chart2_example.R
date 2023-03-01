library("ggplot2")
library("dplyr")
library("stringr")

# Chart 2 will display a line graph of the number of different publishers of Diary of a Wimpy Kid books that were checked out between 2012 to 2022

my_spl_df <- read.csv("~/Desktop/INFO_201/datasets/spl_my_dataset.csv", stringsAsFactors = FALSE)

# Cleaning Publisher column
chart2_df <- my_spl_df 

chart2_df$Publisher[str_detect(chart2_df$Publisher, "Amulet")] <- "Amulet"
chart2_df$Publisher[str_detect(chart2_df$Publisher, "Recorded")] <- "Recorded Books"
chart2_df$Publisher[str_detect(chart2_df$Publisher, "Thorndike")] <- "Thorndike Press"
chart2_df$Publisher[str_detect(chart2_df$Publisher, "Century Fox Home Entertainment")] <- "20th Century Fox Home Entertainment"

chart2_df <- chart2_df[!is.na(chart2_df$Publisher) & chart2_df$Publisher != "", ]


# Creating df for graph
chart2_df <- chart2_df %>% 
  group_by(CheckoutYear, Publisher) %>% 
  summarize(num_of_checkouts = sum(Checkouts, na.rm = TRUE))

# Plotting line graph
ggplot(data = chart2_df) +
  geom_line(aes(
    x = CheckoutYear, 
    y = num_of_checkouts,
    color = Publisher)
  ) +
  labs(
    title = "Number of Checkouts Over Time By Publisher",
    x = "Year", 
    y = "Number of Checkouts",
  ) + 
  scale_x_continuous(breaks =seq(2012, 2022, 1))

