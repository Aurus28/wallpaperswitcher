import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import QtCore

ColumnLayout {
    width: 300
    Layout.alignment: Qt.AlignTop

    RowLayout {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignTop

        Layout.leftMargin: 10
        Layout.rightMargin: 10


        Controls.Label {
            text: i18n("Wallpaper folder")
        }

        Controls.TextField {
            id: folderField

            text: plasmoid.configuration.folderPath
            readOnly: true

            Layout.fillWidth: true
        }

        Controls.Button {
            text: i18n("Choose…")

            onClicked: folderDialog.open()
        }
    }

    FolderDialog {
        id: folderDialog

        title: i18n("Choose wallpaper folder")

        onAccepted: {
            let path = selectedFolder.toString()

            plasmoid.configuration.folderPath = path
        }
    }

    // Popup width
    RowLayout {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignTop

        Layout.leftMargin: 10
        Layout.rightMargin: 10

        Controls.Label {
            text: i18n("Popup width:")

            Layout.alignment: Qt.AlignLeft
            //Layout.fillWidth: true
        }

        Controls.SpinBox {
            from: 100
            to: 2000
            value: plasmoid.configuration.popupWidth

            onValueChanged: {
                plasmoid.configuration.popupWidth = value
            }

            Layout.alignment: Qt.AlignRight
        }
    }
    

    // Popup height
    RowLayout {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignTop

        Layout.leftMargin: 10
        Layout.rightMargin: 10

        Controls.Label {
            text: i18n("Popup height:")

            Layout.alignment: Qt.AlignLeft
        }

        Controls.SpinBox {
            from: 100
            to: 2000
            value: plasmoid.configuration.popupHeight

            onValueChanged: {
                plasmoid.configuration.popupHeight = value
            }

            Layout.alignment: Qt.AlignRight
        }
    }


    // Picture width
    RowLayout {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignTop

        Layout.leftMargin: 10
        Layout.rightMargin: 10

        Controls.Label {
            text: i18n("Picture width:")

            Layout.alignment: Qt.AlignLeft
        }

        Controls.SpinBox {
            from: 20
            to: 500
            value: plasmoid.configuration.pictureWidth

            onValueChanged: {
                plasmoid.configuration.pictureWidth = value
            }

            Layout.alignment: Qt.AlignRight
        }
    }


    // Picture height
    RowLayout {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignTop

        Layout.leftMargin: 10
        Layout.rightMargin: 10

        Controls.Label {
            text: i18n("Picture height:")

            Layout.alignment: Qt.AlignLeft
        }

        Controls.SpinBox {
            from: 20
            to: 500
            value: plasmoid.configuration.pictureHeight

            onValueChanged: {
                plasmoid.configuration.pictureHeight = value
            }

            Layout.alignment: Qt.AlignRight
        }
    }

}
