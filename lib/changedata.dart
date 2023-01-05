import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/writedata.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeDataPage extends StatefulWidget {
  final String PcNo;
  final String Problem;
  final String Cost;
  final String Remarks;
  final String Progress;
  final String Item;
  const ChangeDataPage(
      {super.key,
      required this.Problem,
      required this.Cost,
      required this.Remarks,
      required this.PcNo,
      required this.Progress,
      required this.Item});

  @override
  State<ChangeDataPage> createState() => _ChangeDataPageState();
}

class _ChangeDataPageState extends State<ChangeDataPage> {
  late String _pcno = widget.PcNo;
  late String _problem = widget.Problem;
  late String _cost = widget.Cost;
  late String _remarks = widget.Remarks;
  late String _progress = widget.Progress;
  late String _item = widget.Item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 246, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 121, 174),
        title: Text("Changes",
            style:
                GoogleFonts.ubuntu(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: _pcno,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.design_services),
                      labelText: 'Enter Pc Number',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _pcno = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: _problem,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.design_services),
                      labelText: 'Enter Pc Problem',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _problem = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: _cost,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.design_services),
                      labelText: 'Enter Cost',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _cost = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: _pcno,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.design_services),
                      labelText: 'Enter Remark',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _remarks = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Cancle",
                          style: GoogleFonts.ubuntu(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: const ButtonStyle(),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        FirebaseFirestore.instance
                            .collection("TodayData")
                            .doc(_pcno)
                            .update({"Progress": "Alert"});
                        WriteData()
                            .addAlertData(_pcno, _problem, _cost, _remarks,
                                _progress, _item, context)
                            .then(
                          (result) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Data Changes"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                        );
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Done",
                          style: GoogleFonts.ubuntu(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: const ButtonStyle(),
                    ),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
