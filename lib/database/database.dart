import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Local SQL Database CRUD
class LocalDatabase
{

  Database? _database;

  // Let's see when was the last time you took E ! 
  Future<void> open_database() async
  {
    final db_path = await getDatabasesPath();
    final path    = join(db_path, 'hormone_tracker.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _on_Create
    );

    print("Database opened");
  }

  // Boring stuff when you first open the app.
  Future<void> _on_Create(Database database, int version) async
  {
    // I know, I know SQLite affinity will change those.
    // But That's not my business.
    await database.execute(
    '''
      CREATE TABLE intake (
        date DATE PRIMARY KEY,
        taken BOOLEAN NOT NULL DEFAULT 0,
        streak INT NOT NULL DEFAULT 0
      )
    ''');
  }
  
  // Congratulation you took your E ! 
  Future<void> mark_taken_today() async
  {
    final String today = _stringify_date();
    
    await _database?.insert(
      "intake",
      { "date": today, "taken": 1 }, 
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    
    await update_streak();
  
  }

  // Return the current HRT intake streak
  Future<int> get_current_streak() async
  {
    final String today = _stringify_date();
    int streak         = 0;
    // This is an MVP, so I keep it simple
    // I should make a system with two dates stored per entry
    // Then compute the difference between them and bam streak
    List<Map<String, dynamic>>? records = await _database?.query(
      "intake",
      columns: [ "streak" ],
      where: "date = ?",
      whereArgs: [ today ],
      limit: 1
    );

    if ( records != null )
    {
      Map<String, dynamic> last_intake = records.first;

      if ( !last_intake.isEmpty )
      {
        streak = last_intake["streak"] ?? 0;
      }
    }

    return streak;
  }
  
  // Update your HRT Streak 
  Future<void> update_streak() async
  {
    final String today = _stringify_date();
    int current_streak = await get_current_streak() ?? 0;

    await _database?.update(
      "intake",
      { "streak": current_streak + 1 },
      where: "date = ?",
      whereArgs: [ today ],
    );
  }

  // Format the date into a string
  // the string will be of the form YYYY-MM-DD
  String _stringify_date()
  {
    DateTime now = DateTime.now();
    String day   = now.day.toString().padLeft(2, '0');
    String month = now.month.toString().padLeft(2, '0');
    String year  = now.year.toString().padLeft(4, '0');
    
    return "${year}-${month}-${day}";
  }

}
