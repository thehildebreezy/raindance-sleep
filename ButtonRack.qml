import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {

    property color iconColor: "white"
    property AudioPlayer audioController

    property alias chosenColor: colorPicker.chosenColor

    property string playIcon: "icons/play-white.svg"
    property string pauseIcon: "icons/pause-white.svg"

    property string wakeIcon: "icons/wake-sun-white.svg"
    property string sleepIcon: "icons/night-white.svg"

    property int mainIconSize: 96
    property int sideIconSize: 48
    property int iconMargins: 48


    height: childrenRect.height
    width: childrenRect.width

    color: "transparent"



    Image {
        id: soundOnly
        source: playIcon
        width: mainIconSize
        height: mainIconSize

        anchors.horizontalCenter: parent.horizontalCenter
        
        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true
            onClicked: {
                if( audioController.isPlaying() ){
                    soundOnly.source = playIcon
                    audioController.stop()
                    return
                }

                soundOnly.source = pauseIcon
                backend.checkPlaylist('calm')
            }
        }


        ColorOverlay {
            anchors.fill: parent
            source: soundOnly
            color: iconColor
        }
    }

    SettingsButton {
        iconColor: parent.iconColor

        width: sideIconSize
        height: sideIconSize

        anchors.rightMargin: iconMargins
        anchors.right: sleep.left
        anchors.verticalCenter: soundOnly.verticalCenter
    }

    Image {
        id: sleep
        source: sleepIcon
        width: sideIconSize
        height: sideIconSize
        anchors.rightMargin: iconMargins

        anchors.right: soundOnly.left

        anchors.verticalCenter: soundOnly.verticalCenter

        ColorOverlay {
            anchors.fill: parent
            source: sleep
            color: iconColor
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                backend.sendSleepCommand()
            }
        }
    }

    
    ColorPicker{
        id: colorPicker

        anchors.left: wake.right
        anchors.verticalCenter: soundOnly.verticalCenter
        anchors.leftMargin: iconMargins

        height: sideIconSize
        width: sideIconSize

        chosenColor: iconColor
    }

    Image {
        id: wake
        source: wakeIcon
        width: sideIconSize
        height: sideIconSize
        anchors.leftMargin: iconMargins

        anchors.left: soundOnly.right

        anchors.verticalCenter: soundOnly.verticalCenter

        ColorOverlay {
            anchors.fill: parent
            source: wake
            color: iconColor
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                backend.sendWakeCommand()
            }
        }
    }


}