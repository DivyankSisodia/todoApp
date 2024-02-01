import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/model/todo_model.dart';

class TodoService {
  final todoCollection = FirebaseFirestore.instance.collection('todoApp');

  // CRUD Operation

  // Create

  void addNewTask(TodoModel model) {
    todoCollection.add(model.toMap());
  }
}
