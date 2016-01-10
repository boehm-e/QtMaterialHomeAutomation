import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import Qt.WebSockets 1.0

ApplicationWindow {
    property int notifNumber : 0

    visible: true
    width: 700
    height: 480
    title: qsTr("EPIC")
    id: abcd
    Component.onCompleted:  abcd.showMaximized();
    readonly property int dpi: Screen.pixelDensity * 25.4
    function dp(x){ return (dpi < 120) ? x : x*(dpi/160); }

    Rectangle {
        z: 2
        id: menuRect
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: dp(68)
        color: "#3F51B5"

        Text {
            id: titre
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter

            color: "#FF4081"
            font.pixelSize: 20
            font.bold: true
            text: ""
        }
        Rectangle {
            id: notifCount

            function changeNotifNumber(number) {
                if (number >= 0)
                    counter.text = number
            }

            height: parent.height * 0.7
            width: height
            radius: width / 2
            color: "red"
            anchors.right: parent.right
            anchors.rightMargin: parent.height * 0.15
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: counter
                text: "0"
                color: "white"
                anchors.centerIn: parent
                font.pixelSize: 20
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    listview.showFragment(1);
                    notifNumber = 0
                    parent.changeNotifNumber(0)
                }
            }
        }

        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            width: dp(48)
            color: "#3F51B5"
            Image {
                id: menu
                source: "logo_menu.svg"
                width: parent.width * 0.7
                height: width
                anchors.top: parent.top
                anchors.topMargin: height / 2
                anchors.left: parent.left
                anchors.leftMargin: height / 2

            }
            MouseArea {
                anchors.fill: parent

                onClicked: {
                    nav.toggle()
                }
            }
        }
    }

    Fragment1 {
        id: fragment1
        anchors.top: menuRect.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        visible: true
        anchors.leftMargin: 20
        anchors.rightMargin: width>700?40:20
        z: 1
    }

    Fragment2 {
        id: fragment2
        anchors.top: menuRect.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        visible: false
        onResetCounter: {
            if (number == 0) {
                notifNumber = 0
            } else if (number == -1) {
                notifNumber -= 1
            }
            notifCount.changeNotifNumber(notifNumber)
        }
    }

    Fragment3 {
        id: fragment3
        anchors.top: menuRect.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        visible: false
    }

    NavigationDrawer {
        id: nav
        z: 3
        Rectangle {
            anchors.fill: parent
            color: "white"

            Image {
                id: headerMenu
                source: "background.jpg"
                width: parent.width
                height: width * 9 / 16
                Rectangle {
                    height: parent.height * 0.4
                    anchors.top: parent.top
                    anchors.topMargin: 15
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    width: height
                    radius: width / 2
                    Image {
                        anchors.fill: parent
                        id: logo
                        source: "epic.png"
                    }
                }
                Text {
                    id: link_Text;
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    anchors.rightMargin: 5
                    onLinkActivated: Qt.openUrlExternally(link);
                    text: '<a  href="http://boehm-erwan.cloudapp.net/">WebSite</a>'
                }

                Text {
                    id: contact
                    text: qsTr("boehm_e@etna-alternance.net")
                    color: "white"
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    font.pixelSize: 15

                }
            }
            ListView {
                id: listview
                anchors.fill: parent
                anchors.top: parent.top
                anchors.topMargin: headerMenu.height + dp(10)
                function showFragment(index) {
                    console.debug(index)
                    fragment1.visible = false
                    fragment2.visible = false
                    fragment3.visible = false
                    if (index == 0)
                        fragment1.visible = true
                    else if(index == 1)
                        fragment2.visible = true
                    else if(index == 2)
                        fragment3.visible = true
                    nav.open = false

                }

                delegate: Item {
                    height: dp(48)
                    anchors.left: parent.left
                    anchors.right: parent.right

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: dp(5)

                        Rectangle {
                            id: border
                            color: "grey"
                            height: 1
                            width: parent.width * 1
                            anchors.left: parent.left
                            anchors.top: parent.bottom
                        }

                        Text {
                            text: fragment
                            anchors.fill: parent
                            font.pixelSize: dp(20)

                            renderType: Text.NativeRendering
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                listview.showFragment(index);
                            }
                        }
                    }
                }

                model: navModel
            }
        }
    }

    ListModel {
        id: navModel

        ListElement {fragment: "Etat general"; }
        ListElement {fragment: "Notifications"; }
        ListElement {fragment: "Conact"; }
    }


    WebSocket {
        id: socket
        url: "ws://192.168.1.38:8080"

        onTextMessageReceived: {
            var parsed = JSON.parse(message);
            console.debug(notifNumber + " : " + parsed)
            notifNumber += 1
            notifCount.changeNotifNumber(notifNumber)

            if (parsed[0] == "meteo") {
                fragment2.addNotif(parsed[1], "weather.svg")
            }
            else if(parsed[0] == "light") {
                fragment2.addNotif(parsed[1], "light.svg")
            }
            else {
                fragment2.addNotif(message, "")
            }
        }


        onStatusChanged: if (socket.status == WebSocket.Error) {
                             console.log("Error: " + socket.errorString)
                         } else if (socket.status == WebSocket.Open) {

                         } else if (socket.status == WebSocket.Closed) {
                             console.debug("\nSocket closed")
                         }
        active: true
    }
}

