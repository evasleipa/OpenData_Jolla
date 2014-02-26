/****************************************************************************************
**
** Copyright (C) 2013 Jolla Ltd.
** Contact: Joona Petrell <joona.petrell@jollamobile.com>
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

Page {


    id: searchPage

    property string searchString
    property bool keepSearchFieldFocus
    property string activeView: "list"

    onSearchStringChanged: listModel.update()
    Component.onCompleted: listModel.update()

    Loader {
        anchors.fill: parent
        sourceComponent: activeView == "list" ? listViewComponent : gridViewComponent

    }

    Column {
        id: headerContainer

        width: searchPage.width

        PageHeader {
            title: "Cities"
        }

        SearchField {
            id: searchField
            width: parent.width

            Binding {
                target: searchPage
                property: "searchString"
                value: searchField.text.toLowerCase().trim()
            }
        }
    }

    Component {
        id: gridViewComponent
        SilicaGridView {
            id: gridView
            model: listModel
            anchors.fill: parent
            currentIndex: -1
            header: Item {
                id: header
                width: headerContainer.width
                height: headerContainer.height
                Component.onCompleted: headerContainer.parent = header
            }

            cellWidth: gridView.width / 3
            cellHeight: cellWidth

            PullDownMenu {
                MenuItem {
                    text: "Switch to list"
                    onClicked: {
                        keepSearchFieldFocus = searchField.activeFocus
                        activeView = "list"
                    }
                }
            }

            delegate: BackgroundItem {
                id: rectangle
                width: gridView.cellWidth
                height: gridView.cellHeight
                GridView.onAdd: AddAnimation {
                    target: rectangle
                }
                GridView.onRemove: RemoveAnimation {
                    target: rectangle
                }

                OpacityRampEffect {
                    sourceItem: label
                    offset: 0.5
                }

                Label {
                    id: label
                    x: Theme.paddingMedium; y: Theme.paddingLarge
                    width: parent.width - y
                    textFormat: Text.StyledText
                    color: searchString.length > 0 ? (highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor)
                                                   : (highlighted ? Theme.highlightColor : Theme.primaryColor)

                    text: Theme.highlightText(model.text, searchString, Theme.highlightColor)
                    font {
                        pixelSize: Theme.fontSizeLarge
                        family: Theme.fontFamilyHeading
                    }

                }


                MouseArea{
                        anchors.fill: parent
                        onClicked:  {
                            pageStack.pushAttached(Qt.resolvedUrl("FirstPage.qml"), {city: model.text});
                            pageStack.navigateForward(PageStackAction.Animate);

                        }
                    }
            }

            VerticalScrollDecorator {}

            Component.onCompleted: {
                if (keepSearchFieldFocus) {
                    searchField.forceActiveFocus()
                }
                keepSearchFieldFocus = false
            }
        }
    }

    Component {
        id: listViewComponent
        SilicaListView {
            model: listModel
            anchors.fill: parent
            currentIndex: -1 // otherwise currentItem will steal focus

            header:  Item {
                id: header
                width: headerContainer.width
                height: headerContainer.height
                Component.onCompleted: headerContainer.parent = header


            }


            PullDownMenu {
                MenuItem {
                    text: "Switch to grid"
                    onClicked: {
                        keepSearchFieldFocus = searchField.activeFocus
                        activeView = "grid"
                    }
                }


            }

            delegate: BackgroundItem {
                id: backgroundItem

                ListView.onAdd: AddAnimation {
                    target: backgroundItem
                }
                ListView.onRemove: RemoveAnimation {
                    target: backgroundItem
                }

                Label {
                    x: searchField.textLeftMargin
                    anchors.verticalCenter: parent.verticalCenter
                    color: searchString.length > 0 ? (highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor)
                                                   : (highlighted ? Theme.highlightColor : Theme.primaryColor)
                    textFormat: Text.StyledText
                    text: Theme.highlightText(model.text, searchString, Theme.highlightColor)
                }
                MouseArea{
                        anchors.fill: parent
                        onClicked:  {
                            pageStack.pushAttached(Qt.resolvedUrl("FirstPage.qml"), {city: model.text});
                            pageStack.navigateForward(PageStackAction.Animate);

                        }
                    }
            }

            VerticalScrollDecorator {}

            Component.onCompleted: {
                if (keepSearchFieldFocus) {
                    searchField.forceActiveFocus()
                }
                keepSearchFieldFocus = false
            }
        }
    }

    ListModel {
        id: listModel


        property variant cities: ["Akaa","Alajärvi","Alavus","Espoo","Forssa",
            "Haapajärvi","Haapavesi","Hamina","Hanko","Harjavalta","Heinola",
            "Helsinki","Huittinen","Hyvinkää","Hämeenlinna","Iisalmi","Ikaalinen",
            "Imatra","Joensuu","Juankoski","Jyväskylä","Jämsä","Järvenpää","Kaarina",
            "Kajaani","Kalajoki","Kankaanpää","Kannus","Karkkila","Kaskinen",
            "Kauhajoki","Kauhava","Kauniainen","Kemi","Kemijärvi","Kerava","Keuruu",
            "Kitee","Kiuruvesi","Kokemäki","Kokkola","Kotka","Kouvola",
            "Kristiinankaupunki","Kuhmo","Kuopio","Kurikka","Kuusamo","Lahti",
            "Laitila","Lappeenranta","Lapua","Lieksa","Lohja","Loimaa","Loviisa",
            "Maarianhamina","Mikkeli","Mänttä-Vilppula","Naantali","Nivala","Nokia",
            "Nurmes","Närpiö","Orimattila","Orivesi","Oulainen","Oulu","Outokumpu",
            "Paimio","Parainen","Parkano","Pieksämäki","Pietarsaari","Pori","Porvoo",
            "Pudasjärvi","Pyhäjärvi","Raahe","Raasepori","Raisio","Rauma","Riihimäki",
            "Rovaniemi","Saarijärvi","Salo","Sastamala","Savonlinna","Seinäjoki",
            "Somero","Suonenjoki","Tampere","Tornio","Turku","Ulvila","Uusikaarlepyy",
            "Uusikaupunki","Vaasa","Valkeakoski","Vantaa","Varkaus","Viitasaari",
            "Virrat","Ylivieska","Ylöjärvi","Ähtäri","Äänekoski"]

        function update() {
            var filteredCities = cities.filter(function (city) { return city.toLowerCase().indexOf(searchString) !== -1 })
            while (count > filteredCities.length) {
                remove(filteredCities.length)
            }
            for (var index = 0; index < filteredCities.length; index++) {
                if (index < count) {
                    setProperty(index, "text", filteredCities[index])
                } else {
                    append({ "text": filteredCities[index]})
                }
            }
        }
    }
}
