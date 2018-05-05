
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tidyversity <img src="man/figures/logo.png" width="160px" align="right" />

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

🎓 Tidy tools for
academics

## \*\*\* This package is in very early development. Feedback is encouraged\!\!\! \*\*\*

## Installation

<!-- You can install the released version of tidyversity from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("tidyversity")
```
-->

Install the development version from
[Github](https://github.com/mkearney/tidyversity) with:

``` r
## install devtools if not already
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}
## install tidyversity from Github
devtools::install_github("mkearney/tidyversity")
```

## Regression models

### Ordinary Least Squares (OLS)

Conduct an Ordinary Least Squares (OLS) regression analysis.

``` r
polcom %>%
  tidy_regression(follow_trump ~ news_1 + ambiv_sexism_1) %>%
  tidy_summary()
#> # A tidy model
#> Model formula : follow_trump ~ news_1 + ambiv_sexism_1
#> Model type    : Ordinary Least Squares (OLS) regression
#> Model data    : 243 (observations) X 3 (variables)
#> $fit
#> # A tibble: 6 x 6
#>   fit_stat     n    df estimate p.value stars
#>   <chr>    <int> <int>    <dbl>   <dbl> <chr>
#> 1 F          243     2   3.83    0.0230 *    
#> 2 R^2        243    NA   0.0309 NA      ""   
#> 3 Adj R^2    243    NA   0.0229 NA      ""   
#> 4 RMSE       243    NA   0.409  NA      ""   
#> 5 AIC        243    NA 260.     NA      ""   
#> 6 BIC        243    NA 274.     NA      ""   
#> 
#> $coef
#> # A tibble: 3 x 7
#>   term               est   s.e. est.se p.value stars std.est
#>   <chr>            <dbl>  <dbl>  <dbl>   <dbl> <chr>   <dbl>
#> 1 (Intercept)     0.745  0.0969   7.69  0.     ***    0.    
#> 2 news_1          0.0220 0.0122   1.81  0.0714 +      0.0479
#> 3 ambiv_sexism_1 -0.0385 0.0206  -1.87  0.0627 +     -0.0495
```

### Logistic (dichotomous)

Conduct a logistic regression analysis for binary (dichotomous)
outcomes.

``` r
polcom %>%
  tidy_regression(follow_trump ~ news_1 + ambiv_sexism_1, type = "logistic") %>%
  tidy_summary()
#> # A tidy model
#> Model formula : follow_trump ~ news_1 + ambiv_sexism_1
#> Model type    : logistic
#> Model data    : 243 (observations) X 3 (variables)
#> $fit
#> # A tibble: 7 x 6
#>   fit_stat           n    df estimate p.value stars
#>   <chr>          <int> <int>    <dbl>   <dbl> <chr>
#> 1 χ2               243   240 247.      0.357  ""   
#> 2 Δχ2              243     2   7.47    0.0239 *    
#> 3 Nagelkerke R^2   243    NA   0.0303 NA      ""   
#> 4 McFadden R^2     243    NA   0.0293 NA      ""   
#> 5 RMSE             243    NA   2.54   NA      ""   
#> 6 AIC              243    NA 253.     NA      ""   
#> 7 BIC              243    NA 264.     NA      ""   
#> 
#> $coef
#> # A tibble: 3 x 7
#>   term              est   s.e. est.se p.value stars std.est
#>   <chr>           <dbl>  <dbl>  <dbl>   <dbl> <chr>   <dbl>
#> 1 (Intercept)     1.13  0.553    2.05  0.0405 *       0.   
#> 2 news_1          0.127 0.0702   1.81  0.0707 +       0.195
#> 3 ambiv_sexism_1 -0.229 0.122   -1.87  0.0613 +      -0.201
```

### Poisson (count)

Conduct a poisson regression analysis for count data.

``` r
polcom %>%
  dplyr::mutate(polarize = abs(therm_1 - therm_2)) %>%
  tidy_regression(polarize ~ news_1 + ambiv_sexism_1, type = "poisson") %>%
  tidy_summary()
#> # A tidy model
#> Model formula : polarize ~ news_1 + ambiv_sexism_1
#> Model type    : Poisson regression
#> Model data    : 242 (observations) X 3 (variables)
#> $fit
#> # A tibble: 7 x 6
#>   fit_stat           n    df  estimate   p.value stars
#>   <chr>          <int> <int>     <dbl>     <dbl> <chr>
#> 1 χ2               242   239 6549.      0.       ***  
#> 2 Δχ2              242     2  399.      2.20e-87 ***  
#> 3 Nagelkerke R^2   242    NA    0.808  NA        ""   
#> 4 McFadden R^2     242    NA    0.0574 NA        ""   
#> 5 RMSE             242    NA    0.760  NA        ""   
#> 6 AIC              242    NA 7725.     NA        ""   
#> 7 BIC              242    NA 7736.     NA        ""   
#> 
#> $coef
#> # A tibble: 3 x 7
#>   term               est    s.e. est.se p.value stars std.est
#>   <chr>            <dbl>   <dbl>  <dbl>   <dbl> <chr>   <dbl>
#> 1 (Intercept)     3.80   0.0382   99.4       0. ***     0.   
#> 2 news_1          0.0447 0.00478   9.36      0. ***     0.881
#> 3 ambiv_sexism_1 -0.126  0.00797 -15.9       0. ***    -2.23
```

### Negative binomial (overdispersed)

Conduct a negative binomial regression analysis for overdispersed count
data.

``` r
polcom %>%
  dplyr::mutate(polarize = abs(therm_1 - therm_2)) %>%
  tidy_regression(polarize ~ news_1 + ambiv_sexism_1, type = "negbinom") %>%
  tidy_summary()
#> # A tidy model
#> Model formula : polarize ~ news_1 + ambiv_sexism_1
#> Model type    : Negative binomial regression
#> Model data    : 242 (observations) X 3 (variables)
#> Warning: glm.fit: algorithm did not converge
#> $fit
#> # A tibble: 7 x 6
#>   fit_stat           n    df  estimate  p.value stars
#>   <chr>          <int> <int>     <dbl>    <dbl> <chr>
#> 1 χ2               242   239  293.      0.00943 **   
#> 2 Δχ2              242     2    8.44    0.0147  *    
#> 3 Nagelkerke R^2   242    NA    0.0343 NA       ""   
#> 4 McFadden R^2     242    NA    0.0280 NA       ""   
#> 5 RMSE             242    NA    0.761  NA       ""   
#> 6 AIC              242    NA 2312.     NA       ""   
#> 7 BIC              242    NA 2326.     NA       ""   
#> 
#> $coef
#> # A tibble: 3 x 7
#>   term               est   s.e. est.se p.value stars std.est
#>   <chr>            <dbl>  <dbl>  <dbl>   <dbl> <chr>   <dbl>
#> 1 (Intercept)     3.74   0.258   14.5   0.     ***        NA
#> 2 news_1          0.0526 0.0322   1.63  0.103  ""         NA
#> 3 ambiv_sexism_1 -0.123  0.0541  -2.27  0.0230 *          NA
```

### Robust and quasi- models

``` r
polcom %>%
  dplyr::mutate(polarize = abs(therm_1 - therm_2)) %>%
  tidy_regression(polarize ~ news_1 + ambiv_sexism_1, type = "quasipoisson", robust = TRUE) %>%
  tidy_summary()
#> # A tidy model
#> Model formula : polarize ~ news_1 + ambiv_sexism_1
#> Model type    : [Robust] Poisson regression
#> Model data    : 242 (observations) X 3 (variables)
#> $fit
#> # A tibble: 7 x 6
#>   fit_stat           n    df  estimate   p.value stars
#>   <chr>          <int> <int>     <dbl>     <dbl> <chr>
#> 1 χ2               242   239 6549.      0.       ***  
#> 2 Δχ2              242     2  399.      2.20e-87 ***  
#> 3 Nagelkerke R^2   242    NA    0.808  NA        ""   
#> 4 McFadden R^2     242    NA    0.0574 NA        ""   
#> 5 RMSE             242    NA    0.760  NA        ""   
#> 6 AIC              242    NA 7725.     NA        ""   
#> 7 BIC              242    NA 7736.     NA        ""   
#> 
#> $coef
#> # A tibble: 3 x 7
#>   term               est    s.e. est.se p.value stars std.est
#>   <chr>            <dbl>   <dbl>  <dbl>   <dbl> <chr>   <dbl>
#> 1 (Intercept)     3.80   0.0382   99.4       0. ***     0.   
#> 2 news_1          0.0447 0.00478   9.36      0. ***     0.881
#> 3 ambiv_sexism_1 -0.126  0.00797 -15.9       0. ***    -2.23
```

## Mean comparison models

### ANOVA

Conduct an analysis of variance (ANOVA).

``` r
polcom %>%
  dplyr::mutate(sex = ifelse(sex == 1, "Male", "Female"),
  vote_choice = dplyr::case_when(
    vote_2016_choice == 1 ~ "Clinton",
    vote_2016_choice == 2 ~ "Trump",
    TRUE ~ "Other")) %>%
  tidy_anova(pp_party ~ sex * vote_choice) %>%
  tidy_summary()
#> NULL
#> $fit
#> # A tibble: 6 x 6
#>   fit_stat     n    df estimate   p.value stars
#>   <chr>    <int> <int>    <dbl>     <dbl> <chr>
#> 1 F          243     5   53.3    6.19e-37 ***  
#> 2 R^2        243    NA    0.529 NA        ""   
#> 3 Adj R^2    243    NA    0.519 NA        ""   
#> 4 RMSE       243    NA    1.24  NA        ""   
#> 5 AIC        243    NA  801.    NA        ""   
#> 6 BIC        243    NA  826.    NA        ""   
#> 
#> $coef
#> # A tibble: 4 x 8
#>   term              est    s.e.  est.se statistic   p.value stars std.est
#>   <chr>           <dbl>   <dbl>   <dbl>     <dbl>     <dbl> <chr>   <dbl>
#> 1 sex                1.  19.2    19.2      12.6    0.000474 ***        2.
#> 2 vote_choice        2. 389.    194.      127.     0.       ***        2.
#> 3 sex:vote_choice    2.   0.519   0.259     0.169  0.844    ""         2.
#> 4 Residuals        237. 363.      1.53     NA     NA        ""       237.
```

### t-tests

``` r
polcom %>%
  tidy_ttest(pp_ideology ~ follow_trump) %>%
  tidy_summary()
#> # A tidy model
#> Model formula : pp_ideology ~ follow_trump
#> Model data    : 244 (observations)
#> $fit
#> # A tibble: 2 x 6
#>   group    df  mean   diff  lo.95 hi.05
#>   <chr> <dbl> <dbl>  <dbl>  <dbl> <dbl>
#> 1 FALSE  76.9  4.19  0.922  0.308  1.54
#> 2 TRUE   76.9  3.26 -0.922 -0.308 -1.54
#> 
#> $coef
#>        est       t  p.value stars
#> 1 0.922027 2.99241 0.003719    **
```

## Latent variable models

### Structural equation modeling (SEM)

``` r
table(polcom$ambiv_sexism_1)
#> 
#>  1  2  3  4  5 
#> 73 62 47 43 18
polcom %>%
  dplyr::mutate(therm_2 = 10 - therm_2 / 10,
    therm_1 = therm_1 / 10) %>%
  tidy_sem(news =~ news_1 + news_2 + news_3 + news_4 + news_5 + news_6,
    ambiv_sexism =~ ambiv_sexism_1 + ambiv_sexism_2 + ambiv_sexism_3 + ambiv_sexism_4 + ambiv_sexism_5 + ambiv_sexism_6,
    partisan =~ a*therm_1 + a*therm_2,
    ambiv_sexism ~ age + hhinc + edu + news + partisan) %>%
  tidy_summary()
#> NULL
#> $fit
#> # A tibble: 8 x 6
#>   fit_stat             n    df   estimate      p.value stars
#>   <chr>            <int> <int>      <dbl>        <dbl> <chr>
#> 1 chisq              236   114   205.      0.000000382 ***  
#> 2 cfi                236    NA     0.925  NA           ""   
#> 3 tli                236    NA     0.912  NA           ""   
#> 4 aic                236    NA 15901.     NA           ""   
#> 5 bic                236    NA 16064.     NA           ""   
#> 6 rmsea              236    NA     0.0581 NA           ""   
#> 7 srmr               236    NA     0.0682 NA           ""   
#> 8 ambiv_sexism:R^2   236    NA     0.403  NA           ""   
#> 
#> $coef
#> # A tibble: 63 x 8
#>    term                  est     se est.se p.value ci.lower ci.upper stars
#>    <chr>               <dbl>  <dbl>  <dbl>   <dbl>    <dbl>    <dbl> <chr>
#>  1 news =~ news_1      1.00  0.      NA    NA        1.00      1.00  ""   
#>  2 news =~ news_2      1.63  0.723    2.25  0.0246   0.208     3.04  *    
#>  3 news =~ news_3      5.16  2.11     2.45  0.0143   1.03      9.29  *    
#>  4 news =~ news_4      5.71  2.34     2.44  0.0147   1.12     10.3   *    
#>  5 news =~ news_5      3.58  1.43     2.49  0.0126   0.765     6.39  *    
#>  6 news =~ news_6      1.21  0.648    1.88  0.0607  -0.0546    2.48  +    
#>  7 ambiv_sexism =~ am… 1.00  0.      NA    NA        1.00      1.00  ""   
#>  8 ambiv_sexism =~ am… 0.945 0.0573  16.5   0.       0.833     1.06  ***  
#>  9 ambiv_sexism =~ am… 0.801 0.0570  14.1   0.       0.689     0.913 ***  
#> 10 ambiv_sexism =~ am… 0.743 0.0613  12.1   0.       0.623     0.863 ***  
#> # ... with 53 more rows
```

# Data sets

Comes with one data set.

### `polcom`

Consists of survey responses to demographic, background, and likert-type
attitudinal items about political communication.

``` r
print(tibble::as_tibble(polcom), n = 5)
#> # A tibble: 244 x 63
#>   follow_trump news_1 news_2 news_3 news_4 news_5 news_6 ambiv_sexism_1
#> * <lgl>         <int>  <int>  <int>  <int>  <int>  <int>          <int>
#> 1 TRUE              8      1      1      1      1      6              3
#> 2 TRUE              1      1      1      1      1      1              5
#> 3 TRUE              8      1      1      1      8      1              5
#> 4 TRUE              8      1      1      1      1      6              2
#> 5 TRUE              6      1      2      1      1      3              4
#> # ... with 239 more rows, and 55 more variables: ambiv_sexism_2 <int>,
#> #   ambiv_sexism_3 <int>, ambiv_sexism_4 <int>, ambiv_sexism_5 <int>,
#> #   ambiv_sexism_6 <int>, img1_hrc_1 <int>, img1_hrc_2 <dbl>,
#> #   img1_hrc_3 <int>, img1_hrc_4 <dbl>, img1_hrc_5 <int>,
#> #   img1_hrc_6 <int>, img1_hrc_7 <int>, img1_hrc_8 <int>,
#> #   img1_hrc_9 <int>, img2_hrc_10 <int>, img2_hrc_11 <int>,
#> #   img2_hrc_12 <dbl>, img2_hrc_13 <int>, img2_hrc_14 <int>,
#> #   img2_hrc_15 <dbl>, img1_djt_1 <int>, img1_djt_2 <dbl>,
#> #   img1_djt_3 <int>, img1_djt_4 <dbl>, img1_djt_5 <int>,
#> #   img1_djt_6 <int>, img1_djt_7 <int>, img1_djt_8 <int>,
#> #   img1_djt_9 <int>, img2_djt_10 <int>, img2_djt_11 <int>,
#> #   img2_djt_12 <dbl>, img2_djt_13 <int>, img2_djt_14 <int>,
#> #   img2_djt_15 <dbl>, pie_1 <int>, pie_2 <int>, pie_3 <int>, pie_4 <int>,
#> #   vote_2016 <int>, vote_2016_choice <int>, pp_ideology <int>,
#> #   pp_party <int>, pp_party_lean <int>, therm_1 <int>, therm_2 <int>,
#> #   therm_3 <int>, therm_4 <int>, therm_5 <int>, age <int>, sex <int>,
#> #   gender <int>, race <int>, edu <int>, hhinc <int>
```

## Descriptive statistics

Return summary statistics in the form of a data frame ***(not yet
added)***.

``` r
## summary stats for social media use (numeric) variables
summarize_numeric(polcom_survey, smuse1:smuse3)

## summary stats for respondent sex and race (categorical) variables
summarize_categorical(polcom_survey, sex, race)
```

Estimate Cronbach’s alpha for a set of variables.

``` r
## reliability of social media use items
cronbachs_alpha(polcom, ambiv_sexism_1:ambiv_sexism_6)
#>                           items    alpha alpha.std
#> 1 ambiv_sexism_1:ambiv_sexism_6 0.904609  0.904600
#> 2               -ambiv_sexism_1 0.882322  0.882225
#> 3               -ambiv_sexism_2 0.884272  0.884121
#> 4               -ambiv_sexism_3 0.896061  0.896218
#> 5               -ambiv_sexism_4 0.897127  0.897411
#> 6               -ambiv_sexism_5 0.883554  0.883420
#> 7               -ambiv_sexism_6 0.881595  0.881855
```
