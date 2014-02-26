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
import QtGraphicalEffects 1.0





Page
{
    id: page
    property string city: ""
    allowedOrientations: Orientation.Portrait | Orientation.Landscape
    XmlListModel {
            id: forecast
            source: "http://api.openweathermap.org/data/2.5/forecast/daily?q=" + city +",fi&units=metric&mode=xml&cnt=6"
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
            XmlRole {
                name: "windDirection"
                query: "windDirection/@name/string()"
            }
            XmlRole {
                name: "windSpeed_name"
                query: "windSpeed/@name/string()"
            }
            XmlRole {
                name: "windSpeed_mps"
                query: "windSpeed/@mps/string()"
            }



        onStatusChanged: {
            if (status === XmlListModel.Ready) {
                var today = get(0)
                coverImage.source = "http://openweathermap.org/img/w/" + today.symbol + ".png"
            }
        }
    }


    Drawer {
        id: drawer

        anchors.fill: parent
        dock: page.isPortrait ? Dock.Top : Dock.Left

        background: SilicaListView {
            anchors.fill: parent
            model: 5

            VerticalScrollDecorator {}
            Column {
                PageHeader { title: "Forecast" }

                SilicaGridView {
                        id: forecastView
                        width: 540;
                        height: 960;


                        cellHeight: 140
                        cellWidth:180
                        model: forecast

                        delegate: ListItem {

                            Rectangle
                            {
                                id: rect

                                anchors {
                                    left: parent.left
                                    right: parent.right
                                    margins: Theme.paddingLarge
                                        }
                            radius: 10

                            color: "transparent"
                            width: 170
                            height: 100


                                Image {
                                    id: img;
                                    height: Theme.itemSizeLarge
                                    width: Theme.itemSizeLarge
                                    source: "http://openweathermap.org/img/w/" + model.symbol + ".png"
                                }

                                Column {

                                    Label {
                                        function checkDayName(name,symbol,temp,wind_d,wind_name,wind_mps)
                                        {

                                            var array_a = name.split("-");
                                            var retVal = "";
                                            var month = "";
                                            switch(array_a[1])
                                            {
                                            case "01":
                                                month = "January";
                                                break;
                                            case "02":
                                                month = "February";
                                                break;
                                            case "03":
                                                month = "March";
                                                break;
                                            case "04":
                                                month = "April";
                                                break;
                                            case "05":
                                                month = "May";
                                                break;
                                            case "06":
                                                month = "June";
                                                break;
                                            case "07":
                                                month = "July";
                                                break;
                                            case "08":
                                                month = "August";
                                                break;
                                            case "09":
                                                month = "September";
                                                break;
                                            case "10":
                                                month = "October";
                                                break;
                                            case "11":
                                                month = "November";
                                                break;
                                            case "12":
                                                month = "December";
                                                break;
                                            default:
                                                break;
                                            }

                                            var d = new Date(month + " "+array_a[2]+", "+array_a[0]);
                                            var day = d.getDay();

                                            var day_name = "";
                                            switch(day)
                                            {
                                            case 0:
                                                day_name = "Sun";
                                                break;
                                            case 1:
                                                day_name = "Mon";
                                                break;
                                            case 2:
                                                day_name = "Tue";
                                                break;
                                            case 3:
                                                day_name = "Wed";
                                                break;
                                            case 4:
                                                day_name = "Thu";
                                                break;
                                            case 5:
                                                day_name = "Fri"
                                                break;
                                            case 6:
                                                day_name = "Sat"
                                                break;
                                            default:
                                                break;
                                            }

                                            var d_2 = new Date();

                                            if(d_2.getDate() == d.getDate())
                                            {
                                                img_cont.source = "http://openweathermap.org/img/w/" + symbol + ".png"
                                                text_cont.text = d.getDate() + "." + array_a[1] + "." + array_a[0] + "\n°C "+ temp;
                                                text_smaller_cont.text = "Wind: "+wind_name;
                                                text_smaller_cont_2.text = wind_mps + "m/s " + wind_d;
                                                glow_big.color = cont.correctColor(temp);


                                            }
                                            retVal += day_name + " " + array_a[2] + "." + array_a[1] + "." + array_a[0];
                                            return retVal;

                                        }
                                        font.pixelSize: 20
                                        text:  checkDayName(model.day,model.symbol,model.temperature,model.windDirection,model.windSpeed_name,model.windSpeed_mps)
                                        height: 80
                                    }
                                    Label {



                                        text: "°C " + model.temperature

                                    }
                               }
                            }
                            Glow {
                                    anchors.fill: rect
                                    radius: 16
                                    samples: 16
                                    color: cont.correctColor(model.temperature);
                                    source:rect
                                }
                        }
                    }
            }
        }

        SilicaFlickable {
            anchors {
                fill: parent
                leftMargin: page.isPortrait ? 0 : controlPanel.visibleSize
                topMargin: page.isPortrait ? controlPanel.visibleSize : 0
                rightMargin: page.isPortrait ? 0 : progressPanel.visibleSize
                bottomMargin: page.isPortrait ? progressPanel.visibleSize : 0
            }

            contentHeight: column.height + Theme.paddingLarge

            VerticalScrollDecorator {}

            MouseArea {
                enabled: drawer.open
                anchors.fill: column
                onClicked: drawer.open = false
            }

            Column {
                id: column
                spacing: Theme.paddingLarge
                width: parent.width
                enabled: !drawer.opened

                PageHeader { title: city }
                Button {
                    text: "Show forecast"
                    onClicked: drawer.open = true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Rectangle {

                    id: cont;
                    color: "transparent";
                    width: 540;
                    height: 240;
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


                        var retVal = "#";

                        function rgbConverter(val, string)
                        {
                            if(val.toString(16).length == 1)
                            {string += '0'; string += val.toString(16);}
                            else{string += val.toString(16);}
                            return string;
                        }


                        retVal = rgbConverter(r_a, retVal);
                        retVal = rgbConverter(g_a, retVal);
                        retVal = rgbConverter(b_a, retVal);

                        return retVal;
                    }
                            Image {
                            y: -100
                            id: img_cont;
                            height: Theme.itemSizeLarge*3
                            width: Theme.itemSizeLarge*3
                            source: ""
                            }
                            Label {
                                anchors.left: img_cont.right;

    //                                    y: 90;
                                id: text_cont;
                                text: ""

                            }
                            Label {
                                anchors.left: img_cont.right;

                                anchors.top: text_cont.bottom;
                                font.pixelSize: 20
                                id: text_smaller_cont;
                                text: ""
                            }
                            Label {
                                anchors.left: img_cont.right;

                                anchors.top: text_smaller_cont.bottom;
                                font.pixelSize: 20
                                id: text_smaller_cont_2;
                                text: ""
                            }

                            Glow {
                                    id: glow_big
                                    anchors.fill: cont
                                    radius: 16
                                    samples: 16
                                    color: cont.correctColor(model.temperature);
                                    source:cont
                                }

                    }




            }


        }
    }


}


