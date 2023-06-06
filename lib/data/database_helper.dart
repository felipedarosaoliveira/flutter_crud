import 'package:crud_gpt/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('contacts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        phone TEXT
      )
    ''');
  }

  Future<Contact?> findContact(int id) async {
    final db = await instance.database;
    List<Map<String, dynamic>> data =
        await db.query('contacts', where: 'id = ?', whereArgs: [id]);
    if (data.isNotEmpty) {
      return Contact.fromJson(data.first);
    }
    return null;
  }

  Future<int> insertContact(Contact contact) async {
    final db = await instance.database;
    return await db.insert('contacts', contact.toJson());
  }

  Future<List<Contact>> getContacts() async {
    final db = await instance.database;
    final contacts = await db.query('contacts');
    return contacts.map((map) => Contact.fromJson(map)).toList();
  }

  Future<int> updateContact(Contact contact) async {
    final db = await instance.database;
    final id = contact.id;
    return await db
        .update('contacts', contact.toJson(), where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteContact(int id) async {
    final db = await instance.database;
    return await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}
