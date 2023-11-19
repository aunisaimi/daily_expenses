import 'package:flutter/material.dart';
import 'dailyexpenses.dart';

void main(){
  runApp(
      const MaterialApp(
        home: LoginScreen(),
      )
  );
}

//To connect the login screen to the daily expenses screen,
// we have to import the dailyexpenses.dart file and
// use Navigator.push() to navigate to the daily expenses screen
// when the login is successful.To connect the login screen to the
// daily expenses screen, we have to import the dailyexpenses.dart file
// and use Navigator.push() to navigate to the daily expenses screen when
// the login is successful.

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'UserName',
              ),
            ),
            ),
            Padding(padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: passwordController,
              obscureText: true, // hide password,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            ),
            ElevatedButton(
              onPressed: (){
              // implement login logic here
                String username = usernameController.text;
                String password = passwordController.text;
                if (username == 'test' && password == '123456789')
                // navigate to Daily Expenses screen
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DailyExpensesApp(),
                      )
                    );

                  }
                else{
                  // show an error message or handle invalid login
                  showDialog(
                      context: context,
                      builder: (context){
                    return AlertDialog(
                      title: const Text('Login Failed'),
                      content: const Text('Invalid Username or Password.'),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                  );
                }
            },
                child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
