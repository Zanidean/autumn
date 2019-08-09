Autumn
================

``` r
library(tidyverse)
```

    ## -- Attaching packages ------------------------------------------------------------- tidyverse 1.2.1 --

    ## v ggplot2 3.1.1       v purrr   0.3.2  
    ## v tibble  2.1.1       v dplyr   0.8.0.1
    ## v tidyr   0.8.3       v stringr 1.4.0  
    ## v readr   1.3.1       v forcats 0.4.0

    ## -- Conflicts ---------------------------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(autumn)

diamonds %>% 
  auto_mm(model = model_maker(lm, price ~ x + y + z), 
          split = c("cut", "color", "clarity")) %>% 
  extract_model_metric("p.value") %>% 
  extract_model_metric("r.squared")
```

    ## Loading required package: broom

    ## # A tibble: 20 x 7
    ##    data                  model      n variable value      p.value r.squared
    ##    <list>                <list> <dbl> <chr>    <chr>        <dbl>     <dbl>
    ##  1 <tibble [1,610 x 9]>  <lm>    1610 cut      Fair     0.            0.697
    ##  2 <tibble [4,906 x 9]>  <lm>    4906 cut      Good     0.            0.766
    ##  3 <tibble [12,082 x 9]> <lm>   12082 cut      Very Go~ 0.            0.781
    ##  4 <tibble [13,791 x 9]> <lm>   13791 cut      Premium  0.            0.783
    ##  5 <tibble [21,551 x 9]> <lm>   21551 cut      Ideal    0.            0.802
    ##  6 <tibble [6,775 x 9]>  <lm>    6775 color    D        0.            0.742
    ##  7 <tibble [9,797 x 9]>  <lm>    9797 color    E        0.            0.756
    ##  8 <tibble [9,542 x 9]>  <lm>    9542 color    F        0.            0.756
    ##  9 <tibble [11,292 x 9]> <lm>   11292 color    G        0.            0.799
    ## 10 <tibble [8,304 x 9]>  <lm>    8304 color    H        0.            0.799
    ## 11 <tibble [5,422 x 9]>  <lm>    5422 color    I        0.            0.828
    ## 12 <tibble [2,808 x 9]>  <lm>    2808 color    J        0.            0.834
    ## 13 <tibble [741 x 9]>    <lm>     741 clarity  I1       3.34e-316     0.862
    ## 14 <tibble [9,194 x 9]>  <lm>    9194 clarity  SI2      0.            0.805
    ## 15 <tibble [13,065 x 9]> <lm>   13065 clarity  SI1      0.            0.826
    ## 16 <tibble [12,258 x 9]> <lm>   12258 clarity  VS2      0.            0.830
    ## 17 <tibble [8,171 x 9]>  <lm>    8171 clarity  VS1      0.            0.837
    ## 18 <tibble [5,066 x 9]>  <lm>    5066 clarity  VVS2     0.            0.844
    ## 19 <tibble [3,655 x 9]>  <lm>    3655 clarity  VVS1     0.            0.798
    ## 20 <tibble [1,790 x 9]>  <lm>    1790 clarity  IF       0.            0.830
