% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/elasticNet.R
\name{elasticNet}
\alias{elasticNet}
\title{The elastic net (EN) function with multiple training run averaging}
\usage{
elasticNet(
  featureMat,
  responseVec,
  standardize = TRUE,
  alphaVals = seq(0.2, 1, length = 9),
  lambdaVals = NULL,
  nFoldsForParamSelection = 10,
  nCvRepeats = 10,
  nTrainingRuns = 200,
  minFeatureFrequencyPctl = 0.95,
  cumCorNumPredictors = 10,
  useLambdaMin = TRUE,
  useOneStdErrRule = FALSE,
  id = "",
  obsFractionForModelSelection = 0.75,
  verbose = TRUE
)
}
\arguments{
\item{featureMat}{p x n matrix with input feature vectors along rows.}

\item{responseVec}{n-dimensional response vector to be predicted using a sparse
linear combination of input feature vectors specified in featureMat.}

\item{standardize}{Logical flag for feature variable standardization (across
observations), passed in to glmnet functions (glmnet documentation: if
variables are already in the same units, standardization may not be necessary).}

\item{alphaVals}{a vector of alpha values to be optimized over}

\item{lambdaVals}{a vector of lambda values to be optimized over}

\item{nFoldsForParamSelection}{the number of cross-validation folds to perform}

\item{nCvRepeats}{The number of cross-validation repeats (with different fold
assignments).}

\item{nTrainingRuns}{number of training runs to perform}

\item{minFeatureFrequencyPctl}{a fractional value (0-1). Features in the x 
percentile defined by this parameter after the removal of features with 
zero weights are retained.}

\item{cumCorNumPredictors}{the maximum number of predictors to be returned}

\item{useLambdaMin}{a boolean, whether to use the minimum lambda (lambda.min) 
from cross-validation as the optimum lambda, if FALSE then the largest value 
of lambda such that error is within 1 standard error of the minimum (lambda.1se)
is used.}

\item{useOneStdErrRule}{Use one standard error rule for model selection, i.e.,
select smallest model (in terms of number of predictors) for which the estimated
error (by cross-validation) is within one standard error of the minimum estimated
error.}

\item{id}{a optional string identifier for the EN run}

\item{obsFractionForModelSelection}{The fraction of the number of observations
used to limit the maximum possible number of predictors considered during 
model selection (default = 0.75).}

\item{verbose}{a boolean, whether debugging information should be displayed}
}
\value{
a list with members: 
\itemize{
  \item{predictorWts} {Coefficient weights for the selected predictors.}
  \item{predictorSelectionFreq} {The selection frequency for the final set of predictors, i.e.,
   the fraction of training set iterations in which the predictor was selected.}
  \item{cvPredRsqVals} {A vector with the k-th entry indicating the square of the Pearson's
   correlation coefficient between the actual response and the cross-validation}
  \item{cvPredRVals} {A vector with the k-th entry indicating the Pearson's
   correlation coefficient between the actual response and the cross-validation
   predicted response for a model based on the top k predictors (by coeff. weight magnitude).}
  \item{cvMeanSqErrVals} {A vector with the k-th entry indicating the mean cross-validation error
   estimate for a model based on the top k predictors (by coeff. weight magnitude).}
  \item{cvSdMeanSqErrVals} {A vector with the k-th entry indicating the standard deviation of
   the cross-validation error estimate for a model based on the top k predictors 
   (by coeff. weight magnitude).}
  \item{predictedResponse} {A matrix with the k-th column giving the predicted response with
   respect to the top k predictors (by coefficient weight magnitude).}
  \item{predictedResponseCor} {a vector whose nth element gives the correlation of 
    the response with the linear combination of the first n predictors, with 
    coefficient weights given in predictorWts.}
  \item{call} {the command used to call the function with parameters described}
  \item{alpha} {the optimized alpha value used}
  \item{lambda} {the optimized lambda value used}
  \item{foldIdsParamSelection} {The cross-validation fold IDs used during elastic net parameter 
   selection.}
  \item{foldIdsParamSelection} {The cross-validation fold IDs used during final model selection
   (selecting among models with different numbers of predictors).}
  \item{cvm} {mean cross-validated errors for alpha values tried}
  \item{featureWtMat} {a matrix with the feature weights for all features across all training 
  runs (using random observation data subsets).}
}
}
\description{
Applies the elastic net regression algorithm to learn a sparse linear model
for predicting a response vector from a set of input feature vectors.
}
\author{
Vinodh Rajapakse
}
\concept{rcellminerElasticNet}
