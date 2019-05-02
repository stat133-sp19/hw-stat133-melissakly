library(testthat)

context("test auxiliary functions")

# test aux_mean()
test_that("test that aux_mean works",{
  expect_equal(aux_mean(20, 0.2), 4)
  expect_equal(aux_mean(200, 0.2), 40)
  expect_error(aux_mean('x', 2))
  expect_length(aux_mean(20,0.2),1)
  expect_is(aux_mean(20,0.2),'numeric')
})


# test aux_variance()
test_that("test that aux_variance works",{
  expect_equal(aux_variance(20, 0.2), 3.2)
  expect_length(aux_variance(20,0.2),1)
  expect_error(aux_variance('x', 2))
})


# test aux_mode()
test_that("test that aux_mode works",{
  expect_equal(aux_mode(20, 0.2), 4)
  expect_length(aux_mode(20, 0.2),1)
  expect_error(aux_mode('x', 2))
})


# test aux_skewness()
test_that("test that aux_skewness works",{
  expect_equal(aux_skewness(20, 0.5), 0)
  expect_length(aux_skewness(20, 0.2),1)
  expect_error(aux_skewness('z', 0.5))
})


# test aux_kurtosis()
test_that("test that aux_kurtosis works",{
  expect_equal(aux_kurtosis(20, 0.2),0.0125)
  expect_length(aux_kurtosis(20, 0.2),1)
  expect_error(aux_kurtosis('z', 0.5))
})

