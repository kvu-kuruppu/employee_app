import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_app/screens/view_more.dart';
import 'package:employee_app/widgets/log_out.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marquee/marquee.dart';

class EmpDetails extends StatefulWidget {
  final int id;

  const EmpDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<EmpDetails> createState() => _EmpDetailsState();
}

class _EmpDetailsState extends State<EmpDetails> {
  List _empDetails = [];

  Future<void> _fetchData() async {
    final apiUrl =
        'https://retoolapi.dev/H2F0Ui/getemployedetail?id=${widget.id}';

    final response = await http.get(Uri.parse(apiUrl));
    final data = jsonDecode(response.body);

    setState(() {
      _empDetails = data;
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
        title: Container(
          alignment: Alignment.center,
          height: 50,
          width: 200,
          child: Column(
            children: [
              Expanded(
                child: Marquee(
                  text: 'EMPLOYEE DETAILS',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    letterSpacing: 5,
                    wordSpacing: 8,
                  ),
                  scrollAxis: Axis.horizontal,
                  blankSpace: 20,
                  velocity: 50,
                  pauseAfterRound: const Duration(milliseconds: 500),
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.bounceIn,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.bounceOut,
                ),
              ),
            ],
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: const [LogOut()],
      ),
      body: _empDetails.isEmpty
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
          : (_empDetails[0]['name'] != null ||
                  _empDetails[0]['rating'] != null ||
                  _empDetails[0]['interests'] != null ||
                  _empDetails[0]['company_logo'] != null ||
                  _empDetails[0]['company'] != null ||
                  _empDetails[0]['designation'] != null ||
                  _empDetails[0]['job_descripton'] != null ||
                  _empDetails[0]['view_more'] != null)
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 64, 44, 151),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.red,
                              spreadRadius: 0.2,
                              blurRadius: 5,
                              offset: Offset(5, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Name
                            Text(
                              _empDetails[0]['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 5,
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Rating
                            Text(
                              _empDetails[0]['rating'],
                              style: const TextStyle(
                                letterSpacing: 5,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Interests
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.sports_handball,
                                    color: Colors.white),
                                const SizedBox(width: 20),
                                Text(
                                  _empDetails[0]['interests'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Company Logo
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CachedNetworkImage(
                                    imageUrl: _empDetails[0]['company_logo'],
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // child: Image.network(
                                  //   _empDetails[0]['company_logo'],
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
                                  //       child: Icon(
                                  //         Icons.error,
                                  //         color: Colors.white,
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                ),
                                const SizedBox(width: 20),
                                // Company
                                Text(
                                  _empDetails[0]['company'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Designation
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.work, color: Colors.white),
                                const SizedBox(width: 20),
                                Text(
                                  _empDetails[0]['designation'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // Job Description
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                _empDetails[0]['job_descripton'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: 150,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(50)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewMore(
                                url: _empDetails[0]['view_more'],
                              ),
                            ));
                          },
                          child: const Text(
                            'View More',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
    );
  }
}
