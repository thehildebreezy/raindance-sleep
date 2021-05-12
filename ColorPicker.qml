import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: colorPicker
    property color chosenColor

    color: "transparent"


    Image {
        id: colorPickerButton
        
        source: "icons/color-white.svg"

        width: colorPicker.width
        height: colorPicker.height

        anchors.top: colorPicker.top
        anchors.left: colorPicker.left

        ColorOverlay {
            anchors.fill: parent
            source: colorPickerButton
            color: chosenColor
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                colorPallete.open()
            }
        }
    }

    Rectangle {
        id: colorPallete

        color: "transparent"

        function open(){
            colorPallete.visible = true
        }
        function close( cellColor ){
            colorPicker.chosenColor = cellColor
            colorPallete.visible = false
        }
        visible: false

        width: childrenRect.width
        height: childrenRect.height

        anchors.bottom: colorPickerButton.top
        anchors.horizontalCenter: colorPickerButton.horizontalCenter
        anchors.bottomMargin: 12

        Grid {
            id: colorGrid
            rows: 3
            columns: 3
            spacing: 3

            ColorItem { cellColor: "deeppink"; onClicked: colorPallete.close(cellColor) }
            ColorItem { cellColor: "lime"; onClicked: colorPallete.close(cellColor) }
            ColorItem { cellColor: "lightgrey"; onClicked: colorPallete.close(cellColor) }
            ColorItem { cellColor: "yellow"; onClicked: colorPallete.close(cellColor) }
            ColorItem { cellColor: "deepskyblue"; onClicked: colorPallete.close(cellColor) }
            ColorItem { cellColor: "white"; onClicked: colorPallete.close(cellColor) }
            ColorItem { cellColor: "orange"; onClicked: colorPallete.close(cellColor) }
            ColorItem { cellColor: "magenta"; onClicked: colorPallete.close(cellColor) }
            ColorItem { cellColor: "red"; onClicked: colorPallete.close(cellColor) }

        }
    }

}