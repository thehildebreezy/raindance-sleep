import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: buttonHolder
    color: "transparent"

    property color iconColor

    Image {
        id: settingsIcon

        source: "icons/gear-white.svg"
        height: buttonHolder.height
        width: buttonHolder.width

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("settings pressed")
            }
        }
        

        ColorOverlay {
            anchors.fill: parent
            source: settingsIcon
            color: buttonHolder.iconColor
        }
    }

    Rectangle {
        color: "transparent"
        visible: false
    }
}