# Makefile for MAST Arduino Sailcode

CC=avr-g++
CFLAGS=-mmcu=atmega2560 -Wall -Wextra -Os
#We can't use -Werror because using the deprecated prog_* types generates warnings
ARDUINO_DIR=~/arduino
# The above should probably be changed to /usr/include or something
ARDUINO_DOT_H_DIR=$(ARDUINO_DIR)/hardware/arduino/cores/arduino/
ARDUINO_PINS_DIR=$(ARDUINO_DIR)/hardware/arduino/variants/mega/
AVR_LIB_DIR=~/local/avr/avr/include/

all: ashcon.o aprintf.o
	$(CC) $(CFLAGS) arduino/src/arduino.cpp -o main

ashcon.o: aprintf.o
	$(CC) $(CFLAGS) arduino/lib/ashcon/ashcon.cpp \
	-I $(ARDUINO_DOT_H_DIR) -I $(ARDUINO_PINS_DIR)

aprintf.o:
	$(CC) $(CFLAGS) arduino/lib/aprintf/aprintf.cpp \
	-I $(AVR_LIB_DIR) -I $(ARDUINO_DOT_H_DIR) -I $(ARDUINO_PINS_DIR) \
	-D __PROG_TYPES_COMPAT__
# The prog_* data types are deprecated, we use __PROG_TYPES_COMPAT__ to allow them

clean:
	rm main *.o
