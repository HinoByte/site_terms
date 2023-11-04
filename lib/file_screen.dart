import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:site/TableModule.dart';

class SubjectScreen extends StatefulWidget {
  SubjectScreen({Key key}) : super(key: key);

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _ternController = TextEditingController();
  String textButton = 'ADD / UPDATE';
  String dropDownStr = "Дисциплина";
  List<String> subjects = ["Дисциплина"];
  List<String> terns = [];
  List<String> idDocuments = [];
  bool isLock = false;
  String _imageLock = 'assets/lock.jpg';
  String _imageUnlock = 'assets/unlock.jpg';
  String _text =
      'Нажмите на значек блокировки для разрешения внесения изменений';
  bool visibilityIcon = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  initState() {
    super.initState();
    _subjectController = TextEditingController();
    _ternController = TextEditingController();
    updateState();
    //subjects = TableModule().getSubjects();
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _ternController.dispose();
    super.dispose();
  }

  setText() {
    if (dropDownStr != 'Дисциплина')
      _text = _text = 'Нажмите на значек блокировки для внесения изменений';
    else
      _text = _text = 'Заполните поля ниже для добавления дисциплины';
    return _text;
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
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            colors: [
              Colors.cyan[500],
              Colors.cyan[300],
              Colors.cyan[400],
            ],
          ),
        ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BackButton(
                          color: Color(0xFF6F35A5),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Меню добавления / редактирования дисциплин',
                            style: GoogleFonts.lobster(
                                fontSize: isSmall ? 18 : 22.0,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding: EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFAB3FF),
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: dropDownStr,
                            onChanged: (String newValue) async {
                              int indexValue = indexInfo(newValue);
                              setState(() {
                                if (newValue != 'Дисциплина') {
                                  _subjectController.text =
                                      subjects[indexValue];
                                  _ternController.text = terns[indexValue - 1];
                                  //_currentOpacity = 1;
                                  // if (_text ==
                                  //     'Нажмите на значек блокировки для внесения изменений')
                                  isLock = true;
                                  visibilityIcon = true;
                                } else {
                                  _subjectController.text = '';
                                  _ternController.text = '';
                                  isLock = false;
                                  visibilityIcon = false;
                                }
                                dropDownStr = newValue;
                                //updateState(text: newValue);
                              });
                            },
                            items: subjects.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: Center(
                                  child: new Text(value,
                                      style: GoogleFonts.roboto(fontSize: 17)),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(setText(),
                              style: GoogleFonts.lobster(
                                  fontSize: isSmall ? 14 : 18.0)),
                          SizedBox(
                            width: 5.0,
                          ),
                          visibilityIcon
                              ? GestureDetector(
                                  onTap: () {
                                    print(isLock);
                                    setState(() {
                                      isLock = !isLock;
                                    });
                                    print(isLock);
                                  },
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            isLock ? _imageLock : _imageUnlock),
                                        fit: BoxFit.cover,
                                      ),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color(0xFF6F35A5),
                                          width: 2.0,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    // child: Image(
                                    //   image:
                                    //       AssetImage(isLock ? _imageLock : _imageUnlock),
                                    // ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
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
                          enabled: !isLock,
                          // enableInteractiveSelection: !isLock,
                          //readOnly: isLock,
                          //maxLines: 2,
                          controller: _subjectController,
                          style: GoogleFonts.lobster(fontSize: 18),
                          decoration: InputDecoration(
                              enabled: isLock,
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
                          enabled: !isLock,
                          // enableInteractiveSelection: !isLock,
                          minLines: 1,
                          maxLines: 4,
                          controller: _ternController,
                          style: GoogleFonts.roboto(fontSize: 18),
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
                  if (_subjectController.text.isEmpty) {
                    // TableModule().showSnackBar(
                    //     'Ошибка добавления. Дисциплина не может быть пустой строкой',
                    //     isSmall,
                    //     context);
                    var snackBar = SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('dsfdsfsdf',
                              style:
                                  TextStyle(fontSize: isSmall ? 12.0 : 22.0)),
                        ],
                      ),
                    );
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                  } else {
                    if (dropDownStr == 'Дисциплина')
                      await TableModule().addSubject(
                          _subjectController.text, _ternController.text);
                    else {
                      int indexValue = indexInfo(dropDownStr);
                      await TableModule().updateSubject(
                          idDocuments[indexValue - 1],
                          _subjectController.text,
                          _ternController.text);
                      //  await updateState(text: _subjectController.text);
                    }
                    cleanLists();
                    updateState(text: _subjectController.text);
                  }

                  // if (dropDownStr == 'Дисциплина' &&
                  //     _subjectController.text.isNotEmpty) {
                  //   await TableModule().addSubject(
                  //       _subjectController.text, _ternController.text);
                  //   // updateState(text: _subjectController.text);
                  //   // setState(() {
                  //   //   dropDownStr = _subjectController.text;
                  //   // });
                  // }
                  // if (dropDownStr != 'Дисциплина') {
                  //   int indexValue = indexInfo(dropDownStr);
                  //   await TableModule().updateSubject(
                  //       idDocuments[indexValue - 1],
                  //       _subjectController.text,
                  //       _ternController.text);
                  //   //  await updateState(text: _subjectController.text);
                  // }
                  // if (_subjectController.text == '')
                  //   TableModule().showSnackBar(
                  //       'Ошибка добавления. Дисциплина не может быть пустой строкой',
                  //       isSmall,
                  //       context);
                  // else {
                  //   cleanLists();
                  //   updateState(text: _subjectController.text);
                  // }
                },
                child: Text(
                  textButton,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  cleanLists() {
    subjects = ["Дисциплина"];
    terns = [];
    idDocuments = [];
  }

  updateState({String text = 'Дисциплина'}) {
    print('activate');
    var userSubjects = TableModule().getSubjects().then((value) {
      // List<String> subj = ['Выберите это поле для добавления новой дисциплины'];
      // subj.addAll(value[1]);
      setState(() {
        idDocuments.addAll(value[0]);
        subjects.addAll(value[1]);
        terns.addAll(value[2]);
        dropDownStr = text;
        if (dropDownStr != 'Дисциплина') {
          isLock = true;
          visibilityIcon = true;
        }

        print('end $idDocuments + $subjects + $terns update');
      });
    });
  }

  int indexInfo(String newValue) {
    //  for (var nameSubject in subjects) {
    //     print(prop);
    for (int i = 0; i < subjects.length; i++) {
      if (subjects[i] == newValue) {
        return i;
      }
    }
    return -1;
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
