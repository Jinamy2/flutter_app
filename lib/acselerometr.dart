import 'package:sensors/sensors.dart';

class AccelerometrService {
  static final AccelerometrService _singleton = AccelerometrService._internal();
  factory AccelerometrService() {
    return _singleton;
  }
  AccelerometrService._internal();
  final StringBuffer _accelerometerStringBuffer = StringBuffer();


  String tiltDirection = '';

  void startListening() {
    
    accelerometerEvents.listen((event) {
      _accelerometerStringBuffer.clear();
      _accelerometerStringBuffer.write('X: ${event.x.toStringAsFixed(2)}, ');
      _accelerometerStringBuffer.write('Y: ${event.y.toStringAsFixed(2)}, ');
      _accelerometerStringBuffer.write('Z: ${event.z.toStringAsFixed(2)}');
    });

  }

  
  String get accelerometerData => _accelerometerStringBuffer.toString();
}
