class ImageResponseModel {
  int? statusCode;
  String? imageUrl;

  ImageResponseModel({this.statusCode, this.imageUrl});

  factory ImageResponseModel.fromJson({
    required Map<String, dynamic> json,
    required int statusCode,
  }) {
    return ImageResponseModel(
      statusCode: statusCode,
      imageUrl: json["url"] ?? "",
    );
  }
}
