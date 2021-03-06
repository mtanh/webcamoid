/* Webcamoid, webcam capture application.
 * Copyright (C) 2019  Gonzalo Exequiel Pedone
 *
 * Webcamoid is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Webcamoid is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Webcamoid. If not, see <http://www.gnu.org/licenses/>.
 *
 * Web-Site: http://webcamoid.github.io/
 */

import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Templates 2.5 as T
import QtGraphicalEffects 1.0
import QtQuick.Controls.impl 2.12
import AkQml 1.0

T.Switch {
    id: control
    opacity: enabled? 1: 0.5
    icon.width: Ak.newUnit(18 * ThemeSettings.controlScale, "dp").pixels
    icon.height: Ak.newUnit(18 * ThemeSettings.controlScale, "dp").pixels
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth +
                            implicitIndicatorWidth + implicitIndicatorHeight
                            + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                              2 * implicitIndicatorHeight + topPadding + bottomPadding)
    padding: Ak.newUnit(4 * ThemeSettings.controlScale, "dp").pixels
    spacing: Ak.newUnit(8 * ThemeSettings.controlScale, "dp").pixels
    hoverEnabled: true
    clip: true

    readonly property int animationTime: 100

    indicator: Item {
        id: sliderIndicator
        anchors.left: control.left
        anchors.leftMargin: switchThumb.width / 2 + control.leftPadding
        anchors.verticalCenter: control.verticalCenter
        implicitWidth:
            Ak.newUnit(36 * ThemeSettings.controlScale, "dp").pixels
        implicitHeight:
            Ak.newUnit(20 * ThemeSettings.controlScale, "dp").pixels

        Rectangle {
            id: switchTrack
            height: parent.height / 2
            color: ThemeSettings.shade(ThemeSettings.colorBack, -0.5)
            radius: height / 2
            anchors.verticalCenter: sliderIndicator.verticalCenter
            anchors.right: sliderIndicator.right
            anchors.left: sliderIndicator.left
        }
        Item {
            id: switchThumb
            width: height
            anchors.bottom: sliderIndicator.bottom
            anchors.top: sliderIndicator.top

            Rectangle {
                id: highlight
                width: control.visualFocus? 2 * parent.width: 0
                height: width
                color: switchThumbRect.color
                radius: width / 2
                anchors.verticalCenter: switchThumb.verticalCenter
                anchors.horizontalCenter: switchThumb.horizontalCenter
                opacity: control.visualFocus? 0.5: 0
            }
            Rectangle {
                id: shadowRect
                color: ThemeSettings.shade(ThemeSettings.colorBack, -0.1)
                radius: height / 2
                anchors.fill: parent
                visible: false
            }
            DropShadow {
                anchors.fill: parent
                cached: true
                horizontalOffset: radius / 2
                verticalOffset: radius / 2
                radius: Ak.newUnit(1 * ThemeSettings.controlScale, "dp").pixels
                samples: 2 * radius + 1
                color: ThemeSettings.constShade(ThemeSettings.colorBack, -0.9)
                source: shadowRect
                visible: !control.flat
            }
            Rectangle {
                id: switchThumbRect
                color: ThemeSettings.shade(ThemeSettings.colorBack, -0.1)
                radius: height / 2
                anchors.fill: parent
            }
        }
    }
    contentItem: IconLabel {
        id: iconLabel
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        icon.name: control.icon.name
        icon.source: control.icon.source
        icon.width: control.icon.width
        icon.height: control.icon.height
        icon.color: ThemeSettings.colorText
        text: control.text
        font: control.font
        color: ThemeSettings.colorText
        alignment: Qt.AlignLeft
        anchors.leftMargin: switchThumb.width / 2
        anchors.left: sliderIndicator.right
        anchors.rightMargin: control.rightPadding
        anchors.right: control.right
    }

    states: [
        State {
            name: "Checked"
            when: control.checked
                  && !(control.hovered
                       || control.visualFocus
                       || control.activeFocus)
                  && !control.pressed

            PropertyChanges {
                target: switchTrack
                color: ThemeSettings.colorPrimary
            }
            PropertyChanges {
                target: switchThumbRect
                color: ThemeSettings.constShade(ThemeSettings.colorPrimary, 0.2)
            }
            PropertyChanges {
                target: switchThumb
                x: sliderIndicator.width - switchThumb.width
            }
        },
        State {
            name: "Hovered"
            when: !control.checked
                  && (control.hovered
                      || control.visualFocus
                      || control.activeFocus)
                  && !control.pressed

            PropertyChanges {
                target: switchTrack
                color: ThemeSettings.shade(ThemeSettings.colorBack, -0.6)
            }
            PropertyChanges {
                target: switchThumbRect
                color: ThemeSettings.shade(ThemeSettings.colorBack, -0.2)
            }
            PropertyChanges {
                target: highlight
                width: 2 * switchThumb.width
                opacity: 0.5
            }
        },
        State {
            name: "CheckedHovered"
            when: control.checked
                  && (control.hovered
                      || control.visualFocus
                      || control.activeFocus)
                  && !control.pressed

            PropertyChanges {
                target: switchTrack
                color: ThemeSettings.constShade(ThemeSettings.colorPrimary, 0.1)
            }
            PropertyChanges {
                target: switchThumbRect
                color: ThemeSettings.constShade(ThemeSettings.colorPrimary, 0.3)
            }
            PropertyChanges {
                target: switchThumb
                x: sliderIndicator.width - switchThumb.width
            }
            PropertyChanges {
                target: highlight
                width: 2 * switchThumb.width
                opacity: 0.5
            }
        },
        State {
            name: "Pressed"
            when: !control.checked
                  && control.pressed

            PropertyChanges {
                target: switchTrack
                color: ThemeSettings.shade(ThemeSettings.colorBack, -0.7)
            }
            PropertyChanges {
                target: switchThumbRect
                color: ThemeSettings.shade(ThemeSettings.colorBack, -0.3)
            }
            PropertyChanges {
                target: highlight
                width: 2 * switchThumb.width
                opacity: 0.75
            }
        },
        State {
            name: "CheckedPressed"
            when: control.checked
                  && control.pressed

            PropertyChanges {
                target: switchTrack
                color: ThemeSettings.constShade(ThemeSettings.colorPrimary, 0.2)
            }
            PropertyChanges {
                target: switchThumbRect
                color: ThemeSettings.constShade(ThemeSettings.colorPrimary, 0.4)
            }
            PropertyChanges {
                target: switchThumb
                x: sliderIndicator.width - switchThumb.width
            }
            PropertyChanges {
                target: highlight
                width: 2 * switchThumb.width
                opacity: 0.75
            }
        }
    ]

    transitions: Transition {
        ColorAnimation {
            target: switchTrack
            duration: control.animationTime
        }
        PropertyAnimation {
            target: switchThumb
            properties: "x"
            duration: control.animationTime
        }
        ColorAnimation {
            target: switchThumbRect
            duration: control.animationTime
        }
        PropertyAnimation {
            target: highlight
            properties: "width,opacity"
            duration: control.animationTime
        }
    }
}
