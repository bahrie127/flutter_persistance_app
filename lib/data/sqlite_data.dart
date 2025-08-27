import 'dart:async';

import 'package:flutter_shared_preferences_app/data/student.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteData {
  final String tableStudents = 'students';
  final String tableRoom = 'rooms';

  //Database instance
  Database? _database;

  // open database
  Future<Database> openDatabaseConnection() async {
    if (_database != null) return _database!;
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'schools.db');

    _database = await openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE $tableStudents(id INTEGER PRIMARY KEY, name TEXT, address TEXT, age INTEGER)',
        );
        db.execute(
          'CREATE TABLE $tableRoom(id INTEGER PRIMARY KEY, name TEXT, capacity INTEGER)',
        );
      },
      version: 1,
    );
    return _database!;
  }

  //insert student
  Future<void> insertStudent(Student student) async {
    final db = await openDatabaseConnection();
    await db.insert(
      tableStudents,
      student.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    closeDatabase();
  }

  //get all students
  Future<List<Student>> getAllStudents() async {
    final db = await openDatabaseConnection();
    final List<Map<String, dynamic>> maps = await db.query(tableStudents);

    closeDatabase();
    return List.generate(maps.length, (i) {
      return Student.fromMap(maps[i]);
    });
  }

  //delete all students
  Future<void> deleteAllStudents() async {
    final db = await openDatabaseConnection();
    await db.delete(tableStudents);
    closeDatabase();
  }

  //update student
  Future<void> updateStudent(Student student) async {
    final db = await openDatabaseConnection();
    await db.update(
      tableStudents,
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
    closeDatabase();
  }

  //delete student by id
  Future<void> deleteStudentById(int id) async {
    final db = await openDatabaseConnection();
    await db.delete(tableStudents, where: 'id = ?', whereArgs: [id]);
    closeDatabase();
  }

  //close database
  Future<void> closeDatabase() async {
    final db = await openDatabaseConnection();
    await db.close();
  }
}
