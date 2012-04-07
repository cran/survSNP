#ifndef __INTEGRATION_WRAPPER_H
#define __INTEGRATION_WRAPPER_H

#include <gsl/gsl_integration.h>

typedef  double (*FUNCX)(double x);
FUNCX funcx;
double funcForIntegration(double x, void * params) {
    double alpha = *(double *) params;
    return funcx(alpha*x);
};
class GslIntegration
{
public:
    gsl_integration_workspace * w;
    gsl_function gslFunc;

    double alpha;
    double result, error;

    static GslIntegration& getInstance() {
        static GslIntegration instance;
        return instance;
    }

    GslIntegration() {
        w = gsl_integration_workspace_alloc (1000);
        gslFunc.function = &funcForIntegration;
        alpha = 1.0;
        gslFunc.params = &alpha;
    }

    ~GslIntegration() {
        gsl_integration_workspace_free (w);
    }

    double integration(FUNCX f, double a, double b) {
        funcx=f;
        gsl_integration_qags (&gslFunc, a, b, 0, 1e-7, 1000,
                              w, &result, &error); 
        return result;
    }
};
double gslIntegration(FUNCX f, double a, double b) {    
    return GslIntegration::getInstance().integration(f,a,b);
}

#endif //__INTEGRATION_WRAPPER_H

