CC=gcc
STRIP=strip --strip-all
CFLAGS=-O2

all: bf bf16 bfstrip bf2bs bf2bs-raw bfmt

dir:
	mkdir -vp bin/$(ARCH)

bf: dir
	$(CC) $(CFLAGS) -o bin/$@ brainfuck/LostKingdomBF/bftools/bf.c
# 	$(STRIP) bin/$@

bf16: dir
	$(CC) $(CFLAGS) -o bin/$@ brainfuck/LostKingdomBF/bftools/bf16.c
# 	$(STRIP) bin/$@

bfstrip: dir
	$(CC) $(CFLAGS) -o bin/$@ brainfuck/LostKingdomBF/bftools/bfstrip.c
# 	$(STRIP) bin/$@

bf2bs: dir
	$(CC) $(CFLAGS) -o bin/$@ tools/bf2bs.c
# 	$(STRIP) bin/$@

bf2bs-raw: dir
	$(CC) $(CFLAGS) -o bin/$@ tools/bf2bs-raw.c
# 	$(STRIP) bin/$@

bfmt: dir
	$(CC) $(CFLAGS) -o bin/$@ tools/bfmt.c
# 	$(STRIP) bin/$@

clean:
	rm -rvf bin/bf bin/bf16 bin/bfstrip bin/bf2bs bin/bf2bs-raw bin/bfmt
