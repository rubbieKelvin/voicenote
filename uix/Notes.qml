import QtQuick 2.12
import QtQuick.Controls 2.5
import "../fontawesome/" as FA
import "../scripts/color.js" as Color
import QtQuick.Controls.Material 2.12
import Qt.labs.folderlistmodel 2.15
import "../components" as UiComponents


Page{
	id: root
	background: Rectangle{color: "#ffffff"}

	header: ToolBar{
		Material.elevation: 0

		background: Rectangle{
			color: "white"
			implicitHeight: 60
		}

		Label {
			x: 10
			text: "Notes"
			color: "#333333"
			anchors.verticalCenter: parent.verticalCenter
			verticalAlignment: Text.AlignVCenter
			font.weight: Font.Medium
			font.pointSize: 24
		}
	}

	ListView {
		id: listView
		anchors.fill: parent
		model: FolderListModel {
			nameFilters: ["*-voicenote.**"]
			folder: recorder.folder
		}
		delegate: UiComponents.VoiceNoteModel{
			filename: fileName
			width: parent.width
		}
	}	
}

/*##^##
Designer {
	D{i:0;autoSize:true;formeditorZoom:0.5;height:850;width:400}D{i:5}
}
##^##*/
