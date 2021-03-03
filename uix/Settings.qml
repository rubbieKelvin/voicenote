import QtQuick 2.12
import QtQuick.Controls 2.5
import "../fontawesome/" as FA
import "../scripts/color.js" as Color
import QtQuick.Controls.Material 2.12

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
			text: "Settings"
			color: "#333333"
			anchors.verticalCenter: parent.verticalCenter
			verticalAlignment: Text.AlignVCenter
			font.weight: Font.Medium
			font.pointSize: 24
		}
	}

	ScrollView {
		id: scrollView
		anchors.fill: parent

		Column {
			id: column
			width: parent.parent.width
			height: childrenRect.height
			spacing: 10
			padding: 5

			Column {
				width: parent.parent.parent.width - 20
				height: childrenRect.height
				anchors.horizontalCenter: parent.horizontalCenter
				spacing: 3

				Label{
					text: "codec"
					font.pointSize: 15
				}

				ComboBox{
					id: codec_combo
					width: parent.width
					height: 60
					flat: true
					font.pointSize: 16
					displayText: "Default"
					model: recorder.codecs

					onCurrentValueChanged: {
						recorder.setdCodec(currentValue);
						displayText = currentValue;
					}

				}
			}
		}
	}
}

/*##^##
Designer {
	D{i:0;autoSize:true;formeditorZoom:0.5;height:850;width:400}D{i:7}D{i:6}D{i:5}
}
##^##*/
