import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'model/subjects.dart';
import 'model/user.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class MyTutorSubjectScreen extends StatefulWidget {
  final User user;
  const MyTutorSubjectScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<MyTutorSubjectScreen> createState() => _MyTutorSubjectScreenState();
}

class _MyTutorSubjectScreenState extends State<MyTutorSubjectScreen> {
  late double screenHeight, screenWidth, resWidth;
  var numofpage, curpage = 1;
  int currentIndex = 0;
  List<Subjects> subjectList = <Subjects>[];
  var color;

  @override
  void initState() {
    super.initState();
    _loadSubjects(1);
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
        title: const Text('Subjects'),
      ),
      body: Column(children: [
        Expanded(
            child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (1 / 1),
                children: List.generate(subjectList.length, (index) {
                  return InkWell(
                    splashColor: Colors.blue,
                    child: Card(
                        child: Column(
                      children: [
                        Flexible(
                          flex: 6,
                          child: CachedNetworkImage(
                            imageUrl: CONSTANTS.server +
                                "/mytutor/mobile/assets/courses/" +
                                subjectList[index].subjectId.toString() +
                                '.png',
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
                                  subjectList[index].subjectName.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("RM " +
                                    double.parse(subjectList[index]
                                            .subjectPrice
                                            .toString())
                                        .toStringAsFixed(2)),
                                Text(subjectList[index]
                                        .subjectRating
                                        .toString() +
                                    " stars"),
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
                    onPressed: () => {_loadSubjects(index + 1)},
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

  _loadSubjects(int pageno) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/load_subjects.php"),
        body: {
          'pageno': pageno.toString(),
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);

        if (extractdata['subjects'] != null) {
          subjectList = <Subjects>[];
          extractdata['subjects'].forEach((v) {
            subjectList.add(Subjects.fromJson(v));
          });
        }
        setState(() {});
      }
    });
  }
}
