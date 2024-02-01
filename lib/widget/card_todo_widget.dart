import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/provider/todo_services.dart';

class CardTododWidget extends ConsumerWidget {
  const CardTododWidget({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return todoData.when(
      data: (todoData) {
        Color categoryColor = Colors.white;
        final getCategory = todoData[getIndex].category;

        switch (getCategory) {
          case 'Learning':
            categoryColor = Colors.green;
            break;
          case 'Working':
            categoryColor = Colors.blue;
            break;
          case 'General':
            categoryColor = Colors.amber;
            break;
        }

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                width: 20,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  // vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: IconButton(
                        onPressed: () => ref
                            .read(serviceProvider)
                            .deleteTask(todoData[getIndex].docID),
                        icon: const Icon(
                          CupertinoIcons.delete,
                        ),
                      ),
                      title: Text(
                        todoData[getIndex].titleTask,
                        maxLines: 1,
                        style: TextStyle(
                          decoration: todoData[getIndex].isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text(
                        todoData[getIndex].description,
                        maxLines: 1,
                        style: TextStyle(
                          decoration: todoData[getIndex].isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          activeColor: Colors.lightBlue,
                          shape: const CircleBorder(),
                          value: todoData[getIndex].isDone,
                          onChanged: (value) {
                            ref
                                .read(serviceProvider)
                                .updateTask(todoData[getIndex].docID, value);
                          },
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -10),
                      child: SizedBox(
                        child: Column(
                          children: [
                            Divider(
                              thickness: 1.5,
                              color: Colors.grey.shade300,
                            ),
                            Row(
                              children: [
                                Text(todoData[getIndex].dateTask),
                                const Gap(12),
                                Text(todoData[getIndex].timeTask),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
            ],
          ),
        );
      },
      error: (e, s) => const Center(child: Text('Oops, something went wrong!')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
