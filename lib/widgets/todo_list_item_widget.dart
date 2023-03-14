 // ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_proje/providers/all_providers.dart';

class TodoListItemWidget extends ConsumerStatefulWidget {
  const TodoListItemWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget> {
  late FocusNode textFocusNode; // Eleman seçildi mi seçilmedi mi
  late TextEditingController textEditingController;
  bool _hasFocus = false; //
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    textFocusNode = FocusNode();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    textFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTodo = ref.watch(currentTodoProvider);
    return Focus(
      onFocusChange: (isFocused) {
        if (!isFocused) {
          setState(() {
            _hasFocus = false;
          });
          ref.read(todoListProvider.notifier).editTodo(
              idForDescriptionChange: currentTodo.id,
              newDescription: textEditingController.text);
        }
      },
      child: ListTile(
        onTap: () {
          setState(() {
            _hasFocus = true;
            textFocusNode.requestFocus();
            textEditingController.text = currentTodo.description;
          });
        },
        leading: Checkbox(
            value: currentTodo.completed,
            onChanged: (chosenValue) {
              ref.read(todoListProvider.notifier).toggle(currentTodo.id);
            }),
        title: _hasFocus
            ? TextField(
                controller: textEditingController,
                focusNode: textFocusNode,
              )
            : Text(currentTodo.description),
      ),
    );
  }
}
 



