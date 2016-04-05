/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
** Contact: http://www.qt.io/ or http://www.pelagicore.com/
**
** This file is part of the QmlLive tool.
**
** $QT_BEGIN_LICENSE:GPL3-PELAGICORE$
** Commercial License Usage
** Licensees holding valid commercial Pelagicore QmlLive
** licenses may use this file in accordance with the commercial license
** agreement provided with the Software or, alternatively, in accordance
** with the terms contained in a written agreement between you and
** Pelagicore. For licensing terms and conditions, contact us at:
** http://www.pelagicore.com.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU General Public License version 3 requirements will be
** met: http://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
** SPDX-License-Identifier: GPL-3.0
**
****************************************************************************/

#pragma once

#include <QtCore>
#include <QAbstractSocket>

class LiveHubEngine;
class IpcClient;

class RemotePublisher : public QObject
{
    Q_OBJECT
public:
    explicit RemotePublisher(QObject *parent = 0);
    void connectToServer(const QString& hostName, int port);
    QString errorToString(QAbstractSocket::SocketError error);
    QAbstractSocket::SocketState state() const;

    void registerHub(LiveHubEngine *hub);
Q_SIGNALS:
    void connected();
    void disconnected();
    void sentSuccessfully(const QUuid& uuid);
    void sendingError(const QUuid& uuid, QAbstractSocket::SocketError socketError);
    void connectionError(QAbstractSocket::SocketError error);
    void needsPinAuthentication();
    void pinOk(bool ok);
    void remoteLog(int type, const QString &msg, const QUrl &url = QUrl(), int line = -1, int column = -1);

public Q_SLOTS:
    void setWorkspace(const QString &path);
    void disconnectFromServer();
    QUuid activateDocument(const QString& document);
    QUuid sendDocument(const QString& document);
    QUuid checkPin(const QString& pin);
    QUuid setXOffset(int offset);
    QUuid setYOffset(int offset);
    QUuid setRotation(int rotation);

private Q_SLOTS:
    void handleCall(const QString &method, const QByteArray &content);
    QUuid sendWholeDocument(const QString &document);

    void onSentSuccessfully(const QUuid& uuid);
    void onSendingError(const QUuid& uuid, QAbstractSocket::SocketError socketError);

private:
    IpcClient *m_ipc;
    LiveHubEngine *m_hub;
    QDir m_workspace;

    QHash<QUuid, QString> m_packageHash;
};