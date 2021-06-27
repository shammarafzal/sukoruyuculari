import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sukoruyuculari/Models/getImages.dart';

class Utils{
  final String baseUrl = 'okuyolla.com';

  Future<GetImages> fetchImages() async {
    var url = Uri.https(baseUrl, '/sukoruyuculari/rest.php', {"q": "dart"});
    final response = await http.get(url);
    return GetImages.fromJson(jsonDecode(response.body));
  }

}