ARDUINO_LIBS = EEPROM Servo SPI FrequencyTimer2 Wire
OTHER_LIBS = bitlash Adafruit_MCP23017 Adafruit_DotStar
ARDUINO_SKETCHBOOK = ../
EXTRA_FLAGS = -DIR_RAWBUF=256 -DBITLASH_INTERNAL -DBITLASH_PROMPT='">\r\n"' -DBITLASH_TXEN=bitlash_txen \
			  -DSHELL_REBOOT -DSHELL_EEPROM -DHMO_LED=9
ARDUINO_DIR=../../ide

ISP_PROG = stk500v1
ISP_PORT = /dev/ttyUSB0
AVRDUDE_ISP_BAUDRATE = 19200

ifeq ($(type),)
EXTRA_FLAGS += -DHMO_AUTO
endif
ifeq ($(type),body)
EXTRA_FLAGS += -DHMO_BODY
endif
ifeq ($(type),eyepiece)
EXTRA_FLAGS += -DHMO_EYEPIECE
endif

ifeq ($(board),)

USER_LIBS = $(OTHER_LIBS)
EXTRA_FLAGS += -DLAYOUT_US_ENGLISH -DUSB_SERIAL -DSHELL_BAUDRATE=384000

include ../Teensy.mk

else

ARDUINO_LIBS += $(OTHER_LIBS)
EXTRA_FLAGS += -DTINY_BUILD -DUSER_FUNCTIONS

ifeq ($(board),pro2)
    override board = pro5v328
	EXTRA_FLAGS += -DBOARD_PRO2
endif
ifeq ($(board),nano3)
    override board = nano328
endif
BOARD_TAG = $(board)

include ../Arduino-Makefile/Arduino.mk

endif
