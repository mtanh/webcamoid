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

T.ScrollIndicator {
    id: control
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    padding: Ak.newUnit(2 * ThemeSettings.controlScale, "dp").pixels
    leftPadding: Ak.newUnit(4 * ThemeSettings.controlScale, "dp").pixels
    rightPadding: Ak.newUnit(4 * ThemeSettings.controlScale, "dp").pixels

    readonly property int fadeInTime: 200
    readonly property int fadeOutTime: 450

    contentItem: Rectangle {
        id: indicatorRect
        implicitWidth: Ak.newUnit(6 * ThemeSettings.controlScale, "dp").pixels
        implicitHeight: Ak.newUnit(6 * ThemeSettings.controlScale, "dp").pixels
        radius: Math.min(implicitWidth, implicitHeight) / 2
        color: ThemeSettings.colorPrimary
        visible: control.size < 1.0
        opacity: 0.0
    }

    PropertyAnimation {
        id: fadeIn
        target: indicatorRect
        property: "opacity"
        to: 1
        duration: control.fadeInTime
    }

    SequentialAnimation {
        id: fadeOut

        PauseAnimation {
            duration: control.fadeOutTime
        }
        PropertyAnimation {
            target: indicatorRect
            property: "opacity"
            duration: control.fadeInTime
        }
    }

    onActiveChanged: {
        if (active){
            fadeOut.stop()
            fadeIn.start()
        } else {
            fadeIn.stop()
            fadeOut.start()
        }
    }
}
