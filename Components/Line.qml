import QtQuick 2.15
import QtQuick.Shapes 1.4

Item {
    id: root
    anchors.fill: parent
    layer.enabled: true
    layer.samples: 4

    property int lineThicknessPx: 1

    property int startX: 0
    property int startY: 0

    property int endX: 0
    property int endY: 0

    readonly property real lenX_px: endX - startX
    readonly property real lenY_px: endY - startY
    readonly property real len_px: Math.sqrt(Math.pow(lenX_px, 2) + Math.pow(lenY_px, 2))
    readonly property real angle_deg: radToDeg(Math.atan2(lenY_px, lenX_px))

    function radToDeg(rad) {
        return rad * (180.0 / Math.PI);
    }

    Shape {
        ShapePath {
            id: line
            strokeColor: "red"
            strokeWidth: root.lineThicknessPx
            capStyle: ShapePath.RoundCap

            startX: root.startX
            startY: root.startY
            PathLine { relativeX: root.endX - root.startX; relativeY: root.endY - root.startY }
        }
    }
}

