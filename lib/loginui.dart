import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _username;
  late String _password;
  late String _role = 'user';

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final isLoggedIn = await login(_username, _password, _role);
      if (isLoggedIn) {
// Navigate to the home page
        if (_role == "user") {
          Navigator.pushNamed(context, "/home");
        } else {
          Navigator.pushNamed(context, "/admin");
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid username, password, or role')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange[100],
        appBar: AppBar(
          title: const Text(
            'Login',
            style: TextStyle(fontFamily: 'Bubblegum Sans'),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Lottie.asset(
                    'assets/lottie_kids.json', // Replace with a more kid-friendly animation
                    height: 200,
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(fontFamily: 'Bubblegum Sans'),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your username' : null,
                    onSaved: (value) => _username = value!,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontFamily: 'Bubblegum Sans'),
                    ),
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your password' : null,
                    onSaved: (value) => _password = value!,
                  ),
                  DropdownButtonFormField<String>(
                    value: _role,
                    decoration: InputDecoration(
                      labelText: 'Role',
                      labelStyle: TextStyle(fontFamily: 'Bubblegum Sans'),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'user',
                        child: Text('User',
                            style: TextStyle(fontFamily: 'Bubblegum Sans')),
                      ),
                      DropdownMenuItem(
                        value: 'admin',
                        child: Text('Admin',
                            style: TextStyle(fontFamily: 'Bubblegum Sans')),
                      ),
                    ],
                    onChanged: (value) => setState(() => _role = value!),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    child: const Text(
                      'Login',
                      style: TextStyle(fontFamily: 'Bubblegum Sans'),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      onPrimary: Colors.white,
                    ),
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
