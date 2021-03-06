#' Creates an Categorical Summary Report object
#'
#' @param analysis.obj [\code{CatSumObj} Object]\cr
#'   A object of the "CatSumObj" class
#' @return CatSumReport
#' @import checkmate
#' @import BBmisc
#' @examples
#'  data("Arthritis", package = "vcd")
#'  cat.sum.task = makeCatSumTask(id = "Arthritis.Task", data = Arthritis, target = "Improved")
#'  cat.sum.result = makeCatSum(cat.sum.task)
#'  #create the categorical summary report
#'  cat.sum.report = makeReport(cat.sum.result)
#' @export
makeReport.CatSumObj = function(analysis.obj){
  assertClass(analysis.obj, "CatSumObj")
  #assertCharacter(type, min.chars = 1)

  #report.id = reportId()
  report.id = deparse(substitute(analysis.obj))
  makeS3Obj("CatSumReport",
    task = analysis.obj$task,
    cat.sum = analysis.obj$cat.sum,
    report.id = report.id,
    type = "CategoricalReport")
}

print.CatSumReport = function(x, ...) {
  print(x$task)
}
