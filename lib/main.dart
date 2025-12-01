import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final base = ThemeData(
      primarySwatch: Colors.red,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.red.shade700,
        elevation: 0,
        centerTitle: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade700,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );

    return MaterialApp(
      title: 'Cutie Web - Christmas',
      debugShowCheckedModeBanner: false,
      theme: base,
      home: LoginPage(),
      routes: {'/home': (_) => HomePage()},
    );
  }
}

/// Simple login page with hardcoded credentials:
/// username: `cutie`, password: `web`
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  String? _error;

  void _tryLogin() {
    final username = _userController.text.trim();
    final password = _passController.text;

    if (!_formKey.currentState!.validate()) return;

    // Require user to enter credentials manually. Accept any non-empty pair.
    if (username.isNotEmpty && password.isNotEmpty) {
      setState(() => _error = null);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage(username: username)),
      );
    } else {
      setState(() {
        _error = 'กรุณากรอก username และ password ให้ครบถ้วน';
      });
    }
  }

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login - Cutie Web')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/christmas.jpg'),
            fit: BoxFit.cover,
            onError: (_, __) {},
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 420),
              child: Card(
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Welcome to Cutie Web',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade800,
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _userController,
                          decoration: InputDecoration(
                            labelText: 'Username (email or name)',
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Please enter username or email'
                              : null,
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: _passController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'Please enter password'
                              : null,
                          onFieldSubmitted: (_) => _tryLogin(),
                        ),
                        SizedBox(height: 16),
                        if (_error != null) ...[
                          Text(_error!, style: TextStyle(color: Colors.red)),
                          SizedBox(height: 8),
                        ],
                        SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _tryLogin,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                              ),
                              child: Text('Login'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String? username;
  HomePage({this.username});

  @override
  Widget build(BuildContext context) {
    // Show a one-time success snackbar when arriving with a username
    if (username != null && username!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('เข้าสู่ระบบสำเร็จ — ${username!}'),6611130091-a55y
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Lab03 - Widget Tree Example'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.of(
                context,
              ).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chris.jpg'),
            fit: BoxFit.cover,
            onError: (_, __) {},
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.white.withOpacity(0.8),
                child: Text(
                  "Hello, ${username ?? 'Flutter Web'}!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: Text("Click Me")),
            ],
          ),
        ),
      ),
    );
  }
}
