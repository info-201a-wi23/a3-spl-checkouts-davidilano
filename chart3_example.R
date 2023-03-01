library("ggplot2")
library("dplyr")
library("stringr")

# Chart 3 will display a bar chart of the number of checkouts of the second Diary of a Wimpy Kid book from 2012 to 2022

my_spl_df <- read.csv("~/Desktop/INFO_201/datasets/spl_my_dataset.csv", stringsAsFactors = FALSE)

# Creating data frame for graph
chart3_df <- my_spl_df
chart3_df <- chart3_df %>% 
  filter(str_detect(chart3_df$Title, "Rodrick") == TRUE) %>% 
  group_by(CheckoutYear) %>% 
  summarize(num_of_checkouts = sum(Checkouts, na.rm = TRUE))

# Plotting bar chart
ggplot(data = chart3_df) +
  geom_col(aes(
    x = CheckoutYear, 
    y = num_of_checkouts,
    fill = num_of_checkouts)
  ) +
  scale_fill_continuous(low = "lightgreen",
                        high = "darkgreen") +
  labs(
    title = "Number of Checkouts for the 2nd Diary of a Wimpy Kid Book Over Time",
    x = "Year", 
    y = "Number of Checkouts",
    fill = "Number of Checkouts"
  ) + 
  scale_x_continuous(breaks =seq(2012, 2022, 1))