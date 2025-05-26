#' Estimate impact per MCMC draw of coefficients
#' @param object an `mcmc_hsar` or `mcmc_hsar_lambda_0` or `mcmc_sar` object
#' @return a list of three matrices named `direct`, `indirect`, and `total` giving impact estimates for each MCMC draw
#' @export
mcmc_impacts <- function(object) {
  betas <- object$cbetas
  betas <- betas[, setdiff(colnames(betas), "(Intercept)")]

  if(object$Durbin) {
    thetas <- betas[,  grepl("^lag_", colnames(betas))]
    betas  <- betas[, !grepl("^lag_", colnames(betas))]

    result <- impact_durbin_cpp_arma(betas, thetas, object$crho, object$W)
  } else {
    result <- impact_cpp_arma(betas, object$crho, object$W)
  }

  lapply(result, `colnames<-`, value = colnames(betas))
}
