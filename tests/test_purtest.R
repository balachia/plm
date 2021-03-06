# Various run tests for purtest()
library(plm)
data("Grunfeld", package = "plm")
pG <- pdata.frame(Grunfeld)

y <- data.frame(split(Grunfeld$inv, Grunfeld$firm))

purtest(pG$inv, pmax = 4, exo = "intercept", test = "ips")
purtest(inv ~ 1, data = Grunfeld, index = "firm", pmax = 4, test = "madwu")

summary(a1 <- purtest(pG$inv, lags = "SIC", exo = "intercept", test = "ips", pmax = 8))
print(a1$args$lags)
if (length(a1$args$lags) != 1) stop("length(return_value$args$lags must be 1")
if (a1$args$lags != "SIC") stop("length(return_value$args$lags must be \"SIC\"")

summary(a2 <- purtest(pG$inv, lags = 2, exo = "intercept", test = "ips"))
print(a2$args$lags)
if (length(a2$args$lags) != 1) stop("length(return_value$args$lags must be 1")

summary(a3 <- purtest(pG$inv, lags = c(2,3,1,5,8,1,4,6,7,1), exo = "intercept", test = "ips"))
length(a3$args$lags)
print(a3$args$lags)
if (length(a3$args$lags) != 10) stop("length(return_value$args$lags must be 10")

### pseries
purtest(pdata.frame(Grunfeld)[ , "inv"],  pmax = 4, test = "ips", exo = "intercept") # works
purtest(pdata.frame(Grunfeld)[ , "inv"],  pmax = 4, test = "ips", exo = "trend")     # works
# purtest(pdata.frame(Grunfeld)[ , "inv"],  pmax = 4, test = "ips", exo = "none")      # works as intended: gives informative error msg

### pdata.frame
# purtest(pdata.frame(Grunfeld)[ , "inv", drop = F],  pmax = 4, test = "ips", exo = "intercept") # runs but but gives different results! and a warning!
# purtest(pdata.frame(Grunfeld)[ , "inv", drop = F],  pmax = 4, test = "ips", exo = "trend")     # runs but but gives different results! and a warning!
# purtest(pdata.frame(Grunfeld)[ , "inv", drop = F],  pmax = 4, test = "ips", exo = "none")     # works as intended: gives informative error msg


#### Hadri (2000) test
## matches results vom EViews 9.5:
## z stat     =  4.18428, p = 0.0000 (intercept)
## z stat het = 10.1553,  p = 0.0000 (intercept)
## z stat     =  4.53395, p = 0.0000 (trend)
## z stat het =  9.57816, p = 0.0000 (trend)
purtest(pG$value, exo = "intercept", test = "hadri", Hcons = FALSE)
purtest(pG$value, exo = "intercept", test = "hadri")
purtest(pG$value, exo = "trend", test = "hadri", Hcons = FALSE)
purtest(pG$value, exo = "trend", test = "hadri")


### IPS (2003) test
## use dfcor = TRUE to match gretl 2017c and EViews 9.5 exactly
b <- purtest(pG$value, test = "ips", exo = "intercept", lags = 0, dfcor = TRUE)
unlist(lapply(b$idres, function(x) x[["rho"]]))
unlist(lapply(b$idres, function(x) x[["trho"]]))

## lags = 2 to match gretl and EViews exactly (lags > 0 gives the Wtbar stat in gretl and EViews)
b_lag2 <- purtest(pG$value, test = "ips", exo = "intercept", lags = 2, dfcor = TRUE)
unlist(lapply(b_lag2$idres, function(x) x[["rho"]]))
unlist(lapply(b_lag2$idres, function(x) x[["trho"]]))

#### various tests from Choi (2001)
purtest(pG$value, test = "Pm", exo = "intercept", lags = 2, dfcor = TRUE)
purtest(pG$value, test = "invnormal", exo = "intercept", lags = 2, dfcor = TRUE)
purtest(pG$value, test = "logit", exo = "intercept", lags = 2, dfcor = TRUE)

### Levin-Lin-Chu test
purtest(pG$value, test = "levinlin", exo = "intercept", lags = 0, dfcor = TRUE)
