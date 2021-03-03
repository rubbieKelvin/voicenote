import QtQuick 2.12
import QtQuick.Controls 2.5
import "../fontawesome/" as FA
import "../scripts/color.js" as Color
import QtQuick.Controls.Material 2.12

Page{
	id: root

	header: ToolBar{
		id: toolBar
		Material.elevation: 0
		Material.foreground: "white"

		background: Rectangle{
			color: `#${Color.primary}`
			implicitHeight: 60
		}

		Label {
			x: 10
			color: "#ddffffff"
			text: "Voice Note"
			anchors.verticalCenter: parent.verticalCenter
			verticalAlignment: Text.AlignVCenter
			font.weight: Font.Medium
			font.pointSize: 24
		}
	}

	Rectangle {
		id: rectangle
		color: `#${Color.primary}`
		anchors.top: parent.top
		anchors.bottom: rectangle1.top
		width: parent.width

		Label {
			id: timer_label
			x: 120
			y: 188
			color: "#ffffff"
			text: qsTr("00 : 00")
			anchors.verticalCenter: parent.verticalCenter
			anchors.horizontalCenter: parent.horizontalCenter
			font.pointSize: 60
		}
	}

	Rectangle {
		id: rectangle1
		height: parent.height * .3
		anchors.bottom: parent.bottom
		width: parent.width
		color: "#ffffff"

		Rectangle{
			id: anim_rect
			color: `#33${Color.primary}`
			radius: width * .5
			height: width
			width: 90
			anchors.centerIn: parent
		}


		NumberAnimation {
			id: circle_anim
			target: anim_rect
			property: "width"
			duration: 1000
			easing.type: Easing.InOutQuad
			from: 90
			to: 400
			loops: -1
			running: false
		}

		Connections{
			target: recorder

			function onRunningChanged(value){
				if (recorder.running) {
					circle_anim.restart();
				}else{
					anim_rect.width = 90;
					circle_anim.from = 90;
					circle_anim.to = 400;
					circle_anim.stop();
					
					application_swipe.currentIndex = 1;
					application_swipe.currentIndex = Qt.binding(function (){
						return tab_bar.currentIndex;
					})
				}
			}

			function onDurationChanged(value){
				let time = new Date(value);
				let sec = time.getSeconds();
				let minutes = time.getMinutes();

				function two_digits(v) {
					if (v<10) return `0${v}`;
					else return v;
				}

				let sec_text = two_digits(sec);
				let min_text = two_digits(minutes);
				let label = `${min_text} : ${sec_text}`;
				timer_label.text = label;

			}
		}

		RoundButton {
			id: roundButton
			width: 100
			height: 100
			text: FA.FontAwesome.microphone
			font.family: FA.FontAwesome.fontFamily
			anchors.verticalCenter: parent.verticalCenter
			font.pointSize: 28
			contentItem: Label{
				font: parent.font
				text: parent.text
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter
				color: "white"
				anchors.centerIn: parent
			}

			anchors.horizontalCenter: parent.horizontalCenter
			background: Rectangle{
				color: `#${Color.primary}`
				radius: parent.radius
			}

			onClicked: recorder.record();
		}
	}
}
