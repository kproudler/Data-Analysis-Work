install.packages("tidyverse")
install.packages("skimr")
install.packages("janitor")

library("tidyverse")
library("skimr")
library("janitor")

#read data file
bookings_df <- read.csv("hotel_bookings.csv")

#summaries of data
head(bookings_df)
summary(bookings_df)
str(bookings_df)
glimpse(bookings_df)
colnames(bookings_df)
#skim gives good summary including summary statistics
skim_without_charts(bookings_df)

# new trimmed dataframe
new_bookings_df <- bookings_df %>% 
  select(hotel, is_canceled, lead_time)

#rename hotel for clarity
new_bookings_df <- new_bookings_df %>% 
  rename(hotel_type = hotel)

new_bookings_df <- new_bookings_df %>% 
  rename(cancelations = is_canceled)

# combine arrival year and month
temp_df <- bookings_df %>% 
  select(arrival_date_year, arrival_date_month) %>% 
  unite(arrival_month_year, c("arrival_date_month", "arrival_date_year"), sep = " ")
glimpse(temp_df)

#add arrival year/month to new_bookings_df
new_bookings_df <- new_bookings_df %>% 
  mutate(temp_df)
head(new_bookings_df)

# create new column 'guests' by combining adults, children, babies
temp_df <- bookings_df %>% 
  mutate(guests = adults + children + babies)
head(temp_df)

temp_df <- temp_df %>% 
  select(guests)
head(temp_df)

#add new column to new_booking_df
new_bookings_df <- new_bookings_df %>% 
  mutate(temp_df)

example_df <- bookings_df %>% 
  summarize(number_canceled = sum(is_canceled),
            average_lead_time = mean(lead_time))

new_bookings_df <- new_bookings_df %>% 
  mutate(example_df)

skim_without_charts(new_bookings_df)
