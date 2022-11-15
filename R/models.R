#' Predict gestational age using Model C
#' @param gagelmp Gestational age at birth in days based on last menstrual
#' period (must be between 161 and 350).
#' @param birthwt Birth weight in grams (must be between 1000 and 5000).
#' @param round_pred Should the predicted gestational age be rounded to the
#'   nearest day? Default is `TRUE`.
#' @references Simplified models to assess newborn gestational age in low-middle
#' income countries: findings from a multicountry, prospective cohort study.
#' *BMJ Global Health*, 2021.
#' [(url)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8438948/)
#' @export
#' @examples
#' gestage_c(gagelmp = 250, birthwt = 2800)
#' gestage_c(gagelmp = 201:225, birthwt = 2800)
#' gestage_c(gagelmp = 250, birthwt = seq(3005, 3100, by = 5))
#' @importFrom splines bs
#' @importFrom checkmate qassert
gestage_c <- function(gagelmp, birthwt, round_pred = TRUE) {
  checkmate::qassert(gagelmp, "X[161,350]")
  gagelmp <- round(gagelmp)
  checkmate::qassert(birthwt, "X[1000,5000]")
  if (length(gagelmp) == 1)
    gagelmp <- rep(gagelmp, length(birthwt))
  if (length(birthwt) == 1)
    birthwt <- rep(birthwt, length(gagelmp))
  if (length(gagelmp) != length(birthwt))
    stop("Length of gagelmp and birthwt must be the same.", call. = FALSE)
  knots <- attr(gestage::coefs_mod_c, "knots")
  # coefficients matrix starts at gagelmp 161
  cf <- gestage::coefs_mod_c[gagelmp - 160, , drop = FALSE]
  bb <- splines::bs(birthwt, knots = knots, Boundary.knots = c(1000, 5000),
    degree = 3, intercept = TRUE)
  bb[, 1] <- 1
  # diag(cf %*% t(bb))
  res <- colSums(t(cf) * t(bb))
  if (round_pred)
    res <- round(res)
  res
}

#' Predict gestational age using Model C
#' @param birthhc birth head circumference in centimeters (must be between
#' 25 and 40).
#' @param birthwt birth weight in grams (must be between 1000 and 5000).
#' @param round_pred Should the predicted gestational age be rounded to the
#'   nearest day? Default is `TRUE`.
#' @references Simplified models to assess newborn gestational age in low-middle
#' income countries: findings from a multicountry, prospective cohort study.
#' *BMJ Global Health*, 2021.
#' [(url)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8438948/)
#' @export
#' @examples
#' gestage_d(birthhc = 35, birthwt = 2800)
#' gestage_d(birthhc = seq(25, 30, by = 0.1), birthwt = 2800)
#' gestage_d(birthhc = 35, birthwt = seq(3005, 3100, by = 5))
#' @importFrom splines bs
#' @importFrom checkmate qassert
gestage_d <- function(birthhc, birthwt, round_pred = TRUE) {
  checkmate::qassert(birthhc, "R[25,40]")
  oldbirthhc <- birthhc
  birthhc <- round(birthhc, 1)
  if (any(oldbirthhc != birthhc))
    message("Rounded birthhc to the nearest hundredth of a centimeter")
  checkmate::qassert(birthwt, "X[1000,5000]")
  if (length(birthhc) == 1)
    birthhc <- rep(birthhc, length(birthwt))
  if (length(birthwt) == 1)
    birthwt <- rep(birthwt, length(birthhc))
  if (length(birthhc) != length(birthwt))
    stop("Length of birthhc and birthwt must be the same.", call. = FALSE)
  knots <- attr(gestage::coefs_mod_d, "knots")
  # birthhc=25.0 is row 1, birthhc=25.1 is row 2, etc.
  cf <- gestage::coefs_mod_d[(birthhc - 25) * 10 + 1, , drop = FALSE]
  bb <- splines::bs(birthwt, knots = knots, Boundary.knots = c(1000, 5000),
    degree = 3, intercept = TRUE)
  bb[, 1] <- 1
  # diag(cf %*% t(bb))
  res <- colSums(t(cf) * t(bb))
  if (round_pred)
    res <- round(res)
  res
}
