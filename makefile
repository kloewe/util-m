#-----------------------------------------------------------------------------
# File    : makefile
# Contents: install util-m by adding the relevant dirs to the Matlab path
#
# Author  : Kristian Loewe
#-----------------------------------------------------------------------------

THISDIR = $(CURDIR)
INSTALLCMD = addpath('$(CURDIR)/util-m'); savepath

MATLABROOT = $(dir $(realpath $(shell which matlab)))
MATLAB = $(realpath $(MATLABROOT))/matlab

.PHONY: all
all: ;

.PHONY: install
install:
	@if [ -e "$(MATLAB)" ]; then \
	  $(MATLAB) -nodisplay -nojvm -nosplash -logfile install.log \
	  -r "try; $(INSTALLCMD); catch; quit; end; quit;" > /dev/null; \
	  grep -m1 -E 'Error|Warning' install.log; \
	  status=$$?; \
	  if [ $$status -eq 0 ]; then \
	    cat install.log; \
	  fi \
	else \
	  echo "Error: matlab not found."; \
	  echo "You may have to add MATLABROOT/bin to your path."; \
	fi
