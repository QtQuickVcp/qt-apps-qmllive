include(qmllive.pri)

!minQtVersion(5, 1, 1):error("You need at least Qt 5.1.1 to build this application")

TEMPLATE = subdirs


SUBDIRS += \
    src \
    # tests

exists($$[QT_INSTALL_BINS]/qdoc) {
    exists($$[QT_INSTALL_BINS]/qhelpgenerator) {
        message ("Using qdoc/qhelpgenerator in QTDIR for generating docs")
        QDOC = $$[QT_INSTALL_BINS]/qdoc
        QHELPGENERATOR = $$[QT_INSTALL_BINS]/qhelpgenerator
    } else {
        message ("Trying to use system qdoc/qhelpgenerator for generating docs")
        QDOC = qdoc
        QHELPGENERATOR = qhelpgenerator
    }
} else {
    message ("Trying to use system qdoc/qhelpgenerator for generating docs")
    QDOC = qdoc
    QHELPGENERATOR = qhelpgenerator
}


html-docs.files = $$PWD/doc/html

html-docs.commands = QT_INSTALL_DOCS=$$[QT_INSTALL_DOCS] $$QDOC $$PWD/doc/qmllive.qdocconf
html-docs.files = $$PWD/doc/html

qch-docs.commands = $$QHELPGENERATOR $$PWD/doc/html/qmllive.qhp -o $$PWD/doc/html/qmllive.qch
qch-docs.files = $$PWD/docs/qch
qch-docs.CONFIG += no_check_exist directory

docs.depends = html-docs qch-docs

QMAKE_EXTRA_TARGETS += html-docs qch-docs docs
