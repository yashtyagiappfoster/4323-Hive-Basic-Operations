import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Database'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: Hive.openBox('Hive DB1'),
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Text(snapshot.data!.get('name').toString()),
                    Text(snapshot.data!.get('age').toString()),
                    Text(snapshot.data!.get('details').toString()),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: Hive.openBox('Hive DB2'),
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Text(snapshot.data!.get('name').toString()),
                    Text(snapshot.data!.get('company').toString()),
                  ],
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('Hive DB1');
          var box2 = await Hive.openBox('Hive DB2');
          box.put('name', 'yash tyagi');
          box.put('age', 21);

          box2.put('name', 'Rahul');
          box2.put('company', 'appfoster');

          box.put('details', {
            'position': 'Flutter Developer Intern',
            'company': 'Appfoster',
            'location': 'Remote',
          });
          print(box.get('name'));
          print(box.get('age'));
          print(box.get('details')['company']);
          print(box2.get('name'));
          print(box2.get('company'));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
