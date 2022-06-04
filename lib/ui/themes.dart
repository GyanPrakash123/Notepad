import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

const Color bluishClr = Color(0xff4e5ae8);
const Color yellowClr = Color(0xffffb746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyColor = Color(0xFF121212);
const Color darkHeaderClr = Color(0xff424242);

class Themes {
  static final light = ThemeData(
    appBarTheme: AppBarTheme(color: primaryClr),
    //primaryColor is responsible for changing the appbar color and button color
    primaryColor: primaryClr,

    //brightness scaffold color ko text color se compare karta hai aur adjust kar leta hai color
    //man lo agar scaffold dark hai to ye text ko light color me kar leta hai
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    // primaryColor: Colors.amberAccent,
    appBarTheme: AppBarTheme(color: darkGreyColor),
    primaryColor: darkGreyColor,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode == false ? Colors.grey[400] : Colors.grey,
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode == false ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode == false ? Colors.grey[400] : Colors.grey[400],
    ),
  );
}

TextStyle get subtitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode == false ? Colors.grey : Colors.grey[400],
    ),
  );
}
