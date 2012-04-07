sim.snp.expsurv.sctest <-
function(n,gtprev,lam,a,b,test,diag=FALSE)
  {
    ng=as.integer(rmultinom(1,n,gtprev))
    atime=rexp(n,rep(lam,ng))
    ctime=runif(n,a,b)
    otime=pmin(atime,ctime)
    event=as.integer(atime<ctime)
    SNP=rep(0:2,ng)
    if(test=="genotype")
      SNP=factor(SNP)
    else if(test=="additive")
      SNP=SNP
    else if(test=="dominant")
      SNP=factor(ifelse(SNP==0,0,1))
    else if(test=="recessive")
      SNP=factor(ifelse(SNP==2,1,0))
    else
      print("test not implemented")
    mod=summary(coxph(Surv(otime,event)~SNP))
    if(diag)
      print(mod)
    c(event=mean(event),pval=mod$sctest[3])
  }

