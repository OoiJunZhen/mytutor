import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mytutor/model/tutors.dart';
import 'model/user.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class MyTutorTutorScreen extends StatefulWidget {
  final User user;
  const MyTutorTutorScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<MyTutorTutorScreen> createState() => _MyTutorTutorScreenState();
}

class _MyTutorTutorScreenState extends State<MyTutorTutorScreen> {
  late double screenHeight, screenWidth, resWidth;
  var numofpage, curpage = 1;
  int currentIndex = 0;
  List<Tutors> tutorList = <Tutors>[];
  var color;

  @override
  void initState() {
    super.initState();
    _loadTutors(1);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutors'),
      ),
      body: Column(children: [
        Expanded(
            child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (1 / 1),
                children: List.generate(tutorList.length, (index) {
                  return InkWell(
                    splashColor: Colors.blue,
                    child: Card(
                        child: Column(
                      children: [
                        Flexible(
                          flex: 6,
                          child: CachedNetworkImage(
                            imageUrl: CONSTANTS.server +
                                "/mytutor/mobile/assets/tutors/" +
                                tutorList[index].tutorId.toString() +
                                '.jpg',
                            fit: BoxFit.cover,
                            width: resWidth,
                            placeholder: (context, url) =>
                                const LinearProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Flexible(
                            flex: 6,
                            child: Column(
                              children: [
                                Text(
                                  tutorList[index].tutorName.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("Email: " +
                                    tutorList[index].tutorEmail.toString()),
                                Text("PhoneNo: " +
                                    tutorList[index].tutorPhone.toString()),
                              ],
                            ))
                      ],
                    )),
                  );
                }))),
        SizedBox(
          height: 30,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: numofpage,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if ((curpage - 1) == index) {
                color = Colors.red;
              } else {
                color = Colors.black;
              }
              return SizedBox(
                width: 40,
                child: TextButton(
                    onPressed: () => {_loadTutors(index + 1)},
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(color: color),
                    )),
              );
            },
          ),
        ),
      ]),
    );
  }

  _loadTutors(int pageno) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/load_tutors.php"),
        body: {
          'pageno': pageno.toString(),
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);

        if (extractdata['tutors'] != null) {
          tutorList = <Tutors>[];
          extractdata['tutors'].forEach((v) {
            tutorList.add(Tutors.fromJson(v));
          });
        }
        setState(() {});
      }
    });
  }
}
