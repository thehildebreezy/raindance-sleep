import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {

    id: messageBlock

    property string text: "Good morning!"
    property color textColor

    color: "transparent"

    width: childrenRect.width
    height: childrenRect.height

    property int baseSizeLarge: 30
    property int baseSizeSmall: 10

    property int scale: 2

    Image {
        id: iconImage

        width: 100
        height: 100

        source: "icons/heart-white.svg"

        anchors.horizontalCenter: messageBlock.horizontalCenter

        ColorOverlay {
            anchors.fill: parent
            source: iconImage
            color: textColor
        }
    }

    Text {
        id: messageText
        text: messageBlock.text

        font.pointSize: messageBlock.baseSizeSmall * messageBlock.scale
        color: textColor

        anchors.horizontalCenter: iconImage.horizontalCenter
        anchors.top: iconImage.bottom

        anchors.topMargin: -24
    }

}