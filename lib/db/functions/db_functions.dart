import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:sqfligth_students/db/model/data_model.dart';
import 'package:sqflite/sqflite.dart';

class Controller extends GetxController {
  List<StudentModel> studentListNotifier = <StudentModel>[].obs;

  List<Map<String, dynamic>> _students = <Map<String, dynamic>>[].obs;
  List<Map<String, dynamic>> searchItems = <Map<String, dynamic>>[].obs;

  String? text;

  late Database _db;

  Future<void> initializeDataBase() async {
    _db = await openDatabase(
      'student.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT,clas TEXT,roll TEXT,image TEXT)');
      },
    );
  }

  Future<StudentModel> addStudent(StudentModel value) async {
    await _db.rawInsert(
        'INSERT INTO student (name,age,clas,roll,image) VALUES (?,?,?,?,?)',
        [value.name, value.age, value.clas, value.roll, value.image]);

    getAllStudents();

    return value;
  }

  Future<dynamic> getAllStudents() async {
    final _values = await _db.rawQuery('SELECT * FROM student');

    _values.forEach((map) {
      final student = StudentModel.fromMap(map);
      studentListNotifier.add(student);
    });
    return _values;
  }

  Future<void> deleteStudent(int id) async {
    await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);

    refreshStudents();

    getAllStudents();
    update();
  }

  Future<void> editStudent(int id, String name, String age, String clas,
      String roll, String image) async {
    print('edit');
    final data = {
      'name': name,
      'age': age,
      'clas': clas,
      'roll': roll,
      'image': image,
    };
    final result =
        await _db.update("student", data, where: "id = ?", whereArgs: [id]);

    getAllStudents();
  }

  void refreshStudents() async {
    try {
      final h = getAllStudents().then((value) {
        _students.clear();
        _students.addAll(value);
        searchItems.clear();
        searchItems.addAll(value);
        update();
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  void filterSearch(String query) async {
    List<Map<String, dynamic>> studentList = _students;

    if (query.isNotEmpty) {
      List<Map<String, dynamic>> studentData = [];
      searchItems.clear();
      for (var item in studentList) {
        var student = StudentModel.fromMap(item);
        print('-------------------${student}');
        if (student.name.toLowerCase().contains(query.toLowerCase())) {
          studentData.add(item);
          print('----------${studentData}');
        }
        searchItems.clear();
        searchItems.addAll(studentData);
        update();
        print('----------${searchItems}');
      }

      return;
    } else {
      searchItems.clear();
      searchItems.addAll(_students);
      update();

      refreshStudents();
    }
  }
}
