
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gestage

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/ki-tools/gestage/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ki-tools/gestage/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The `gestage` R package implements methods described in [this
paper](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8438948/) to
estimate gestational age.

## Installation

You can install the development version of `gestage` from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("ki-tools/gestage")
```

## Example

Currently only one of the models in the paper has been implemented,
“Model C”, which takes as input gestational age at birth based on last
menstrual period (LMP), `gagelmp`, and birth weight, `birthwt`.

``` r
library(gestage)

# predict GA for one set of predictors:
method_c_predict(gagelmp = 250, birthwt = 2800)
#> [1] 269.2557

# predict GA for different values of gagelmp
method_c_predict(gagelmp = 201:225, birthwt = 2800)
#>  [1] 265.7839 265.9027 266.0173 266.1273 266.2328 266.3337 266.4304 266.5232
#>  [9] 266.6126 266.6995 266.7845 266.8686 266.9526 267.0374 267.1239 267.2130
#> [17] 267.3054 267.4016 267.5024 267.6078 267.7181 267.8332 267.9529 268.0766
#> [25] 268.2037

# predict GA for different values of birthwt
method_c_predict(gagelmp = 250, birthwt = seq(3005, 3100, by = 5))
#>  [1] 272.3983 272.4645 272.5290 272.5919 272.6531 272.7129 272.7711 272.8280
#>  [9] 272.8835 272.9377 272.9906 273.0424 273.0930 273.1425 273.1910 273.2384
#> [17] 273.2849 273.3305 273.3753 273.4192
```
