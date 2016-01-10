import QtQuick 2.0
import QtQuick.Window 2.2

Rectangle {
    id: root
    property int margin: 20
    color: "#EEEEEE"
    anchors.top: parent.top
    anchors.topMargin: margin
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
            }
            RoomMaterial {
                textString: "salle a manger"
                image: "light.svg"
            }
            RoomMaterial {
                textString: "salle de bain"
                image: "light.svg"
            }
            RoomMaterial {
                textString: "rideau"
                image: "weather.svg"
            }
        }
    }
}
