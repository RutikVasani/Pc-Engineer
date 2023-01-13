import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../appbarpage.dart';
import '../itemdata.dart';

class AllPcDetails extends StatefulWidget {
  const AllPcDetails({Key? key}) : super(key: key);

  @override
  State<AllPcDetails> createState() => _AllPcDetailsState();
}

class _AllPcDetailsState extends State<AllPcDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 244, 247),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("TodayData").snapshots(),
        builder:
            (__, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (___, int index) {
                  Map<String, dynamic> docTodayData =
                      snapshot.data!.docs[index].data();
                  String uid = snapshot.data!.docs[index].id;
                  if (docTodayData.isEmpty) {
                    return const SizedBox(
                      child: Center(
                        child: Text("Document is Empty"),
                      ),
                    );
                  }
                  if (docTodayData["Progress"] == "Pending") {
                    String dropdownValue = 'Pending';
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemDataPage(
                                uid: uid,
                              ),
                            ),
                          );
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          width: 200,
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              'Pc No: ${docTodayData["Pc No"]}',
                                              style: GoogleFonts.ubuntu(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              docTodayData["Progress"] =
                                                  "On Going";
                                            });
                                            try {
                                              FirebaseFirestore.instance
                                                  .collection("TodayData")
                                                  .doc(uid)
                                                  .update({
                                                "Progress":
                                                    docTodayData["Progress"],
                                                "Uid": uid
                                              }).then((_) {
                                                print("success!" +
                                                    docTodayData["Progress"]);
                                                print(uid);
                                              });
                                              FirebaseFirestore.instance
                                                  .collection("Customers")
                                                  .doc(
                                                      docTodayData["Mobile No"])
                                                  .collection("PcNumber")
                                                  .doc(docTodayData["Pc No"])
                                                  .collection("Data")
                                                  .doc(uid)
                                                  .set(docTodayData);
                                            } on FirebaseException catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      e.message.toString()),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          },
                                          icon: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.blue.shade200,
                                            ),
                                            child: const Icon(
                                              Icons.done,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Name: ",
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.7,
                                        child: Text(
                                          docTodayData["Name"],
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Mobile No: ",
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          docTodayData["Mobile No"],
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        docTodayData["Item"],
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Text(
                                        docTodayData["Cost"],
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      docTodayData["Problem"],
                                      style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            )),
                      ),
                    );
                  } else {
                    return SizedBox(width: 0, height: 0);
                  }
                },
              );
            } else {
              return const Center(
                child: Text("Document aren't available"),
              );
            }
          } else {
            return const Center(
              child: Text("Getting Error"),
            );
          }
        },
      ),
    );
  }
}
