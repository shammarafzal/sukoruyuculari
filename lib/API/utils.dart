import 'dart:convert';
import 'package:http/http.dart' as http;

class Utils{
  final String baseUrl = 'okuyolla.com';

  getImages() async {
    var url = Uri.http(baseUrl,
        '/sukoruyuculari/rest.php', {"q": "dart"});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return (jsonDecode(responseString));
    }
  }

}