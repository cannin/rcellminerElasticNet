test_that("expected elasticNet() output is produced", {
  featureSet <- t(mtcars[, -1])
  #featureSet <- t(mtcars)
  responseVec <- mtcars[, 1]
  maxPredictors <- 3
  
  elNetResults <- elasticNet(featureMat = featureSet, 
                             responseVec = responseVec, 
                             id = "Example",
                             alphaVals = seq(0.2, 1, length = 10), 
                             useLambdaMin = TRUE, 
                             cumCorNumPredictors = maxPredictors, 
                             nCvRepeats = 3,
                             nTrainingRuns = 10,
                             verbose = FALSE, 
                             standardize = FALSE, 
                             useOneStdErrRule = TRUE)
  
  # Get the summed response vector
  predictedResponseVec <- rowSums(elNetResults$predictedResponse)
  cr <- cor(predictedResponseVec, responseVec)
  
  # testing -------------------------------------------------------------------
  expect_equal(elNetResults$predictorWts,
               c(SLFN11 = -0.0303745), tolerance = 10^-6)
  expect_equal(elNetResults$predictorSelectionFreq,
               c(disp = 1), tolerance = 10^-6)
  
  expect_equal(elNetResults$predictorWts_preModelSelection,
               c(disp = -0.03037450, hp=-0.02510745), 
               tolerance = 10^-6)
  expect_equal(elNetResults$predictorSelectionFreq_preModelSelection,
               c(disp = 1, hp=1), 
               tolerance = 10^-6)
  #----------------------------------------------------------------------------
})