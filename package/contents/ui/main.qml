import QtQuick 
import QtQuick.Layouts 
import org.kde.plasma.plasmoid 
import org.kde.plasma.components as PlasmaComponents
import Qt.labs.folderlistmodel


PlasmoidItem {
    fullRepresentation: Item {
        Layout.preferredHeight: 400
        Layout.preferredWidth: 600

        GridView {
            width: 600
            height: 400
            cellWidth: 100
            cellHeight: 100
            

            model: FolderListModel {
                folder: "file:///home/aurus28/Pictures/Wallpapers"
                nameFilters: ["*.jpg", "*.jpeg", "*.png"]
                showDirs: false
            }

            delegate: Image {
                width: 90
                height: 90
                source: fileUrl
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                sourceSize.width: 90
                sourceSize.height: 90

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        var process = Qt.createQmlObject('import QtQuick 2.0; import QtCore; Process {}', parent);
                        var command = "plasma-apply-wallpaperimage " + fileUrl

                        
                        process.program = "/bin/sh";
                        process.arguments = ["-c", command];
                        process.start();
                    }
                }
            }
        }
    }
}
