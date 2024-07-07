import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/cuaca_services.dart';
import 'layout/button_partials.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<Map<String, dynamic>> _futureCuaca;
  late String _cityName;

  @override
  void initState() {
    super.initState();
    _cityName =
        Get.arguments ?? 'jakarta'; // Default city if no argument passed
    _futureCuaca = CuacaServices().getDataFromAPI(_cityName);
  }

  @override
  Widget build(BuildContext context) {
    final String cityName = Get.arguments as String;

    return Scaffold(
      backgroundColor: Color(0xfff3B7E88),
      body: FutureBuilder<Map<String, dynamic>>(
        future: CuacaServices().getDataFromAPI(cityName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            if (snapshot.data!.containsKey("error")) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      snapshot.data!["error"],
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      child: ButtonPartials(
                        text: "Kembali",
                        colorButton: Color(0xfffE98A1F),
                        onTap: () {
                          Get.offNamed('/signIn');
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              final data = snapshot.data!["data"];
              return CuacaField(data: data);
            }
          } else {
            return Center(
              child: Text(
                "Error occurred",
                style: TextStyle(color: Colors.red, fontSize: 24),
              ),
            );
          }
        },
      ),
    );
  }
}

class CuacaField extends StatelessWidget {
  const CuacaField({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        // color: Colors.yellow,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            data['name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                              color: Color(0xFFFEFF0F1),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        // color: Colors.yellow,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Kelembapan: ${data["main"]["humidity"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: Color(0xFFFEFF0F1),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        // color: Colors.yellow,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${data["main"]["temp"]} °C",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 60,
                              color: Color(0xFFFEFF0F1),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        // color: Colors.yellow,
                        child: Image.asset(
                          "assets/cuaca2.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CuacaPartials(
                            data: data,
                            img: "assets/cuaca-berangin.png",
                            text1: "Berangin",
                            text2: "${data["wind"]["speed"]}",
                          ),
                          CuacaPartials(
                            data: data,
                            img: "assets/cuaca-berawan.png",
                            text1: "Berawan",
                            text2: "${data["clouds"]["all"]}",
                          ),
                          CuacaPartials(
                            data: data,
                            img: "assets/cuaca-cerah.png",
                            text1: "Cerah",
                            text2: "${data["main"]["feels_like"]}",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: ButtonPartials(
                    text: "Log Out",
                    colorButton: Color(0xfffE98A1F),
                    onTap: () {
                      Get.offNamed('/signIn');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CuacaPartials extends StatelessWidget {
  CuacaPartials(
      {Key? key, this.img, this.text1, this.text2, required this.data})
      : super(key: key);

  final Map<String, dynamic> data;
  String? img;
  String? text1;
  String? text2;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "$img",
            width: 50,
            fit: BoxFit.cover,
          ),
          Text(
            "$text1",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          Text(
            "$text2",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
