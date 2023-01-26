import QtQuick 2.15

Item {
    id: root

    property color pointer_color: "red"
    property int item_size_px: 50
    property int line_thickness_px: 4

    width:  item_size_px
    height: item_size_px

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        color: pointer_color
        width: line_thickness_px
        height: parent.height
    }

    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        color: pointer_color
        width: parent.width
        height: line_thickness_px
    }
}
