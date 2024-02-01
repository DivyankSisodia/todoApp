import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CardTododWidget extends StatelessWidget {
  const CardTododWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
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
                  title: const Text('Learning Riverpod'),
                  subtitle: const Text('Building a ToDo App'),
                  trailing: Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      activeColor: Colors.lightBlue,
                      shape: const CircleBorder(),
                      value: true,
                      onChanged: (value) {
                        print(value);
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
                        const Row(
                          children: [
                            Text('Today'),
                            Gap(12),
                            Text('5:00 PM - 12:00 PM')
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
  }
}
