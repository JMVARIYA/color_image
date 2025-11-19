import 'dart:convert';

import '../model/image_response_model.dart';
import 'package:http/http.dart' as http;

final apiUrl = "https://november7-730026606190.europe-west1.run.app/image";

Future<ImageResponseModel> getImageData() {
  return http.get(Uri.parse(apiUrl)).then((http.Response response) {
    return ImageResponseModel.fromJson(
      json: json.decode(response.body),
      statusCode: response.statusCode,
    );
  });
}
