install.packages("palmerpenguins")
library(palmerpenguins)
data(penguins)
View(penguins)

ggplot(data=penguins)+geom_point(mapping = aes(x=flipper_length_mm, y=body_mass_g))
ggplot(data=penguins)+geom_point(mapping = aes(x=bill_length_mm, y=bill_depth_mm))

ggplot(data=penguins) +
  geom_point(mapping=aes(x=flipper_length_mm, y=body_mass_g)) +
  geom_smooth(mapping=aes(x=flipper_length_mm, y=body_mass_g))

ggplot(data=penguins)+
  geom_smooth(mapping=aes(x=flipper_length_mm, y=body_mass_g, linetype=species))

ggplot(data=penguins)+
  geom_smooth(mapping=aes(x=flipper_length_mm, y=body_mass_g, linetype=species))
  geom_jitter(mapping=aes(x=flipper_length_mm,y=body_mass_g))

ggplot(data=penguins, aes(x=flipper_length_mm, y=body_mass_g))+
  geom_point(aes(color=species))+
  facet_grid(~sex)
