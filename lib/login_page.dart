import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:site/TableModule.dart';
import 'package:site/main_screen.dart';
import 'package:site/passwordField.dart';
import 'package:site/reg_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  String _password = '';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    FirebaseAuth.instance.authStateChanges().listen(
      (User user) {
        if (user != null)
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => MainScreen()));
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isSmall = false;
    if ((width < 1000) && (height < 850) || ((width >= 1000) && (height < 850)))
      isSmall = true;
    print('$width + $height');
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
                  // width: 150,
                  // height: 150,
                  // /*decoration: BoxDecoration(
                  //     color: Colors.red,
                  //     borderRadius: BorderRadius.circular(50.0)),*/
                  // child: Image.asset('assets/reg.jpg')
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
                // height: height / 4.69,
                // width: width / 2.5,
                height: isSmall ? height / 3.3 : height / 4.69,
                width: isSmall ? width / 1.4 : width / 2.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                          controller: _emailController,
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
                  bool login = await TableModule().loginUser(
                      _emailController.text, _password, isSmall, context);
                  if (login)
                    //checkPasword(_emailController.text, _password);
                    // return showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return AlertDialog(
                    //       // Retrieve the text the that user has entered by using the
                    //       // TextEditingController.
                    //       content: Text(_emailController.text),
                    //     );
                    //   },
                    // );
                    // Scaffold.of(context).showSnackBar(SnackBar(
                    //   content: Text('Tap'),
                    // ));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MainScreen()));
                },
                child: Text(
                  'Войти',
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => RegistrationScreen()));

                    //  TableModule().addUser(_emailController.text, _password);
                    //await TableModule().updateCurrentUser();
                    // checkPasword(_emailController.text, _password);
                    //PasswordField(onChanged: _handleTapboxChanged);
                    //print(_password);

                    // checkPasword(
                    //  _emailController.text,
                    // PasswordFieldState().passwordController.text
                    //);
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

  Future<void> checkPasword(String email, String password) async {
    //String password = PasswordField().onChanged;
    print('$email + $password');
    // await TableModule().loginUser(email, password);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => RegistrationScreen(),
    //   ),
    // );
  }
}
