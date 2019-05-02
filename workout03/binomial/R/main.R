# setwd("~/hw-stat133/workout03/binomial")
source("R/check.R")
source("R/auxiliary.R")

#' @title bin_choose
#' @description computes n choose k
#' @param n total number of items
#' @param k number of items to choose
#' @return n choose k
#' @export
#' @examples
#' # choosing 3 from 5
#' bin_choose(5, 3)
#'
#' # choosing 6 from 12
#' bin_choose(12, 6)
#'
bin_choose = function(n, k) {
  return (factorial(n) / (factorial(k) * factorial(n-k)))
}


#' @title bin_probability
#' @description computes probability of successes
#' @param success number of successes
#' @param trials number of trials
#' @param prob probability of success
#' @return probability of successs
#' @export
#' @examples
#' # chance of 5 successes in 10 trials with p=.5
#' bin_probability(5, 10, .5)
#'
#' # chance of 2 successes in 8 trials with p=.7
#' bin_probability(2, 8, .7)
#'
bin_probability = function(success, trials, prob) {
  check_trials(trials)
  check_prob(prob)
  check_success(success, trials)

  return (bin_choose(trials, success) * prob**success * (1-prob)**(trials-success))
}


#' @title bin_distribution
#' @description calculates probability of all successes
#' @param trials number of trials
#' @param prob probability of success
#' @return  a data frame with two classes: trials and the probability of successes in each trial
#' @examples
#' # chances of successes in 10 trials with p=.5
#' bin_distributoin(10, .5)
#'
#' # chances of successes in 8 trials with p=.7
#' bin_distribution(8, .7)
#'
bin_distribution <- function(trials, prob) {
  success <- 0:trials
  probability <- bin_probability(0:trials, trials, prob)
  data <- data.frame(success, probability)
  class(data) <- c('bindis', 'data.frame')
  return(data)
}


# plots a binomial distribution object
#' @export
plot.bindis = function(dist) {
  barplot(dist$probability, xlab = "successes", ylab = "probability", names.arg = dist$success)
}


#' @title bin_cumulative
#' @description calculates cumulative chances of all success
#' @param trials numb of trials
#' @param prob prob of success
#' @return data frame containing cumulative probability of success in each trial
#' @export
#' @examples
#' # chances of successes in 10 trials with p=.5
#' bin_cumulative(10, .5)
#'
#' # chances of successes in 8 trials with p=.7
#' bin_cumulative(8, .7)
#'
bin_cumulative = function(trials, prob) {
  df = bin_distribution(trials, prob)
  df["cumulative"] = cumsum(df$probability)
  class(df) = c("bincum", "data.frame")
  return(df)
}


# plots a cumulative binomial distribution
#' @export
plot.bincum = function(dist) {
  plot(dist$success, dist$cumulative, type="b", xlab = "success", ylab = "probability")
}


#' @title bin_variable
#' @description creates a binomial random variable
#' @param trials numb of trials
#' @param prob prob of success
#' @return binvar object
#' @export
#' @examples
#' # binvar with 10 trials with p=.5
#' bin_variable(10, .5)
#'
#' # binvar with 8 trials with p=.7
#' bin_variable(8, .7)
#'
bin_variable = function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  lst = list(trials = trials, prob = prob)
  class(lst) = c("binvar")
  return(lst)
}


# prints a binvar
#' @export
print.binvar = function(rv) {
  print("Binomial variable")
  print(noquote(" "))
  print(noquote("Paramaters"))
  print(noquote(paste("- number of trials:", rv$trials)))
  print(noquote(paste("- prob of success:", rv$prob)))
}


# provides summary statistics for a binvar
#' @export
summary.binvar = function(rv) {
  lst = list(
    trials = rv$trials,
    prob = rv$prob,
    mean = aux_mean(rv$trials, rv$prob),
    variance = aux_variance(rv$trials, rv$prob),
    mode = aux_mode(rv$trials, rv$prob),
    skewness = aux_skewness(rv$trials, rv$prob),
    kurtosis = aux_kurtosis(rv$trials, rv$prob)
  )
  class(lst) = "summary.binvar"
  return(lst)
}


# prints a summary.binvar
#' @export
print.summary.binvar = function(rv) {
  print("Summary Binomial")
  print(noquote(" "))
  print(noquote("Paramaters"))
  print(noquote(paste("- number of trials:", rv$trials)))
  print(noquote(paste("- prob of success:", rv$prob)))
  print(noquote(" "))
  print(noquote("Measures"))
  print(noquote(paste("- mean:", rv$mean)))
  print(noquote(paste("- variance:", rv$variance)))
  print(noquote(paste("- mode:", rv$mode)))
  print(noquote(paste("- skewness:", rv$skewness)))
  print(noquote(paste("- kurtosis:", rv$kurtosis)))
}


#' @title bin_mean
#' @description calculates mean
#' @param trials numb of trials
#' @param prob prob of success
#' @return the binomial mean
#' @export
#' @examples
#' # mean of 10 trials with p=.5
#' bin_mean(10, .5)
#'
#' # mean of 8 trials with p=.7
#' bin_mean(8, .7)
#'
bin_mean = function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_mean(trials, prob))
}


#' @title bin_variance
#' @description calculates variance
#' @param trials numb of trials
#' @param prob prob of success
#' @return the binomial variance
#' @export
#' @examples
#' # variance of 10 trials with p=.5
#' bin_variance(10, .5)
#'
#' # variance of 8 trials with p=.7
#' bin_variance(8, .7)
#'
bin_variance = function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_variance(trials, prob))
}


#' @title bin_mode
#' @description calculates the mode
#' @param trials numb of trials
#' @param prob prob of success
#' @return the binomial mode
#' @export
#' @examples
#' # mode of 10 trials with p=.5
#' bin_mode(10, .5)
#'
#' # mode of 8 trials with p=.7
#' bin_mode(8, .7)
#'
bin_mode = function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_mode(trials, prob))
}


#' @title bin_skewness
#' @description calculates skewness
#' @param trials numb of trials
#' @param prob prob of success
#' @return the binom skewness
#' @export
#' @examples
#' # skewness of 10 trials with p=.5
#' bin_skewness(10, .5)
#'
#' # skewness of 8 trials with p=.7
#' bin_skewness(8, .7)
#'
bin_skewness = function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_skewness(trials, prob))
}


#' @title bin_kurtosis
#' @description calculates the kurtosis
#' @param trials numb of trials
#' @param prob prob of success
#' @return the binomial kurtosis
#' @export
#' @examples
#' # kurtosis of 10 trials with p=.5
#' bin_kurtosis(10, .5)
#'
#' # kurtosis of 8 trials with p=.7
#' bin_kurtosis(8, .7)
#'
bin_kurtosis = function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_kurtosis(trials, prob))
}


