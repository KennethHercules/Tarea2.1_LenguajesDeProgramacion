import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/src/widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _register() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos los campos son obligatorios')),
      );
      return;
    }

    if (!email.endsWith('@unah.hn')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El correo debe ser @unah.hn')),
      );
      return;
    }

    // Contraseña: mínimo 6 caracteres y al menos un caracter especial
    final passwordRegex = RegExp(r'^(?=.*[!@#$%^&*(),.?":{}|<>]).{6,}$');
    if (!passwordRegex.hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'La contraseña debe tener al menos 6 caracteres y un caracter especial')),
      );
      return;
    }

    // Registro simulado
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registro exitoso')),
    );

    // Limpiar campos
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();

    // Ir al login
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: nameController,
                label: 'Nombre completo',
                icon: Icons.person,
              ),
              CustomTextField(
                controller: emailController,
                label: 'Correo institucional',
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email,
              ),
              CustomTextField(
                controller: phoneController,
                label: 'Teléfono',
                keyboardType: TextInputType.phone,
                icon: Icons.phone,
              ),
              CustomTextField(
                controller: passwordController,
                label: 'Contraseña',
                isPassword: true,
                icon: Icons.lock,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _register,
                child: const Text('Registrarse'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text('¿Ya tienes cuenta? Inicia sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
