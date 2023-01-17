import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/alertdatapage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Ongoing Pc/ongoingpc.dart';
import 'Today All/todayallpc.dart';

class AppBarPage extends StatefulWidget {
  const AppBarPage({Key? key}) : super(key: key);

  @override
  State<AppBarPage> createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  int pageIndex = 0;

  final pages = [const TodayAllPcPage(), const OngoingPcPage()];
  late String mobileno;
  late String name;
  late String PcNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 16, 121, 174),
        title: Text('PC Computer',
            style:
                GoogleFonts.ubuntu(fontSize: 25, fontWeight: FontWeight.bold)),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 5, bottom: 12),
          child: IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {},
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_alert),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShowAlertDataPage(),
                        ),
                      );
                    },
                  ),
                  Container(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Alert")
                          .snapshots(),
                      builder: (__,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          if (snapshot.data!.docs.isNotEmpty) {
                            int _alertItem = snapshot.data!.docs.length;
                            return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text('${_alertItem}',
                                        style: GoogleFonts.ubuntu(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  );
                          }
                        }
                        return const SizedBox(
                          height: 0,
                          width: 0,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 16, 121, 174),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            child: pageIndex == 0
                ? Row(
                    children: [
                      Image.asset("assets/images/home.png", height: 25),
                      const SizedBox(width: 7),
                      Text(
                        "Today",
                        style: GoogleFonts.poppins(
                            fontSize: 22, color: Colors.white),
                      ),
                    ],
                  )
                : Image.asset("assets/images/home1.png", height: 25),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              child: pageIndex == 1
                  ? Row(
                      children: [
                        Image.asset("assets/images/menu.png", height: 25),
                        const SizedBox(width: 7),
                        Text("Ongoing",
                            style: GoogleFonts.poppins(
                                fontSize: 22, color: Colors.white))
                      ],
                    )
                  : Image.asset("assets/images/menu1.png", height: 25)),
        ],
      ),
    );
  }
}
