import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _register() {
    if (_formKey.currentState!.validate()) {
      // Aquí podrías guardar los datos en Firebase o localmente
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
      );
      Navigator.pop(context); // Regresa al login
    }
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Ingrese su contraseña';
    if (value.length < 6) return 'La contraseña debe tener al menos 6 caracteres';
    final specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (!specialCharRegex.hasMatch(value)) {
      return 'La contraseña debe tener al menos un carácter especial';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Ingrese su correo';
    if (!value.endsWith('@unah.hn')) return 'Debe ser un correo institucional (@unah.hn)';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                controller: _nameController,
                label: 'Nombre completo',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese su nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                label: 'Correo institucional',
                icon: Icons.email,
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _phoneController,
                label: 'Teléfono',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ingrese su teléfono';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                label: 'Contraseña',
                icon: Icons.lock,
                obscureText: _obscurePassword,
                validator: _validatePassword,
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
                onPressed: _register,
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}