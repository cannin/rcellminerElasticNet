#' Generate an equation string representing the model
#' 
#' @param predictorWts a named vector of numeric weights
#' @param orderByDecrAbsVal boolean, whether to order predictors or keep the input order
#' @param numSigDigits number of digits to show 
#' 
#' @return a string representing the model
#' 
#' @author Vinodh Rajapakse 
#' 
#' @export
#' @concept rcellminerElasticNet
getLmEquationString <- function(predictorWts, orderByDecrAbsVal = TRUE, numSigDigits = 3){
  if (length(predictorWts) == 0){
    return("")
  }
  if (is.null(names(predictorWts))){
    names(predictorWts) <- paste0("predictor_", 1:length(predictorWts))
  }
  if (orderByDecrAbsVal){
    predictorWts <- predictorWts[order(abs(predictorWts), decreasing = TRUE)]
  }
  if ((length(predictorWts) > 0) && ("(Intercept)" %in% names(predictorWts))){
    i <- which(names(predictorWts) == "(Intercept)")
    predictorWts <- c(predictorWts[i], predictorWts[-i])
  }
  
  predictorWts <- signif(predictorWts, numSigDigits)
  if (names(predictorWts)[1] == "(Intercept)"){
    eqStr <- paste0("Y = ", predictorWts[1])
  } else{
    eqStr <- paste0("Y = (", predictorWts[1], "*", names(predictorWts)[1], ")")
  }
  
  if (length(predictorWts) > 1){
    for (predName in names(predictorWts[-1])){
      eqStr <- paste0(eqStr, " + (", predictorWts[predName], "*", predName, ")")
    }
  }
  
  return(eqStr)
}