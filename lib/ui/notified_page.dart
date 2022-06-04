import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  final String label;
  const NotifiedPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.grey[600] : Colors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Get.isDarkMode ? Colors.white : Colors.grey,
            )),
        title: Text(
          label.toString().split("|")[0],
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Get.isDarkMode ? Colors.white : Colors.grey,
          ),
          child: Center(
            child: Text(
              label.toString().split("|")[1],
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
