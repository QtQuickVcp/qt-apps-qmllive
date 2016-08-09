/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
** Contact: https://www.qt.io/licensing/
**
** This file is part of the QmlLive tool.
**
** $QT_BEGIN_LICENSE:GPL-QTAS$
** Commercial License Usage
** Licensees holding valid commercial Qt Automotive Suite licenses may use
** this file in accordance with the commercial license agreement provided
** with the Software or, alternatively, in accordance with the terms
** contained in a written agreement between you and The Qt Company.  For
** licensing terms and conditions see https://www.qt.io/terms-conditions.
** For further information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
** SPDX-License-Identifier: GPL-3.0
**
****************************************************************************/

//![0]
#include <QtGui>
#include <QtQuick>

// Use QmlLive headers
#include "livenodeengine.h"
#include "remotereceiver.h"

class MyView : public QQuickView
{
    Q_OBJECT

public:
    MyView(); // Perform some setup here
};

int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);

    MyView view;

    LiveNodeEngine node;
    // Let qml live instrument your view
    node.setView(&view);
    // Tell it where file updates should be stored relative to
    node.setWorkspace(".");
    // For local usage use the LocalPublisher
    RemoteReceiver receiver;
    receiver.registerNode(&node);
    // Listen to ipc call from remote
    receiver.listen(10234);

    view.show();

    return app.exec();
}
//![0]

MyView::MyView()
{
    QStringList colors;
    colors.append(QStringLiteral("red"));
    colors.append(QStringLiteral("green"));
    colors.append(QStringLiteral("blue"));
    colors.append(QStringLiteral("black"));
    rootContext()->setContextProperty("myColors", colors);

    setResizeMode(QQuickView::SizeViewToRootObject);
    setSource(QUrl::fromLocalFile("main.qml"));
};

#include "main.moc"