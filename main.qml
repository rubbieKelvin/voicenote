import QtQuick 2.12
import QtQuick.Controls 2.5
import "./uix" as UiX
import QtMultimedia 5.12

ApplicationWindow {
	id: window
	width: 640
	height: 480
	visible: true
	title: qsTr("Stack")
	font.family: app_font.name

	FontLoader{
		id: app_font
		source: "./fonts/Nunito/Nunito-Regular.ttf"
	}

	MediaPlayer{
		id: audio_player
		autoPlay: false
	}

	// StackView {
	// 	id: application_stack
	// 	initialItem: "uix/home.qml"
	// 	anchors.fill: parent
	// }

	SwipeView {
		id: application_swipe
		anchors.fill: parent
		currentIndex: tab_bar.currentIndex

		UiX.Home{}
		UiX.Notes{}
		UiX.Settings{}
	}

	footer: TabBar {
		id: tab_bar
		currentIndex: application_swipe.currentIndex

		TabButton {
			text: qsTr("recorder")
		}

		TabButton{
			text: qsTr("notes")
		}

		TabButton {
			text: qsTr("settings")
		}
	}
}
