
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gestage

<!-- badges: start -->

[![R-CMD-check](https://github.com/ki-tools/gestage/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ki-tools/gestage/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/ki-tools/gestage/branch/main/graph/badge.svg)](https://app.codecov.io/gh/ki-tools/gestage?branch=main)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
<!-- badges: end -->

The `gestage` R package implements methods described in [this
paper](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8438948/) to
estimate gestational age. Currently only models C and D are implemented.
These are the simplest models, requiring the fewest number of inputs,
yet they perform as well or nearly as well as the more complex models
based on harder-to-capture inputs. You can choose between these models
based on what measurements you have available. Model C is preferable to
Model D in terms of performance.

## Installation

You can install `gestage` from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("ki-tools/gestage")
```

## Example

Model C takes as input gestational age at birth based on last menstrual
period (LMP), `gagelmp`, and birth weight, `birthwt`. We can provide
values or vectors values of these variables to a function `gestage_c()`.

``` r
library(gestage)

# predict GA for one set of predictors:
gestage_c(gagelmp = 250, birthwt = 2800)
#> [1] 269

# predict GA for different values of gagelmp and specific birthwt
gestage_c(gagelmp = seq(200, 300, by = 10), birthwt = 2800)
#>  [1] 266 267 268 269 270 269 269 272 277 279 279

# predict GA for different values of birthwt and specific gagelmp
gestage_c(gagelmp = 250, birthwt = seq(2000, 3500, by = 100))
#>  [1] 253 255 257 259 261 264 266 268 269 271 272 273 274 275 275 276

# predict GA for different combinations of gagelmp and birthwt
gestage_c(gagelmp = c(170, 340), birthwt = c(2000, 4000))
#> [1] 249 281
```

Model D takes as input head circumference at birth in centimeters,
`birthhc`, and birth weight, `birthwt`.

``` r
library(gestage)

# predict GA for one set of predictors:
gestage_d(birthhc = 30, birthwt = 2800)
#> [1] 270

# predict GA for different values of birthhc and specific birthwt
gestage_d(birthhc = seq(30, 35, by = 0.2), birthwt = 2800)
#>  [1] 270 271 271 271 271 271 272 272 272 272 272 273 273 273 273 274 274 275 275
#> [20] 275 276 276 276 277 277 277

# predict GA for different values of birthwt and specific birthhc
gestage_d(birthhc = 30, birthwt = seq(2000, 3500, by = 100))
#>  [1] 252 255 258 261 264 267 268 269 270 271 272 273 273 273 273 273

# predict GA for different combinations of birthhc and birthwt
gestage_d(birthhc = c(30, 35), birthwt = c(2000, 4000))
#> [1] 252 282
```
