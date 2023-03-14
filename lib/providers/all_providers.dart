import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_proje/models/todo_model.dart';
import 'package:todo_proje/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

//StateNotifire yaptığımız için StateNotifierProvider yapacağız
//ref.watch(todoListProvider); bu şekilde yazarsak ikinci sıradaki sınıfın değerleri ile ilgilenmiş oluruz yani bize sabit döner
//ref.read(todoListProvider.notifier) dersek birinci kısmında belirttiğimiz kısımda fonksiyonlara erişmiş oluruz
final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(id: const Uuid().v4(), description: "Spor Yapmak"),
    TodoModel(id: const Uuid().v4(), description: "Ders Çalış"),
    TodoModel(id: const Uuid().v4(), description: "Oyun Oyna"),
    TodoModel(id: const Uuid().v4(), description: "Kitap Oku"),
  ]);
});

final unCompletedTodoCount = Provider<int>((ref) {
  final allTodos = ref.watch(todoListProvider);
  final deger = allTodos.where((element) => !element.completed).length;
  return deger;
});

final currentTodoProvider = Provider<TodoModel>((ref) {
  throw UnimplementedError();
});

enum TodoListFilter { all, active, completed }

final todoListFilter = StateProvider<TodoListFilter>(
    (ref) => TodoListFilter.all); // İlk önce bunu döndersin

final fiteredTodoList = Provider<List<TodoModel>>(
  (ref) {
    final filter = ref.watch(todoListFilter);
    final todoList = ref.watch(todoListProvider);

    switch (filter) {
      case TodoListFilter.all:
        return todoList;
      case TodoListFilter.active:
        return todoList.where((element) => !element.completed).toList();
      case TodoListFilter.completed:
        return todoList.where((element) => element.completed).toList();
    }
  },
);
