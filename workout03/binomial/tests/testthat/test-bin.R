library(testthat)

context("test binomial functions")

# test bin_choose() function
test_that("test if bin_choose works",{
  expect_error(bin_choose('z', 15))
  expect_equal(bin_choose(10, 0), 1)
  expect_equal(bin_choose(9, 6), 84)
  expect_length(bin_choose(9, 6), 1)
})




# test bin_probability function
test_that("test if bin_choose works",{
  expect_error(bin_probability('x', 10))
  expect_equal(bin_probability(2, 6, 0.5), 0.234375)
  expect_length(bin_probability(0:2, 3, 0.2),3)
  expect_is(bin_probability(5, 10, 0.2),'numeric')
  expect_length(bin_probability(5, 10, 0.5),1)
})


# test bin_distribution function
test_that("test if bin_distribution works",{
  expect_is(bin_distribution(3,0.2), 'data.frame')
  expect_length(bin_distribution(3,0.2),2)
  expect_is(bin_distribution(3,0.2), 'bindis')
  expect_error(bin_distribution(-5,0.2))
  expect_error(bin_distribution(-2,2))
})


# test bin_cumulative function
test_that("test if bin_cumulative works",{
  expect_is(bin_cumulative(3,0.2), 'data.frame')
  expect_error(bin_cumulative(-5,2))
  expect_error(bin_cumulative(-8,0.2))
  expect_is(bin_cumulative(2,0.2), 'bincum')
  expect_length(bin_cumulative(3,0.2),3)
})

