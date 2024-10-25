import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/book.dart';

class DatabaseHelper {
  String column_book_id = 'id';
  String column_bood_name = 'book_name';
  String column_bood_author = 'book_author';
  String column_bood_price = 'book_price';

  String table_name = 'book';

  String database_name = 'book_store.db';
  Future<Database> mDatabase() async {
    var dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, database_name),
      onCreate: createDatabase,
      version: 1,
    );
  }

  createDatabase(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table_name ($column_book_id INTEGER PRIMARY KEY AUTOINCREMENT, $column_bood_name TEXT, $column_bood_author TEXT,$column_bood_price INTEGER);');
  }

  Future<int> addBook(Book book) async {
    Database database = await mDatabase();
    return database.insert(table_name, book.toMap());
  }

  Future<int> updateBook(Book book) async {
    Database database = await mDatabase();
    return database
        .update(table_name, book.toMap(), where: 'id=?', whereArgs: [book.id]);
  }

  deleteBook(int id) async {
    Database database = await mDatabase();
    return database.delete(
      table_name,
      where: 'id=?',
      whereArgs: [id],
    );
  }

  Future<List<Book>> getAllBook() async {
    Database database = await mDatabase();
    List<Map<String, dynamic>> maps = await database.query(table_name);
    List<Book> listBook = maps.map((map) => Book.formMap(map)).toList();
    return listBook;
  }

  Future<List<Book>> searchBook(bookName) async {
    Database database = await mDatabase();
    List<Map<String, dynamic>> maps = await database.query(table_name, where: 'book_name like ?', whereArgs: ['%$bookName%']);
    List<Book> listBook = maps.map((map) => Book.formMap(map)).toList();
    return listBook;
  }

  Future<List<Book>> searchSuggestion() async {
    Database database = await mDatabase();
    List<Map<String, dynamic>> maps = await database.query(table_name);
    List<Book> listBook = maps.map((map) => Book.formMap(map)).toList();
    return listBook;
  }
}
