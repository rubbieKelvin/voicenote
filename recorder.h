#ifndef RECORDER_H
#define RECORDER_H
#include <QUrl>
#include <QObject>
#include <QAudioRecorder>


class Recorder: public QObject {
	Q_OBJECT
	Q_PROPERTY(bool running READ getRunning NOTIFY runningChanged)
	Q_PROPERTY(QStringList codecs READ getCodecs NOTIFY codecsChanged)
	Q_PROPERTY(QUrl folder READ getPath NOTIFY pathChanged)

	signals:
		void runningChanged(bool value);
		void durationChanged(qint64 value);
		void codecsChanged(QStringList list);
		void pathChanged(QUrl value);

	public:
		Recorder();
		bool getRunning();
		QStringList getCodecs();
		QUrl getPath();

	private:
		bool running = false;
		QAudioRecorder *recorder = nullptr;
		QStringList codecs;
		QString codec;
		QString path;

	public slots:
		void record ();
		void setdCodec (QString value);

};

#endif // RECORDER_H
