import 'package:google_fonts/google_fonts.dart';
import 'package:site/TableModule.dart';
import 'package:site/login_page.dart';
import 'package:flutter/material.dart';
import 'package:site/passwordField.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _loginController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String _password = '';

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isSmall = false;
    if ((width < 1000) && (height < 900) || ((width >= 1000) && (height < 900)))
      isSmall = true;
    return Scaffold(
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
                      image: ExactAssetImage('assets/reg.jpg'),
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
                // height: height / 3.5,
                // width: width / 2.5,
                height: isSmall ? height / 2.5 : height / 3.5,
                width: isSmall ? width / 1.4 : width / 2.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 20.0, right: 20.0, top: 20, bottom: 0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Container(
                    //        // height: 50,
                    //         width: width/4,
                    //         decoration: BoxDecoration(
                    //           color: Color(0xFFFAB3FF),
                    //           //E667AF
                    //           borderRadius: BorderRadius.circular(29),
                    //         ),
                    //         child: TextField(
                    //           decoration: InputDecoration(
                    //               //border: OutlineInputBorder(),
                    //               icon: Icon(
                    //                 Icons.person,
                    //                 color: Color(0xFF6F35A5),
                    //               ),
                    //               labelText: 'Фамилия',
                    //               border: InputBorder.none),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 35,
                    //       ),
                    //       Container(
                    //        // height: 50,
                    //         width: width/9,
                    //         decoration: BoxDecoration(
                    //           color: Color(0xFFFAB3FF),
                    //           //E667AF
                    //           borderRadius: BorderRadius.circular(29),
                    //         ),
                    //         child: TextField(
                    //           decoration: InputDecoration(
                    //               //border: OutlineInputBorder(),
                    //               icon: Icon(
                    //                 Icons.person,
                    //                 color: Color(0xFF6F35A5),
                    //               ),
                    //               labelText: 'Инициалы',
                    //               border: InputBorder.none),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding: EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFAB3FF),
                          //E667AF
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: TextField(
                          style: GoogleFonts.lobster(fontSize: 18),
                          controller: _loginController,
                          decoration: InputDecoration(
                              labelStyle: GoogleFonts.roboto(fontSize: 18),
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Icon(
                                  Icons.person,
                                  color: Color(0xFF6F35A5),
                                ),
                              ),
                              labelText: 'Фамилия Имя Отчество',
                              hintText: 'Иванов Иван Иванович',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 0, bottom: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFAB3FF),
                          //E667AF
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: TextField(
                          style: GoogleFonts.lobster(fontSize: 18),
                          controller: _emailController,
                          decoration: InputDecoration(
                              labelStyle: GoogleFonts.roboto(fontSize: 18),
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Icon(
                                  Icons.alternate_email,
                                  color: Color(0xFF6F35A5),
                                ),
                              ),
                              labelText: 'Email',
                              hintText: 'abc@gmail.com',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 0, bottom: 20),
                      child: PasswordField(
                        isReg: true,
                        onChanged: (value) {
                          _password = value;
                        },
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
                  bool reg = await TableModule().registerUser(
                      _loginController.text,
                      _emailController.text,
                      _password,
                      isSmall,
                      context);
                  if (reg == true)
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          elevation: 3.0,
                          backgroundColor: Color(0xFFFAB3FF),
                          content: Container(
                            height: 120,
                            width: 250,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 85,
                                  width: 85,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.indigo,
                                        width: 2.0,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(90.0),
                                    image: const DecorationImage(
                                      image: ExactAssetImage(
                                          'assets/successful.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Вы успешно зарегистрировались',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    // shadows: [
                                    //   Shadow(
                                    //     blurRadius: 20.0,
                                    //     color: Colors.white,
                                    //     // offset: Offset(10.0, 10.0),
                                    //   ),
                                    // ],
                                  ),
                                  // style: GoogleFonts.roboto(
                                  //     shadows: <Shadow>[
                                  //       Shadow(
                                  //           offset: Offset(10.0, 10.0),
                                  //           blurRadius: 50.0,
                                  //           color: Colors.yellow),
                                  //       // Shadow(
                                  //       //   offset: Offset(10.0, 10.0),
                                  //       //   blurRadius: 8.0,
                                  //       //   color: Color.fromARGB(125, 0, 0, 255),
                                  //       // ),
                                  //     ],
                                  //     // backgroundColor: Colors.red,
                                  //     fontSize: 13,
                                  //     color: Color(0xFF6F35A5),
                                  //     // fontWeight: FontWeight.w700,
                                  //     decorationColor: Colors.green),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (_) => LoginScreen()));
                  //TableModule().showSnackBar(
                  // 'Пользователь успешно зарегестрирован',
                  // isSmall,
                  // context);

                  // TableModule().showSnackBar(
                  //     'Пользователь успешно зарегестрирован', context);
                  // Navigator.pop(context);
                },
                child: Text(
                  'Регистрация',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('У меня уже есть аккаунт'),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'На страницу авторизации',
                      style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class PasswordField extends StatefulWidget {
//   PasswordField({Key key, this.isObscure = true}) : super(key: key);
//   final bool isObscure;

//   @override
//   State<StatefulWidget> createState() => PasswordFieldState();
// }

// class PasswordFieldState extends State<PasswordField> {
//   bool isObscure;
//   @override
//   void initState() {
//     super.initState();
//     isObscure = widget.isObscure;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Color(0xFFFAB3FF),
//         borderRadius: BorderRadius.circular(29),
//       ),
//       child: TextField(
//         cursorColor: Colors.red,
//         obscureText: isObscure ? true : false,
//         decoration: InputDecoration(
//           //border: OutlineInputBorder(),
//           icon: Icon(
//             Icons.lock,
//             //0xFF9F3ED5
//             color: Color(0xFF6F35A5),
//           ),
//           labelText: 'Password',
//           hintText: 'Пароль минимум из 5 символов, буквы и цифры',
//           border: InputBorder.none,
//           suffixIcon: GestureDetector(
//             onTap: () {
//               print(isObscure);
//               setState(() {
//                 isObscure = !isObscure;
//               });
//             },
//             behavior: HitTestBehavior.opaque,
//             child: Icon(
//               Icons.visibility,
//               color: Color(isObscure ? 0xFF6F35A5 : 0xFF9F3ED5),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
