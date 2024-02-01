import 'package:flutter/material.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({
    super.key,
    required this.titleRadio,
    required this.categColor,
  });

  final String titleRadio;
  final Color categColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: ThemeData(
          unselectedWidgetColor: categColor,
        ),
        child: RadioListTile(
          contentPadding: EdgeInsets.zero,
          title: Transform.translate(
            offset: const Offset(-22, 0),
            child: Text(
              titleRadio,
              style: TextStyle(
                fontSize: 14,
                color: categColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          value: 1,
          groupValue: 0,
          onChanged: (value) {},
        ),
      ),
    );
  }
}
