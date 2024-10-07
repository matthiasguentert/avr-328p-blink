CC=avr-gcc
OBJCOPY=avr-objcopy

CFLAGS=-Os -DF_CPU=8000000UL -mmcu=atmega328p
PORT=/dev/ttyUSB0
PART=m328p
BAUDRATE=57600

main.hex: main.elf
	${OBJCOPY} -O ihex -R .eeprom main.elf main.hex

main.elf: main.o
	${CC} ${CFLAGS} -o main.elf main.o

main.o: main.c
	${CC} ${CFLAGS} -c main.c

flash: main.hex
	avrdude -C /usr/local/etc/avrdude.conf -v -p ${PART} -c arduino -P ${PORT} -b ${BAUDRATE} -D -U flash:w:main.hex:i

clean:
	rm -f main.o main.elf main.hex

