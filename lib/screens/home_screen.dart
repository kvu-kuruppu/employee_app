import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_app/screens/emp_details_screen.dart';
import 'package:employee_app/widgets/log_out.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        actions: const [LogOut()],
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
                if (_empList[index]['name'] != null ||
                    _empList[index]['company_logo'] != null ||
                    _empList[index]['company'] != null ||
                    _empList[index]['designation'] != null) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              EmpDetails(id: _empList[index]['id']),
                        ));
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
                                  _empList[index]['name'],
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
                                    child: CachedNetworkImage(
                                      imageUrl: _empList[index]['company_logo'],
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      // child: Image.network(
                                      //   _empDetails[index]['company_logo'],
                                      //   loadingBuilder:
                                      //       (context, child, loadingProgress) {
                                      //     if (loadingProgress == null) {
                                      //       return child;
                                      //     }
                                      //     return Center(
                                      //       child: CircularProgressIndicator(
                                      //         value: loadingProgress
                                      //                     .expectedTotalBytes !=
                                      //                 null
                                      //             ? loadingProgress
                                      //                     .cumulativeBytesLoaded /
                                      //                 loadingProgress
                                      //                     .expectedTotalBytes!
                                      //             : null,
                                      //       ),
                                      //     );
                                      //   },
                                      //   errorBuilder: (context, error, stackTrace) {
                                      //     return const Center(
                                      //       child: Icon(Icons.error),
                                      //     );
                                      //   },
                                      // ),
                                    ),
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
                                                    _empList[index]['company'],
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
                                                        ['designation'],
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
                }

                return Container();
              },
            ),
    );
  }
}
