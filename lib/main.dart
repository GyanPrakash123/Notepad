import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:personal_notebook/db/db_helper.dart';
import 'package:personal_notebook/services/themeServices.dart';
import 'package:personal_notebook/ui/home_page_screen.dart';
import 'package:personal_notebook/ui/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Notebook',
      theme: Themes.light,
      themeMode: ThemeServices().theme,
      darkTheme: Themes.dark,
      home: HomePageScreen(),
    );
  }
}
