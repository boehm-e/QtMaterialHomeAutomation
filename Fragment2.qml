import QtQuick 2.5
import QtGraphicalEffects 1.0

Rectangle {
    signal resetCounter(int number)
    id: notifications
    MouseArea {
        anchors.fill: parent
        onClicked: {
            addNotif("coucou");
        }
    }

    color: "#EEEEEE"
    function addNotif(text, image) {
        notif.insert(0,{textNotif: text, image: image})
    }

    Image {
        source: "delete.svg"
        height: 40
        width: height
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        visible: true
        MouseArea {
            anchors.fill: parent
            onClicked: {
                notif.clear()
                resetCounter(0)
            }
        }
    }

    ListView {
        interactive: true
        anchors.fill: parent
        anchors.top: parent.top
        anchors.topMargin: 50
        height: parent.height
        spacing: 50
        delegate: Item {
            height: dp(48)
            anchors.topMargin: 70
            anchors.left: parent.left
            anchors.right: parent.right
            Rectangle {
                anchors.margins: dp(5)
                width: parent.width * 0.8
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.1
                height: text.contentHeight + 40
                color: "white"

                Image {
                    id: remove
                    source: "delete.svg"
                    height: 35
                    width: height
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    visible: true
                    opacity: 0.6
                    ColorOverlay {
                        anchors.fill: remove
                        source: remove
                        color: "gray"
                        opacity: 0.6
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            notif.remove(index)
                            resetCounter(-1)
                        }
                    }
                }

                Image {
                    id: pic
                    //                    source: image
                    source: image
                    visible: true
                    height: 40
                    width: height
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    id: text
                    text: textNotif
                    font.bold: true
                    font.pixelSize: 20
                    width: parent.width * 0.8
                    wrapMode: Text.WordWrap
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 60
                }

                Text {
                    id: date
                    text: "( " + new Date().getHours() + ":" + new Date().getMinutes() /*+ ":" + new Date().getSeconds()*/ + " )"
                    font.bold: true
                    font.pixelSize: 15
                    color: "gray"
                    opacity: 0.5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 60
                }

            }

        }
        add: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 200 }
            NumberAnimation { property: "scale"; from: 0.5; to: 1.0; duration: 200 }
        }

        displaced: Transition {
//            NumberAnimation { properties: "y"; duration: 400; easing.type: Easing.OutBounce }
            NumberAnimation { properties: "y"; duration: 400; easing.type: Easing.OutSine }
        }

        model: notif
    }

    ListModel {
        id: notif
        ListElement {textNotif: "Conact"; image: "" }
    }

    Component.onCompleted:  {
    }
}

