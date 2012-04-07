sim.snp.expsurv.power <-
function(GHR,B,n,raf,erate,pilm,lm,model,test,alpha,exactvar=FALSE,interval=c(0,10),rootint=c(0.1,200))
  {
    gtprev=hwe(raf)
    lam=surv.exp.gt.model(pilm,lm,gtprev,GHR,model,interval)
    b=censbnd(lam,gtprev,1-erate,rootint)$root
    if(model=="additive")
      z=c(0,1,2)
    else
      {
        z=NA
        print("Model not defined")
      }
    asypval=asypow(n,log(GHR),a=0,b,lam[1],raf,gtprev,alpha,z,exactvar)
    if(B>0)
      {
        pvals=replicate(B,sim.snp.expsurv.sctest(n,gtprev,lam,0,b,test))
        powB=mean(pvals[2,]<alpha)
        erateB=mean(pvals[1,])
      }
    else
      {
        powB=NA
        erateB=NA
      }
    data.frame(B=B,raf,q0=gtprev[1],q1=gtprev[2],q2=gtprev[3],lam0=lam[1],lam1=lam[2],lam2=lam[3],GHR,
               pilm=gtprev[1]*exp(-lm*lam[1])+gtprev[2]*exp(-lm*lam[2])+gtprev[3]*exp(-lm*lam[3]),
               lm,model,test,alpha,a=0,b,erate,erateB=erateB,n,powB=powB,pow=asypval[1],pow0=asypval[2],v1=asypval[3],v2=asypval[4],v12=asypval[5])
    
  }

