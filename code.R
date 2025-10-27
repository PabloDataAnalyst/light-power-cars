# Cargar librerías e importar los datos
library(tidyverse)
library(janitor)

cars = read_csv("../data/Large Cars Dataset.csv")

# Visualización de los datos
head(cars)
View(cars)

# Limpieza y manipulación de datos
light_cars = cars |> 
  filter(Weight < 2646) |> 
  clean_names()

light_power_cars = light_cars |> 
  arrange(-horse_power)

# Creación de una visualización con los resultados
light_power_cars |> 
  arrange(-horse_power) |> 
  filter(horse_power> 130) |> 
  ggplot() + 
  geom_col(aes(x = reorder(model, -horse_power), horse_power, fill = brand), color = 'black') +
  scale_fill_manual(values = c( "#1F77B4", "#2CA02C", "#FF7F0E", "#9467BD", "#7F7F7F"))+
  xlab('Modelo de Coche') +
  ylab('Potencia(CV)') +
  ggtitle("Coches de Menos de 1200kg") +
  theme_classic(base_size = 14)+
  theme(plot.title = element_text(hjust = 0.5, size = 25, face = 'bold', color = 'white'),
axis.text.x = element_text(size = 30, angle = 45, hjust = 1, color = 'white'), 
axis.text.y = element_text(size = 40, hjust = 0.5, face = 'bold', color = 'white'),
axis.title.x = element_text(size = 40, face = 'bold', color = 'white'),
axis.title.y = element_text(size = 40, face = 'bold', color = 'white'),
plot.background = element_rect(fill = "#2B2B2B", color = NA ),
panel.background = element_rect(fill = '#2B2B2B', color = NA),
panel.grid       = element_line(color = "#444444"),
legend.position = "none")

