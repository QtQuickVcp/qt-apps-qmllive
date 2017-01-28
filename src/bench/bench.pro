TEMPLATE = app
TARGET = qmllivebench
DESTDIR = $$BUILD_DIR/bin

QT *= gui core quick widgets core-private svg

SOURCES += \
    main.cpp \
    mainwindow.cpp \
    optionsdialog.cpp \
    benchlivenodeengine.cpp \
    previewimageprovider.cpp \
    directorypreviewadapter.cpp \
    qmlpreviewadapter.cpp \
    benchquickview.cpp \
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
    mainwindow.h \
    optionsdialog.h \
    benchlivenodeengine.h \
    previewimageprovider.h \
    directorypreviewadapter.h \
    qmlpreviewadapter.h \
    benchquickview.h \
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
include(../src.pri)

OTHER_FILES += \
    ../../misc/*.*

windows: {
    RC_FILE = ../../icons/appicon.rc
}

macx: {
    ICON = ../../icons/appicon.icns
    QMAKE_POST_LINK += $$QMAKE_COPY $$ICON $${TARGET}.app/Contents/Resources/qmllivebench.icns
}

linux: !android: {
target.path = /usr/bin

desktop.path = /usr/share/applications
desktop.files = ../../misc/qmllivebench.desktop

icon.path = /usr/share/pixmaps
icon.files = ../../icons/qmllivebench.png

INSTALLS += target desktop icon
}
