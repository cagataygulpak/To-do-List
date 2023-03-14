// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_proje/providers/all_providers.dart';
import 'package:todo_proje/widgets/title_widget.dart';
import 'package:todo_proje/widgets/todo_list_item_widget.dart';
import 'package:todo_proje/widgets/toolbar_widget.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({super.key});
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var todoAllModels = ref.watch(fiteredTodoList);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const TitleWidget(),
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                labelText: "What are you gonna do today?",
              ),
              onSubmitted: (incomingString) {
                ref.read(todoListProvider.notifier).addTodo(incomingString);
              },
            ),
            const SizedBox(
              height: 30,
            ),
            ToolbarWidget(),
            todoAllModels.isEmpty
                ? const Center(child: Text("There is no information here"))
                : const SizedBox(),
            for (int i = 0; i < todoAllModels.length; i++)
              Dismissible(
                key: ValueKey(todoAllModels[i].id),
                onDismissed: (_) {
                  ref
                      .read(todoListProvider.notifier)
                      .removeTodo(todoAllModels[i]);
                },
                child: ProviderScope(
                  overrides: [
                    currentTodoProvider.overrideWithValue(todoAllModels[i])
                  ],
                  child: const TodoListItemWidget(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Provider ile sadece .watch()
// StateProvider ile .watch() ve .read()
// StateNotifierProvider ==>
//  Bunu kullanan sınıf extends StateNotifier<Tür> yapmak zorunda
