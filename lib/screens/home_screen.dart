import 'dart:convert';

import 'package:employee_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _empList = [];

  Future<void> _fetchData() async {
    const apiUrl = 'https://retoolapi.dev/GFHqAV/getemployees';

    final response = await http.get(Uri.parse(apiUrl));
    final data = jsonDecode(response.body);

    setState(() {
      _empList = data;
    });
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'EMPLOYEES',
          style: TextStyle(color: Colors.black, fontSize: 25, letterSpacing: 5),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Do you want to log out?',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('CANCEL'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();

                                  preferences.remove('email');

                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ));
                                },
                                child: const Text('OK'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _empList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Please wait...')
                ],
              ),
            )
          : ListView.builder(
              itemCount: _empList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      print(_empList[index]['company_logo']);
                    },
                    child: Card(
                      color: Colors.amber[200],
                      shadowColor: Colors.red,
                      elevation: 10,
                      child: Column(
                        children: [
                          // Name
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                _empList[index]['name'] ?? 'N/A',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 10, 11, 102),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                // Image
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: _empList[index]['company_logo'] != null
                                      ? Image.network(
                                          _empList[index]['company_logo'],
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Center(
                                              child: Icon(Icons.error),
                                            );
                                          },
                                        )
                                      : const Center(child: Text('N/A')),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: SizedBox(
                                    child: Column(
                                      children: [
                                        // Company
                                        Row(
                                          children: [
                                            const Icon(Icons.account_balance),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Text(
                                                  _empList[index]['company'] ??
                                                      'N/A',
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        // Designation
                                        Row(
                                          children: [
                                            const Icon(Icons.work),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Text(
                                                  _empList[index]
                                                          ['designation'] ??
                                                      'N/A',
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
