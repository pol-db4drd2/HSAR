#' Estimate impact per MCMC draw of coefficients
#' @param object an `mcmc_hsar` or `mcmc_hsar_lambda_0` or `mcmc_sar` object
#' @return a list of three matrices named `direct`, `indirect`, and `total` giving impact estimates for each MCMC draw
#' @export
mcmc_impacts <- function(object) {
  betas <- object$cbetas
  betas <- as.matrix(betas)
  betas <- betas[, setdiff(colnames(betas), "(Intercept)")]

  if(object$Durbin) {
    thetas <- betas[,  grepl("^lag_", colnames(betas)), drop = FALSE]
    betas  <- betas[, !grepl("^lag_", colnames(betas)), drop = FALSE]

    result <- impact_Durbin_cpp_arma(betas, thetas, object$crho, object$W)
  } else {
    result <- impact_cpp_arma(betas, object$crho, object$W)
  }

  lapply(result, `colnames<-`, value = colnames(betas))
}
