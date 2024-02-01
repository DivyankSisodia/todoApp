

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TodoModel {
  String? docID;
  final String title;
  final String description;
  final String category;
  final String dateTask;
  final String timeTask;
  TodoModel({
    this.docID,
    required this.title,
    required this.description,
    required this.category,
    required this.dateTask,
    required this.timeTask,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'category': category,
      'dateTask': dateTask,
      'timeTask': timeTask,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
      title: map['title'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      dateTask: map['dateTask'] as String,
      timeTask: map['timeTask'] as String,
    );
  }

  factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel(
      docID: doc.id,
      title: doc['titleTask'],
      description: doc['description'],
      category: doc['category'],
      dateTask: doc['datetask'],
      timeTask: doc['timeTask'],
    );
  }
}
