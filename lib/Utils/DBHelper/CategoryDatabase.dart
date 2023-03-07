import 'dart:io';
import 'dart:typed_data';

import 'package:quotes/Screens/QuotesAddScreen/Model/CategoryModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class CategoryDatabse
{

  static CategoryDatabse categoryDatabse = CategoryDatabse._();

  CategoryDatabse._();

  Database? database;
  Future<Database?> CheckDatabase() async
  {
    if(database != null)
      {
        return database;
      }
    else
      {
        return await CreateDatabase();
      }
  }

  Future<Database> CreateDatabase() async
  {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,'category.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query = "CREATE TABLE category (id INTEGER PRIMARY KEY AUTOINCREMENT, categorytypes TEXT, image BLOB)";
        db.execute(query);
      },
    );
  }

  void InsertDatabase({required String Category, String? image}) async
  {

    database = await CheckDatabase();
    Uint8List? Image;

    File file = File("$image");
    await file.readAsBytes().then((value) {
      Image = value;
    });

    database!.insert('category', {'categorytypes' : Category, 'image' : Image});

  }


  Future<List<CategoryModel>> ReadDatabase() async
  {
    database = await CheckDatabase();
    String query = "SELECT * FROM category";
    List<Map> dataList = await database!.rawQuery(query);

    List<CategoryModel> Data = dataList.map((e) => CategoryModel().fromMap(e)).toList();

    return Data;


  }
}