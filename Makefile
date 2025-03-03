
${OCOMP} lib.oc x_file 2
${OLINK}
${OCONV} lib.oc.x
$(CC) ${linkerflags} -shared lib.c -o liborb.so
$(CC) -g a.c -L. -lorb `pkg-config --libs ruby-3.5`
LD_LIBRARY_PATH=./ ./a.out
