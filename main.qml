import QtQuick 2.15
import QtQuick.Window 2.15

import "Components"

Window {
    id: main_win
    flags: Qt.WA_TranslucentBackground | Qt.FramelessWindowHint
    color: "#00000000"
    visibility: "FullScreen"
    visible: true

    Shortcut {
        sequence: "Esc"
        context: Qt.ApplicationShortcut
        onActivated: Qt.quit()
    }

    Pointer {
        id: pointer_1
        item_size_px: 5 * main_win.screen.pixelDensity
        line_thickness_px: 0.5 * main_win.screen.pixelDensity
    }

    Pointer {
        id: pointer_2
        item_size_px: 5 * main_win.screen.pixelDensity
        line_thickness_px: 0.5 * main_win.screen.pixelDensity
    }

    Line {
        id: line
        startX: 300
        startY: 300
        lineThicknessPx: 0.5 * main_win.screen.pixelDensity
        onAngle_degChanged: text_on_line.rotation = angle_deg
        onLen_pxChanged: console.log(len_px / main_win.screen.pixelDensity)
    }

    Item {
        x: line.startX + (line.lenX / 2) - (width / 2)
        y: line.startY + (line.lenY / 2) - (height / 2)
        Text {
            id: text_on_line
            font.pixelSize: 15
            color: "red"
            text: "22.15mm"
            rotation: 20
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.BlankCursor
        onMouseXChanged: {
            pointer_1.x = mouseX - pointer_1.width / 2
            line.endX = mouseX
        }
        onMouseYChanged: {
            pointer_1.y = mouseY - pointer_1.height / 2
            line.endY = mouseY
        }
    }

    //    Rectangle {
    //        id: rect1
    ////        anchors.centerIn: parent
    //        width: 20 * main_win.screen.pixelDensity
    //        height: 20 * main_win.screen.pixelDensity
    //        color: "red"
    //        radius: width / 2
    //        MouseArea {
    //            anchors.fill: parent
    //            drag.target: parent
    //            onClicked: {
    //                console.log(main_win.screen.pixelDensity)
    //            }
    //        }
    //    }
}
