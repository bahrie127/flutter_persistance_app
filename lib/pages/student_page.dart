import 'package:flutter/material.dart';
import 'package:flutter_shared_preferences_app/data/sqlite_data.dart';
import 'package:flutter_shared_preferences_app/data/student.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  List<Student> students = [];

  void getAllStudents() async {
    //fetch all students from database
    final allStudent = await SqliteData().getAllStudents();
    setState(() {
      students = allStudent;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Page')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: students.isEmpty
            ? const Center(
                child: Text('No students found. Please add some students.'),
              )
            : ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Card(
                    child: ListTile(
                      title: Text(student.name),
                      subtitle: Text(
                        'Age: ${student.age}, Address: ${student.address}',
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            //edit icon button
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                //edit student via dialog
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    final TextEditingController nameController =
                                        TextEditingController(
                                          text: student.name,
                                        );
                                    final TextEditingController
                                    addressController = TextEditingController(
                                      text: student.address,
                                    );
                                    final TextEditingController ageController =
                                        TextEditingController(
                                          text: student.age.toString(),
                                        );
                                    return AlertDialog(
                                      title: const Text('Edit Student'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: nameController,
                                            decoration: const InputDecoration(
                                              labelText: 'Name',
                                            ),
                                          ),
                                          TextField(
                                            controller: addressController,
                                            decoration: const InputDecoration(
                                              labelText: 'Address',
                                            ),
                                          ),
                                          TextField(
                                            controller: ageController,
                                            decoration: const InputDecoration(
                                              labelText: 'Age',
                                            ),
                                            keyboardType: TextInputType.number,
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            final name = nameController.text;
                                            final address =
                                                addressController.text;
                                            final age = int.tryParse(
                                              ageController.text,
                                            );
                                            if (name.isNotEmpty &&
                                                address.isNotEmpty &&
                                                age != null) {
                                              //update student to database
                                              SqliteData().updateStudent(
                                                Student(
                                                  id: student.id,
                                                  name: name,
                                                  address: address,
                                                  age: age,
                                                ),
                                              );
                                              nameController.clear();
                                              addressController.clear();
                                              ageController.clear();
                                              getAllStudents();
                                            }
                                          },
                                          child: const Text('Save'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                //yes no dialog
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Delete Student'),
                                      content: const Text(
                                        'Are you sure you want to delete this student?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            SqliteData().deleteStudentById(
                                              student.id!,
                                            );
                                            getAllStudents();
                                          },
                                          child: const Text('Yes'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('No'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      //add floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //add new student via dialog
          showDialog(
            context: context,
            builder: (context) {
              final TextEditingController nameController =
                  TextEditingController();
              final TextEditingController addressController =
                  TextEditingController();
              final TextEditingController ageController =
                  TextEditingController();
              return AlertDialog(
                title: const Text('Add Student'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    TextField(
                      controller: addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                    ),
                    TextField(
                      controller: ageController,
                      decoration: const InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      final name = nameController.text;
                      final address = addressController.text;
                      final age = int.tryParse(ageController.text);
                      if (name.isNotEmpty &&
                          address.isNotEmpty &&
                          age != null) {
                        //add new student to database
                        SqliteData().insertStudent(
                          Student(name: name, address: address, age: age),
                        );
                        nameController.clear();
                        addressController.clear();
                        ageController.clear();
                        getAllStudents();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Add Student',
        child: const Icon(Icons.add),
      ),
    );
  }
}
