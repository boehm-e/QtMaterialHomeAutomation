import QtQuick 2.5

Rectangle {
    property string textString: ""
    property string image: ""
    property string roomName: ""
    id: roomRoot
    signal switchchanged (string name, bool isOn)
    function changeSwitch(status) {
        currentSwitch.changeSwitch(status);
    }

    color: "white";
    width: root.width > 700?root.width / 2:root.width;
    height: 100;
    Image {
        id: logo
        source: image
        sourceSize.height: 50
        sourceSize.width: height
        smooth: true
        anchors.verticalCenter: parent.verticalCenter
    }
    Text{
        text: textString
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        font.bold: true
        font.pixelSize: 25
        anchors.leftMargin: 100
    }
    SwitchMaterial {
        id: currentSwitch;
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        room: roomName
        onStateChanged: {
            switchchanged(roomName, !currentSwitch.on)
        }

    }
}
