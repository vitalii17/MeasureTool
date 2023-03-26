import QtQuick 2.15
import QtQuick.Shapes 1.4

Item {
    id: root
    anchors.fill: parent
    layer.enabled: true
    layer.samples: 4

    property int lineThickness

    property color lineColor

    property int startX
    property int startY

    property int endX
    property int endY

    readonly property real lenX: endX - startX
    readonly property real lenY: endY - startY
    readonly property real len: Math.sqrt(Math.pow(lenX, 2) + Math.pow(lenY, 2))
    readonly property real centerX: startX + lenX / 2
    readonly property real centerY: startY + lenY / 2
    readonly property real angleRad: Math.atan2(lenY, lenX)
    readonly property real angleDeg: radToDeg(angleRad)

    function radToDeg(rad) {
        return rad * (180.0 / Math.PI);
    }

    Shape {
        ShapePath {
            id: line
            strokeColor: lineColor
            strokeWidth: root.lineThickness
            capStyle: ShapePath.RoundCap

            startX: root.startX
            startY: root.startY
            PathLine {
                relativeX: root.endX - root.startX
                relativeY: root.endY - root.startY
            }
        }
    }
}

