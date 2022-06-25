import 'package:flutter/material.dart';
import 'package:gsheets_flutter/api/sheets/user_sheets_api.dart';
import 'package:gsheets_flutter/model/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetsApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Sheets"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Dashboard"),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () async {
                insertUsers();
              },
              child: const Text("SAVE"))
        ],
      ),
    );
  }

  Future insertUsers() async {
    final users = [
      const User(id: 1, name: 'a', email: 'a@gmail.com', isBeginner: true),
      const User(id: 2, name: 'b', email: 'b@gmail.com', isBeginner: true),
      const User(id: 3, name: 'c', email: 'c@gmail.com', isBeginner: false),
      const User(id: 4, name: 'd', email: 'd@gmail.com', isBeginner: false),
      const User(id: 5, name: 'e', email: 'e@gmail.com', isBeginner: true),
    ];

    final usersJson = users.map((user) => user.toJson()).toList();
    await UserSheetsApi.insert(usersJson);
  }
}
