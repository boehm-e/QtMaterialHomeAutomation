import QtQuick 2.5

import QtQuick 2.0
import QtQuick.Controls 1.0
import QtWebKit 3.0

ScrollView {
    anchors.fill: parent
    property string weburl: "http://localhost"
    WebView {
        id: webview
        url: weburl
        anchors.fill: parent
        onNavigationRequested: {
            // detect URL scheme prefix, most likely an external link
            var schemaRE = /^\w+:/;
            if (schemaRE.test(request.url)) {
                request.action = WebView.AcceptRequest;
            } else {
                request.action = WebView.IgnoreRequest;
                // delegate request.url here
            }
        }
    }
}
