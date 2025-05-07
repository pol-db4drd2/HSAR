## code to prepare `testmodels` dataset goes here

del <- model.matrix(~ factor(I) - 1, testspace) # check if this can be done: do we know what testspace is in this context?

form <- y ~ j + k + X

testmodels <- list(
  # foo  = HSAR:: sar(form, testspace, Matrix::Matrix(WL)),
  # bar  = HSAR::hsar(form, testspace, Matrix::Matrix(WL), NULL,               Matrix::Matrix(del)),
  # baz  =  HSAR::hsar(form, testspace, NULL,               Matrix::Matrix(WU), Matrix::Matrix(del)), # why is this an error
  # quux = HSAR::hsar(form, testspace, Matrix::Matrix(WL), Matrix::Matrix(WU), Matrix::Matrix(del))
)

usethis::use_data(testmodels, overwrite = TRUE)

# baz  =  hsar(form, testspace, NULL,               Matrix::Matrix(WU), Matrix::Matrix(del)) # why is this an error
