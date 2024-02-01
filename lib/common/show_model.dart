import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/constants/app_style.dart';
import 'package:todoapp/model/todo_model.dart';
import 'package:todoapp/provider/date_provider.dart';
import 'package:todoapp/provider/radio_provider.dart';
import 'package:todoapp/provider/todo_services.dart';
import 'package:todoapp/widget/date_time_widget.dart';
import 'package:todoapp/widget/radio_widget.dart';
import 'package:todoapp/widget/textform_widget.dart';

class AddNewTaskModel extends ConsumerWidget {
  AddNewTaskModel({
    super.key,
  });

  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                'New Task Todo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              thickness: 1.2,
              color: Colors.grey.shade300,
            ),
            const Gap(12),
            const Text(
              'Title Task',
              style: AppStyle.headingOne,
            ),
            const Gap(6),
            textFormWidget(
              txtController: titleController,
              maxLine: 1,
              hintText: 'Add Task Name',
            ),
            const Gap(12),
            const Text(
              'Description',
              style: AppStyle.headingOne,
            ),
            const Gap(6),
            textFormWidget(
              maxLine: 5,
              hintText: 'Add Description',
              txtController: descController,
            ),
            const Gap(12),
            const Text(
              'Category',
              style: AppStyle.headingOne,
            ),
            Row(
              children: [
                Expanded(
                  child: RadioWidget(
                    categColor: const Color.fromARGB(255, 39, 214, 129),
                    titleRadio: 'LRN',
                    valueInput: 1,
                    onChangedValue: () =>
                        ref.read(radioProvider.notifier).update((state) => 1),
                  ),
                ),
                Expanded(
                  child: RadioWidget(
                    categColor: Colors.blue.shade700,
                    titleRadio: 'WRK',
                    valueInput: 2,
                    onChangedValue: () =>
                        ref.read(radioProvider.notifier).update((state) => 2),
                  ),
                ),
                Expanded(
                  child: RadioWidget(
                    categColor: Colors.amberAccent.shade700,
                    titleRadio: 'GEN',
                    valueInput: 3,
                    onChangedValue: () =>
                        ref.read(radioProvider.notifier).update((state) => 3),
                  ),
                )
              ],
            ),
            const Gap(6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateTimeWidget(
                  text: dateProv,
                  icon: CupertinoIcons.calendar,
                  headingtext: 'Date',
                  OnTap: () async {
                    final getValue = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2025),
                    );
                    if (getValue != null) {
                      final format = DateFormat.yMd();
                      ref
                          .read(dateProvider.notifier)
                          .update((state) => format.format(getValue));
                    }
                  },
                ),
                const Gap(24),
                DateTimeWidget(
                  text: ref.watch(timeProvider),
                  icon: CupertinoIcons.clock,
                  headingtext: 'Time',
                  OnTap: () async {
                    final getTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (getTime != null) {
                      ref
                          .read(timeProvider.notifier)
                          .update((state) => getTime.format(context));
                    }
                  },
                ),
              ],
            ),
            const Gap(12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(
                        color: Colors.blue.shade800,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                    ),
                    onPressed: () {
                      final getRadioValue = ref.read(radioProvider);
                      String category = '';

                      switch (getRadioValue) {
                        case 1:
                          category = 'Learning';
                          break;
                        case 2:
                          category = 'Working';
                          break;
                        case 3:
                          category = 'General';
                          break;
                      }
                      ref.read(serviceProvider).addNewTask(
                        TodoModel(
                          titleTask: titleController.text,
                          description: descController.text,
                          category: category,
                          dateTask: ref.read(dateProvider),
                          timeTask: ref.read(timeProvider),
                          isDone: false,
                        ),
                      );
                      titleController.clear();
                      descController.clear();
                      ref.read(radioProvider.notifier).update((state) => 0);
                      Navigator.pop(context);
                    },
                    child: const Text('Create'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
