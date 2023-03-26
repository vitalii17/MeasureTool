import QtQuick 2.15

Item {
    id: root

    property color pointerColor
    property int itemSize
    property int lineWidth

    width:  itemSize
    height: itemSize

    Rectangle {
        id: vertLine
        anchors.horizontalCenter: parent.horizontalCenter
        color: pointerColor
        width: lineWidth
        height: parent.height
        radius: width / 2
    }

    Rectangle {
        id: horLine
        anchors.verticalCenter: parent.verticalCenter
        color: pointerColor
        width: parent.width
        height: lineWidth
        radius: height / 2
    }
}
