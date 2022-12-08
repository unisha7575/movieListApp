import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movie_list/screens/auth/sign_up.dart';
import '../../constants/strings/string.dart';
import '../../constants/theme_smart_to_do/color.dart';
import '../../constants/theme_smart_to_do/style.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../home_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final userdata = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          body: ListView(
            children: [
              Image(image: loginImage),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: TextField(
                  controller: contactController,
                  onChanged: (e) {
                    setState(() {});
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter. digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.white,
                    filled: true,
                    label: Text(
                      loginTitle,
                      style: TextStyle(color: color, fontSize: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  inputFormatters: [
                    FilteringTextInputFormatter. digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.white,
                    filled: true,
                    label: Text("password",
                        style: TextStyle(color: color, fontSize: 14)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                    height: 45,
                    width: 180,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                            backgroundColor: buttonColor),
                        onPressed: () async {
                          // final _payload = {
                          //
                          //   "mobile": mobileController.text
                          // };
                          // final response  = await BaseClient().post('kdfkllkf.com', 'kfdjlkjfdlkj', _payload);

                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) =>  SignUp(
                          //      // isFromLogin: true,
                          //     )));
                          print("Line112: ${passwordController.text}");
                          print("Line113: ${contactController.text}");
                          print("Line114: ${userdata.read('password')}");
                          print("Line115: ${userdata.read('contact')}");
                          userdata.write("islogin", true);
                          if (passwordController.text.trim() ==
                                  userdata.read('password') &&
                              contactController.text.trim() ==
                                  userdata.read('contact')) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          } else {
                            Fluttertoast.showToast(
                                msg: "invalid Credential",
                                backgroundColor: Colors.red);
                            //showToast("invalid Credential", Colors.red);

                          }
                        },
                        child: Text(buttonLogin, style: buttonTextStyle))),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
                color: color,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(loginBottomText, style: bottomText),
                  InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUp()));
                      },
                      child:
                          Text(loginSecondBottomText, style: bottomSecondText)),
                ],
              ),
            ],
          )),
    );
  }
}
