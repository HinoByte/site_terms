import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TableModule {
  uploadFile(String subject, String fileName, Uint8List fileBytes) async {
    await FirebaseStorage.instance.ref('$subject/$fileName').putData(fileBytes);
  }

  Future<bool> registerUser(
      name, email, password, bool isSmall, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      //await userCredential.user.updateProfile(displayName: name);
      await createUser(name, userCredential.user.uid);
      // print(userCredential.user.displayName);
      return true;
    } on FirebaseAuthException catch (e) {
      // TODO all iskluchenia
      if (e.code == 'weak-password') {
        showSnackBar('Введенный пароль слишком слаб', isSmall, context);
      } else if (e.code == 'email-already-in-use') {
        showSnackBar('На эту электронную почту уже зарегестрирован аккаунт',
            isSmall, context);
      }
    }
    return false;
  }

  Future<bool> loginUser(email, password, bool isSmall, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'invalid-email') {
        showSnackBar(
            'Адрес электронной почты в неверном формате', isSmall, context);
      }
      if (e.code == 'user-not-found') {
        showSnackBar(
            'Пользователь зарегистрированный на этот адрес электронной почты не найден',
            isSmall,
            context);
      } else if (e.code == 'wrong-password') {
        showSnackBar('Пароль не подходит к этому аккаунту', isSmall, context);
      }
    }
    return false;
  }

  showSnackBar(String text, bool isSmall, BuildContext context) {
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: TextStyle(fontSize: isSmall ? 12.0 : 22.0)),
          ],
        ),
      ),
    );
  }

  createUser(name, uid) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.add(
      {
        'uid': uid,
        'full_name': name,
        'files': [],
      },
    );
  }

  currentUser() async {
    String userDocumentId;
    String uidUser = FirebaseAuth.instance.currentUser.uid;
    QuerySnapshot users =
        await FirebaseFirestore.instance.collection('users').get();
    users.docs.forEach(
      (doc) {
        if (uidUser == doc["uid"]) userDocumentId = doc.id;
      },
    );
    return userDocumentId;
  }

  addSubject(String nameSubject, String terns) async {
    String uidUser = await currentUser();
    CollectionReference subjects =
        FirebaseFirestore.instance.collection('subjects');
    await subjects.add(
      {
        'uidUser': uidUser,
        'nameSubject': nameSubject,
        'terns': terns,
      },
    );
  }

  getSubjects() async {
    String uidUser = await currentUser();
    List<String> userSubjectsId = [];
    List<String> userSubjects = [];
    List<String> subjectsTerns = [];
    QuerySnapshot subjects =
        await FirebaseFirestore.instance.collection('subjects').get();
    subjects.docs.forEach(
      (doc) {
        if (uidUser == doc["uidUser"]) {
          userSubjectsId.add(doc.id);
          userSubjects.add(doc.get("nameSubject"));
          subjectsTerns.add(doc.get("terns"));
        }
      },
    );
    print(userSubjectsId);
    print(userSubjects);
    print(subjectsTerns);
    return [userSubjectsId, userSubjects, subjectsTerns];
    // var currentUserDoc = await FirebaseFirestore.instance
    //     .collection('subjects')
    //     .doc(uidUser)
    //     .get();
    // return await currentUserDoc.get('files');
  }

  updateSubject(currentSubjectId, subject, terns) {
    FirebaseFirestore.instance
        .collection('subjects')
        .doc(currentSubjectId)
        .update({'nameSubject': subject, 'terns': terns})
        .then((value) => print("Subject Updated"))
        .catchError((error) => print("Failed to update subject: $error"));
  }
  //  getSubjectInfo() async {
  //   String uidUser = await currentUser();
  //   String userSubjectId ='';
  //   String userSubject = '';
  //   String subjectsTerm = '';
  //   QuerySnapshot subject =
  //       await FirebaseFirestore.instance.collection('subjects').get();
  //   subject.docs.forEach(
  //     (doc) {
  //       if (uidUser == doc["uidUser"]) {
  //         userSubjectId.add(doc.id);
  //         userSubject.add(doc.get("nameSubject"));
  //         subjectsTerm.add(doc.get("terns"));
  //       }
  //     },
  //   );
  // }

  addUserFiles(String fileName) async {
    String uidUser = await currentUser();
    var currentUserDoc =
        await FirebaseFirestore.instance.collection('users').doc(uidUser).get();

    var currentUserFiles = await currentUserDoc.get('files');

    //List<String> files = ['Хохо', 'haha'];
    currentUserFiles.add(fileName);
    //String uidUser = FirebaseAuth.instance.currentUser.uid;
    // QuerySnapshot users =
    //     await FirebaseFirestore.instance.collection('users').get();
    // users.docs.forEach(
    //   (doc) {
    //     if (uidUser == doc["uid"]) userDocument = doc.id;
    //   },
    // );
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserDoc.id)
        .update({'files': currentUserFiles})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  updateCurrentUser() async {
    User user = FirebaseAuth.instance.currentUser;
    List<String> fileName = [];
    Map<String, String> subjectTerm = {};
    QuerySnapshot currentUser =
        await FirebaseFirestore.instance.collection('users').get();
    currentUser.docs.forEach(
      (doc) {
        print(doc["email"]);
      },
    );

    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc('gFR9xc7vv7vkoy1l9A5k')
    //     .update({'files': fileName, 'terns': subjectTerm})
    //     .then((value) => print("User Updated"))
    //     .catchError((error) => print("Failed to update user: $error"));
  }

  giveAllInfo() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'test@test.com', password: 'test123');
    User user = FirebaseAuth.instance.currentUser;
    print(user.uid);
    user.uid;
    List<String> fileName = ['урок.pdf, слова.docx, учеба.doc'];
    Map<String, String> subjectTerm = {
      'урок': 'слова, учеба, тарампамапа',
      'гаф': 'слова, учеба, тарампамапа'
    };

    FirebaseFirestore.instance
        .collection('users')
        .doc('gFR9xc7vv7vkoy1l9A5k')
        .update({'files': fileName, 'terns': subjectTerm})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
    // QuerySnapshot allUsers =
    //     await FirebaseFirestore.instance.collection('users').get();
    // allUsers.docs.forEach(
    //   (doc) {
    //     print(doc["first_name"]);
    //   },
    // );
  }
}
