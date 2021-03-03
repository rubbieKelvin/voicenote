import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "../fontawesome" as FA
import "../scripts/color.js" as Color

Rectangle{
	id: root
	height: 60

	property alias filename : filename.text

	RoundButton {
		id: roundButton
		y: 8
		width: 40
		height: 40
		text: FA.FontAwesome.play
		anchors.verticalCenter: parent.verticalCenter
		anchors.left: parent.left
		anchors.leftMargin: 14
		font.family: FA.FontAwesome.fontFamily
		Material.elevation: 0
		background: Rectangle{
			anchors.fill: parent
			radius: parent.radius
			color: `#${Color.primary}`

		}

		contentItem: Label{
			id: label
			anchors.centerIn: parent
			font: parent.font
			text: parent.text
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
			color: "#ffffff"
			clip: true
		}

		onClicked: {
			audio_player.stop();
			audio_player.source = recorder.folder + "/" + filename.text;
			audio_player.play();
		}
	}

	Label {
		id: filename
		y: 8
		height: 44
		text: qsTr("Label")
		anchors.left: roundButton.right
		anchors.right: parent.right
		verticalAlignment: Text.AlignVCenter
		anchors.leftMargin: 10
		anchors.rightMargin: 14
	}


}
