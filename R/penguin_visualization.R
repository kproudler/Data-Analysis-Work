install.packages("palmerpenguins")
library(palmerpenguins)
data(penguins)
View(penguins)

ggplot(data=penguins)+geom_point(mapping = aes(x=flipper_length_mm, y=body_mass_g))
ggplot(data=penguins)+geom_point(mapping = aes(x=bill_length_mm, y=bill_depth_mm))

ggplot(data=penguins) +
  geom_point(mapping=aes(x=flipper_length_mm, y=body_mass_g)) +
  geom_smooth(mapping=aes(x=flipper_length_mm, y=body_mass_g))
