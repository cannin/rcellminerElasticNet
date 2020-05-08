test_that("expected elasticNet() output is produced", {
  # Dataset included with R
  
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

test_that("expected lmCvFit output is produced", {
  set.seed(1)
  
  # Dataset included with R
  lmData <- mtcars 
  
  # Note: Handling issues caused by variable names with spaces 
  # or other characters that cannot be used within a formula.
  colnames(lmData) <- stringr::str_replace_all(colnames(lmData), 
                                               pattern = "[-|/| ]", replacement = "")
  
  lmFormula <- as.formula(paste0(colnames(lmData)[1], " ~ ."))
  lmFit <- lm(lmFormula, lmData)
  lmCvFit <- rcellminerElasticNet::getLmCvFit(X = as.matrix(lmData[, -1, drop = FALSE]), 
                                              y = lmData[, 1, drop = TRUE], nFolds = 10, nRepeats = 1)
  
  # Results
  predictorWts <- coef(lmFit)
  predictedResponse <- predict(lmFit)
  cvPredictedResponse <- lmCvFit$cvPred
  techDetails <- lmFit
  eqnStr <- rcellminerElasticNet::getLmEquationString(predictorWts)
  
  expect_equal(eqnStr, 'Y = 12.3 + (-3.72*wt) + (2.52*am) + (0.821*qsec) + (0.787*drat) + (0.655*gear) + (0.318*vs) + (-0.199*carb) + (-0.111*cyl) + (-0.0215*hp) + (0.0133*disp)')
})