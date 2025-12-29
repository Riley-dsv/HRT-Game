import "package:flutter/material.dart";
import "../database/database.dart";

// The Home widget which contain the button to confirm your intake 
class HomePage extends StatefulWidget
{
  const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  final database = LocalDatabase();
  int streak     = 0;

  @override
  void initState() 
  {
    super.initState();
    _init_database();
    _load_streak();
  }

  Future<void> _init_database() async
  {
    await database.open_database();
  }

  Future<void> _load_streak() async
  {
    final current = await database.get_current_streak();
    setState(() {
      streak = current;
    });
  }

  Future<void> _mark_taken() async
  {
    await database.mark_taken_today();
    await _load_streak();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Congratulation! You did really well <3'))
    );
  }


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("HRT Game Tracker"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('Your current E Streak is:'),
            Text(
              '$streak days',
              style: Theme.of(context).textTheme.headlineMedium
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary)
              ),
              onPressed: _mark_taken, 
              child: Text( 
                "I took my Estrogen !", 
                style: TextStyle(
                  color: Colors.white
                ) 
              ),
            )
          ],
        )
      )
    );
  }
}

