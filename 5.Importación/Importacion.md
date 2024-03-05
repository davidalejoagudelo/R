Importación de datos
================

``` r
knitr::opts_chunk$set(fig.width=12, fig.height=8)
```

### TIBBLES

data frame es un lenguaje muy obsoleto. Ahora se usan Tibbles. Es una
tabla, pero la diferencia es

``` r
#install.packages("nycflights13")

library(nycflights13)
```

``` r
nycflights13::flights
```

    ## # A tibble: 336,776 × 19
    ##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
    ##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
    ##  1  2013     1     1      517            515         2      830            819
    ##  2  2013     1     1      533            529         4      850            830
    ##  3  2013     1     1      542            540         2      923            850
    ##  4  2013     1     1      544            545        -1     1004           1022
    ##  5  2013     1     1      554            600        -6      812            837
    ##  6  2013     1     1      554            558        -4      740            728
    ##  7  2013     1     1      555            600        -5      913            854
    ##  8  2013     1     1      557            600        -3      709            723
    ##  9  2013     1     1      557            600        -3      838            846
    ## 10  2013     1     1      558            600        -2      753            745
    ## # ℹ 336,766 more rows
    ## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
    ## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
    ## #   hour <dbl>, minute <dbl>, time_hour <dttm>

``` r
head(iris)
```

    ##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
    ## 1          5.1         3.5          1.4         0.2  setosa
    ## 2          4.9         3.0          1.4         0.2  setosa
    ## 3          4.7         3.2          1.3         0.2  setosa
    ## 4          4.6         3.1          1.5         0.2  setosa
    ## 5          5.0         3.6          1.4         0.2  setosa
    ## 6          5.4         3.9          1.7         0.4  setosa

Los data frame se muestran completos en la consola, los tibbles se
muestran incompletos, rara vez hay que transformar un data frame a
tibble

``` r
#iris2 <- as.tibble(iris)

#iris2
```

### IMPORT. CON READR 3

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

en “tidyverse” tabien está reader

``` r
read_csv("sexo, edad, ingreso
         1,40,5000,
         2,25,2300,
         1,15,4600")
```

    ## Warning: One or more parsing issues, call `problems()` on your data frame for details,
    ## e.g.:
    ##   dat <- vroom(...)
    ##   problems(dat)

    ## Rows: 3 Columns: 3
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (2): sexo, edad
    ## num (1): ingreso
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    ## # A tibble: 3 × 3
    ##    sexo  edad ingreso
    ##   <dbl> <dbl>   <dbl>
    ## 1     1    40    5000
    ## 2     2    25    2300
    ## 3     1    15    4600

Si falta un dato lo pone como NA

``` r
read_csv("sexo, edad, ingreso
         1,40,
         2,25,2300,
         1,15,4600")
```

    ## Warning: One or more parsing issues, call `problems()` on your data frame for details,
    ## e.g.:
    ##   dat <- vroom(...)
    ##   problems(dat)

    ## Rows: 3 Columns: 3
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (2): sexo, edad
    ## num (1): ingreso
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    ## # A tibble: 3 × 3
    ##    sexo  edad ingreso
    ##   <dbl> <dbl>   <dbl>
    ## 1     1    40      NA
    ## 2     2    25    2300
    ## 3     1    15    4600

Si no se especifica una columna, le pone el número al cual corresponde
esta

``` r
read_csv("sexo, edad,
         1,40,2300
         2,25,2300,
         1,15,4600")
```

    ## New names:
    ## • `` -> `...3`

    ## Warning: One or more parsing issues, call `problems()` on your data frame for details,
    ## e.g.:
    ##   dat <- vroom(...)
    ##   problems(dat)

    ## Rows: 3 Columns: 3
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (2): sexo, edad
    ## num (1): ...3
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    ## # A tibble: 3 × 3
    ##    sexo  edad  ...3
    ##   <dbl> <dbl> <dbl>
    ## 1     1    40  2300
    ## 2     2    25  2300
    ## 3     1    15  4600

“\#” permite hacer comentarios en el código. Dentro de un Tibble hay que
especificar lo que indica un comentario con “comment”

``` r
read_csv("#algo que no quiero
          sexo, edad, ingreso
         1,40,5000,
         2,25,2300,
         1,15,4600", comment = "#")
```

    ## Warning: One or more parsing issues, call `problems()` on your data frame for details,
    ## e.g.:
    ##   dat <- vroom(...)
    ##   problems(dat)

    ## Rows: 3 Columns: 3
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (2): sexo, edad
    ## num (1): ingreso
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    ## # A tibble: 3 × 3
    ##    sexo  edad ingreso
    ##   <dbl> <dbl>   <dbl>
    ## 1     1    40    5000
    ## 2     2    25    2300
    ## 3     1    15    4600

“skyp” hace que se salte las primeras filas que no interesan

``` r
read_csv("#algo que no quiero,
          #otra cosa,
          sexo, edad, ingreso
         1,40,5000,
         2,25,2300,
         1,15,4600", skip = 2)
```

    ## Warning: One or more parsing issues, call `problems()` on your data frame for details,
    ## e.g.:
    ##   dat <- vroom(...)
    ##   problems(dat)

    ## Rows: 3 Columns: 3
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (2): sexo, edad
    ## num (1): ingreso
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    ## # A tibble: 3 × 3
    ##    sexo  edad ingreso
    ##   <dbl> <dbl>   <dbl>
    ## 1     1    40    5000
    ## 2     2    25    2300
    ## 3     1    15    4600

Se pueden hacer ambas cosas al tiempo

``` r
read_csv("#algo que no quiero,
          #otra cosa,
          sexo, edad, ingreso
         1,40,5000
         2,25,2300
         Aloooo,
         1,15,4600", skip = 2, comment = "A")
```

    ## Warning: One or more parsing issues, call `problems()` on your data frame for details,
    ## e.g.:
    ##   dat <- vroom(...)
    ##   problems(dat)

    ## Rows: 4 Columns: 3
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (3): sexo, edad, ingreso
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    ## # A tibble: 4 × 3
    ##    sexo  edad ingreso
    ##   <dbl> <dbl>   <dbl>
    ## 1     1    40    5000
    ## 2     2    25    2300
    ## 3    NA    NA      NA
    ## 4     1    15    4600

Si no tengo nombres de coumnas entonces me sirve el comando “col_names =
F”, y le coloca títulos a las olumnas como X1, X2, etc.

``` r
read_csv("1,40, 5000
          2,25,2300
          1,15,4600")
```

    ## Rows: 2 Columns: 3
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (3): 1, 40, 5000
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    ## # A tibble: 2 × 3
    ##     `1`  `40` `5000`
    ##   <dbl> <dbl>  <dbl>
    ## 1     2    25   2300
    ## 2     1    15   4600

``` r
read_csv("1,40, 5000
          2,25,2300
          1,15,4600", col_names = F)
```

    ## Rows: 3 Columns: 3
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (3): X1, X2, X3
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    ## # A tibble: 3 × 3
    ##      X1    X2    X3
    ##   <dbl> <dbl> <dbl>
    ## 1     1    40  5000
    ## 2     2    25  2300
    ## 3     1    15  4600

Se los puedo especificar con la función “c()”, que es concatenar, o un
vector.

``` r
read_csv("1,40, 5000
          2,25,2300
          1,15,4600", col_names =  c("Sexo", "Edad", "Ingreso"))
```

    ## Rows: 3 Columns: 3
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (3): Sexo, Edad, Ingreso
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    ## # A tibble: 3 × 3
    ##    Sexo  Edad Ingreso
    ##   <dbl> <dbl>   <dbl>
    ## 1     1    40    5000
    ## 2     2    25    2300
    ## 3     1    15    4600

me permite escribir un título con espacio

### ANALISIS DE UN VECTOR

La función “parse” sirve para analizar el contenido de una columna

``` r
vector <- c("True", "False", "NA")

class(vector)
```

    ## [1] "character"

``` r
vector2 <- parse_logical(vector)

class(vector2)
```

    ## [1] "logical"

Ahora los datos son de tipo “logical”

``` r
vector3 <- c("1", "2", "3")

class(vector3)
```

    ## [1] "character"

Como están entre comillas, quedan como caracter

``` r
vector3 <- parse_integer(vector3)

class(vector3)
```

    ## [1] "integer"

``` r
vector4 <- c("2010-01-01", "1979-10-14")

class(vector4)
```

    ## [1] "character"

``` r
vector4 <- parse_date(vector4)

class(vector4)
```

    ## [1] "Date"

``` r
vector5 <- c("1", "231", ".", "456")

class(vector5)
```

    ## [1] "character"

``` r
parse_integer(vector5)
```

    ## Warning: 1 parsing failure.
    ## row col               expected actual
    ##   3  -- no trailing characters      .

    ## [1]   1 231  NA 456
    ## attr(,"problems")
    ## # A tibble: 1 × 4
    ##     row   col expected               actual
    ##   <int> <int> <chr>                  <chr> 
    ## 1     3    NA no trailing characters .

Como en el vector inicial hay un valor que no es un entero, me dice que
hay un error. Se puede transformar en un “NA”.

``` r
parse_integer(vector5, na = ".")
```

    ## [1]   1 231  NA 456

### NUMEROS

Hay tres situaciones en las que R se jode.

1)  Uso de “,” como decimal
2)  En peso o %
3)  Cuando se abreviando un dato

``` r
x <- "1.23"

class(x)
```

    ## [1] "character"

No se puede transformar a un formato de entero porque NO es entero.
“parse_integer” transforma solo enteros

``` r
y <- parse_integer(x)
```

    ## Warning: 1 parsing failure.
    ## row col               expected actual
    ##   1  -- no trailing characters   1.23

“parse_doble” también transforma decimales.

``` r
y <- parse_double(x)
```

Si viene en formato europeo…

``` r
x <- "1,23"

y <- parse_double(x, locale = locale(decimal_mark = ","))

class(y)
```

    ## [1] "numeric"

“decimal_mark” indica, entre “.” o “,”, el separador de decimal

Ahora viene en el formato que R necesita…

``` r
y
```

    ## [1] 1.23

2)  Cuando viene en formato de moneda o %…

``` r
x <- "$100"
x
```

    ## [1] "$100"

``` r
y <- parse_number(x)
y
```

    ## [1] 100

``` r
class(y)
```

    ## [1] "numeric"

Se puede extraer cualquier numero

``` r
x <- "La utilida del mes fue de $15000"
y <- parse_number(x)

y
```

    ## [1] 15000

3)  Ahora, si es un numero de más de 6 cifras con solo separación con
    “.”…

``` r
x <- "$442.185.895.145"

y <- parse_number(x, locale = locale(grouping_mark = "."))
y
```

    ## [1] 442185895145

“grouping_mark” me permite agrupar los números que vienen separados por
puntos, como un número entero.

### TIEMPOS

Ahora vamos a ver “parse_date”

``` r
x <- "2020/10/01"

y <- parse_date(x)

y
```

    ## [1] "2020-10-01"

Si no tengo un separador, no puedo usar “parse_date”, porque exige
separadores…

``` r
x <- "20201001"

y <- parse_datetime(x)
y
```

    ## [1] "2020-10-01 UTC"

Lo que pasa es que esta por default nos da un horario de tiempo, y dice
que son las 12 de la noche, si no se especifica una hora.

Si quiero darle una hora…

``` r
x <- "20201001T2010"

y <- parse_datetime(x)
y
```

    ## [1] "2020-10-01 20:10:00 UTC"

Así me está diciendo que son las 8:10 pm.

Coo estos datos normalmente vienen de bases de datos, hay que hacer una
limpieza de datos antes de pasar a R.

Si se trabajan fechas en otro formato.

``` r
x <- "09/12/20" # Diciendo que es el 9 de diciembre del 2020

parse_date(x)
```

    ## Warning: 1 parsing failure.
    ## row col   expected   actual
    ##   1  -- date like  09/12/20

    ## [1] NA

Hay que especificar el formato…

``` r
x <- "09/12/20" # Diciendo que es el 9 de diciembre del 2020

parse_date(x, "%d/%m/%y")
```

    ## [1] "2020-12-09"

Se puede intercalar esto…

``` r
x <- "09/12/20" # Diciendo que es el 12 de septiembre del 2020

parse_date(x, "%m/%d/%y")
```

    ## [1] "2020-09-12"

Hay que saber el formato de las fechas con las que se trabajan.

Si solo tengo tiempo…

``` r
x <- ("05:30:05 pm")

y <- parse_time(x)
y
```

    ## 17:30:05

R da la hora en horario militar.

### ANALISIS DE UN ARCHIVO

Como hacerlo con un archivo completo. Tidyverse tiene archivos de
muestra

``` r
prueba <- read_csv(readr_example("challenge.csv"))
```

    ## Rows: 2000 Columns: 2
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl  (1): x
    ## date (1): y
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
head(prueba)
```

    ## # A tibble: 6 × 2
    ##       x y     
    ##   <dbl> <date>
    ## 1   404 NA    
    ## 2  4172 NA    
    ## 3  3004 NA    
    ## 4   787 NA    
    ## 5    37 NA    
    ## 6  2332 NA

La segunda columna la asignó como fecha, pero no se cargaron los datos
porque no es de la forma en la que R las lee.

``` r
prueba <- read_csv(readr_example("challenge.csv"),
                   col_types = cols(
                     x = col_double(),
                     y = col_date()
                   ))

tail(prueba)
```

    ## # A tibble: 6 × 2
    ##       x y         
    ##   <dbl> <date>    
    ## 1 0.805 2019-11-21
    ## 2 0.164 2018-03-29
    ## 3 0.472 2014-08-04
    ## 4 0.718 2015-08-16
    ## 5 0.270 2020-02-04
    ## 6 0.608 2019-01-06

Ya cargó algunas fechas, pero no todas. Se recomienda siempre
especificar lo que contiene cada columna. Se puede ingresar todo como
caracter, y luego si cambiar todo con “parse”

``` r
prueba2 <- read_csv(readr_example("challenge.csv"),
                   col_types = cols(.default = col_character()))

tail(prueba2)
```

    ## # A tibble: 6 × 2
    ##   x                   y         
    ##   <chr>               <chr>     
    ## 1 0.805274312151596   2019-11-21
    ## 2 0.1635163405444473  2018-03-29
    ## 3 0.47193897631950676 2014-08-04
    ## 4 0.7183186465408653  2015-08-16
    ## 5 0.26987858884967864 2020-02-04
    ## 6 0.608237189007923   2019-01-06

Para R, no son fechas, así se vean como fechas.

``` r
prueba2$y <- parse_date(prueba2$y)

prueba2
```

    ## # A tibble: 2,000 × 2
    ##    x     y     
    ##    <chr> <date>
    ##  1 404   NA    
    ##  2 4172  NA    
    ##  3 3004  NA    
    ##  4 787   NA    
    ##  5 37    NA    
    ##  6 2332  NA    
    ##  7 2489  NA    
    ##  8 1449  NA    
    ##  9 3665  NA    
    ## 10 3863  NA    
    ## # ℹ 1,990 more rows

Ahora la columna ya está en fecha. Generalmente R usa las 1.000 primeras
dilas para determinar el tipo de dato, y generlamente están bien, pero
en este caso no

``` r
prueba3 <- read_csv(readr_example("challenge.csv"), guess_max = 1001)
```

    ## Rows: 2000 Columns: 2
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl  (1): x
    ## date (1): y
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
prueba3
```

    ## # A tibble: 2,000 × 2
    ##        x y     
    ##    <dbl> <date>
    ##  1   404 NA    
    ##  2  4172 NA    
    ##  3  3004 NA    
    ##  4   787 NA    
    ##  5    37 NA    
    ##  6  2332 NA    
    ##  7  2489 NA    
    ##  8  1449 NA    
    ##  9  3665 NA    
    ## 10  3863 NA    
    ## # ℹ 1,990 more rows

Así, R ya determinó que la columna y es de fechas!!!!

Estas son las únicas maneras para aplicar un parse a un archivo, se hace
en R cuando se trata de una cantidad muy grande de datos.

### EXPORTAR DATOS

Primero hay que tener el directorio de trabajo bien ubicado

``` r
getwd()
```

    ## [1] "C:/Users/david/OneDrive/Escritorio/Personal/a2/Curso - R/R/5.Importación"

``` r
write_csv(prueba3, "challenge4.csv")
```

Ahora, en la carpeta, aparece el archivo que acabamos de guardar.

Cuando se guarda un archivo, no quedan guardados los tipos de datos que
se asignaron desde R. Para esto, se puede exportar el archivo en formato
RDS

``` r
write_rds(prueba3, "challenge5.rds")
```

Este es un archivo que SOLO LO LEE R.
