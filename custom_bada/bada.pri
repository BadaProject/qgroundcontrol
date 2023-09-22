message("Adding Custom Plugin")

#-- Version control
#   Major and minor versions are defined here (manually)

CUSTOM_QGC_VER_MAJOR = 0
CUSTOM_QGC_VER_MINOR = 0
CUSTOM_QGC_VER_FIRST_BUILD = 0

# Build number is automatic
# Uses the current branch. This way it works on any branch including build-server's PR branches
CUSTOM_QGC_VER_BUILD = $$system(git --git-dir ../.git rev-list $$GIT_BRANCH --first-parent --count)
win32 {
    CUSTOM_QGC_VER_BUILD = $$system("set /a $$CUSTOM_QGC_VER_BUILD - $$CUSTOM_QGC_VER_FIRST_BUILD")
} else {
    CUSTOM_QGC_VER_BUILD = $$system("echo $(($$CUSTOM_QGC_VER_BUILD - $$CUSTOM_QGC_VER_FIRST_BUILD))")
}
CUSTOM_QGC_VERSION = $${CUSTOM_QGC_VER_MAJOR}.$${CUSTOM_QGC_VER_MINOR}.$${CUSTOM_QGC_VER_BUILD}

DEFINES -= APP_VERSION_STR=\"\\\"$$APP_VERSION_STR\\\"\"
DEFINES += APP_VERSION_STR=\"\\\"$$CUSTOM_QGC_VERSION\\\"\"

message(Custom QGC Version: $${CUSTOM_QGC_VERSION})

# Build a single flight stack by disabling APM support
MAVLINK_CONF = common
CONFIG  += QGC_DISABLE_APM_MAVLINK
CONFIG  += QGC_DISABLE_APM_PLUGIN QGC_DISABLE_APM_PLUGIN_FACTORY

# We implement our own PX4 plugin factory
CONFIG  += QGC_DISABLE_PX4_PLUGIN_FACTORY

# Branding

DEFINES += CUSTOMHEADER=\"\\\"BadaPlugin.h\\\"\"
DEFINES += CUSTOMCLASS=BadaPlugin

TARGET   = CustomQGroundControl
DEFINES += QGC_APPLICATION_NAME='"\\\"Bada GroundControl\\\""'

DEFINES += QGC_ORG_NAME=\"\\\"bada.kr\\\"\"
DEFINES += QGC_ORG_DOMAIN=\"\\\"kr.bada\\\"\"

QGC_APP_NAME        = "Bada GroundControl"
QGC_BINARY_NAME     = "Bada GroundControl"
QGC_ORG_NAME        = "Bada"
QGC_ORG_DOMAIN      = "kr.bada"
QGC_ANDROID_PACKAGE = "kr.bada"
QGC_APP_DESCRIPTION = "Bada GroundControl"
QGC_APP_COPYRIGHT   = "Copyright (C) 2023 Bada Development Team. All rights reserved."

# Our own, custom resources
RESOURCES += \
    $$PWD/bada.qrc

QML_IMPORT_PATH += \
   $$PWD/res

# Our own, custom sources
SOURCES += \
    $$PWD/src/BadaPlugin.cc \

HEADERS += \
    $$PWD/src/BadaPlugin.h \

INCLUDEPATH += \
    $$PWD/src \

#-------------------------------------------------------------------------------------
# Bada Firmware/AutoPilot Plugin

INCLUDEPATH += \
    $$PWD/src/FirmwarePlugin \
    $$PWD/src/AutoPilotPlugin

HEADERS+= \
    $$PWD/src/AutoPilotPlugin/BadaAutoPilotPlugin.h \
    $$PWD/src/FirmwarePlugin/BadaFirmwarePlugin.h \
    $$PWD/src/FirmwarePlugin/BadaFirmwarePluginFactory.h \

SOURCES += \
    $$PWD/src/AutoPilotPlugin/BadaAutoPilotPlugin.cc \
    $$PWD/src/FirmwarePlugin/BadaFirmwarePlugin.cc \
    $$PWD/src/FirmwarePlugin/BadaFirmwarePluginFactory.cc \

