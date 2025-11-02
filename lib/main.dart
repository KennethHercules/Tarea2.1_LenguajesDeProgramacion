import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/src/views/admin_todo_page.dart';
import 'package:todo_app/src/views/home_page.dart';
import 'package:todo_app/src/views/login_page.dart';
import 'package:todo_app/src/views/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            name: 'login',
            builder: (context, state) => LoginPage(),
          ),
          GoRoute(
            path: '/register',
            name: 'register',
            builder: (context, state) => RegisterPage(),
          ),
          GoRoute(
            path: '/todos',
            name: 'todo-list',
            builder: (context, state) => HomePage(),
            routes: [
              GoRoute(
                path: '/create',
                name: 'new-todo',
                builder: (context, state) => AdminTodoPage(),
              ),
              GoRoute(
                path: '/:id',
                name: 'update-todo',
                builder: (context, state) {
                  final todo = state.extra as Map<String, dynamic>?;
                  return AdminTodoPage(todo: todo);
                },
              ),
            ],
          ),
        ],
      ), // ← IMPORTANTE: coma agregada aquí
      debugShowCheckedModeBanner: false,
      title: 'Todo - App',
    );
  }
}

