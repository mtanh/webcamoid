/* Webcamoid, webcam capture application.
 * Copyright (C) 2020  Gonzalo Exequiel Pedone
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
import QtQuick.Controls.impl 2.12
import AkQml 1.0

T.ScrollBar {
    id: control
    implicitWidth:
        Math.max(implicitBackgroundWidth + leftInset + rightInset,
                 implicitContentWidth + leftPadding + rightPadding)
    implicitHeight:
        Math.max(implicitBackgroundHeight + topInset + bottomInset,
                 implicitContentHeight + topPadding + bottomPadding)
    padding: Ak.newUnit(2 * ThemeSettings.controlScale, "dp").pixels
    leftPadding: Ak.newUnit(4 * ThemeSettings.controlScale, "dp").pixels
    rightPadding: Ak.newUnit(4 * ThemeSettings.controlScale, "dp").pixels
    visible: control.policy !== T.ScrollBar.AlwaysOff
    minimumSize: orientation == Qt.Horizontal?
                     height / width:
                     width / height
    hoverEnabled: true

    contentItem: Rectangle {
        implicitWidth: Ak.newUnit(6 * ThemeSettings.controlScale, "dp").pixels
        implicitHeight: Ak.newUnit(6 * ThemeSettings.controlScale, "dp").pixels
        radius: Math.min(implicitWidth, implicitHeight) / 2
        color: control.pressed?
                   ThemeSettings.constShade(ThemeSettings.colorPrimary, 0.2):
               control.interactive && control.hovered?
                   ThemeSettings.constShade(ThemeSettings.colorPrimary, 0.1):
                   ThemeSettings.colorPrimary
        opacity: 0
    }

    background: Rectangle {
        implicitWidth: Ak.newUnit(6 * ThemeSettings.controlScale, "dp").pixels
        implicitHeight: Ak.newUnit(6 * ThemeSettings.controlScale, "dp").pixels
        color: ThemeSettings.shade(ThemeSettings.colorBack, -0.1)
        opacity: 0
        visible: control.interactive
    }

    states: State {
        name: "active"
        when: control.policy === T.ScrollBar.AlwaysOn
              || (control.active && control.size < 1.0)
    }

    transitions: [
        Transition {
            to: "active"

            NumberAnimation {
                targets: [control.contentItem, control.background]
                property: "opacity"
                to: 1.0
            }
        },
        Transition {
            from: "active"

            SequentialAnimation {
                PropertyAction{
                    targets: [control.contentItem, control.background]
                    property: "opacity"
                    value: 1.0
                }
                PauseAnimation {
                    duration: 2450
                }
                NumberAnimation {
                    targets: [control.contentItem, control.background]
                    property: "opacity"
                    to: 0.0
                }
            }
        }
    ]
}
