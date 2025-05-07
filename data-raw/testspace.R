## code to prepare `testspace` dataset goes here
# This is a toy data set to use for unit tests in HSAR
# Now, thinking through how to write and use unit tests in HSAR is another matter

set.seed(1234567890)

L  <-  0.25
R  <- -0.3

WL <- spdep::nb2mat(spdep::cell2nb(25, 25, "queen"))
WU <- spdep::nb2mat(spdep::cell2nb( 5,  5, "queen"))

us <- dplyr::tibble(I = 0:24)
us <- dplyr::mutate(
  us,
  Mu = rnorm(dplyr::n(), 0, 1),
   u = Matrix::solve(Matrix::Diagonal(25) - L * WU, .data$Mu)
)

testspace <- dplyr::tibble(
  i  = 1:625 - 1,
  j  = .data$i  %% 25,
  k  = .data$i %/% 25, # I guess this is in row-major order
  bj = 6 * ((.data$j / 24)^3 - (.data$j / 24)^2),
  bk = (.data$k / 24)^3 + (.data$k / 24)^2 + (.data$k / 24),
  J  = .data$j %/% 5,
  K  = .data$k %/% 5,
  I  = .data$J + 5 * .data$K
)

testspace <- dplyr::left_join(testspace, us)

testspace <- dplyr::mutate(
  testspace,
   X = stats::rnorm(dplyr::n(), 0, 1),
  My = rnorm(dplyr::n(), .data$bj + .data$bk - .data$X + .data$u, sqrt(2)),
   y = Matrix::solve(Matrix::Diagonal(625) - R * WL, .data$My)
)

# del <- model.matrix(~ factor(I) - 1, testspace)

usethis::use_data(testspace, overwrite = TRUE)
usethis::use_data(WL,        overwrite = TRUE)
usethis::use_data(WU,        overwrite = TRUE)
