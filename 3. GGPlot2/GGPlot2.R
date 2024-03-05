
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

# "alpha" da un gradiente a los puntos de acuerdo a una variable

ggplot(data = enoe)+
  geom_point(aes(anios_esc, ingreso_mensual), color = "orange")+
  geom_smooth(aes(anios_esc, ingreso_mensual), color = "orange")

# "smooth" es una línea suavizada

ggplot(data = enoe)+
  geom_point(aes(anios_esc, ingreso_mensual))+
  facet_wrap(~sex, nrow=1,ncol=2)

ggplot(data = enoe)+
  geom_point(aes(anios_esc, ingreso_mensual, color = tipo_empleo))+
  facet_wrap(~sex, nrow=1,ncol=2)

ggplot(data = enoe)+
  geom_point(aes(anios_esc, ingreso_mensual))+
  facet_grid(tipo_empleo~sex)

# "facet_grid" se usa para variables categóricas

ggplot(data = enoe)+
  geom_smooth(aes(x=anios_esc, y = ingreso_mensual))

# En R los diferentes tipos de gráficas son diferentes "geometrias"

ggplot(data = enoe)+
  geom_smooth(aes(x=anios_esc, y = ingreso_mensual, linetype = sex))

ggplot(data = enoe)+
  geom_smooth(mapping = aes(x = anios_esc, y=ingreso_mensual, linetype = tipo_empleo))

ggplot(data = enoe)+
  geom_smooth(mapping = aes(x = anios_esc, y=ingreso_mensual, linetype = tipo_empleo))+
  geom_point(mapping=aes(x=anios_esc, y=ingreso_mensual, color = tipo_empleo))

# Ambas gráficas tienen los mismos aes, se puede decir desde el principio

ggplot(data = enoe, mapping=aes(x = anios_esc, y=ingreso_mensual))+
  geom_point(mapping = aes(color =tipo_empleo))+
  geom_smooth(mapping = aes(linetype=tipo_empleo))

# Se pueden especificar los aes desde ggplot

ggplot(data = enoe, mapping = aes(x = anios_esc, y = ingreso_mensual))+
  geom_point(mapping = aes(color = niv_edu), show.legend = F)

### TRANSFORMACIONES ESTADÍSTICAS

ggplot(data = enoe)+
  geom_bar(mapping = aes(x = sex))

ggplot(data = enoe)+
  stat_count(mapping=aes(x=sex))

# "stat_count" permite sacar estadística en las gráficas

ggplot(data = enoe)+
  stat_count(mapping=aes(x=sex, y =..prop..,group=1))

# "..prop..,group=" permite ver la gráfica en forma de %

?geom_bar

#"?" antes de una función permite ver para qué funciona

ggplot(data = enoe)+
  stat_summary(
    mapping=aes(x=sex, y=ingreso_mensual),
    fun.min = min,
    fun.max=max,
    fun=median
  )

# "fun.min, fun.max, fun" permite aplicar análisis estadístico en la misma gráfica

# "stat_summary" es como una gráfica de cajas y bigotes en R

### AJUSTES DE POSICIÓN

ggplot(data = enoe)+
  geom_bar(mapping = aes(x=sex, fill = sex))

ggplot(data = enoe)+
  geom_bar(mapping = aes(x=sex, fill = niv_edu))

# "fill" requiere de variables categoricas

ggplot(data = enoe, mapping=aes(x=sex, fill=niv_edu))+
  geom_bar(alpha=1/5, position="identity")

ggplot(data = enoe, mapping=aes(x=sex, fill=niv_edu))+
  geom_bar(position="identity")

# position = "identity" genera un apilamiento en una misma posición en 3D, por lo que hay que usar transparencia para verlo.

ggplot(data = enoe, mapping=aes(x=sex, color=niv_edu))+
  geom_bar(fill = NA, position="identity")

ggplot(data = enoe, mapping=aes(x=sex, fill = niv_edu))+
  geom_bar(position = "fill")

# position = "fill" me da un gráfico en forma de proporciones

ggplot(data = enoe, mapping=aes(x=factor(1), fill = niv_edu))+
  geom_bar(position = "fill")

ggplot(data = enoe, mapping = aes(x=sex, fill = niv_edu))+
  geom_bar(position = "dodge")+
  labs(title = "a", x = "sexo", y = "observaciones")

# "dodge" permite ver los datos en barras independientes

ggplot(data = enoe)+
  geom_point(mapping=aes(x=anios_esc, y=ingreso_mensual), position = "jitter")

# "jitter" mueve los puntos para ver todos así estén en el mismo lugar

### SISTEMA DE COORDENADAS

ggplot(data = enoe, mapping = aes(x = niv_edu, y=ingreso_mensual))+
  geom_boxplot()

ggplot(data = enoe, mapping = aes(x = niv_edu, y=ingreso_mensual))+
  geom_boxplot()+
  coord_flip()

# "coord_flip" rota las gráficas

barra <- ggplot(data = enoe)+
  geom_bar(mapping=aes(x=niv_edu, fill=niv_edu),
           show.legend = F, with = 1)+
  theme(aspect.ratio = 1)+
  labs(x = NULL, y = NULL)

barra

barra + coord_flip()

barra + coord_polar()

ggplot(data = enoe, mapping = aes(x=factor(1), fill = niv_edu))+
  geom_bar(position = "fill")+
  coord_polar(theta = "y")