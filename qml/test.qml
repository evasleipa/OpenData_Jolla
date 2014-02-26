/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0


<<<<<<< Updated upstream
ApplicationWindow
{
    XmlListModel {
        id: forecast
        source: "http://api.openweathermap.org/data/2.5/forecast/daily?q=Lappeenranta,fi&units=metric&mode=xml"
        query: "/weatherdata/forecast/time"

        XmlRole {
            name: "day"
            query: "@day/string()"
        }
        XmlRole {
            name: "temperature"
            query: "temperature/@day/string()"
        }
        XmlRole {
            name: "symbol"
            query: "symbol/@var/string()"
        }



        onStatusChanged: {
                    if (status === XmlListModel.Ready) {
                        var today = get(0)
                        coverImage.source = "http://openweathermap.org/img/w/" + today.symbol + ".png"
                    }
                }
    }
=======
ApplicationWindow {
    id: mainWindow




    initialPage: Qt.resolvedUrl("pages/SearchPage.qml")
//    cover: Qt.resolvedUrl("pages/Cover.qml")
    cover: CoverBackground {

            Column {
                anchors.centerIn: parent
                Image {
                    id: coverImage
                    height: Theme.itemSizeLarge
                    width: Theme.itemSizeLarge

                }

            }



            CoverActionList {
                    id: coverAction
                    signal doge()

                    CoverAction {
                        iconSource: "image://theme/icon-cover-next"
                        onTriggered:{
                            console.log("RASSE PRKL!")
                            coverAction.doge.connect(FirstPage.forecast.changeDay)
                            coverAction.doge()



                        }


                    }

                    CoverAction {
                        iconSource: "image://theme/icon-cover-pause"
                    }
                }
        }
>>>>>>> Stashed changes

    initialPage: Page {

            SilicaListView {
                anchors.fill: parent
                spacing: Theme.paddingLarge

                model: forecast

                delegate: ListItem {
                    Row {
                        Image {
                            height: Theme.itemSizeLarge
                            width: Theme.itemSizeLarge
                            source: "http://openweathermap.org/img/w/" + model.symbol + ".png"
                        }
                        Column {
                            Label {
                                text: model.day
                            }
                            Label {
                                text: model.temperature
                            }
                        }
                    }
                }
            }
        }

        cover: CoverBackground {
            Column {
                anchors.centerIn: parent
                Image {
                    id: coverImage
                    height: Theme.itemSizeLarge
                    width: Theme.itemSizeLarge
                }

            }
        }
}


