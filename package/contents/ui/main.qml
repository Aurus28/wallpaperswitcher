import QtQuick 
import QtCore
import QtQuick.Layouts 
import org.kde.plasma.plasmoid 
import org.kde.plasma.components as PlasmaComponents
import Qt.labs.folderlistmodel
import org.kde.plasma.plasma5support as Plasma5Support




PlasmoidItem {
    Plasma5Support.DataSource {
        id: executable
        engine: "executable"

        onNewData: function(sourceName, data) {
            disconnectSource(sourceName)
        }
    }


    property string wallpaperFolder:
        plasmoid.configuration.folderPath ||
        StandardPaths.writableLocation(StandardPaths.PicturesLocation)
        + "/Wallpapers/"


    fullRepresentation: Item {
        Layout.preferredHeight: 400
        Layout.preferredWidth: 600


        // debug
        Component.onCompleted: {
            console.log("configured folder:", plasmoid.configuration.folderPath)
            console.log("effective folder:", wallpaperFolder)
        }


        GridView {
            width: plasmoid.configuration.popupWidth
            height: plasmoid.configuration.popupHeight
            cellWidth: plasmoid.configuration.pictureWidth + 10
            cellHeight: plasmoid.configuration.pictureHeigth + 10
            

            model: FolderListModel {
                folder: wallpaperFolder
                nameFilters: ["*.jpg", "*.jpeg", "*.png"]
                showDirs: false
            }

            delegate: Image {
                width: plasmoid.configuration.pictureWidth
                height: plasmoid.configuration.pictureHeight
                source: fileUrl
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                sourceSize.width: plasmoid.configuration.pictureWidth
                sourceSize.height: plasmoid.configuration.pictureHeight

                MouseArea {
                    anchors.fill: parent
                    onClicked: {

                        let path = fileUrl.toString().replace(/^file:\/\//, "")
                        executable.connectSource(
                            "plasma-apply-wallpaperimage " +
                            path
                        )
                    }
                }
            }
        }
    }
}
