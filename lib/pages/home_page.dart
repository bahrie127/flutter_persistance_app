import 'package:flutter/material.dart';
import 'package:flutter_shared_preferences_app/data/counter_storage.dart';
import 'package:flutter_shared_preferences_app/data/local_data.dart';
import 'package:flutter_shared_preferences_app/data/user.dart';
import 'package:flutter_shared_preferences_app/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadCounterData();
  }

  void _loadUserData() async {
    _user = await LocalData().loadUserData();
    setState(() {});
  }

  //save counter data to local storage
  void _saveCounterData(int counter) async {
    await CounterStorage().writeCounter(counter);
  }

  //load counter data from local storage
  Future<int> _loadCounterData() async {
    _counter = await CounterStorage().readCounter();
    setState(() {});
    return _counter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              LocalData().saveLoginFlag(false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_user != null)
            Text(
              'Welcome, ${_user!.username}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 20),
          Text('Counter: $_counter', style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _counter++;
                  });
                  _saveCounterData(_counter);
                },
                child: const Text('Increment'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_counter > 0) _counter--;
                  });
                  _saveCounterData(_counter);
                },
                child: const Text('Decrement'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                LocalData().deleteData();
                LocalData().saveLoginFlag(false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Logout and Clear Data'),
            ),
          ),
        ],
      ),
    );
  }
}
