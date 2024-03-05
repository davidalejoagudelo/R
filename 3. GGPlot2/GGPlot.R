setwd("C:/Users/david/OneDrive/Escritorio/Personal/a2/Curso - R/R/R")

library(readxl)

enoe <- read_excel("C:/Users/david/OneDrive/Escritorio/Personal/a2/Curso - R/3. GGPlot2/mu_enoe.xlsx")

enoe

class(enoe)

dim(enoe)

colnames(enoe)

library(ggplot2)

ggplot(data = enoe)+
  geom_point(mapping=aes(x=anios_esc, y=ingreso_mensual))

ggplot(data = enoe)+
  geom_point(mapping=aes(x=anios_esc, y=ingreso_mensual), color = "orange")

ggplot(data = enoe)+
  geom_point(mapping = aes(x=anios_esc, y = ingreso_mensual, color = tipo_empleo))

ggplot(data = enoe)+
  geom_point(mapping = aes(x=anios_esc, y = ingreso_mensual, shape = tipo_empleo))

ggplot(data = enoe)+
  geom_point(mapping = aes(x = anios_esc, y = edad, alpha = ingreso_mensual))

#"alpha" da un gradiente a los puntos de acuerdo a una variable

ggplot(data = enoe)+
  geom_point(aes(anios_esc, ingreso_mensual), color = "orange")+
  geom_smooth(aes(anios_esc, ingreso_mensual), color = "orange")

