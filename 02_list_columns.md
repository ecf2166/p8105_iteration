List Columns
================

``` r
library(tidyverse)
library(rvest)
```

    ## 
    ## Attaching package: 'rvest'

    ## The following object is masked from 'package:readr':
    ## 
    ##     guess_encoding

``` r
library(p8105.datasets)

source("source/mean_and_sd.R")
source("source/nsduh_process.R")

set.seed(1236) # so that when you do random things you get the same results
```

## List …

Prove that lists can have anything

``` r
l = list(
  vec_numeric = 5:17,
  mat = matrix(1:8, nrow=2, ncol=4, byrow = TRUE),
  vec_logical = c(TRUE),
  summary_table = summary(rnorm(1000))
)

l
```

    ## $vec_numeric
    ##  [1]  5  6  7  8  9 10 11 12 13 14 15 16 17
    ## 
    ## $mat
    ##      [,1] [,2] [,3] [,4]
    ## [1,]    1    2    3    4
    ## [2,]    5    6    7    8
    ## 
    ## $vec_logical
    ## [1] TRUE
    ## 
    ## $summary_table
    ##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
    ## -2.866342 -0.637111 -0.002336  0.003323  0.658024  3.265081

``` r
l[[1]]
```

    ##  [1]  5  6  7  8  9 10 11 12 13 14 15 16 17

``` r
l[[2]]
```

    ##      [,1] [,2] [,3] [,4]
    ## [1,]    1    2    3    4
    ## [2,]    5    6    7    8

``` r
l[["vec_logical"]]
```

    ## [1] TRUE

``` r
l$summary_table
```

    ##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
    ## -2.866342 -0.637111 -0.002336  0.003323  0.658024  3.265081

# `for` loops

``` r
list_norm = list(
  a = rnorm(20, 3, 4),
  b = rnorm(20, -14, 20),
  c = rnorm(20, 1000, 10000),
  d = rnorm(20, 0, 1)
)
list_norm
```

    ## $a
    ##  [1]  0.9159114  3.9351002  0.4542432 -2.2204479  6.8932190  5.1244742
    ##  [7]  3.0167339  1.2722880  2.2738587  1.3975934  0.2412513  8.7954751
    ## [13]  5.4102001  5.6806398  1.4349576  7.7910554  1.3815394  3.9662007
    ## [19]  5.5049290 -4.4350801
    ## 
    ## $b
    ##  [1] -38.8273125 -17.3048465 -37.0491490 -10.9662495 -13.8820017 -42.4692825
    ##  [7]  24.9015607  10.7117280  -1.2350787 -11.9174419  16.2479180  23.7679930
    ## [13] -10.8558799  -2.3840318 -27.5021477 -11.0160255  -0.9578981 -54.7284315
    ## [19]  -0.6934327  21.7843104
    ## 
    ## $c
    ##  [1]  -7057.94004   4896.59485    747.66684 -12308.94390   4830.62953
    ##  [6]   6012.00905  -2539.74791   3074.49521   1084.28773  11207.32225
    ## [11]   4905.01088  -3652.74558  13887.36106   1463.48383    -46.55387
    ## [16]   8779.84511  -8885.48741   4443.70973  -3824.23101  -3926.24941
    ## 
    ## $d
    ##  [1]  1.95387846 -0.05245400 -0.46954531  0.07402405 -1.58979325 -1.30688268
    ##  [7] -1.10632794 -0.56723500 -0.41408053  0.92099945  1.44702754  1.99236409
    ## [13] -0.55596915 -0.28278326  0.08300015  1.09988202 -1.89214254  0.10662779
    ## [19]  0.16717212 -0.72687919

can I get mean and sd for each sample?

``` r
mean_and_sd(list_norm[[1]])
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  2.94  3.32

``` r
mean_and_sd(list_norm[[2]])
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1 -9.22  22.7

``` r
mean_and_sd(list_norm[[3]])
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1 1155. 6647.

``` r
mean_and_sd(list_norm[[4]])
```

    ## # A tibble: 1 × 2
    ##      mean    sd
    ##     <dbl> <dbl>
    ## 1 -0.0560  1.09

can I do this better?

``` r
output = vector("list", length = 4)

for (i in 1:4) {
  
  output[[i]] = mean_and_sd(list_norm[[i]])
}

output
```

    ## [[1]]
    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  2.94  3.32
    ## 
    ## [[2]]
    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1 -9.22  22.7
    ## 
    ## [[3]]
    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1 1155. 6647.
    ## 
    ## [[4]]
    ## # A tibble: 1 × 2
    ##      mean    sd
    ##     <dbl> <dbl>
    ## 1 -0.0560  1.09

## `map` instead

This is better!

``` r
output = map(list_norm, mean_and_sd)
output = map(list_norm, IQR)
output = map(list_norm, median)
```

what about map variants

``` r
output = map_df(list_norm, mean_and_sd) # df
output = map_dbl(list_norm, mean) # vector
```
