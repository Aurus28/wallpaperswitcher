import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import QtCore
import org.kde.plasma.components as PlasmaComponents

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

    // Aspect Ratio
    RowLayout {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignTop

        Layout.leftMargin: 10
        Layout.rightMargin: 10

        Controls.Label {
            text: i18n("Aspect Ratio:")

            Layout.alignment: Qt.AlignLeft
            //Layout.fillWidth: true
        }

        Controls.SpinBox {
            from: 1
            to: 2000
            value: plasmoid.configuration.aspectX

            onValueChanged: {
                plasmoid.configuration.aspectX = value
            }
        }

        Controls.Label {
            text: i18n(":")
        }

        Controls.SpinBox {
            from: 1
            to: 2000
            value: plasmoid.configuration.aspectY

            onValueChanged: {
                plasmoid.configuration.aspectY = value
            }

            // Layout.alignment: Qt.AlignRight
        }
    }
    

    // Rows
    RowLayout {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignTop

        Layout.leftMargin: 10
        Layout.rightMargin: 10

        Controls.Label {
            text: i18n("Number of Rows:")

            Layout.alignment: Qt.AlignLeft
        }

        Controls.SpinBox {
            from: 1
            to: 5
            value: plasmoid.configuration.rowCount

            onValueChanged: {
                plasmoid.configuration.rowCount = value
            }

            Layout.alignment: Qt.AlignRight
        }
    }


    // Columns
    RowLayout {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignTop

        Layout.leftMargin: 10
        Layout.rightMargin: 10

        Controls.Label {
            text: i18n("Number of columns:")

            Layout.alignment: Qt.AlignLeft
        }

        Controls.SpinBox {
            from: 1
            to: 5
            value: plasmoid.configuration.colCount

            onValueChanged: {
                plasmoid.configuration.colCount = value
            }

            Layout.alignment: Qt.AlignRight
        }
    }


    // Margins
    RowLayout {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignTop

        Layout.leftMargin: 10
        Layout.rightMargin: 10

        Controls.Label {
            text: i18n("Margins between pictures (in pt):")

            Layout.alignment: Qt.AlignLeft
        }

        Controls.SpinBox {
            from: 0
            to: 100
            value: plasmoid.configuration.margins

            onValueChanged: {
                plasmoid.configuration.margins = value
            }

            Layout.alignment: Qt.AlignRight
        }
    }
    
    
    // Margins
    RowLayout {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignTop

        Layout.leftMargin: 10
        Layout.rightMargin: 10

        Controls.Label {
            text: i18n("Image Width")

            Layout.alignment: Qt.AlignLeft
        }

        Controls.SpinBox {
            from: 100
            to: 1000
            value: plasmoid.configuration.imageWidth

            onValueChanged: {
                plasmoid.configuration.imageWidth = value
            }

            Layout.alignment: Qt.AlignRight
        }
    }

    // hide widget toggle
    PlasmaComponents.CheckBox {
        Layout.leftMargin: 10

        text: "Hide icon unless editing"
        checked: plasmoid.configuration.hideUnlessEditMode
        onCheckedChanged: plasmoid.configuration.hideUnlessEditMode = checked
    }

    // also change lockscreen toggle
    PlasmaComponents.CheckBox {
        Layout.leftMargin: 10

        text: "Also change lockscreen wallpaper"
        checked: plasmoid.configuration.changeLockscreen
        onCheckedChanged: plasmoid.configuration.changeLockscreen = checked
    }

}
