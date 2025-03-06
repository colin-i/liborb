
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
ifndef compilerflags
compilerflags=${linkerflags}
endif
OFLAGS=x_file 2 include_sec 1

core=orb
cores=${core}s
proj=lib${core}.so
com=common
exte=libexte.a

all: ${proj} ${core}.h
${core}.h: ${cores}.h

%.ohi: %.oh
	echo "format elfobj64" > $@
	echo "orphan off" >> $@
	cat $< >> $@
%.h: %.ohi
	${OCOMP} $< ${OFLAGS} logfile 0
	${OCONV} $<.x
%.o: %.oc
	${OCOMP} $< ${OFLAGS}
	${OCONV} $<.x
	$(CC) -c -w -fPIC ${compilerflags} $*.c
#-fPIC at launchpad bionic build

lib.o: ${com}.h ${cores}.h
util.o: ${com}.h

${exte}: util.o
	$(AR) cr ${exte} $^
${proj}: lib.o ${exte}
	${OLINK} lib.oc.log util.oc.log
	$(CC) ${linkerflags} -shared $< -o $@ -L. -l:${exte} -Wl,--exclude-libs ${exte} #will not work with util.o instead of libexte.a, will be global

clean:
	rm -f lib.c lib.oc.log lib.oc.x lib.o
	rm -f util.c util.oc.log util.oc.x util.o
	rm -f ${com}.h ${com}.ohi ${com}.ohi.x
	rm -f ${cores}.h ${cores}.ohi ${cores}.ohi.x
	rm -f ${core}.h ${core}.ohi ${core}.ohi.x
	rm -f ${proj} ${exte}

.PHONY: all clean
