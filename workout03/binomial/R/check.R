# Description: checks if probability is valid
# Inputs
#   prob: probability (numeric)
# Output
#   logical value
check_prob = function(prob) {
  if (prob < 0 || 1 < prob) {
    stop("invalid probability given")
  } else {
    return (TRUE)
  }
}

# Description: checks if trials is valid
# Input
#   trial: number of trials (integer)
# Output
#   logical value
check_trials = function(trials){
  if(trials%%1 == 0 & trials >= 0){
    return(TRUE)
  }else{
    stop('invalid trials given')
  }
}

# Description: checks if success is valid
# Inputs
#   success: number or vector of successes
#   trial: number of trials (integer)
# Output
#   logical value
check_success <- function(success, trials){
  for (i in 1:length(success)){
    if(success[i] < 0){
      stop("invalid: success must not be below 0 success")
    }else if(success[i] > trials){
      stop("invalid: success cannot exceed number of trials")
    }else if(success[i] - as.integer(success[i]) != 0){
      stop("invalid: success must be int")
    }else{
      return(TRUE)
    }
  }
}
