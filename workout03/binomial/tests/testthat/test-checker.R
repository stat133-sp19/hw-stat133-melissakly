library(testthat)

context("test checker functions")

# test check_prob() function
test_that("test that check_prob works",{
  expect_true(check_prob(0.5))
  expect_error(check_prob(-2), "invalid probability given")
  expect_length(check_prob(0.5),1)
  expect_error(check_prob(7), "invalid probability given")
}
)



# test check_trials() function

test_that("test that check_trials works",{
  expect_true(check_trials(8))
  expect_error(check_trials(9.5), 'invalid trials given')
  expect_length(check_trials(3),1)
}
)



# test check_success() function

test_that("test that check_success works",{
  expect_true(check_success(2,10))
  expect_error(check_success(10,9),'invalid: success cannot exceed number of trials')
  expect_error(check_success(2.3,3), 'invalid: success must be int')
  expect_length(check_success(9,10), 1)

}
)

