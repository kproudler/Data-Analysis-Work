#Load packages
install.packages("tidyverse")
install.packages("skimr")
install.packages("janitor")
install.packages("dplyr")
library(dplyr)
library(skimr)
#load data set
hotel_bookings <- read_csv("hotel_bookings.csv")

glimpse(hotel_bookings)
colnames(hotel_bookings)

#arrange lead_time descending
arrange(hotel_bookings, desc(lead_time))

#assign lead_time descending to new df
hotel_bookings_v2 <-
  arrange(hotel_bookings, desc(lead_time))

head(hotel_bookings_v2)

#other ways of finding max/min of particular column
max(hotel_bookings$lead_time)
min(hotel_bookings$lead_time)

#other descriptive statistics
mean(hotel_bookings$lead_time)
median(hotel_bookings$lead_time)

#find mean of hotel booking lead time of "City Hotel" only
hotel_bookings_city <- filter(hotel_bookings, hotel_bookings$hotel == "City Hotel")
head(hotel_bookings_city)

mean(hotel_bookings_city$lead_time)

hotel_summary <-
  hotel_bookings %>% 
  group_by(hotel) %>% 
  summarise(average_lead_time=mean(lead_time),
            min_lead_time=min(lead_time),
            max_lead_time=max(lead_time))
head(hotel_summary)
