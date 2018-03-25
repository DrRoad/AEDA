context("finishReport")

test_that("finishReport Works", {

  data("Aids2", package = "MASS")
  set.seed(1)
  aids2 = Aids2[sample.int(500, 100), ]
  # Test with Boston dataset and just two reports
  num.sum.task = makeNumSumTask(id = "BostonTask", data = aids2, target = "T.categ")
  num.sum = makeNumSum(num.sum.task)
  num.sum.report = makeNumSumReport(num.sum)

  my.task = makeCorrTask(id = "BostonTask", data = aids2, type = "CorrPlot")
  my.corr = makeCorr(my.task)
  corr.report = makeReport(my.corr)

  cat.sum.task = makeCatSumTask(id = "BostonTask", data = aids2,
   target = "T.categ", na.rm = TRUE)
  cat.sum = makeCatSum(cat.sum.task)
  cat.sum.report = makeReport(cat.sum)

  my.report.task = makeBasicReportTask(id = "BostonTask", data = aids2, target = "sex")
  basic.report = makeReport(my.report.task)


  #combine all reports
  finishReport(basic.report, num.sum.report, corr.report,
   cat.sum.report, save.mode = FALSE, override = TRUE)
  rmarkdown::render("MainReport.rmd", quiet = TRUE)

  expect_error(finishReport(basic.report, num.sum.report, corr.report,
    cat.sum.report))

})