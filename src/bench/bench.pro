include(../../qmllive.pri)

TEMPLATE = app
TARGET = qmllivebench
DESTDIR = $$BUILD_DIR/bin

CONFIG += c++11
QT *= gui core quick widgets core-private svg

SOURCES += \
    aboutdialog.cpp \
    main.cpp \
    mainwindow.cpp \
    optionsdialog.cpp \
    benchlivenodeengine.cpp \
    previewimageprovider.cpp \
    directorypreviewadapter.cpp \
    qmlpreviewadapter.cpp \
    host.cpp \
    hostmodel.cpp \
    hostwidget.cpp \
    dummydelegate.cpp \
    allhostswidget.cpp \
    hostmanager.cpp \
    hostsoptionpage.cpp \
    httpproxyoptionpage.cpp \
    importpathoptionpage.cpp \
    hostdiscoverymanager.cpp \
    autodiscoveryhostsdialog.cpp \
    options.cpp

HEADERS += \
    aboutdialog.h \
    mainwindow.h \
    optionsdialog.h \
    benchlivenodeengine.h \
    previewimageprovider.h \
    directorypreviewadapter.h \
    qmlpreviewadapter.h \
    host.h \
    hostmodel.h \
    hostwidget.h \
    dummydelegate.h \
    allhostswidget.h \
    hostmanager.h \
    hostsoptionpage.h \
    importpathoptionpage.h \
    httpproxyoptionpage.h \
    hostdiscoverymanager.h \
    autodiscoveryhostsdialog.h \
    options.h

FORMS += \
    optionsdialog.ui \
    hostsoptionpage.ui \
    httpproxyoptionpage.ui \
    importpathoptionpage.ui \
    autodiscoveryhostsdialog.ui

include(../widgets/widgets.pri)
include(../lib.pri)

# install rules
macx*: CONFIG -= app_bundle
target.path = $$PREFIX/bin
INSTALLS += target

OTHER_FILES += \
    $$PWD/../../misc/*.*

windows: {
    RC_FILE = $$PWD/../../icons/appicon.rc
}

macx*: {
    ICON = $$PWD/../../icons/appicon.icns
    QMAKE_POST_LINK += $$QMAKE_COPY $$ICON $${TARGET}.app/Contents/Resources/qmllivebench.icns
}

linux: !android: {
desktop.path = /usr/share/applications
desktop.files = $$PWD/../../misc/qmllivebench.desktop

icon.path = /usr/share/pixmaps
icon.files = $$PWD/../../icons/qmllivebench.png

INSTALLS += desktop icon
}
