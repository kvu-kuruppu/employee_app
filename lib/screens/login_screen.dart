import 'package:employee_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  final _formKey = GlobalKey<FormState>();
  bool visible = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Login
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // User ID
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      const Icon(Icons.alternate_email),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            label: Text('User ID'),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'User ID is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Password
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      const Icon(Icons.lock_outline),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _password,
                          obscureText: visible ? false : true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            label: const Text('Password'),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visible = !visible;
                                });
                              },
                              icon: visible
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                // Login Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 226, 151, 240),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  EasyLoading.show(status: 'Please Wait...');
                                  final url =
                                      'https://retoolapi.dev/B13laa/getusers?user_id=${_email.text}&password=${_password.text}';

                                  final response = await http.get(
                                    Uri.parse(url),
                                  );

                                  if (response.body.contains(_email.text) &&
                                      response.body.contains(_password.text)) {
                                    EasyLoading.showSuccess('Login Success')
                                        .then((value) => Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen(),
                                            )));
                                  } else {
                                    EasyLoading.showError('Wrong credentials');
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(e.toString()),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                                color: Colors.white,
                              ),
                            ),
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
      ),
    );
  }
}
