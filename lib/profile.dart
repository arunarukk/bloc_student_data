import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sqfligth_students/db/functions/db_functions.dart';
import 'package:sqfligth_students/screen_home.dart';
import 'package:sqfligth_students/widget/add_student.dart';

class ProfileStudent extends StatelessWidget {
  final data;
  const ProfileStudent({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String name = data.name;
    String age = data.age;
    String clas = data.clas;
    String roll = data.roll;
    int id = data.id;
    return Scaffold(
      appBar: AppBar(
        title: Text('Student profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 100, backgroundColor: Colors.red,
                    backgroundImage: Image.file(File(data.image)).image,
                   ),
                ),
                SizedBox(
                  height: 50.0,
                  child: Text(
                    'Name : $name',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                  child: Text(
                    'Age : $age',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                  child: Text(
                    'Class : $clas',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                  child: Text(
                    'Roll-No : $roll',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                     
                      Get.off(AddStudent(data: data));
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Edit'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
