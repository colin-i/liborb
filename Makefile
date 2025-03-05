

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
OFLAGS=x_file 2

core=orb
cores=${core}s
proj=lib${core}.so

all: ${proj}

%.ohi: %.oh
	echo "format elfobj64" > $@
	echo "orphan off" >> $@
	echo "override include_sec 1" >> $@
	cat $< >> $@
%.h: %.ohi
	${OCOMP} $< ${OFLAGS} logfile 0
	${OCONV} $<.x

${core}.h: ${cores}.h
${proj}: ${core}.h
	${OCOMP} lib.oc ${OFLAGS}
	${OLINK} lib.oc.log
	${OCONV} lib.oc.x
	$(CC) ${linkerflags} -shared -w lib.c -o $@

clean:
	rm -f lib.c lib.oc.log lib.oc.x ${proj} ${core}.h ${core}.ohi ${core}.ohi.x ${cores}.h ${cores}.ohi ${cores}.ohi.x

.PHONY: clean
