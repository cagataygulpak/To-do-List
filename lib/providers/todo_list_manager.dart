import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_proje/models/todo_model.dart';
import 'package:uuid/uuid.dart';

// Bu sınıfın yapılma amacı, Ana state nedir ==> List<TodoModel>
class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(String description) {
    var willBeAddedTodoModel =
        TodoModel(id: const Uuid().v4(), description: description);
    state = [...state, willBeAddedTodoModel];
  }

  void editTodo(
      {required String idForDescriptionChange,
      required String newDescription}) {
    state = [
      for (var meanWhileTodo in state)
        if (meanWhileTodo.id == idForDescriptionChange)
          TodoModel(
            id: meanWhileTodo.id,
            description: newDescription,
          )
          else meanWhileTodo
    ];
  }
  
  void removeTodo(TodoModel willBeRemovedTodo) {
    state =
        state.where((element) => element.id != willBeRemovedTodo.id).toList();
  }

  //Chechbox Kontrol
  void toggle(String approvedID) {
    state = [
      for (var meanWhileTodo in state)
        if (meanWhileTodo.id == approvedID)
          TodoModel(
              id: meanWhileTodo.id,
              description: meanWhileTodo.description,
              completed: !meanWhileTodo.completed)
        else
          meanWhileTodo
    ];
  }

  int showUncompletedTodo() {
    return state.where((element) => !element.completed).length;
  }
}
