import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WriteData {

  Future<void> addAlertData(
      pcNo, problem, cost, remarks, progress, item,BuildContext context) async {
    try {
      FirebaseFirestore.instance.collection("Alert").doc(pcNo).set({
        "Pc No": pcNo,
        "Problem": problem,
        "Cost": cost,
        "Remarks": remarks,
        "Progress": progress,
        "Item": item,
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> addprogress(PcNo, progress, BuildContext context) async {
    try {
      FirebaseFirestore.instance
          .collection(progress)
          .doc(PcNo)
          .set({"progress": progress});
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> removeprogress(
    PcNo,
    progress,
    BuildContext context,
  ) async {
    try {
      FirebaseFirestore.instance.collection(progress).doc(PcNo).delete();
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
