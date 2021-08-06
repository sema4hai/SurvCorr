source('R/survcorr.R')
require(survival)
require(testthat)

#test_that('lacking noncencored pairs, init r0 as 0 by default',
test_survcorr_gooddata = function() {
    #data(kidney_test)
    load('data/kidney.RData')
    obj = survcorr(formula1=Surv(TIME1, STATUS1) ~ 1, formula2=Surv(TIME2, STATUS2) ~ 1,
      data=kidney, M=10, MCMCSteps=10, alpha=0.05, epsilon=0.001)
    print(obj)
    #expect_equal(obj$r0, 0)
}
test_survcorr_baddata = function() {
  #data(kidney_test)
  load('data/kidney.RData')
  obj = survcorr(formula1=Surv(TIME1, STATUS1) ~ 1, formula2=Surv(TIME2, STATUS2) ~ 1,
                 data=kidney_test, M=10, MCMCSteps=10, alpha=0.05, epsilon=0.001)
  print(obj)
  #expect_equal(obj$r0, 0)
}

.test_survcorr_anothererror = function() {
    data = read.csv('data/debug_data.csv')
    surv_d = Surv(time=data$DFS, event=data$DFS_event)
    surv_o = Surv(time=data$OS, event=data$OS_event)
    #browser()
    obj = survcorr(formula1=surv_d ~ 1, formula2=surv_o ~ 1, M=10, data=data)

    #obj = survcorr(formula1=Surv(time=data$DFS, event=data$DFS_event) ~ 1, formula2=Surv(time=data$OS, event=data$OS_event) ~ 1, M=100, data=data)
    res = unlist(obj[1:3])
    print (res)
}

#expect fail
test_survcorr_anothererror = function() {
  load('data/kidney.RData')
  kidney$STATUS2[1] = NA
  expect_error(survcorr(formula1=Surv(TIME1, STATUS1) ~ 1, formula2=Surv(TIME2, STATUS2) ~ 1,
           data=kidney, M=10, MCMCSteps=10, alpha=0.05, epsilon=0.001),
           'Unmatching models:.*')
}

test_survcorr_gooddata()
test_survcorr_baddata()
test_survcorr_anothererror()
'
length(surv_d)
length(surv_o)
tail(sort(surv_o))
tail(sort(surv_d))
Looks like one of the survs(dfs?) are filtered off 1 item in survcorr.
  tmp1 is one item less: turn out that one of the DFS_event is NA!
'
