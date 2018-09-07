THEOS_DEVICE_IP = 192.168.100.126
THEOS_DEVICE_PORT = 6789
ARCHS = armv7 armv7s arm64
TARGET = iphone:10.2:10.0
GO_EASY_ON_ME = 1
ADDITIONAL_LDFLAGS = -L/Volumes/MacData/Projects/myprojects/TweakApp/obj/debug

include $(THEOS)/makefiles/common.mk

#]$(error $(_THEOS_INTERNAL_CFLAGS))

TWEAK_NAME = wsmsgpreview
$(TWEAK_NAME)_FILES = VoiceMessageViewModel.xm BaseMsgContentViewController.xm
$(TWEAK_NAME)_FRAMEWORKS = UIKit Foundation
#wsmsgpreview_CFLAGS = -fobjc-arc


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 WeChat"
