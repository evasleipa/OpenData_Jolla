/****************************************************************************************
**
** Copyright (C) 2013 Jolla Ltd.
** Contact: Vesa-Matti Hartikainen <vesa-matti.hartikainen@jollamobile.com>
** All rights reserved.
**
** This file is part of Sailfish Silica UI component package.
**
** You may use this file under the terms of BSD license as follows:
**
** Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are met:
**     * Redistributions of source code must retain the above copyright
**       notice, this list of conditions and the following disclaimer.
**     * Redistributions in binary form must reproduce the above copyright
**       notice, this list of conditions and the following disclaimer in the
**       documentation and/or other materials provided with the distribution.
**     * Neither the name of the Jolla Ltd nor the
**       names of its contributors may be used to endorse or promote products
**       derived from this software without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
** ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
** DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
** ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
** ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
** SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
****************************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0
import "pages"

ApplicationWindow {
    id: mainWindow

    property string city_name: "";

    property string first: "";
    property string second: "";
    property string today_text: "";
    property string tomorrow_text: "";
    property string temp_today: "";
    property string temp_next: "";


    initialPage: Qt.resolvedUrl("pages/SearchPage.qml")
    cover: CoverBackground {
        Column {
            anchors.centerIn: parent
            Label{
                id: cover_cont_city
                text: ""
            }
            Label{
                id: cover_cont
                text: ""
            }
            Label{
                id: cover_cont_temp
                text: ""
            }

            Image {
                id: coverImage
                height: Theme.itemSizeLarge
                width: Theme.itemSizeLarge
            }

        }
        Loader
       {
       id: myLoader
       source: "pages/FirstPage.qml"
       }
        CoverActionList {
                id: coverAction

                CoverAction {
                    iconSource: "image://theme/icon-cover-previous"
                    onTriggered: {
                        Connections
                       {
                            target: myLoader.item.changeCoverP();
                       }
                    }
                }

                CoverAction {
                    iconSource: "image://theme/icon-cover-next"
                    onTriggered: {
                        Connections
                       {
                            target: myLoader.item.changeCoverN();
                       }
                    }
                }
            }
    }
}

