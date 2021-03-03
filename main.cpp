#include <QQmlContext>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "recorder.h"

#if defined (Q_OS_ANDROID)

#include <QtAndroid>
// android permissions
const QVector<QString> permissions({
	"android.permission.WRITE_EXTERNAL_STORAGE",
	"android.permission.READ_EXTERNAL_STORAGE"
});

#endif



int main(int argc, char *argv[]){

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif


#if defined (Q_OS_ANDROID)
	//Request requiered permissions at runtime
	for(const QString &permission : permissions){
		auto result = QtAndroid::checkPermission(permission);
		if(result == QtAndroid::PermissionResult::Denied){
			auto resultHash = QtAndroid::requestPermissionsSync(QStringList({permission}));
			if(resultHash[permission] == QtAndroid::PermissionResult::Denied)
				return 0;
		}
	}
#endif


	QGuiApplication app(argc, argv);
	Recorder *recorder = new Recorder();

	QQmlApplicationEngine engine;
	const QUrl url(QStringLiteral("qrc:/main.qml"));
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
					 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);

	engine.rootContext()->setContextProperty("recorder", recorder);
	engine.load(url);

	return app.exec();
}
