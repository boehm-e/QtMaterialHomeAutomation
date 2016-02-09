import QtQuick 2.0
import QtQuick.Window 2.2

Rectangle {
    id: root
    property int margin: 20
    color: "#EEEEEE"
    anchors.top: parent.top
    anchors.topMargin: margin

    function setSwitch(itemName, status) {
        var length = grid.children.length
        for(var i = 0; i < length ; i++) {
            if (grid.children[i].roomName == itemName) {
                grid.children[i].changeSwitch(status);
            }
        }
    }

    Flickable {
        interactive: true
        anchors.fill: root
        contentHeight: grid.height
        contentWidth: root.width

        Grid {
            id: grid
            columns: root.width > 700?2:1
            spacing: margin

            RoomMaterial {
                textString: "salon"
                image: "light.svg"

                roomName: "salon"
                onSwitchchanged: {
                    console.debug(name, isOn)
//                    socket.sendTextMessage(JSON.stringify(["state", name, isOn]))
                }
            }
            RoomMaterial {
                textString: "salle a manger"
                image: "light.svg"

                roomName: "salle_manger"

                onSwitchchanged: {
                    console.debug(name, isOn)
//                    socket.sendTextMessage(JSON.stringify(["state",name, isOn]))
                }
            }
            RoomMaterial {
                textString: "salle de bain"
                image: "light.svg"

                roomName: "salle_bain"
                onSwitchchanged: {
                    console.debug(name, isOn)
//                    socket.sendTextMessage(JSON.stringify(["state", name, isOn]))
                }
            }
            RoomMaterial {
                textString: "rideau"
                image: "weather.svg"

                roomName: "rideau"
                onSwitchchanged: {
                    console.debug(name, isOn)
                    socket.sendTextMessage(JSON.stringify(["state", name, isOn]))
                }
            }
        }
    }
}
