import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather/module/home_controller.dart';

import 'package:weather/widgets/weather_item.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('EEEE d MMMM y');
    return formatter.format(date);
  }

  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Today",
              style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                  color: Colors.black),
            ),
            Text(
              formatDate(DateTime.now()),
              style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.grey),
            )
          ],
        ),
      ),
      body: SizedBox.expand(
        child: Obx(
          () => _controller.weatherData.value == null
              ? Center(
                  child: LoadingAnimationWidget.halfTriangleDot(
                      color: Colors.black, size: 40),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WhetherItem(
                      lottie: 'assets/loc.json',
                      text: "Your Location is ",
                      subText: _controller.address,
                    ),
                    WhetherItem(
                      lottie: 'assets/temp.json',
                      text: "The temperature is ",
                      subText: '${_controller.temperature} C',
                    ),
                    WhetherItem(
                      lottie: 'assets/thums_up.json',
                      text: "You should ",
                      subText: _controller.infoText.value,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
