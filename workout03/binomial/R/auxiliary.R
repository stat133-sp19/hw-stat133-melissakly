# Description: calculates the mean of a binomial distribution
# Inputs
#   trials: how many trials
#   prob: probability of successes
# Output
#   a numeric value
aux_mean <- function(trials, prob) {
  avg <- trials * prob
  return(avg)
}

# Description: calculates the variance
# Inputs
#   trials: how many trials
#   prob: probability of successes
# Output
#   a numeric value
aux_variance <- function(trials, prob) {
  var <- trials * prob * (1 - prob)
  return(var)
}

# Description: calculates the mode
# Inputs
#   trials: how many trials
#   prob: probability of successes
# Output
#   a numeric value
aux_mode <- function(trials, prob) {
  mid <- floor(trials * prob + prob)
  return(mid)
}

# Description: calculates the skewness
# Inputs
#   trials: how many trials
#   prob: probability of successes
# Output
#   a numeric value
aux_skewness <- function(trials, prob) {
  skew <- (1 - 2 * prob) / sqrt(trials * prob * (1 - prob))
  return(skew)
}

# Description: calculates the kurtosis
# Inputs
#   trials: how many trials
#   prob: probability of successes
# Output
#   a numeric value
aux_kurtosis <- function(trials, prob) {
  kurt <- (1 - 6 * prob * (1 - prob)) / (trials * prob * (1 - prob))
  return(kurt)
}
