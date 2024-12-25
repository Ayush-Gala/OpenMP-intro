SHELL=/bin/sh
CLASS=S
SFILE=config/suite.def
THREADS=14
export OMP_NUM_THREADS = $THREADS
default: header
	@ $(SHELL) sys/print_instructions
      
FT: ft		       
ft: header	       
	cd FT; $(MAKE) CLASS=$(CLASS)
		       
# Awk script courtesy cmg@cray.com
suite:
	@ awk '{ if ($$1 !~ /^#/ &&  NF > 0)                              \
	printf "make %s CLASS=%s\n", $$1, $$2 }' $(SFILE)  \
	| $(SHELL)


# It would be nice to make clean in each subdirectory (the targets
# are defined) but on a really clean system this will won't work
# because those makefiles need config/make.def
clean:
	- rm -f core 
	- rm -f *~ */core */*~ */*.o */npbparams.h */*.obj */*.exe
	- rm -f sys/setparams sys/makesuite sys/setparams.h
	- rm -f bin/ft.S bin/ft.B

header:
	@ $(SHELL) sys/print_header

kit: 
	- makekit -s100k -k30 * */* */*/*

# Custom debug and test targets for FT

# Target to run FT with debug settings (bin/ft.S)
# Setting OMP_NUM_THREADS to 4 for debug mode
debug: bin/ft.S
	@echo "Running Debug (ft.S) with $(THREADS) OpenMP threads"
	OMP_NUM_THREADS=$(THREADS) bin/ft.S

# Target to run FT with test settings (bin/ft.B)
# Setting OMP_NUM_THREADS to 8 for test mode
test: bin/ft.B
	@echo "Running Test (ft.B) with $(THREADS) OpenMP threads"
	OMP_NUM_THREADS=$(THREADS) bin/ft.B

# Ensure ft.S and ft.B are built before running
bin/ft.S:
	@mkdir -p bin
	cd FT; $(MAKE) CLASS=S
	${CLINK} ${CLINKFLAGS} -o bin/ft.S FT/ft.o ${C_LIB} -lm

bin/ft.B:
	@mkdir -p bin
	cd FT; $(MAKE) CLASS=B
	${CLINK} ${CLINKFLAGS} -o bin/ft.B FT/ft.o ${C_LIB} -lm

