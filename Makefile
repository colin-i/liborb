

ifndef OCOMP
OCOMP=o
endif
ifndef OLINK
OLINK=ounused
endif
ifndef OCONV
OCONV=otoc
endif
ifndef linkerflags
linkerflags=-O3 -s
endif

proj=liborb.so

${proj}:
	${OCOMP} lib.oc x_file 2
	#${OLINK}
	${OCONV} lib.oc.x
	$(CC) ${linkerflags} -shared -w lib.c -o $@

clean:
	rm -f lib.c lib.oc.log lib.oc.x ${proj}

.PHONY: clean
