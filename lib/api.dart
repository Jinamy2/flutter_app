import 'dart:convert'as convert;
import 'dart:convert';
import 'package:hello_flutter/geo.dart';
import 'package:http/http.dart' as http;

Future<String> createAndress() async {
  var position = await determinePosition();
  final payload = {"lat": position.latitude, "lon": position.longitude};
  final response = await http.post(
    Uri.parse(
        'https://suggestions.dadata.ru/suggestions/api/4_1/rs/geolocate/address'),
    body: json.encode(payload),
    headers: {
      'Authorization': 'Token a29000408ff35f96119caf675e6714e746d6391d',
      'Content-Type': 'application/json',
    },
  );
  var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

  if (response.statusCode == 201) {
     
   } else {
  //   print('Request failed with status: ${response.statusCode}.');
   }
  return jsonResponse['suggestions'][0]['value'].toString();
}
