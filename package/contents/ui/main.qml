import QtQuick 
import QtCore
import QtQuick.Layouts 
import org.kde.plasma.plasmoid 
import org.kde.plasma.components as PlasmaComponents
import Qt.labs.folderlistmodel
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore





PlasmoidItem {
    id: widget

    preferredRepresentation: compactRepresentation

    Plasmoid.status: plasmoid.configuration.hideUnlessEditMode
        ? PlasmaCore.Types.HiddenStatus
        : PlasmaCore.Types.PassiveStatus

    //Plasmoid.onStatusChanged: console.log("status is now:", Plasmoid.status)


    compactRepresentation: Item {
        id: compactWrapper

        readonly property bool inEditMode:
            plasmoid.containment && plasmoid.containment.corona
            ? plasmoid.containment.corona.editMode : false

        readonly property bool shouldShow:
            !plasmoid.configuration.hideUnlessEditMode || inEditMode

        Layout.minimumWidth: shouldShow ? Kirigami.Units.iconSizes.small : 0
        Layout.minimumHeight: shouldShow ? Kirigami.Units.iconSizes.small : 0
        Layout.preferredWidth: Layout.minimumWidth
        Layout.preferredHeight: Layout.minimumHeight

        Loader {
            anchors.fill: parent
            active: compactWrapper.shouldShow

            onActiveChanged: {
                Plasmoid.backgroundHints = compactWrapper.shouldShow ? PlasmaCore.Types.DefaultBackground : PlasmaCore.Types.NoBackground
                //console.log("Changed Background Hints!")
            }

            sourceComponent: Kirigami.Icon {
                source: Plasmoid.icon
                MouseArea {
                    anchors.fill: parent
                    onClicked: widget.expanded = !widget.expanded
                }
            }
        }
    }

    Plasma5Support.DataSource {
        id: executable
        engine: "executable"

        onNewData: function(sourceName, data) {
            disconnectSource(sourceName)
        }
    }

    function applyWallpaper(url) {
        if (!url) return
        let path = decodeURIComponent(url.toString().replace(/^file:\/\//, ""))
        let escaped = path.replace(/'/g, "'\\''")
        executable.connectSource("plasma-apply-wallpaperimage '" + escaped + "'")
        widget.expanded = false
    }


    property string wallpaperFolder:
        plasmoid.configuration.folderPath ||
        StandardPaths.writableLocation(StandardPaths.PicturesLocation)
        + "/Wallpapers/"


    fullRepresentation: Item {
        id: root

        readonly property int imgW: plasmoid.configuration.imageWidth
        readonly property int imgH: plasmoid.configuration.imageWidth
            * plasmoid.configuration.aspectY / plasmoid.configuration.aspectX
        readonly property int gap: plasmoid.configuration.margins

        Layout.preferredWidth:  grid.cellWidth  * plasmoid.configuration.colCount
        Layout.preferredHeight: grid.cellHeight * plasmoid.configuration.rowCount


        Component.onCompleted: { 
            grid.forceActiveFocus() 
        }

        Connections {
            target: widget
            function onExpandedChanged() {
                if (widget.expanded) grid.forceActiveFocus()
            }
        }

        GridView {
            id: grid
            anchors.fill: parent
            clip: true
            cellWidth:  root.imgW + root.gap
            cellHeight: root.imgH + root.gap

            highlightMoveDuration: 100
            highlight: Item {
                Rectangle {
                    anchors.centerIn: parent
                    width: root.imgW + 6
                    height: root.imgH + 6
                    radius: 10
                    color: "transparent"
                    border.width: 4
                    border.color: Kirigami.Theme.highlightColor
                }
            }

            Keys.onPressed: function(event) {
                switch (event.key) {
                case Qt.Key_H: grid.moveCurrentIndexLeft();  event.accepted = true; break
                case Qt.Key_J: grid.moveCurrentIndexDown();  event.accepted = true; break
                case Qt.Key_K: grid.moveCurrentIndexUp();    event.accepted = true; break
                case Qt.Key_L: grid.moveCurrentIndexRight(); event.accepted = true; break
                }
            }
            Keys.onReturnPressed: widget.applyWallpaper(grid.model.get(grid.currentIndex, "fileUrl"))
            Keys.onEnterPressed:  widget.applyWallpaper(grid.model.get(grid.currentIndex, "fileUrl"))
            Keys.onEscapePressed: widget.expanded = false

            model: FolderListModel {
                folder: wallpaperFolder
                nameFilters: ["*.jpg", "*.jpeg", "*.png"]
                showDirs: false
            }

            delegate: Item {
                width: grid.cellWidth
                height: grid.cellHeight

                Kirigami.ShadowedImage {
                    anchors.centerIn: parent
                    width: root.imgW
                    height: root.imgH
                    source: fileUrl
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                    sourceSize.width: root.imgW
                    sourceSize.height: root.imgH

                    radius: 8
                    border.width: 1
                    border.color: Kirigami.Theme.textColor

                    MouseArea {
                        anchors.fill: parent
                        onClicked: widget.applyWallpaper(fileUrl)
                    }
                }
            }
        }
    }
}
