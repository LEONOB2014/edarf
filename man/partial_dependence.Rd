% Generated by roxygen2 (4.0.2): do not edit by hand
\name{partial_dependence}
\alias{partial_dependence}
\title{Partial dependence using random forests}
\usage{
partial_dependence(fit, df, var, cutoff = 10, empirical = TRUE,
  parallel = FALSE)
}
\arguments{
\item{fit}{an object of class 'RandomForest-class' returned from \code{cforest}, an object
of class 'randomForest' returned from \code{randomForest}, or an object of class 'rfsrc'
returned from \code{rfsrc}}

\item{df}{the dataframe used to fit the model, if the model is a party object of class 'RandomForest'
this option can be omitted and the dataframe will be extracted from the object}

\item{var}{a character vector of the predictors of interest, which must match the input
matrix in the call to \code{cforest}, \code{randomForest}, or \code{randomForestSRC}}

\item{cutoff}{the maximal number of unique points in each element of 'var' used in the
partial dependence calculation}

\item{empirical}{logical indicator of whether or not only values in the data should be sampled}

\item{parallel}{logical indicator of whether a parallel backend should be used if registered}
}
\value{
a dataframe with columns for each predictor in `var` and the fitted value for
each set of values taken by the values of 'var' averaged within the values of predictors
in the model but not in `var`
}
\description{
Calculates the partial dependence of the response on an arbitrary dimensional set of predictors
from a fitted random forest object from the Party, randomForest, or randomForestSRC packages
}
\examples{
\dontrun{
library(randomForest)
library(party)
library(randomForestSRC)
## library(doParallel)
## library(parallel)
## registerDoParallel(makeCluster(detectCores()))

## Classification

data(iris)

fit_rf <- randomForest(Species ~ ., iris)
fit_pt <- cforest(Species ~ ., iris, controls = cforest_control(mtry = 2))
fit_rfsrc <- rfsrc(Species ~ ., iris)

pd_rf <- partial_dependence(fit_rf, iris, "Petal.Width")
pd_pt <- partial_dependence(fit_pt, iris, "Petal.Width")
pd_rfsrc <- partial_dependence(fit_rfsrc, iris, "Petal.Width")

pd_int_rf <- partial_dependence(fit_rf, iris, c("Petal.Width", "Sepal.Length"))
pd_int_pt <- partial_dependence(fit_pt, iris, c("Petal.Width", "Sepal.Length"))
pd_int_rfsrc <- partial_dependence(fit_rfsrc, iris, c("Petal.Width", "Sepal.Length"))

## Regression

data(swiss)

fit_rf <- randomForest(Fertility ~ ., swiss)
fit_pt <- cforest(Fertility ~ ., swiss, controls = cforest_control(mtry = 2))
fit_rfsrc <- rfsrc(Fertility ~ ., swiss)

pd_rf <- partial_dependence(fit_rf, swiss, "Education")
pd_pt <- partial_dependence(fit_pt, swiss, "Education")
pd_rfsrc <- partial_dependence(fit_rfsrc, swiss, "Education")

pd_int_rf <- partial_dependence(fit_rf, swiss, c("Education", "Catholic"))
pd_int_pt <- partial_dependence(fit_pt, swiss, c("Education", "Catholic"))
pd_int_rfsrc <- partial_dependence(fit_rfsrc, swiss, c("Education", "Catholic"))


## Survival

data(veteran, package = "randomForestSRC")

fit_rfsrc <- rfsrc(Surv(time, status) ~ ., veteran)

pd_rfsrc <- partial_dependence(fit_rfsrc, veteran, "age")

pd_int_rfsrc <- partial_dependence(fit_rfsrc, veteran, c("age", "diagtime"))
}
}

