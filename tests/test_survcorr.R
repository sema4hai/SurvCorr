source('R/survcorr.R')
require(survival)

#test_that('lacking noncencored pairs, init r0 as 0 by default',
test_survcorr_gooddata = function() {
    #data(kidney_test)
    load('data/kidney.RData')
    obj = survcorr(formula1=Surv(TIME1, STATUS1) ~ 1, formula2=Surv(TIME2, STATUS2) ~ 1,
      data=kidney, M=1000, MCMCSteps=10, alpha=0.05, epsilon=0.001)
    print(obj)
    #expect_equal(obj$r0, 0)
}
test_survcorr_baddata = function() {
  #data(kidney_test)
  load('data/kidney.RData')
  obj = survcorr(formula1=Surv(TIME1, STATUS1) ~ 1, formula2=Surv(TIME2, STATUS2) ~ 1,
                 data=kidney_test, M=1000, MCMCSteps=10, alpha=0.05, epsilon=0.001)
  print(obj)
  #expect_equal(obj$r0, 0)
}
test_survcorr_gooddata()
test_survcorr_baddata()

