import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Dialog {
    id: dialog
    modal: true
    title: "Reference Dimension"
    standardButtons: Dialog.Ok | Dialog.Cancel
    anchors.centerIn: parent

    property real resultValue

    Column {
        anchors.fill: parent
        spacing: infoText.font.pixelSize / 2

        Text {
            id: infoText
            text: "Enter the right dimension from the drawing"
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: infoText.font.pixelSize / 2

            TextField {
                focus: true
                Layout.fillWidth: parent

                validator: RegularExpressionValidator {
                    regularExpression: /^(?:[1-9]\d*|0)?(?:\.\d+)?$/
                }

                onAccepted: {
                    if(text) {
                        dialog.resultValue = parseFloat(text)
                        dialog.accept()
                    }
                }
            }

            Text {
                id: unitsText
                text: "mm"
            }
        }
    }
}
