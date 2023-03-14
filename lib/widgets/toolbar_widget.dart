// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_proje/providers/all_providers.dart';

class ToolbarWidget extends ConsumerWidget {
  ToolbarWidget({super.key});
  var currentFilter = TodoListFilter.all;

  Color changeTextColor(TodoListFilter filt) {
    return currentFilter == filt ? Colors.orange : Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int uncompletedTodoCount = ref.watch(unCompletedTodoCount);
    currentFilter = ref.watch(todoListFilter);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(uncompletedTodoCount != 0
                ? "$uncompletedTodoCount Unfinished"
                : "There is no todo")),
        Tooltip(
          triggerMode: TooltipTriggerMode.longPress,
          message: "All todos",
          child: TextButton(
            style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.all)),
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoListFilter.all;
            },
            child: const Text("All"),
          ),
        ),
        Tooltip(
          triggerMode: TooltipTriggerMode.longPress,
          message: "Uncompleted todos",
          child: TextButton(
             style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.active)),
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoListFilter.active;
            },
            child: const Text("Active"),
          ),
        ),
        Tooltip(
          triggerMode: TooltipTriggerMode.longPress,
          message: "Completed todos",
          child: TextButton(
             style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.completed)),
            onPressed: () {
              ref.read(todoListFilter.notifier).state =
                  TodoListFilter.completed;
            },
            child: const Text("Completed"),
          ),
        ),
      ],
    );
  }
}
