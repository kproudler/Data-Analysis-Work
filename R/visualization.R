install.packages("ggplot2")
install.packages("tidyverse")
install.packages("dplyr")
library(ggplot2)
library(dplyr)
library(tidyverse)



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
  geom_point(mapping=aes(x=stays_in_weekend_nights, y=children)) +
  geom_smooth(mapping=aes(x=stays_in_weekend_nights, y=children))

ggplot(hotel_bookings) + 
  geom_smooth(mapping=aes(x=stays_in_weekend_nights, y=children, linetype=customer_type))

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


#Goal - develop promotions based on different booking distributions
#Figure out how many of the transactions are occurring for each different distribution type

ggplot(hotel_bookings)+
  geom_bar(mapping=aes(x=distribution_channel, fill=distribution_channel))

#dive deeper to figure out if the number of bookings for each distribution type is different
#depending on whether or not there was a deposit of what market segment they represent

#deposit type
ggplot(hotel_bookings)+
  geom_bar(mapping=aes(x=distribution_channel, fill=deposit_type))

#market segment
ggplot(hotel_bookings)+
  geom_bar(mapping=aes(x=distribution_channel, fill=market_segment))

#create separate charts for each deposit type and market segment to make it more clear
#deposit type
ggplot(hotel_bookings)+
  geom_bar(mapping=aes(x=distribution_channel))+
  facet_wrap(~deposit_type)+
  theme(axis.text.x=element_text(angle=45))

#market segment
ggplot(hotel_bookings)+
  geom_bar(mapping=aes(x=distribution_channel))+
  facet_wrap(~market_segment)+
  theme(axis.text.x=element_text(angle=45))

#matrix of graphs regarding both
ggplot(hotel_bookings)+
  geom_bar(mapping=aes(x=distribution_channel))+
  facet_grid(~deposit_type~market_segment)+
  theme(axis.text.x=element_text(angle=45))

#Investigate which market segments generate the largest number of bookings, and where these
#bookings are made (city hotels or resort hotels)

ggplot(hotel_bookings)+
  geom_bar(mapping=aes(x=hotel))+
  facet_wrap(~market_segment)

#Show the relationship between lead time and guests traveling w/children for online bookings at city hotels
#filter, then plot data

onlineta_city_hotels <- filter(hotel_bookings,
                               (hotel=="City Hotel" &
                                  hotel_bookings$market_segment=="Online TA"))

View(onlineta_city_hotels)

ggplot(data = onlineta_city_hotels) +
  geom_jitter(mapping = aes(x = lead_time, y = children))
