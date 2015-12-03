PROJECT = main



$(PROJECT).bin: main.o system.o startup_stm32f401xe.o

	arm-none-eabi-gcc -mcpu=cortex-m4 -mlittle-endian -mthumb -DSTM32F401xE -TSTM/Projects/STM32F401RE-Nucleo/Templates/TrueSTUDIO/STM32F4xx-Nucleo/STM32F401CE_FLASH.ld -Wl,--gc-sections system.o main.o startup_stm32f401xe.o -o main.elf

	arm-none-eabi-objcopy -Oihex main.elf main.hex

%.o: %.c 

	arm-none-eabi-gcc -lc -Wall -mcpu=cortex-m4 -mlittle-endian -mthumb -ISTM/Drivers/CMSIS/Device/ST/STM32F4xx/Include	-ISTM/Drivers/CMSIS/Include -DSTM32F401xE -Os -c system.c -o system.o
	arm-none-eabi-gcc -lc -Wall -mcpu=cortex-m4 -mlittle-endian -mthumb -ISTM/Drivers/CMSIS/Device/ST/STM32F4xx/Include -ISTM/Drivers/CMSIS/Include -DSTM32F401xE -Os -c main.c -o main.o 
	arm-none-eabi-gcc -lc -Wall -mcpu=cortex-m4 -mlittle-endian -mthumb -ISTM/Drivers/CMSIS/Device/ST/STM32F4xx/Include -ISTM/Drivers/CMSIS/Include -DSTM32F401xE -Os -c startup_stm32f401xe.s -o startup_stm32f401xe.o

clean:

	find ./ -name '*~' | xargs rm -f
	find ./ -name '*.o' | xargs rm -f
	find ./ -name '*.d' | xargs rm -f
	find ./ -name '*.elf' | xargs rm -f
	find ./ -name '*.bin' | xargs rm -f
	find ./ -name '*.map' | xargs rm -f

install: $(PROJECT).bin

	openocd -f /usr/share/openocd/scripts/board/st_nucleo_f4.cfg
