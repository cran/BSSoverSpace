## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(BSSoverSpace)
set.seed(16)

## ----sim coords---------------------------------------------------------------
sample_size <- 500
coords <- runif(sample_size * 2) * 50
dim(coords) <- c(sample_size, 2)

## ----sim zs-------------------------------------------------------------------
library('BSSoverSpace')
dim <- 5 # specify the dimensionality of random variable
nu <- runif(dim, 0, 6) # parameter for matern covariance function
kappa <- runif(dim, 0, 2) # parameter for matern covariance function
zs <- gen_matern_gaussian_rf(coords=coords, dim=dim, nu=nu, kappa=kappa)

## ----sim xs-------------------------------------------------------------------
mix_mat <- diag(dim) # create a diagonal matrix as the mixing matrix
xs <- t(mix_mat %*% t(zs))

## ----BSSS---------------------------------------------------------------------
example<-BSSS(xs, coord = coords, kernel_type = 'ring', kernel_parameter = c(0, 0.5, 0.5, 1, 1, 8))

## ----d_score------------------------------------------------------------------
d_score(example$mix_mat_est, mix_mat)

## -----------------------------------------------------------------------------
plot(example$w_eigenvalue)

