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
import QtQuick.Layouts 1.3
import QtQuick.Templates 2.5 as T
import QtQuick.Controls.impl 2.12
import AkQml 1.0

T.TabBar {
    id: tabBar
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    contentItem: ListView {
        model: tabBar.contentModel
        currentIndex: tabBar.currentIndex
        spacing: tabBar.spacing
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        flickableDirection: Flickable.AutoFlickIfNeeded
        snapMode: ListView.SnapToItem
        highlightMoveDuration: 250
        highlightResizeDuration: 0
        highlightFollowsCurrentItem: true
        highlightRangeMode: ListView.ApplyRange
        preferredHighlightBegin:
            Ak.newUnit(48 * ThemeSettings.controlScale, "dp").pixels
        preferredHighlightEnd:
            width - Ak.newUnit(48 * ThemeSettings.controlScale, "dp").pixels

        highlight: Item {
            z: 2

            Rectangle {
                height:
                    Ak.newUnit(2 * ThemeSettings.controlScale, "dp").pixels
                width: parent.width
                y: tabBar.position === T.TabBar.Footer?
                       0: parent.height - height
                color: ThemeSettings.colorPrimary
            }
        }
    }

    background: Rectangle {
        color: "transparent"
    }
}
