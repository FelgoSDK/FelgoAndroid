import VPlayApps 1.0
import QtQuick 2.0

App {
    AppText {
        id: text

        text: "QML text"
        x: dp(100)

        // animate y position
        PropertyAnimation on y {
            from: 0
            to: text.parent.height - text.height
            duration: 5000
            loops: Animation.Infinite
            easing.type: Easing.SineCurve
        }
    }

    // animate background color
    PropertyAnimation on color {
        from: "purple"
        to: "green"
        duration: 5000
        loops: Animation.Infinite
        easing.type: Easing.SineCurve
    }
}