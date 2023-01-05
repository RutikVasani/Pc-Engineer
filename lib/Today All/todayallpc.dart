import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'details.dart';

class TodayAllPcPage extends StatelessWidget {
  const TodayAllPcPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const AllPcDetails(),
    );
  }
}