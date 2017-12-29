#' @title Calculates a Numeric Summary
#'
#' @description
#' makeNumSum calculates a numeric summary and wrapes an object around it
#'
#' @param num.sum.task [\code{NumTask}]\cr
#'   A NumSumTask Object
#' @return NumSumObj
#' @examples
#'  data("Boston", package = "MASS")
#'  num.sum.task = makeNumSumTask(id = "BostonTask", data = Boston, target = "medv")
#'  #get the numeric summary task object
#'  num.sum = makeNumSum(num.sum.task)
#' @import checkmate
#' @import BBmisc
#' @import moments
#' @import stats
#' @export
makeNumSum = function(num.sum.task){
  assertClass(num.sum.task, "NumSumTask")

  data = num.sum.task$env$data
  features = unlist(num.sum.task$numdatatypes)
  target = num.sum.task$env$datatypes$target
  num.sum = getNumSum(data, features, target)

  makeS3Obj("NumSumObj",
    num.sum = num.sum$merged.list,
    num.sum.df = num.sum$num.sum.df,
    task = num.sum.task)
}

#' @export
# Print function for NumSum Object
print.NumSumObj = function(x, ...) {
  catf("Result of numeric/integer summary for: %s", x$task$id)
  cat("\n")
  print(x$num.sum.df)
}