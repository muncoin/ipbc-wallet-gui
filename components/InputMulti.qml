// Copyright (c) 2014-2015, The Monero Project
// Copyright (c) 2018, The BitTube Project
//
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, are
// permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this list of
//    conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice, this list
//    of conditions and the following disclaimer in the documentation and/or other
//    materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its contributors may be
//    used to endorse or promote products derived from this software without specific
//    prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
// THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import QtQuick.Controls 2.0
import QtQuick 2.7

import "../js/TxUtils.js" as TxUtils
import "../components" as MoneroComponents


TextArea {
    property bool error: false
    property bool addressValidation: false
    property bool wrapAnywhere: true
    property int fontSize: 18 * scaleRatio
    property bool fontBold: false

    id: textArea
    font.family: MoneroComponents.Style.fontRegular.name
    font.pixelSize: fontSize
    font.bold: fontBold
    horizontalAlignment: TextInput.AlignLeft
    selectByMouse: true
    color: MoneroComponents.Style.defaultFontColor
    selectionColor: MoneroComponents.Style.dimmedFontColor
    selectedTextColor: MoneroComponents.Style.defaultFontColor

    wrapMode: {
        if(wrapAnywhere){
            return Text.WrapAnywhere;
        } else {
            return Text.WordWrap;
        }
    }
    onTextChanged: {
        if(addressValidation){
            // js replacement for `RegExpValidator { regExp: /[0-9A-Fa-f]{95}/g }`
            textArea.text = textArea.text.replace(/[^a-z0-9.@]/gi,'');
            var address_ok = TxUtils.checkAddress(textArea.text, appWindow.persistentSettings.nettype);
            if(!address_ok) error = true;
            else error = false;
            TextArea.cursorPosition = textArea.text.length;
        }
    }
}
