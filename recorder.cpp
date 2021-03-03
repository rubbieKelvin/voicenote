#include "recorder.h"
#include <QAudioRecorder>
#include <QMultimedia>
#include <QUrl>
#include <QDir>
#include <QDebug>
#include <QStandardPaths>
#include <QDateTime>

Recorder::Recorder(){
	recorder = new QAudioRecorder(this);
	codecs = recorder->supportedAudioCodecs();

	QString baseurl = QStandardPaths::writableLocation(QStandardPaths::MusicLocation);
	path = QDir::cleanPath(baseurl + QDir::separator() + ".voicenotes");

	emit pathChanged(getPath());
	
	if (! QDir(path).exists()){
		QDir().mkdir(path);
	}

	connect(recorder, &QAudioRecorder::durationChanged, this, &Recorder::durationChanged);
}

bool Recorder::getRunning(){
	return running;
}

void Recorder::record(){
	if (running) {
		// stop recording
		qDebug() << "stopping...";
		running = false;
		recorder->stop();


	}else{
		// start recording
		running = true;

		QDateTime datetime = QDateTime::currentDateTime();
		qDebug() << datetime.toString("ddd_MMMM_yyyy-h_m_s");

		
		QString filename = datetime.toString("ddd_MMMM_yyyy-h_m_s").append("-voicenote.wav");

		QString filepath = QDir::cleanPath(path + QDir::separator() + filename);

		QAudioEncoderSettings audiosetting;

		audiosetting.setCodec(codec);

		qDebug() << "using codec: " << codec;
		audiosetting.setQuality(QMultimedia::HighQuality);

		recorder->setEncodingSettings(audiosetting);
		recorder->setOutputLocation(QUrl::fromLocalFile(filepath));

		qDebug() << recorder->outputLocation();
		recorder->record();

	}

	emit runningChanged(running);
}


QStringList Recorder::getCodecs(){
	return codecs;
}


void Recorder::setdCodec(QString value){
	codec = value;
}

QUrl Recorder::getPath(){
	return QUrl::fromLocalFile(path);
}
