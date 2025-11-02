import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart';
import 'home_page.dart'; // para navegar al HomePage

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      // Validación simulada: correo institucional y número de cuenta
      if (email.endsWith('@unah.hn') && password == '20241012345') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Correo o contraseña incorrectos')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio de sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: _emailController,
                label: 'Correo institucional',
                icon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese su correo';
                  }
                  if (!value.endsWith('@unah.hn')) {
                    return 'Debe ser un correo institucional (@unah.hn)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                label: 'Contraseña (número de cuenta)',
                icon: Icons.lock,
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese su contraseña';
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Iniciar sesión'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('¿No tienes cuenta? Regístrate aquí'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
