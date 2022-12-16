import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_crud_flutter/employee.dart';

class MyDatabase {
  static final MyDatabase _myDatabase = MyDatabase._privateConstructor();

  // private constructor
  MyDatabase._privateConstructor();

  // databse
  static late Database _database;
  //
  factory MyDatabase() {
    return _myDatabase;
  }
  // variables
  final String tableName = 'emp';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnDesignation = 'desg';
  final String columnIsMale = 'isMale';

  //
  // init database
  initializeDatabase() async {
    // Get path where to store database
    Directory directory = await getApplicationDocumentsDirectory();
    // path
    String path = '${directory.path}emp.db';
    // create Database
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        //
        await db.execute(
            'CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY, $columnName TEXT, $columnDesignation TEXT, $columnIsMale BOOLEAN)');
        //
      },
    );
  }

  // CRUD
  // Read
  Future<List<Map<String, Object?>>> getEmpList() async {
    //
    // List<Map<String, Object?>> result = await _database.rawQuery('SELECT * FROM $tableName');
    List<Map<String, Object?>> result =
        await _database.query(tableName, orderBy: columnName);
    return result;
    //
  }

  // Insert
  Future<int> insertEmp(Employee employee) async {
    //
    int rowsInserted = await _database.insert(tableName, employee.toMap());
    return rowsInserted;
    //
  }

  // Update
  Future<int> updateEmp(Employee employee) async {
    //
    int rowsUpdated = await _database.update(tableName, employee.toMap(),
        where: '$columnId= ?', whereArgs: [employee.empId]);
    return rowsUpdated;
    //
  }

  // Delete
  Future<int> deleteEmp(Employee employee) async {
    //
    int rowsDeleted = await _database
        .delete(tableName, where: '$columnId= ?', whereArgs: [employee.empId]);
    return rowsDeleted;
    //
  }

  // Count
  Future<int> countEmp() async {
    //
    List<Map<String, Object?>> result =
        await _database.rawQuery('SELECT COUNT(*) FROM $tableName');
    int count = Sqflite.firstIntValue(result) ?? 0;
    return count;
    //
  }
  //

}
