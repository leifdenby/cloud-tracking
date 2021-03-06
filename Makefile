HOSTNAME=$(shell hostname -d)

ifeq ($(HOSTNAME),hpc.dkrz.de)
	NETCDF_F_PATH=/sw/rhel6-x64/netcdf/netcdf_fortran-4.4.2-intel14/
else
	NETCDF_F_PATH=/sw/squeeze-x64/netcdf_fortran-4.2.0-static-gcc47
endif

NF_CONFIG="$(NETCDF_F_PATH)/bin/nf-config"

FFLAGS=$(shell $(NF_CONFIG) --fflags --flibs --cflags) 
FC=$(shell $(NF_CONFIG) --fc)
NETCDF_INCDIR=$(shell $(NF_CONFIG) --prefix)/include

SOURCES=$(wildcard *.f90)
PROGRAMS=$(patsubst %.f90, %, $(SOURCES))


all: $(PROGRAMS)
	echo $(PROGRAMS)

$(PROGRAMS): $(SOURCES)
	mkdir -p bin/
	$(FC) -O0 -g $(addsuffix .f90,$@) -o bin/$@ $(FFLAGS)
