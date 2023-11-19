import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Daily Expense';

    return MaterialApp( // managing the app's theme, navigation and more
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: ListView(
          children: const <Widget>[
            // ListTile -> individual list items in ListView.
            // Provided to represent daily expenses
            ListTile(
              leading: Icon(Icons.attach_money_sharp),
              title: Text('Clothing -\RM150.00'),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart_rounded),
              title: Text('Clothing -\RM39.00'),
            ),
            ListTile(
              leading: Icon(Icons.local_dining_outlined),
              title: Text('Clothing -\RM7.00'),
            ),
          ],
        ),
      )
    );
  }
}
