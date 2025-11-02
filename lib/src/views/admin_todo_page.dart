import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/api/todos.dart';
import 'package:todo_app/src/shared/utils.dart';
import 'package:todo_app/src/widgets/custom_text_field.dart';

class AdminTodoPage extends StatelessWidget {
  AdminTodoPage({super.key, this.todo});

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final FocusNode titleFocus = FocusNode();

  final Map<String, dynamic>? todo;

  @override
  Widget build(BuildContext context) {
    // Id que me permite consultar a la BBDD la información actualizada
    final todoId = GoRouterState.of(context).pathParameters['id'];

    if (todo != null) {
      titleController.text = todo!['title'];
      descriptionController.text = todo!['description'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          todo == null
              ? 'Creación de una nueva tarea'
              : 'Editando la tarea # $todoId',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            CustomTextField(
              controller: titleController,
              label: 'Titulo',
              hint: 'Eje. Crear opción de eliminar',
              icon: Icons.text_fields_rounded,
            ),
            CustomTextField(
              controller: descriptionController,
              label: 'Descripción',
              maxLines: 4, // ahora soporta varias líneas
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[300],
        onPressed: () {
          if (titleController.text.isEmpty) {
            Utils.showSnackBar(
              context: context,
              title: "El titulo es obligatorio",
              color: Colors.red,
            );
            return;
          }

          final Map<String, dynamic> newTodo = {
            'id': todoList.length + 1,
            'title': titleController.text,
            'description': descriptionController.text,
            'completed': false,
          };

          if (todoId == null) {
            todoList.add(newTodo);
          } else {
            final indice = todoList.indexWhere(
              (todo) => todo['id'].toString() == todoId,
            );
            todoList[indice] = newTodo;
          }

          Utils.showSnackBar(
            context: context,
            title: "Tarea creada correctamente",
          );

          titleController.clear();
          descriptionController.clear();

          context.pop();
        },
        child: Icon(Icons.add, color: Colors.blue[50]),
      ),
    );
  }
}

