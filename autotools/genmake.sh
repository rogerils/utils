autoscan

#edit configure.scan and rename it to configure.ac
#Add   AM_INIT_AUTOMAKE(PACKAGE, VERSION)
#Add   output (Makefile)

aclocal

autoconf

automake --add-missing
#touch xxx

 #./configure
 # make
