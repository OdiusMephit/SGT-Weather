import "dart:convert";

import "package:http/http.dart" as http;
import '';

void main() async {
  Uri url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=jakarta&appid=e12b071afe0de3f217113138d08fe0e2&units=metric");
  // Uri url = Uri.parse("https://web-api.qurankemenag.net/quran-surah");
  var response = await http.get(url);
  print('Ini hasil sebelum decode: ${response.body}');
  print("====================================================================");
  if (response.statusCode == 200) {
    print('Ini hasilnya sesudah decode: ${json.decode(response.body)}');
    final data = json.decode(response.body);
    return data;
  } else {
    throw Exception("Error nih");
  }
}
