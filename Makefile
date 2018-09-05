THEOS_DEVICE_IP = 192.168.100.126
THEOS_DEVICE_PORT = 6789
ARCHS = armv7 armv7s arm64
TARGET = iphone:10.2:10.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = wsmsgpreview
wsmsgpreview_FILES = Tweak.xm
wsmsgpreview_FRAMEWORKS = UIKit Foundation
#wsmsgpreview_CFLAGS = -fobjc-arc


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 WeChat"
