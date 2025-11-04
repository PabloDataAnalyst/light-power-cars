# Project by Pablo - shared publicly for portfolio purposes (2025)
## Charge libraries and import data
library(tidyverse)
library(janitor)
library(ggimage)
library(scales)

cars = read_csv(".../data/Large Cars Dataset.csv")

## View data
head(cars)
View(cars)

## Clean and manipulate data
light_cars = cars |> 
  filter(Weight < 2646) |> 
  clean_names()

light_power_cars = light_cars |> 
  arrange(-horse_power)

light_power_cars$model = trimws(light_power_cars$model)

### Create an additional column for the car's images
light_power_cars = light_power_cars |>
  mutate(image = case_when(
    model == "Celica GT-S 2dr" ~ "https://images.iconfigurators.app/images/vehicles/reference/Toyota-Celica-GT-2000_2005.png",
    model == "MX-5 Miata LS convertible 2dr" ~ "https://images.squarespace-cdn.com/content/v1/6163510905a1267c6e37eabe/0de29391-78d6-48ff-917a-0e3d2e9ac993/S2+Transparant.png",
    model == "MX-5 Miata convertible 2dr" ~ "https://images.squarespace-cdn.com/content/v1/6163510905a1267c6e37eabe/0de29391-78d6-48ff-917a-0e3d2e9ac993/S2+Transparant.png",
    model == 'Cavalier LS 2dr' ~ 'https://images.iconfigurators.app/images/vehicles/reference/Chevrolet-Cavalier-Coupe-1995_2005.png',
    model == 'Cavalier 2dr' ~ 'https://images.iconfigurators.app/images/vehicles/reference/Chevrolet-Cavalier-Coupe-1995_2005.png',
    model == 'MR2 Spyder convertible 2dr' ~ 'https://carsguide-res.cloudinary.com/image/upload/e_trim:10,f_auto/c_scale,t_cg_base,w_678/v1/editorial/Toyota-MR2.png',
    model == 'Elantra GT 4dr' ~ 'https://crdms.images.consumerreports.org/c_lfill,w_563,q_auto,f_auto/prod/cars/cr/model-years/886-2000-hyundai-elantra',
    model == 'Elantra GLS 4dr' ~ 'https://crdms.images.consumerreports.org/c_lfill,w_563,q_auto,f_auto/prod/cars/cr/model-years/886-2000-hyundai-elantra',
    model == 'Neon SXT 4dr' ~ 'https://ik.imagekit.io/2ero5nzbxo2/tr:di-placeholder.png,q-70,w-375,q-70/FILES/generations/Kg2SdXNKIUOdeoHwqGWH8996ZyXJma0SMhTcwtOu.png?ik-sdk-version=php-2.0.0',
    model == 'Neon SE 4dr' ~ 'https://ik.imagekit.io/2ero5nzbxo2/tr:di-placeholder.png,q-70,w-375,q-70/FILES/generations/Kg2SdXNKIUOdeoHwqGWH8996ZyXJma0SMhTcwtOu.png?ik-sdk-version=php-2.0.0',
      TRUE ~ "https://cdn-icons-png.flaticon.com/512/743/743920.png"))

## Create a visualization with the results
### light theme
light_power_cars |> 
  arrange(desc(horse_power)) |> 
  filter(horse_power> 130) |> 
  ggplot(aes(x = horse_power, y = reorder(model, horse_power))) +
  geom_col(fill = "#7c7c7bff", width = 0.7, color = NA) +
  geom_text(aes(horse_power, model, label = paste0(horse_power, "HP")), hjust = -0.1, color = "#222", fontface = "bold", size = 10) +
  geom_text(aes(230, model, label = dealer_cost), vjust = 0.5, hjust = 1, color = "#2b7a0b", fontface = "bold", size = 9) +
  geom_text(aes(horse_power -20, model, label = toupper(model)), hjust = 1, color = "white", size = 12)+
  geom_text(aes(0, model, label = toupper(brand)), hjust = 0, fontface = 'bold', color = "white", size = 12) +
  geom_image(aes(x = horse_power - 10, image = image), size = 0.09, by = "width", asp = 1.5) +
  theme_minimal(base_size = 16) +
  theme(
    plot.background = element_rect(fill = "#faf5ee", color = NA),
    panel.background = element_rect(fill = "#faf5ee", color = NA),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.y = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.title = element_text(face = "bold", size = 60, hjust = 0.5, color = "#2b2b2b"),
    plot.caption = element_text(color = 'black', size = 18),
    plot.subtitle = element_text(size = 30, hjust = 0.5, color = "#555555")) +
  labs(
    title = "THE WORLD’S MOST POWERFUL LIGHT CARS FROM 2000s",
    subtitle = "Less than 1200 kg and more than 130 HP",
    caption = "Data source: Maks Lypko")

### dark theme
light_power_cars |> 
  arrange(desc(horse_power)) |> 
  filter(horse_power> 130) |> 
  ggplot(aes(x = horse_power, y = reorder(model, horse_power))) +
  geom_col(fill = "#a6a6a4ff", width = 0.7, color = NA) +
  geom_text(aes(horse_power, model, label = paste0(horse_power, "HP")), hjust = -0.1, color = 'white', fontface = "bold", size = 10) +
  geom_text(aes(230, model, label = dealer_cost), vjust = 0.5, hjust = 1, color = "#62e92dff", fontface = "bold", size = 9) +
  geom_text(aes(horse_power -20, model, label = toupper(model)), hjust = 1, color = "black", size = 12)+
  geom_text(aes(0, model, label = toupper(brand)), hjust = 0, fontface = 'bold', color = "black", size = 12) +
  geom_image(aes(x = horse_power - 10, image = image), hjust = 1, size = 0.09, by = "width", asp = 1.5) +
  theme_minimal(base_size = 16) +
  theme(
    plot.background = element_rect(fill = "#2B2B2B", color = NA),
    panel.background = element_rect(fill = "#2B2B2B", color = NA),
    panel.grid.major.y = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.y = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.title = element_text(face = "bold", size = 60, hjust = 0.5, color = 'white'),
    plot.caption = element_text(color = 'white', size = 18),
    plot.subtitle = element_text(size = 30, hjust = 0.5, color = "#e4e4e4ff")) +
  labs(
    title = "THE WORLD’S MOST POWERFUL LIGHT CARS FROM 2000s",
    subtitle = "Less than 1200 kg and more than 130 HP",
    caption = "Data source: Maks Lypko")

