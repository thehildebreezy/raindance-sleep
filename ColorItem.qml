import QtQuick 2.0

Item {
    id: colorBox

    property alias cellColor: rect.color
    signal clicked( color cellColor )

    width: 40
    height: 25

    Rectangle {
        id: rect
        anchors.fill: parent
        radius: 2

        MouseArea {
            anchors.fill: parent
            onClicked: colorBox.clicked(colorBox.cellColor)
        }
    }
}