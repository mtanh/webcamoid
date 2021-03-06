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
import AkQml 1.0

T.ToolSeparator {
    id: control
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    horizontalPadding: vertical?
                           Ak.newUnit(12 * ThemeSettings.controlScale,
                                      "dp").pixels:
                           Ak.newUnit(5 * ThemeSettings.controlScale,
                                      "dp").pixels
    verticalPadding: vertical?
                         Ak.newUnit(5 * ThemeSettings.controlScale,
                                    "dp").pixels:
                         Ak.newUnit(12 * ThemeSettings.controlScale,
                                    "dp").pixels

    contentItem: Rectangle {
        implicitWidth: vertical?
                           Ak.newUnit(1 * ThemeSettings.controlScale,
                                      "dp").pixels:
                           Ak.newUnit(48 * ThemeSettings.controlScale,
                                      "dp").pixels
        implicitHeight: vertical?
                            Ak.newUnit(48 * ThemeSettings.controlScale,
                                       "dp").pixels:
                            Ak.newUnit(1 * ThemeSettings.controlScale,
                                       "dp").pixels
        color: ThemeSettings.shade(ThemeSettings.colorBack, -0.1)
    }
}
