/* Webcamoid, webcam capture application.
 * Copyright (C) 2016  Gonzalo Exequiel Pedone
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

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import AkQmlControls 1.0

GridLayout {
    columns: 3

    function fromRgba(rgba)
    {
        var a = ((rgba >> 24) & 0xff) / 255.0
        var r = ((rgba >> 16) & 0xff) / 255.0
        var g = ((rgba >> 8) & 0xff) / 255.0
        var b = (rgba & 0xff) / 255.0

        return Qt.rgba(r, g, b, a)
    }

    function toRgba(color)
    {
        var a = Math.round(255 * color.a) << 24
        var r = Math.round(255 * color.r) << 16
        var g = Math.round(255 * color.g) << 8
        var b = Math.round(255 * color.b)

        return a | r | g | b
    }

    Connections {
        target: Vignette

        onAspectChanged: {
            sldAspect.value = aspect
            spbAspect.value = spbAspect.multiplier * aspect
        }

        onScaleChanged: {
            sldScale.value = scale
            spbScale.value = spbScale.multiplier * scale
        }

        onSoftnessChanged: {
            sldSoftness.value = softness
            spbSoftness.value = spbSoftness.multiplier * softness
        }
    }

    Label {
        text: qsTr("Color")
    }
    RowLayout {
        Layout.columnSpan: 2

        Item {
            Layout.fillWidth: true
        }
        AkColorButton {
            currentColor: fromRgba(Vignette.color)
            title: qsTr("Choose the vignette color")
            showAlphaChannel: true

            onCurrentColorChanged: Vignette.color = toRgba(currentColor)
        }
    }

    Label {
        id: lblAspect
        //: Aspect ratio
        text: qsTr("Aspect")
    }
    Slider {
        id: sldAspect
        value: Vignette.aspect
        stepSize: 0.01
        to: 1
        Layout.fillWidth: true

        onValueChanged: Vignette.aspect = value
    }
    SpinBox {
        id: spbAspect
        value: multiplier * Vignette.aspect
        to: multiplier * sldAspect.to
        stepSize: multiplier * sldAspect.stepSize
        editable: true

        readonly property int decimals: 2
        readonly property int multiplier: Math.pow(10, decimals)

        validator: DoubleValidator {
            bottom: Math.min(spbAspect.from, spbAspect.to)
            top:  Math.max(spbAspect.from, spbAspect.to)
        }
        textFromValue: function(value, locale) {
            return Number(value / multiplier).toLocaleString(locale, 'f', decimals)
        }
        valueFromText: function(text, locale) {
            return Number.fromLocaleString(locale, text) * multiplier
        }
        onValueModified: Vignette.aspect = value / multiplier
    }

    Label {
        id: lblScale
        text: qsTr("Scale")
    }
    Slider {
        id: sldScale
        value: Vignette.scale
        stepSize: 0.01
        to: 1
        Layout.fillWidth: true

        onValueChanged: Vignette.scale = value
    }
    SpinBox {
        id: spbScale
        value: multiplier * Vignette.scale
        to: multiplier * sldScale.to
        stepSize: multiplier * sldScale.stepSize
        editable: true

        readonly property int decimals: 2
        readonly property int multiplier: Math.pow(10, decimals)

        validator: DoubleValidator {
            bottom: Math.min(spbScale.from, spbScale.to)
            top:  Math.max(spbScale.from, spbScale.to)
        }
        textFromValue: function(value, locale) {
            return Number(value / multiplier).toLocaleString(locale, 'f', decimals)
        }
        valueFromText: function(text, locale) {
            return Number.fromLocaleString(locale, text) * multiplier
        }
        onValueModified: Vignette.scale = value / multiplier
    }

    Label {
        id: lblSoftness
        text: qsTr("Softness")
    }
    Slider {
        id: sldSoftness
        value: Vignette.softness
        stepSize: 0.01
        to: 1
        Layout.fillWidth: true

        onValueChanged: Vignette.softness = value
    }
    SpinBox {
        id: spbSoftness
        value: multiplier * Vignette.softness
        to: multiplier * sldSoftness.to
        stepSize: multiplier * sldSoftness.stepSize
        editable: true

        readonly property int decimals: 2
        readonly property int multiplier: Math.pow(10, decimals)

        validator: DoubleValidator {
            bottom: Math.min(spbSoftness.from, spbSoftness.to)
            top:  Math.max(spbSoftness.from, spbSoftness.to)
        }
        textFromValue: function(value, locale) {
            return Number(value / multiplier).toLocaleString(locale, 'f', decimals)
        }
        valueFromText: function(text, locale) {
            return Number.fromLocaleString(locale, text) * multiplier
        }
        onValueModified: Vignette.softness = value / multiplier
    }
}
