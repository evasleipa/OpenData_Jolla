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


Page {
    id: page

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

<<<<<<< Updated upstream
        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Show Page 2"
                onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            }
        }
=======

Page
{
    id:pagu
    property string city: ""


    XmlListModel {


        id: forecast
        source: "http://api.openweathermap.org/data/2.5/forecast/daily?q=" + city +",fi&units=metric&mode=xml"
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
                console.log("today on" + today.symbol)
                coverImage.source = "http://openweathermap.org/img/w/" + today.symbol + ".png"
            }
        }


        function changeDay(){
            console.log("JEEEEE")
        }


    }

    onDoge: console.log("jkngjndgr")


    Column {
        PageHeader {
            title: city
        }



        SilicaGridView {

                width: 540;
                height: 960;


                cellHeight: 140
                cellWidth:180
                model: forecast

                delegate: ListItem {

                    function correctColor(temp)
                    {
                        var temp = parseFloat(temp);



                        if(temp > 30){temp = 30;}
                        else if(temp < -30){temp = -30;}

                        var hue = 30 + 240 * (30 - temp) / 60;






                        function hsvToRgb(h, s, v){
                            var r, g, b;

                            var i = Math.floor(h * 6);
                            var f = h * 6 - i;
                            var p = v * (1 - s);
                            var q = v * (1 - f * s);
                            var t = v * (1 - (1 - f) * s);

                            switch(i % 6){
                                case 0: r = v, g = t, b = p; break;
                                case 1: r = q, g = v, b = p; break;
                                case 2: r = p, g = v, b = t; break;
                                case 3: r = p, g = q, b = v; break;
                                case 4: r = t, g = p, b = v; break;
                                case 5: r = v, g = p, b = q; break;
                            }

                            return [r * 255, g * 255, b * 255];
                        }



                        var rgb_array = hsvToRgb((hue/360),1.0, 1.0);
                        var r_a = rgb_array[0];
                        var g_a = rgb_array[1];
                        var b_a = rgb_array[2];

                        r_a = Math.floor(r_a);
                        g_a = Math.floor(g_a);
                        b_a = Math.floor(b_a);


>>>>>>> Stashed changes

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: "UI Template"
            }
            Label {
                x: Theme.paddingLarge
                text: "Hello Sailors"
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }
        }
    }
}


