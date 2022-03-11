import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqfligth_students/db/functions/db_functions.dart';
import 'package:sqfligth_students/profile.dart';
import 'package:sqfligth_students/widget/add_student.dart';

import 'db/model/data_model.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);

  final controller = TextEditingController();

  final control = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    control.refreshStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.search),
                    title: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                          hintText: 'Search', border: InputBorder.none),
                      onChanged: (String text) {
                        control.filterSearch(text);
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        controller.clear();
                      },
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 620,
              child: Obx(() => ListView.builder(
                    itemBuilder: (ctx, index) {
                      final data =
                          StudentModel.fromMap(control.searchItems[index]);

                      return Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(ProfileStudent(
                                data: data,
                              ));
                            },
                            title: Text(data.name),
                            leading: CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  Image.file(File(data.image)).image,
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                if (data.id != null) {
                                  control.deleteStudent(data.id!);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              "Student Deleted successfully")));
                                  controller.clear();
                                } else {
                                  print('Student_id is null, unable to delete');
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider()
                        ],
                      );
                    },
                    itemCount: control.searchItems.length,
                  )),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddStudent());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
