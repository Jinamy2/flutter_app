import 'package:sensors/sensors.dart';

class GyroscopeService {
  static final GyroscopeService _singleton = GyroscopeService._internal();
  factory GyroscopeService() {
    return _singleton;
  }
  GyroscopeService._internal();
  final StringBuffer _gyroscopeStringBuffer = StringBuffer();

  String tiltDirection = '';

  void startListening() {
    gyroscopeEvents.listen((event) {
      _gyroscopeStringBuffer.clear();
      _gyroscopeStringBuffer.write('X: ${event.x.toStringAsFixed(2)}, ');
      _gyroscopeStringBuffer.write('Y: ${event.y.toStringAsFixed(2)}, ');
      _gyroscopeStringBuffer.write('Z: ${event.z.toStringAsFixed(2)}');
      // if (event.x > 1.0) {
      //   tiltDirection = 'Вправо';
      // } else if (event.x < -1.0) {
      //   tiltDirection = 'Влево';
      // } else {
      //   tiltDirection = 'Прямо';
      // }
    });
  }

  String get gyroscopeData => _gyroscopeStringBuffer.toString();
}
