import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordField extends StatefulWidget {
  PasswordField(
      {Key key,
      this.isObscure = true,
      @required this.onChanged,
      this.isReg = false})
      : super(key: key);
  final bool isObscure;
  final ValueChanged<String> onChanged;
  final bool isReg;

  @override
  State<StatefulWidget> createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool isObscure;
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isObscure = widget.isObscure;
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(primaryColor: Colors.red),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFAB3FF),
          borderRadius: BorderRadius.circular(29),
        ),
        child: TextField(
          controller: _passwordController,
          onChanged: widget.onChanged,
          style: GoogleFonts.roboto(fontSize: 18),
          cursorColor: Colors.red,
          obscureText: isObscure ? true : false,
          decoration: InputDecoration(
            icon: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Icon(
                Icons.lock,
                color: Color(0xFF6F35A5),
              ),
            ),
            labelText: 'Password',
            hintText: widget.isReg ? 'Минимум 6 символов' : '',
            border: InputBorder.none,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: Icon(
                  Icons.visibility,
                  color: Color(isObscure ? 0xFF6F35A5 : 0xFF9F3ED5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
