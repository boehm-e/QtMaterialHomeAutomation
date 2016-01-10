import QtQuick 2.5

Rectangle {
    color: "white"

    Text {
        text: "Fragment 3"
        color: "black"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: dp(50)
        font.pixelSize: dp(30)

        renderType: Text.NativeRendering
    }

}

