import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/src/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Validación básica
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos los campos son obligatorios')),
      );
      return;
    }

    // Validar correo institucional
    if (!email.endsWith('@unah.hn')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El correo debe ser @unah.hn')),
      );
      return;
    }

    // Validar contraseña (ejemplo: número de cuenta = 8 dígitos)
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('La contraseña debe tener al menos 6 caracteres')),
      );
      return;
    }

    // Si todo es correcto, navegar a HomePage
    context.go('/home'); // Asegúrate de tener esta ruta en main.dart
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: emailController,
                label: 'Correo institucional',
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email,
              ),
              CustomTextField(
                controller: passwordController,
                label: 'Contraseña',
                isPassword: true,
                icon: Icons.lock,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Iniciar sesión'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  context.go('/register'); // Navega a pantalla de registro
                },
                child: const Text('¿No tienes cuenta? Regístrate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

