import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controllers/SettingsController.dart';
import 'db/db_helper.dart';
import 'ui/add_event_page.dart';
import 'ui/home_page.dart';
import 'ui/theme.dart';


import 'package:get_storage/get_storage.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.resetDb();  // 重置数据库
  await DBHelper.initDb();
  Get.put(SettingsController());
  await GetStorage.init();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TexPic Calendar',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      themeMode: ThemeMode.light,
      home: CalendarScreen(),
    );
  }
}

void _handleNewDate(date) {
  print('Date selected: $date');
}
