TARGETS=hello.hex

all: $(TARGETS)

clean:
	rm -f $(TARGETS)
	rm -f *.lst *.bin *.hex *.rel *.sym

world: clean all

%.bin: %.asm
	z80asm $< -o $@ --list=$(basename $@).lst

%.hex: %.bin
	objcopy -I binary -O ihex $< $@
