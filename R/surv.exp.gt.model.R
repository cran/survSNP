surv.exp.gt.model <-
function(pilm,lm,gtprev,GRR,model,interval)
  {
    if(model=="dominant")
      ww=c(1,GRR,GRR)
    else if(model=="recessive")
      ww=c(1,1,GRR)
    else if (model=="additive")
      ww=c(1,GRR,GRR^2)
    else
      print("model not implemented")
    foo=function(lam0)
      {
        ww=-lam0*ww*lm
        pilm-sum(exp(ww)%*%gtprev)
      }
    ww*uniroot(foo,interval)$root
  }

