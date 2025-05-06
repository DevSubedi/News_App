import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefDemo extends StatefulWidget {
  const SharedPrefDemo({super.key});

  @override
  State<SharedPrefDemo> createState() => SharedPrefDemoState();
}

class SharedPrefDemoState extends State<SharedPrefDemo> {
  String? username;
  bool? isLoggedIn;

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', 'Dev Subedi');
    await prefs.setBool('isLoggedIn', true);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Data Saved ')));
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      isLoggedIn = prefs.getBool('isLoggedIn');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SharedPreferences Demo')),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: saveData, child: Text('Save Data')),
            ElevatedButton(onPressed: getData, child: Text('Get Data')),

            SizedBox(height: 20),

            Text("Username: ${username ?? "Not Found"}"),
            Text(
              'Is Logged In: ${isLoggedIn != null ? isLoggedIn.toString() : "Not Found"}',
            ),
          ],
        ),
      ),
    );
  }
}
