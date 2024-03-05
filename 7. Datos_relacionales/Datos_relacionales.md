Datos Relacionales
================

``` r
knitr::opts_chunk$set(fig.width=12, fig.height=8)
```

Hasta ahora hemos trabajado con datos que se encuentran contenidos
dentro de una misma base. En ocasiones es necesario trabajar con datos
que se encuentran en diferentes bases. Por ejemplo, en el capítulo 4,
usamos la base de datos de la ENIGH.

Esta base contiene información concentrada de las características de los
hogares en México. Si trabajamos únicamente con ella, decimos que se
trata de una base con datos ordenados, como lo vimos en el capítulo
anterior.

Cada hogar se compone de diversos integrantes (personas), que tienen
características específicas, como edad, sexo, nivel educativo etc.
Imagina ahora que deseemos conocer cual es la edad promedio de los
integrantes del hogar en cada entidad federativa, o que deseemos conocer
el promedio de años de escolaridad de los miembros de un hogar. En este
caso deberíamos hacer uso de dos bases de datos; una donde se encuentra
la información general del hogar y otra donde se encuentra la
información de cada uno de los individuos que conforman el hogar. Este
tipo de datos se conoce como relacionales, precisamente porque es
necesario establecer relaciones entre ellos para poder analizarlos.

En este capítulo nos enfocaremos en el manejo de este tipo de datos, lo
cual implica el uso de mas de una fuente de información. Para ello
usaremos tres tipos de acciones;

• Uniones de transformación (mutating joins) es el procedimiento de
agregar nuevas variables a un data frame, las cuales provienen de otro
data frame, bajo la condición de que existan observaciones coincidentes
entre ambas.

• Uniones de filtro (filtering joins) es el procedimiento de filtrar
observaciones en un data frame dependiendo de si hay o no coincidencia
con una observación de otro data frame.

• Operaciones de conjuntos (set operations) es el procedimiento de
tratar las observaciones como elementos de un conjunto

- 

Archivos que son de tipo .dta normalmente vienen de Stata, SPSS y SAS.
Se pueden importar de la forma…

``` r
library(haven)
```

    ## Warning: package 'haven' was built under R version 4.2.3

``` r
library(tidyverse)
```

    ## Warning: package 'tidyverse' was built under R version 4.2.3

    ## Warning: package 'ggplot2' was built under R version 4.2.3

    ## Warning: package 'tibble' was built under R version 4.2.3

    ## Warning: package 'tidyr' was built under R version 4.2.3

    ## Warning: package 'readr' was built under R version 4.2.3

    ## Warning: package 'purrr' was built under R version 4.2.3

    ## Warning: package 'dplyr' was built under R version 4.2.3

    ## Warning: package 'stringr' was built under R version 4.2.3

    ## Warning: package 'forcats' was built under R version 4.2.3

    ## Warning: package 'lubridate' was built under R version 4.2.3

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ## ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ## ✔ ggplot2   3.5.0     ✔ tibble    3.2.1
    ## ✔ lubridate 1.9.3     ✔ tidyr     1.3.1
    ## ✔ purrr     1.0.2     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
hogares <- read_dta("C:/Users/david/OneDrive/Escritorio/Personal/a2/Curso - R/7. Datos_relacionales/Datos_relacionales_datos/hog_jal.dta") 
viviendas <- read_dta("C:/Users/david/OneDrive/Escritorio/Personal/a2/Curso - R/7. Datos_relacionales/Datos_relacionales_datos/viv_jal.dta") 
personas <- read_dta("C:/Users/david/OneDrive/Escritorio/Personal/a2/Curso - R/7. Datos_relacionales/Datos_relacionales_datos/per_jal.dta") 
trabajos <- read_dta("C:/Users/david/OneDrive/Escritorio/Personal/a2/Curso - R/7. Datos_relacionales/Datos_relacionales_datos/trab_jal.dta") 
ingresos <- read_dta("C:/Users/david/OneDrive/Escritorio/Personal/a2/Curso - R/7. Datos_relacionales/Datos_relacionales_datos/ing_jal.dta")
```

Hogar es donde hay una familia, pero pueden haber dos hogares en una
vivienda.Cada hogar tiene un còdigo para una familia, y también tiene el
còdigo de la vivienda. Dentro de estos, está el código de cada persona,
etc.

### LLAVES

Es de lo más importante en este capítulo. La llave es el código que me
identifica cada observación como único. Cada csa en una base de datos
tiene un código único, esa sería la llave

``` r
summary(viviendas%>%
  count(folioviv))
```

    ##    folioviv               n    
    ##  Length:2095        Min.   :1  
    ##  Class :character   1st Qu.:1  
    ##  Mode  :character   Median :1  
    ##                     Mean   :1  
    ##                     3rd Qu.:1  
    ##                     Max.   :1

Cada llave aparece solo una vez, es decir, cada código de cada cosa
aparece solo UNA VEZ.

``` r
viviendas%>%
  count(folioviv)%>%
  filter(n>1)
```

    ## # A tibble: 0 × 2
    ## # ℹ 2 variables: folioviv <chr>, n <int>

Esto significa que la llave está correctamente dada

``` r
hogares
```

    ## # A tibble: 2,152 × 9
    ##    folioviv   foliohog ubica_geo clase_hog ing_cor gasto_mon alimentos salud
    ##    <chr>      <chr>    <chr>     <chr>       <dbl>     <dbl>     <dbl> <dbl>
    ##  1 1400180001 1        14039     2          28869.    16068.     8511.    0 
    ##  2 1400180002 1        14039     3          57237.    32342.    12793.    0 
    ##  3 1400180005 1        14039     1          32527.    24481.     9148.    0 
    ##  4 1400180006 1        14039     1          28381.    17468.     7579.    0 
    ##  5 1400189601 1        14039     2          39775.    70465.    21188.    0 
    ##  6 1400189603 1        14039     2         102717.    56377.    13731. 3073.
    ##  7 1400189604 1        14039     2          91475.    43816.    12568.  154.
    ##  8 1400189605 1        14039     2          55828.    60636.    15300.    0 
    ##  9 1400189606 1        14039     2          40313.    12303.     5901. 1027.
    ## 10 1400189606 2        14039     2          23390.    21947.    14374.  318.
    ## # ℹ 2,142 more rows
    ## # ℹ 1 more variable: educa_espa <dbl>

En hogares, hay una columna para el número de hogares (foliohog), por lo
cual, la llave vendría siendo la combinación de la llave de vivienda con
este folio.

``` r
hogares%>%
  count(foliohog)
```

    ## # A tibble: 4 × 2
    ##   foliohog     n
    ##   <chr>    <int>
    ## 1 1         2095
    ## 2 2           50
    ## 3 3            5
    ## 4 4            2

Hay 2 casas que tienen 4 hogares/famlias. Se ve que el foliohog por si
solo no puede ser la llave

``` r
hogares%>%
  count(foliohog,folioviv)
```

    ## # A tibble: 2,152 × 3
    ##    foliohog folioviv       n
    ##    <chr>    <chr>      <int>
    ##  1 1        1400180001     1
    ##  2 1        1400180002     1
    ##  3 1        1400180005     1
    ##  4 1        1400180006     1
    ##  5 1        1400189601     1
    ##  6 1        1400189603     1
    ##  7 1        1400189604     1
    ##  8 1        1400189605     1
    ##  9 1        1400189606     1
    ## 10 1        1400264701     1
    ## # ℹ 2,142 more rows

``` r
hogares%>%
  count(foliohog,folioviv)%>%
  filter(n>1)
```

    ## # A tibble: 0 × 3
    ## # ℹ 3 variables: foliohog <chr>, folioviv <chr>, n <int>

El trabajo es el nivel más bajo, por lo cual su código de identificación
o llave será el resultado de unir el folio de vivienda, el folio del
hogar, el número de la persona y el id del trabajo.

``` r
trabajos%>%
  count(foliohog,folioviv, numren, id_trabajo)
```

    ## # A tibble: 4,205 × 5
    ##    foliohog folioviv   numren id_trabajo     n
    ##    <chr>    <chr>      <chr>  <chr>      <int>
    ##  1 1        1400180002 01     1              1
    ##  2 1        1400180002 04     1              1
    ##  3 1        1400180005 01     1              1
    ##  4 1        1400180006 01     1              1
    ##  5 1        1400189601 01     1              1
    ##  6 1        1400189601 02     1              1
    ##  7 1        1400189601 04     1              1
    ##  8 1        1400189603 02     1              1
    ##  9 1        1400189603 02     2              1
    ## 10 1        1400189604 01     1              1
    ## # ℹ 4,195 more rows

Cuando se trabajan con datos relacionales, cada cosa debe tener un
identificador UNICO. No hay ningún dato con un identificador repetido
(er el “n”)

### JOINS

Primero veremos tipos de uniones

``` r
x <- tribble(
  ~llave, ~sexo, ~edad,
  1, "H", "25",
  2, "M", "40",
  3, "H", "18"
)

x
```

    ## # A tibble: 3 × 3
    ##   llave sexo  edad 
    ##   <dbl> <chr> <chr>
    ## 1     1 H     25   
    ## 2     2 M     40   
    ## 3     3 H     18

``` r
y <- tribble(
  ~llave, ~ingreso, ~gasto,
  1, "1750", "1100",
  2, "2540", "1760",
  4, "3000", "890"
)

y
```

    ## # A tibble: 3 × 3
    ##   llave ingreso gasto
    ##   <dbl> <chr>   <chr>
    ## 1     1 1750    1100 
    ## 2     2 2540    1760 
    ## 3     4 3000    890

La llave cumple con el requisito porque son únicas, pero NO se podrán
relacionar al 100% las tablas porque hay una llave que no existe en la
otra tabla.

1.  Unión interior: Conservará las observaciones presentes en ambas
    bases

``` r
inner_join(x, y, by= "llave")
```

    ## # A tibble: 2 × 5
    ##   llave sexo  edad  ingreso gasto
    ##   <dbl> <chr> <chr> <chr>   <chr>
    ## 1     1 H     25    1750    1100 
    ## 2     2 M     40    2540    1760

2.  Unión exterior: Hay dos tipos:

2.1.Por la izquierda: Conserva las observaciones de la base que esté a
la izquierda

``` r
left_join(x, y, by = "llave")
```

    ## # A tibble: 3 × 5
    ##   llave sexo  edad  ingreso gasto
    ##   <dbl> <chr> <chr> <chr>   <chr>
    ## 1     1 H     25    1750    1100 
    ## 2     2 M     40    2540    1760 
    ## 3     3 H     18    <NA>    <NA>

Se conservaron los valores de “x”

2.2. Por la derecha: Conserva las observaciones de la base de la
derecha.

``` r
right_join(x, y, by = "llave")
```

    ## # A tibble: 3 × 5
    ##   llave sexo  edad  ingreso gasto
    ##   <dbl> <chr> <chr> <chr>   <chr>
    ## 1     1 H     25    1750    1100 
    ## 2     2 M     40    2540    1760 
    ## 3     4 <NA>  <NA>  3000    890

3.  Unión completa: Une TODA la información

``` r
full_join(x, y, by = "llave")
```

    ## # A tibble: 4 × 5
    ##   llave sexo  edad  ingreso gasto
    ##   <dbl> <chr> <chr> <chr>   <chr>
    ## 1     1 H     25    1750    1100 
    ## 2     2 M     40    2540    1760 
    ## 3     3 H     18    <NA>    <NA> 
    ## 4     4 <NA>  <NA>  3000    890

El más utlizado es unión interior

### UNIONES ENIGH

Vamos a contestar la pregunta: ¿Cuáles son los conceptos más comunes por
los cuales hombres y mujeres obtienen ingresos?

``` r
ingresos <- left_join(ingresos, personas, by=c("folioviv", "foliohog", "numren"))

ingresos
```

    ## # A tibble: 10,919 × 11
    ##    folioviv  foliohog numren clave ing_tri sexo   edad disc1 hablaind alfabetism
    ##    <chr>     <chr>    <chr>  <chr>   <dbl> <chr> <dbl> <chr> <chr>    <chr>     
    ##  1 14001800… 1        02     P044    1702. 2        73 1     2        1         
    ##  2 14001800… 1        02     P040    3228. 2        73 1     2        1         
    ##  3 14001800… 1        01     P032    6457. 1        81 2     2        1         
    ##  4 14001800… 1        01     P023    5870. 1        81 2     2        1         
    ##  5 14001800… 1        01     P024    1761. 1        78 2     2        1         
    ##  6 14001800… 1        01     P044    1702. 1        78 2     2        1         
    ##  7 14001800… 1        02     P040    1908. 2        70 4     2        1         
    ##  8 14001800… 1        02     P044    1702. 2        70 4     2        1         
    ##  9 14001800… 1        04     P001   23478. 1        41 8     2        1         
    ## 10 14001800… 1        01     P003    7435. 1        78 2     2        1         
    ## # ℹ 10,909 more rows
    ## # ℹ 1 more variable: asis_esc <chr>

``` r
ingresos <- ingresos%>%
  count(sexo, clave)%>%
  arrange(desc(n), sexo)

ingresos
```

    ## # A tibble: 132 × 3
    ##    sexo  clave     n
    ##    <chr> <chr> <int>
    ##  1 1     P001   1715
    ##  2 2     P001   1118
    ##  3 1     P009    819
    ##  4 2     P009    591
    ##  5 2     P040    524
    ##  6 2     P042    328
    ##  7 1     P022    279
    ##  8 1     P008    275
    ##  9 1     P040    270
    ## 10 1     P032    193
    ## # ℹ 122 more rows
