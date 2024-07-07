import "dart:convert";
import "package:http/http.dart" as http;

class CuacaServices {
  Future<Map<String, dynamic>> getDataFromAPI(String cityName) async {
    var response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=e12b071afe0de3f217113138d08fe0e2&units=metric"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {"data": data};
    } else {
      final error = json.decode(response.body);
      return {"error": error["message"]};
    }
  }
}
