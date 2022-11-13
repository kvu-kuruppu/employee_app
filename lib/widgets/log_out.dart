import 'package:employee_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOut extends StatelessWidget {
  const LogOut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
                          style: TextStyle(fontSize: 20),
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

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false);
                          },
                          child: const Text(
                            'LOG OUT',
                            style: TextStyle(color: Colors.red),
                          ),
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
    );
  }
}
