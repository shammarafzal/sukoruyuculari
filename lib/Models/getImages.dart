// To parse this JSON data, do
//
//     final getImages = getImagesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetImages getImagesFromJson(String str) => GetImages.fromJson(json.decode(str));

String getImagesToJson(GetImages data) => json.encode(data.toJson());

class GetImages {
  GetImages({
    required this.status,
    required this.data,
  });

  bool status;
  List<Datum> data;

  factory GetImages.fromJson(Map<String, dynamic> json) => GetImages(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.imageUrl,
    required this.text,
  });

  String imageUrl;
  String text;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    imageUrl: json["image_url"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "image_url": imageUrl,
    "text": text,
  };
}
