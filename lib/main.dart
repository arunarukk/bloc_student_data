import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqfligth_students/db/functions/db_functions.dart';
import 'package:sqfligth_students/screen_home.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main(List<String> args) async {
  final cntrol = Get.put(Controller());
  WidgetsFlutterBinding.ensureInitialized();
  await cntrol.initializeDataBase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Students',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenHome(),
    );
  }
}
