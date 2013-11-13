# Makefile for MAST Arduino Sailcode

CC=avr-g++
CFLAGS=-mmcu=atmega2560 -Wall -Wextra -Os
# We can't use -Werror because using the deprecated prog_* types generates warnings
ARDUINO_DIR=~/arduino
# The above should probably be changed to /usr/include or something
ARDUINO_DOT_H_DIR=$(ARDUINO_DIR)/hardware/arduino/cores/arduino/
ARDUINO_PINS_DIR=$(ARDUINO_DIR)/hardware/arduino/variants/mega/
AVR_LIB_DIR=~/local/avr/avr/include/
LIB_DIR=arduino/lib/

all: 
	$(CC) $(CFLAGS) arduino/src/arduino.cpp -o sailcode -I $(LIB_DIR)/ashcon \
	-I $(LIB_DIR)/aprintf -I $(LIB_DIR)/pololu_controller -I $(LIB_DIR)/RC \
	-I $(LIB_DIR)/motorWrappers -I $(LIB_DIR)/PololuServo -I $(LIB_DIR)/MemoryFree \
	-I $(AVR_LIB_DIR) -I $(ARDUINO_DOT_H_DIR) -I $(ARDUINO_PINS_DIR) \
	-D __PROG_TYPES_COMPAT__
# The prog_* data types are deprecated, so we set __PROG_TYPES_COMPAT__ to allow them

clean:
	rm sailcode *.o
