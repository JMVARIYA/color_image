import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

import '../api/get_api.dart';
import '../model/image_response_model.dart';
import 'theme_controller.dart';

class ImageController extends ThemeController {
  RxBool isInternetConnect = false.obs;
  RxBool isServerError = false.obs;
  RxBool isEnablePullDown = false.obs;
  RxBool isLoading = false.obs;
  RxString imageUrl = "".obs;
  RxString errorMsg = "".obs;
  Color? bgColor;
  Map<String, Color> cornerColors = {
    "topLeft": Colors.grey,
    "topRight": Colors.grey,
    "bottomLeft": Colors.grey,
    "bottomRight": Colors.grey,
  };


  void initStateMethod() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchImageData();
    });
  }

  Future fetchImageData() async {
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();

    // if there is no internet connection
    if (result.contains(ConnectivityResult.none)) {
      isInternetConnect.value = false;
      isServerError.value = false;
      isLoading.value = false;
      errorMsg.value = "No Internet";
      return;
    }

    //Check here if swipe to refresh is open or not
    isInternetConnect.value = true;
    isServerError.value = false;
    if (isEnablePullDown.value) {
      isLoading.value = false;
    } else {
      isLoading.value = true;
    }

    ImageResponseModel imageResponseModel = await getImageData();

    if (imageResponseModel.statusCode == 200) {
      cornerColors = await getCornerColors(imageResponseModel.imageUrl!);
      imageUrl.value = imageResponseModel.imageUrl!;
      isServerError.value = false;
    } else {
      errorMsg.value = "Something went wrong";
      isServerError.value = true;
    }
    isEnablePullDown.value = false;
    isLoading.value = false;
  }

  Future<Map<String, Color>> getCornerColors(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final img.Image? decoded = img.decodeImage(response.bodyBytes);

      if (decoded == null) throw Exception();

      int w = decoded.width;
      int h = decoded.height;

      const int block = 4;

      Color avgColor(int startX, int startY) {
        int sumR = 0, sumG = 0, sumB = 0;
        int count = 0;

        for (int x = startX; x < startX + block; x++) {
          for (int y = startY; y < startY + block; y++) {
            img.Pixel pixel = decoded.getPixel(x, y);

            sumR += pixel.r.toInt();
            sumG += pixel.g.toInt();
            sumB += pixel.b.toInt();

            count++;
          }
        }

        return Color.fromARGB(
          255,
          sumR ~/ count,
          sumG ~/ count,
          sumB ~/ count,
        );
      }

      Color topLeft = avgColor(0, 0);
      Color topRight = avgColor(w - block - 1, 0);
      Color bottomLeft = avgColor(0, h - block - 1);
      Color bottomRight = avgColor(w - block - 1, h - block - 1);

      cornerColors = {
        "topLeft": topLeft,
        "topRight": topRight,
        "bottomLeft": bottomLeft,
        "bottomRight": bottomRight,
      };
      return cornerColors;
    } catch (e) {
      cornerColors = {
        "topLeft": Colors.grey,
        "topRight": Colors.grey,
        "bottomLeft": Colors.grey,
        "bottomRight": Colors.grey,
      };
      return cornerColors;
    }
  }
}
