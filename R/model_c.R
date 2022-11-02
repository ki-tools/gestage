#' Predict gestational age using Model C
#' @param gagelmp gestational age at birth in days based on last menstrual
#' period (must be between 161 and 350)
#' @param birthwt birth weight in grams (must be between 1000 and 5000)
#' @references Simplified models to assess newborn gestational age in low-middle
#' income countries: findings from a multicountry, prospective cohort study.
#' *BMJ Global Health*, 2021.
#' [(url)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8438948/)
#' @export
#' @examples
#' method_c_predict(gagelmp = 250, birthwt = 2800)
#' method_c_predict(gagelmp = 201:225, birthwt = 2800)
#' method_c_predict(gagelmp = 250, birthwt = seq(3005, 3100, by = 5))
#' @importFrom splines bs
#' @importFrom checkmate qassert
method_c_predict <- function(gagelmp, birthwt) {
  checkmate::qassert(gagelmp, "X[161,350]")
  gagelmp <- round(gagelmp)
  checkmate::qassert(birthwt, "X[1000,5000]")
  if (length(gagelmp) == 1)
    gagelmp <- rep(gagelmp, length(birthwt))
  if (length(birthwt) == 1)
    birthwt <- rep(birthwt, length(gagelmp))
  if (length(gagelmp) != length(birthwt))
    stop("Length of gagelmp and birthwt must be the same.", call. = FALSE)
  knots <- attr(coefs_mod_c, "knots")
  # coefficients matrix starts at gagelmp 161
  cf <- coefs_mod_c[gagelmp - 160, , drop = FALSE]
  bb <- splines::bs(birthwt, knots = knots, Boundary.knots = c(1000, 5000),
    degree = 3, intercept = TRUE)
  bb[, 1] <- 1
  # diag(cf %*% t(bb))
  colSums(t(cf) * t(bb))
}
