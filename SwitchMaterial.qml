import QtQuick 2.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0

Item {
    id: toggleswitch
    width: background.width; height: background.height

    property bool on: false

    function toggle() {
        if (toggleswitch.state == "on")
            toggleswitch.state = "off";
        else
            toggleswitch.state = "on";
    }

    function releaseSwitch() {
        if (knob.x == 1) {
            if (toggleswitch.state == "off") return;
        }
        if (knob.x == 78) {
            if (toggleswitch.state == "on") return;
        }
        toggle();
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
    Image {
        id: knob
        x: 0; y: 0
        height: 8 * Screen.logicalPixelDensity
        anchors.verticalCenter: parent.verticalCenter
        width: height
        source: "knob.png"
        smooth: true
        ColorOverlay {
            id: knobOverlay
            anchors.fill: knob
            source: knob
            smooth: true
            color: "#F1F1F1"
        }

        MouseArea {
            anchors.fill: parent
            drag.target: knob; drag.axis: Drag.XAxis; drag.minimumX: 0; drag.maximumX: 8.5 * Screen.logicalPixelDensity
            onClicked: toggle()
            onReleased: releaseSwitch()
        }
    }

    states: [
        State {
            name: "on"
            PropertyChanges { target: knob; x: 7.5 * Screen.logicalPixelDensity}
            PropertyChanges { target: toggleswitch; on: true }
            PropertyChanges { target: backgroundOverlay; color: "#75BEB8" }
            PropertyChanges { target: knobOverlay; color: "#009688" }
        },
        State {
            name: "off"
            PropertyChanges { target: knob; x: 0 }
            PropertyChanges { target: toggleswitch; on: false }
            PropertyChanges { target: backgroundOverlay; color: "#B0AFAF" }
            PropertyChanges { target: knobOverlay; color: "#F1F1F1" }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 200 }
    }
}
