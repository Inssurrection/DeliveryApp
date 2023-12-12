import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vkr_project/widgets/user_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vkr_project/widgets/request_data.dart';


class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;

  DatabaseHelper._instance();

  String usersTable = 'users';
  String colId = 'id';
  String colUsername = 'username';
  String colEmail = 'email';
  String colPhone = 'phone';
  String colPassword = 'password';

  String reqTable = 'request';
  String idReq = 'id_req';
  //int? idEmp;
  String adress_req = 'adress_req';
  String dateReq = 'date_time_req';
  String isCompleted = 'is_completed';

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<Database> _initDb()async {
    String dbPath = await getDatabasesPath();
    print(dbPath);
    String path = join(dbPath, 'my_app.db');
    final myAppDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return myAppDb;
  }

  void _createDb(Database db, int version) async {
    await Permission.storage.request();
    await db.execute(
      'CREATE TABLE $usersTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
          '$colUsername TEXT, $colEmail TEXT, $colPhone TEXT, $colPassword TEXT)',
    );
    await db.execute(
      'CREATE TABLE $reqTable($idReq INTEGER PRIMARY KEY AUTOINCREMENT, '
          '$adress_req TEXT, $dateReq TEXT, $isCompleted BOOLEAN)',
    );
  }

  Future<List<Request>> getRequests() async {
    Database? db = await this.db;
    List<Map<String, dynamic>> maps = await db!.query('request');
    return List.generate(maps.length, (i) {
      return Request.fromMap(maps[i]);
    });
  }

  Future<void> deleteRequest() async {
    await _db!.execute(
      'DROP TABLE IF EXISTS $reqTable',
    );

  }

  Future<void> insertRequest(Request request) async {
    await Permission.storage.request();
    await _db!.execute(
      'CREATE TABLE IF NOT EXISTS $reqTable($idReq INTEGER PRIMARY KEY AUTOINCREMENT, '
          '$adress_req TEXT, $dateReq TEXT, $isCompleted BOOLEAN)',
    );
    Database? db = await this.db;
    await db!.insert(reqTable, request.toMap());
  }

  Future<int> addUser(User user) async {
    Database? db = await this.db;
    final int result = await db!.insert(usersTable, user.toMap());
    print('New user added with id: $result, username: ${user.username}');
    return result;
  }

  Future<int> addReq(Request request) async {
    Database? db = await this.db;
    final int result = await db!.insert(reqTable, request.toMap());
    print('New adress added with id: $result, username: ${request.adress_req}');
    return result;
  }

  Future<User?> getUserById(int id) async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> maps = await db!.query(
      usersTable,
      columns: [colId, colUsername, colEmail, colPhone, colPassword],
      where: '$colId = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> getUserByUsername(String username) async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> maps = await db!.query(
      usersTable,
      columns: [colId, colUsername, colEmail, colPhone, colPassword],
      where: '$colUsername = ?',
      whereArgs: [username],
    );
    if (maps.length > 0) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<List<User>> getUsers() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> maps = await db!.query(usersTable);
    if (maps.length > 0) {
      return maps.map((map) => User.fromMap(map)).toList();
    }
    return [];
  }

  Future<int> updateUser(User user) async {
    Database? db = await this.db;
    final int result = await db!.update(
      usersTable,
      user.toMap(),
      where: '$colId = ?',
      whereArgs: [user.id],
    );
    return result;
  }
  Future<void> updateRequest(Request request) async {
    final db = await this.db;
    await db!.update(
      'request',
      request.toMap(),
      where: '$idReq = ?',
      whereArgs: [request.idReq],
    );
  }

  Future<int> deleteUser(int id) async {
    Database? db = await this.db;
    final int result = await db!.delete(
      usersTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }
}