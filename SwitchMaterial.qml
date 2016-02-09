import QtQuick 2.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0

Item {
    id: toggleswitch
    width: background.width; height: background.height

    property bool on: false
    property string room: ""

    function toggle() {
        if (toggleswitch.state == "on") {
            socket.sendTextMessage(JSON.stringify(["state",room, false]))
            toggleswitch.state = "off";
        }
        else {
            socket.sendTextMessage(JSON.stringify(["state",room, true]))
            toggleswitch.state = "on";
        }
    }

    function changeSwitch(status) {
        if (status == true)
            toggleswitch.state = "on";
        else if (status == false)
            toggleswitch.state = "off"
    }

    Image {
        id: background
        source: "switchBackground.png"
        smooth: true
        width: 15 * Screen.logicalPixelDensity
        height: 5.6 * Screen.logicalPixelDensity
        ColorOverlay {
            id: backgroundOverlay
            anchors.fill: background
            source: background
            smooth: true
            color: "#B0AFAF"
        }
        MouseArea { anchors.fill: parent; onClicked: toggle() }
    }
    Rectangle {
        id: knob
        x: -1; y: 0
        height: 8 * Screen.logicalPixelDensity
        anchors.verticalCenter: parent.verticalCenter
        width: height
        color: "#F1F1F1"
        smooth: true
        radius: width / 2

        MouseArea {
            anchors.fill: parent
            //            drag.target: knob; drag.axis: Drag.XAxis; drag.minimumX: -1; drag.maximumX: 8.5 * Screen.logicalPixelDensity
            onClicked: toggle()
            //            onReleased: releaseSwitch()
        }
    }

    states: [
        State {
            name: "on"
            PropertyChanges { target: knob; x: 7.5 * Screen.logicalPixelDensity}
            PropertyChanges { target: toggleswitch; on: true }
            PropertyChanges { target: backgroundOverlay; color: "#75BEB8" }
            PropertyChanges { target: knob; color: "#009688" }
        },
        State {
            name: "off"
            PropertyChanges { target: knob; x: -1 }
            PropertyChanges { target: toggleswitch; on: false }
            PropertyChanges { target: backgroundOverlay; color: "#B0AFAF" }
            PropertyChanges { target: knob; color: "#F1F1F1" }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 200 }
    }
}
