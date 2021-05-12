import QtQuick 2.0

Rectangle {
    id: clockApp
    property color textColor
    property int scale

    property int baseSizeLarge: 30
    property int baseSizeSmall: 10

    color: "transparent"
    
    height: date.height+time.height
    width: Math.max(time.width,date.width)

    readonly property var months: [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"]

    readonly property var days: [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday"
    ]

    Timer {
        interval: 500; 
        running: true; 
        repeat: true
        onTriggered: {
            var timeObj = new Date()
            var dateString = days[timeObj.getDay()] + ", "
            dateString += timeObj.getDate() + " "
            dateString += months[timeObj.getMonth()] + " "
            dateString += timeObj.getFullYear()
            date.text = dateString

            var hours = timeObj.getHours()
            var minutes = timeObj.getMinutes()

            var seperatorColor = (timeObj.getSeconds() % 2) == 0 ? "black" : clockApp.textColor
            separator.color = seperatorColor

            if( hours >= 12 ){
                hour.text = (hours == 12 ) ? hours :
                    (hours < 22 ) ? "0" + (hours-12) : hours-12
                ampm.text = " PM"
            } else {
                hour.text = (hours<10) ? "0"+hours : hours
                ampm.text = " AM"
            }

            minute.text = (minutes < 10) ? "0"+minutes : minutes
        }
    }

    Rectangle {
        id: time
        anchors.horizontalCenter: parent.horizontalCenter
        width: hour.width + separator.width + minute.width + ampm.width
        height: hour.height
        
        color: "transparent"

        Text {
            id: hour
            font.pointSize: clockApp.scale * clockApp.baseSizeLarge
            font.weight: Font.ExtraBold
            text: "02"
            color: clockApp.textColor
        }
        Text {
            id: separator
            font.pointSize: clockApp.scale * clockApp.baseSizeLarge
            font.weight: Font.ExtraBold
            text: ":"
            color: "black"
            anchors.left: hour.right
        }
        Text {
            id: minute
            font.pointSize: clockApp.scale * clockApp.baseSizeLarge
            font.weight: Font.ExtraBold
            text: "30"
            color: clockApp.textColor
            anchors.left: separator.right
        }
        Text {
            id: ampm
            font.pointSize: clockApp.scale * clockApp.baseSizeLarge
            font.weight: Font.ExtraBold
            text: " AM"
            color: clockApp.textColor
            anchors.left: minute.right
        }
    }
    

    
    Text {
        id: date
        font.pointSize: clockApp.scale * clockApp.baseSizeSmall
        text: "Sunday, 02 May 2021"
        color: clockApp.textColor
        anchors.top:time.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}