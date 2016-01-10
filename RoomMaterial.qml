import QtQuick 2.5

Rectangle {
    property string textString: ""
    property string image: ""
    color: "white";
    width: root.width > 700?root.width / 2:root.width;
    height: 100;
    Image {
        id: logo
        source: image
        height: 50
        width: height
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
        id: test
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
    }
}
