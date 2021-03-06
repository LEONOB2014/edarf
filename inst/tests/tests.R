library(testthat)
library(edarf)

test_that("ivar_points works correctly", {
    df <- data.frame("x" = 1:20, "y" = rep(1, 20))
    expect_that(length(ivar_points(df, "x", 10)), equals(10))
    expect_that(length(unique(ivar_points(df, "x", 10))), equals(length(ivar_points(df, "x", 10))))
    expect_that(ivar_points(df, "x", nrow(df)), equals(df[, "x"]))
})

test_that("partial_dependence works with randomForest regression", {
    library(randomForest)
    data(swiss)
    fit <- randomForest(Fertility ~ ., swiss)
    pd <- partial_dependence(fit, swiss, "Education", length(unique(swiss$Education)))
    expect_that(pd, is_a("data.frame"))
    expect_that(colnames(pd), equals(c("Education", "pred")))
    expect_that(pd$pred, is_a("numeric"))
    expect_that(length(unique(pd$Education)), equals(nrow(pd)))
})

test_that("partial_dependence works with cforest regression", {
    library(party)
    data(swiss)
    fit <- cforest(Fertility ~ ., swiss)
    pd <- partial_dependence(fit, swiss, "Education", length(unique(swiss$Education)))
    expect_that(pd, is_a("data.frame"))
    expect_that(colnames(pd), equals(c("Education", "pred")))
    expect_that(pd$pred, is_a("numeric"))
    expect_that(length(unique(pd$Education)), equals(nrow(pd)))
})

test_that("partial_dependence works with rfsrc regression", {
    library(randomForestSRC)
    data(swiss)
    fit <- rfsrc(Fertility ~ ., swiss)
    pd <- partial_dependence(fit, swiss, "Education", length(unique(swiss$Education)))
    expect_that(pd, is_a("data.frame"))
    expect_that(colnames(pd), equals(c("Education", "pred")))
    expect_that(pd$pred, is_a("numeric"))
    expect_that(length(unique(pd$Education)), equals(nrow(pd)))
})

test_that("partial_dependence works with randomForest classification", {
    library(randomForest)
    data(iris)
    fit <- randomForest(Species ~ ., iris)
    
    pd <- partial_dependence(fit, iris, "Petal.Width", length(unique(iris$Petal.Width)))
    expect_that(pd, is_a("data.frame"))
    expect_that(colnames(pd), equals(c("Petal.Width", "pred")))
    expect_that(pd$pred, is_a("character"))
    expect_that(length(unique(pd$Petal.Width)), equals(nrow(pd)))
})

test_that("partial_dependence works with cforest classification", {
    library(party)
    data(iris)
    fit <- cforest(Species ~ ., iris, controls = cforest_unbiased(mtry = 2))

    pd <- partial_dependence(fit, iris, "Petal.Width", length(unique(iris$Petal.Width)))
    expect_that(pd, is_a("data.frame"))
    expect_that(colnames(pd), equals(c("Petal.Width", "pred")))
    expect_that(pd$pred, is_a("character"))
    expect_that(length(unique(pd$Petal.Width)), equals(nrow(pd)))
}) 

test_that("partial_dependence works with rfsrc classification", {
    library(randomForestSRC)
    data(iris)
    fit <- rfsrc(Species ~ ., iris)

    pd <- partial_dependence(fit, iris, "Petal.Width", length(unique(iris$Petal.Width)))
    expect_that(pd, is_a("data.frame"))
    expect_that(colnames(pd), equals(c("Petal.Width", "pred")))
    expect_that(pd$pred, is_a("character"))
    expect_that(length(unique(pd$Petal.Width)), equals(nrow(pd)))
})
