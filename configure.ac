## This script was copied from
## from the RcppGSL package (version 0.2.3.1)
## http://cran.r-project.org/web/packages/RcppGSL/
## The copyright information for the RcppGSL package is as follows:
## Copyright (C) 2010 Romain Francois and Dirk Eddelbuettel
## Licensed under GNU GPL 2 or later


# The version set here will propagate to other files from here
AC_INIT([RcppGSL], 0.2.3)

# Checks for common programs using default macros
AC_PROG_CC

## Use gsl-config to find arguments for compiler and linker flags
##
## Check for non-standard programs: gsl-config(1)
AC_PATH_PROG([GSL_CONFIG], [gsl-config])
## If gsl-config was found, let's use it
if test "${GSL_CONFIG}" != ""; then
    # Use gsl-config for header and linker arguments
    GSL_CFLAGS=`${GSL_CONFIG} --cflags`
    GSL_LIBS=`${GSL_CONFIG} --libs`
else
    AC_MSG_ERROR([gsl-config not found, is GSL installed?])
fi

# Now substitute these variables in src/Makevars.in to create src/Makevars
AC_SUBST(GSL_CFLAGS)
AC_SUBST(GSL_LIBS)

AC_OUTPUT(src/Makevars)

