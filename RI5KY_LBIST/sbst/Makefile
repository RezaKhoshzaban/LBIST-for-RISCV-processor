PROGRAM_NAME = sbst

RISCV                    ?= ~/.riscv
RISCV_EXE_PREFIX         = $(RISCV)/bin/riscv32-unknown-elf-

all: $(PROGRAM_NAME).hex

$(PROGRAM_NAME).elf: crt0.S main.c syscalls.c vectors.S sbst_boot.S
	$(RISCV_EXE_PREFIX)gcc -march=rv32imc -o $@ -w -Os -g -nostdlib \
		-Xlinker -Map=$(PROGRAM_NAME).map \
		-T link.ld \
		-static \
		$^  \
		-I $(RISCV)/riscv32-unknown-elf/include \
		-L $(RISCV)/riscv32-unknown-elf/lib \
		-lc -lm -lgcc

%.hex: %.elf
	$(RISCV_EXE_PREFIX)objcopy -O verilog $< $@

clean:
	rm -rf $(PROGRAM_NAME).elf $(PROGRAM_NAME).hex $(PROGRAM_NAME).map

