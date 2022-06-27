import 'package:flutter/material.dart';
import 'package:gsheets_flutter/api/sheets/user_sheets_api.dart';
import 'package:gsheets_flutter/model/api/sheets/user.dart';
import 'package:uuid/uuid.dart';

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
                //insertUsers();

                /*User? user = await UserSheetsApi.getById(
                    "6ffab871-be06-469e-9f79-6777b27396e0");
                if (user != null) {
                  print(user.toJson());
                  User newUser = User(
                      id: user.id,
                      cpf: user.cpf,
                      name: "Novo Nome Teste F",
                      email: user.email,
                      district: user.district,
                      post: user.post,
                      animalName: user.animalName,
                      animalSex: user.animalSex,
                      animalSpecies: user.animalSpecies,
                      animalOld: user.animalOld,
                      dataVaccination: user.dataVaccination);
                  bool test =
                      await UserSheetsApi.update(user.id!, newUser.toJson());
                  print(test);
                }*/

                /*bool test = await UserSheetsApi.deleteById(
                    "98d75c69-dd25-42f4-a27d-6b9f5e5296e4");*/
              },
              child: const Text("SAVE"))
        ],
      ),
    );
  }

  Future insertUsers() async {
    final users = [
      User(
          id: const Uuid().v4(),
          cpf: '123.123.123-66',
          name: 'a',
          email: 'a@gmail.com',
          district: 'guamá',
          post: 'posto 1',
          animalName: 'bolinha',
          animalSex: 'macho',
          animalSpecies: 'cachorro',
          animalOld: 'adulto',
          dataVaccination: DateTime.now()),
    ];

    final usersJson = users.map((user) => user.toJson()).toList();
    await UserSheetsApi.insert(usersJson);
  }
}
