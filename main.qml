import QtQuick 2.15
import QtQuick.Window 2.15
import QtQml.StateMachine as DSM

import "Components"

Window {
    id: mainWin
    title: "Measure Tool"
    flags: Qt.WA_TranslucentBackground | Qt.FramelessWindowHint
    color: "#00000000"
    visibility: "FullScreen"
    visible: true

    property real referenceDimension
    property real screenRefDimension
    property real realDimension: referenceDimension / screenRefDimension * screenRealDimension
    property real screenRealDimension: line.len

    Pointer {
        id: pointer_1
        pointerColor: "red"
        itemSize: 5 * mainWin.screen.pixelDensity
        lineWidth: 0.5 * mainWin.screen.pixelDensity
    }

    Pointer {
        id: pointer_2
        pointerColor: "red"
        itemSize: 5 * mainWin.screen.pixelDensity
        lineWidth: 0.5 * mainWin.screen.pixelDensity
    }

    Line {
        id: line
        lineColor: "red"
        lineThickness: 0.5 * mainWin.screen.pixelDensity
        startX: pointer_1.x + pointer_1.width / 2
        startY: pointer_1.y + pointer_1.height / 2
        endX: pointer_2.x + pointer_2.width / 2
        endY: pointer_2.y + pointer_2.height / 2
    }

    Item {
        id: lineTextItem

        property int lineToTextSpacing: textOnLine.contentHeight / 2

        x: line.centerX - textOnLine.contentWidth / 2 + Math.abs(Math.sin(line.angleRad) * lineToTextSpacing)
        y: {
            if(((line.angleDeg > 0) && (line.angleDeg < 90)) || ((line.angleDeg < -90) && (line.angleDeg > -180))) {
                return (line.centerY - textOnLine.contentHeight / 2 - Math.abs(Math.cos(line.angleRad) * lineToTextSpacing))
            }
            else {
                return (line.centerY - textOnLine.contentHeight / 2 + Math.abs(Math.cos(line.angleRad) * lineToTextSpacing))
            }
        }

        Text {
            id: textOnLine
            font.pixelSize: 3.5 * mainWin.screen.pixelDensity
            color: "red"
            visible: parent.visible

            rotation: {
                if((line.angleDeg > -90) && (line.angleDeg < 90)) {
                    return line.angleDeg
                }
                else {
                    return (line.angleDeg + 180)
                }
            }

            text: mainWin.realDimension.toString().slice(0, line.len.toString().indexOf('.') + 2) + "mm"
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.BlankCursor

        property Pointer followTarget

        onMouseXChanged: {
            followTarget.x = mouseX - followTarget.width / 2
        }

        onMouseYChanged: {
            followTarget.y = mouseY - followTarget.height / 2
        }

        onFollowTargetChanged: {
            followTarget.x = mouseX - followTarget.width / 2
            followTarget.y = mouseY - followTarget.height / 2
        }
    }

    Item {
        id: keyHandler
        signal returnPressed()
        signal escPressed()
        focus: refDialog.visible ? false: true
        Keys.onReturnPressed: returnPressed()
        Keys.onEscapePressed: escPressed()
    }

    RefDialog {
        id: refDialog
    }

    DSM.StateMachine {
        id: mainSM
        running: true
        initialState: firstPointRefSM

        DSM.State {
            id: firstPointRefSM

            DSM.SignalTransition { signal: mouseArea.clicked;        targetState: secondPointRefSM }
            DSM.SignalTransition { signal: keyHandler.returnPressed; targetState: secondPointRefSM }
            DSM.SignalTransition { signal: keyHandler.escPressed;    targetState: finalState }

            onEntered: {
                pointer_1.visible = true
                pointer_2.visible = false
                line.visible = false
                lineTextItem.visible = false
                mouseArea.followTarget = pointer_1
            }
        }

        DSM.State {
            id: secondPointRefSM

            DSM.SignalTransition { signal: mouseArea.clicked;        targetState: referenceInputSM }
            DSM.SignalTransition { signal: keyHandler.returnPressed; targetState: referenceInputSM }
            DSM.SignalTransition { signal: keyHandler.escPressed;    targetState: firstPointRefSM }

            onEntered: {
                pointer_1.visible = true
                pointer_2.visible = true
                line.visible = true
                lineTextItem.visible = false
                mouseArea.followTarget = pointer_2
            }
        }

        DSM.State {
            id: referenceInputSM

            DSM.SignalTransition { signal: refDialog.accepted; targetState: firstPointSM }
            DSM.SignalTransition { signal: refDialog.rejected; targetState: secondPointRefSM }

            onEntered: {
                refDialog.open()
            }

            onExited: {
                referenceDimension = refDialog.resultValue
                screenRefDimension = line.len
            }
        }

        DSM.State {
            id: firstPointSM

            DSM.SignalTransition { signal: mouseArea.clicked;        targetState: secondPointSM }
            DSM.SignalTransition { signal: keyHandler.returnPressed; targetState: secondPointSM }
            DSM.SignalTransition { signal: keyHandler.escPressed;    targetState: finalState }

            onEntered: {
                pointer_1.visible = true
                pointer_2.visible = false
                line.visible = false
                lineTextItem.visible = false
                mouseArea.followTarget = pointer_1
            }
        }

        DSM.State {
            id: secondPointSM

            DSM.SignalTransition { signal: keyHandler.escPressed;    targetState: firstPointSM }
            DSM.SignalTransition { signal: keyHandler.returnPressed; targetState: finalState }
            DSM.SignalTransition { signal: mouseArea.clicked;        targetState: finalState }

            onEntered: {
                pointer_1.visible = true
                pointer_2.visible = true
                line.visible = true
                lineTextItem.visible = true
                mouseArea.followTarget = pointer_2
            }
        }

        DSM.FinalState {
            id: finalState

            onEntered: {
                Qt.quit()
            }
        }
    }
}

