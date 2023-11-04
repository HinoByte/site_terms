import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:site/TableModule.dart';
import 'package:site/subject_screen2.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _ternController = TextEditingController();
  String textButton = 'Загрузить файл';
  String dropDownStr = 'Выберите дисциплину';
  List<String> subjects = ["Выберите дисциплину"];

  @override
  void initState() {
    super.initState();
    _subjectController = TextEditingController();
    _ternController = TextEditingController();
    updateState();
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _ternController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isSmall = false;
    if ((width < 1000) && (height < 969) || ((width >= 1000) && (height < 750)))
      isSmall = true;
    print('$width + $height');
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Color(0xFFFFAB73),
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.bottomCenter,
        //     colors: [
        //       Colors.cyan[500],
        //       Colors.cyan[300],
        //       Colors.cyan[400],
        //     ],
        //   ),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: ExactAssetImage('assets/login.jpg'),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.indigo,
                        width: 2.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xFF6F35A5),
                      width: 3.0,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                // height: height / 3.2,
                //width: width / 1.1,
                //height: isSmall ? height / 2.5 : height / 2,
                width: isSmall ? width / 1.1 : width / 2.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Доброго времени суток'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Дмитрий Анатольевич Скворцов'),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: GestureDetector(
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                            },
                            child: Text(
                              'Выйти',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        )
                      ],
                    ),
                    Text('Выберите дисциплину для которой закачиваете файлы'),
                    new DropdownButton<String>(
                      value: dropDownStr,
                      onChanged: (String newValue) {
                        setState(() {
                          dropDownStr = newValue;
                        });
                      },
                      items: subjects.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                    ),
                    Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding: EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFAB3FF),
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: TextField(
                          //maxLines: 2,
                          controller: _subjectController,
                          style: GoogleFonts.lobster(fontSize: 18),
                          decoration: InputDecoration(
                              labelStyle: GoogleFonts.roboto(fontSize: 18),
                              //border: OutlineInputBorder(),
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Icon(
                                  Icons.school,
                                  color: Color(0xFF6F35A5),
                                  //size: 10.0
                                ),
                              ),
                              labelText: 'Название дисциплины',
                              //hintText: '',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 0, bottom: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFAB3FF),
                          //E667AF
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: TextField(
                          minLines: 1,
                          maxLines: 4,
                          controller: _ternController,
                          style: GoogleFonts.lobster(fontSize: 18),
                          decoration: InputDecoration(
                              labelStyle: GoogleFonts.roboto(fontSize: 18),
                              //border: OutlineInputBorder(),
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Icon(
                                  Icons.alternate_email,
                                  color: Color(0xFF6F35A5),
                                ),
                              ),
                              labelText: 'Ключевые слова дисциплины',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 0, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Image(
                          //   width: 75,
                          //   height: 75,
                          //   image: AssetImage('assets/info.jpg'),
                          // ),
                          NewWidget(
                              image: 'assets/info.jpg', text: 'Инструкция'),
                          NewWidget(image: 'assets/files.jpg', text: 'Files'),
                          NewWidget(image: 'assets/subject.jpg', text: ''),
                          // Image(
                          //   width: 75,
                          //   height: 75,
                          //   image: AssetImage('assets/files.jpg'),
                          // ),
                          // Image(
                          //   width: 75,
                          //   height: 75,
                          //   image: AssetImage('assets/server.png'),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color(0xFF89628C),
                  borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () async {
                  // TableModule().addSubject(
                  //     _subjectController.text, _ternController.text);
                  // TableModule().addUserFiles();
                  //  FileSave().saveFile();
                  saveFile();
                  setState(() {
                    textButton = 'файл прогружен';
                  });
                  //saveFile();
                },
                child: Text(
                  textButton,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Новый пользователь?'),
                FlatButton(
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SubjectScreen()));
                  },
                  child: Text(
                    'Создайте аккаунт',
                    style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  updateState({String text = 'Выберите дисциплину'}) {
    print('activate');
    var userSubjects = TableModule().getSubjects().then((value) {
      // List<String> subj = ['Выберите это поле для добавления новой дисциплины'];
      // subj.addAll(value[1]);
      setState(() {
        subjects.addAll(value[1]);
        dropDownStr = text;
      });
    });
  }

  saveFile() async {
    // await TableModule()
    //    .addSubject(_subjectController.text, _ternController.text);
    var result = await FilePicker.platform
        .pickFiles(type: FileType.any, allowMultiple: false);
    if (result.files.first != null) {
      var fileBytes = result.files.first.bytes;
      var fileName = result.files.first.name;
      print(fileName);
      setState(() {
        textButton = 'файл прогружен';
      });
      await FirebaseStorage.instance
          .ref('${_subjectController.text}/$fileName')
          .putData(fileBytes);
      await TableModule().addUserFiles(fileName);
      await TableModule().getSubjects();
      setState(() {
        textButton = 'закачали';
      });
    } else {
      setState(() {
        textButton = 'Файл не удалось загрузить';
      });
    }
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key key,
    this.image,
    this.text,
  }) : super(key: key);
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: AlignmentDirectional.bottomCenter,
      overflow: Overflow.visible,
      children: <Widget>[
        Image(
          width: 75,
          height: 75,
          image: AssetImage(image),
        ),
        Positioned(
          bottom: -5,
          child: Text(
            text,
            style: GoogleFonts.lobster(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
