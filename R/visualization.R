install.packages("ggplot2")
install.packages("palmerpenguins")
install.packages("tidyverse")
install.packages("dplyr")
library(ggplot2)
library(palmerpenguins)
library(dplyr)

data(penguins)
View(penguins)

ggplot(data=penguins)+geom_point(mapping = aes(x=flipper_length_mm, y=body_mass_g))
ggplot(data=penguins)+geom_point(mapping = aes(x=bill_length_mm, y=bill_depth_mm))

#hotel bookings visualization

#load data
hotel_bookings <- read.csv("hotel_bookings.csv")
head(hotel_bookings)
colnames(hotel_bookings)

#hypothesis - people with children will have more lead time
ggplot(data=hotel_bookings)+
  geom_point(mapping=aes(x=lead_time, y=children))
#hypothesis does not appear to be correct

#Goal - increase weekend bookings (important source of revenue for hotel)
#Question - what group of guests book the most weekend nights in order to target that group in a new marketing campaign

ggplot(hotel_bookings) + 
  geom_point(mapping=aes(x=stays_in_weekend_nights, y=children))

hotel_summary_customer_type <-
  hotel_bookings %>% 
  group_by(customer_type) %>% 
  summarise(average_weekend_nights=mean(stays_in_weekend_nights),
            min_weekend_nights=min(stays_in_weekend_nights),
            max_weekend_nights=max(stays_in_weekend_nights))
head(hotel_summary_customer_type)

hotel_summary_children <-
  hotel_bookings %>% 
  group_by(children) %>% 
  summarise(average_weekend_nights=mean(stays_in_weekend_nights),
            min_weekend_nights=min(stays_in_weekend_nights),
            max_weekend_nights=max(stays_in_weekend_nights))
head(hotel_summary_children)

#conclusion: Guests who have 1, or 2 children have the longest average weekend nights (1.09, 1.11 respectively)
#we also found that customer type 'Contract' has a ~50% higher average weekend stay duration to other customer types
