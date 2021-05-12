import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.0

Rectangle {

    id: mainWindow

    color: "black"
    width: Screen.width
    height: Screen.height

    // property backend

    property color defaultColor: "deeppink"
    property color textColor: buttonBar.chosenColor

    property int brightTime: 10000
    property int updateInterval: 60000

    
    property int baseSizeLarge: 30
    property int baseSizeSmall: 10

    // Connected signal spots
    function updatePlaylist( jsonPlaylist ){
        rainAudio.updatePlaylist( jsonPlaylist )
    }

    function updateMessage( message ){
        messageBlock.text = message
    }


    Message {
        id: messageBlock
        
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: mainWindow.top
        anchors.topMargin: 4

        textColor: mainWindow.textColor
        
        baseSizeLarge: mainWindow.baseSizeLarge
        baseSizeSmall: mainWindow.baseSizeSmall
    }

    Clock {
        id: clockApp
        textColor: mainWindow.textColor
        scale: 2
        anchors.centerIn: parent
        baseSizeLarge: mainWindow.baseSizeLarge
        baseSizeSmall: mainWindow.baseSizeSmall
    }

    ButtonRack {
        id: buttonBar
        iconColor: mainWindow.textColor
        anchors.horizontalCenter: parent.horizontalCenter
        
        anchors.bottom: mainWindow.bottom
        anchors.bottomMargin: 36

        audioController: rainAudio
        chosenColor: defaultColor
    }


    Timer {
        id: dimmerTimer
        interval: mainWindow.brightTime
        running: true
        repeat: false
        onTriggered: {
            backend.dimDisplay()
        }
    }

    Timer {
        id: updateTicker
        interval: mainWindow.updateInterval
        triggeredOnStart: true
        running: true
        repeat: true
        onTriggered: {
            backend.requestMessage()
        }
    }


    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true
        
        onClicked: {
            backend.lightDisplay()
            dimmerTimer.restart()
            mouse.accepted = false
        }
    }

    AudioPlayer {
        id: rainAudio
    }
}