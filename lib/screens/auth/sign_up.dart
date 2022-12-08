import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_list/screens/auth/sign_in.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/strings/string.dart';
import '../../constants/theme_smart_to_do/color.dart';
import '../../constants/theme_smart_to_do/style.dart';
import '../../services/base_client.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  final userdata = GetStorage();

  // String? get _errorText {
  //   final text = nameController.value.text;
  //   // if (text.isEmpty) {
  //   //   return 'Can\'t be empty';
  //   // }
  //   if (text.length < 4) {
  //     return 'Please Input Valid Name (more than 3 character)';
  //   }
  //  // return null;
  // }
  // String? get _contactValidation {
  //   final text = contactController.value.text;
  //   if (text.isEmpty) {
  //     return 'Required';
  //   }
  //   if (text.length !=10 ) {
  //     return 'Invalid Number';
  //   }
  //  //return null;
  // }
  // String? get passwordValidation {
  //   final text = passwordController.value.text;
  //   if (text.isEmpty) {
  //     return 'Required';
  //   }
  //   if (text.length <= 4) {
  //     return 'Invalid Number';
  //   }
  //  //return null;
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: (_isLoading)
            ? Center(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 12.0),
                  const Text("Please wait...")
                ],
              ))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image(image: signUpImage),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(signUpTitle, style: customTitle),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: textFieldColor,
                          prefixIcon: const Icon(Icons.person),
                          hintText: signUpFirstHintText,
                          hintStyle: const TextStyle(fontSize: 13),
                        ),
                        onChanged: (e) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: contactController,
                        inputFormatters: [
                          FilteringTextInputFormatter. digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.phone),
                          filled: true,
                          fillColor: textFieldColor,
                          hintText: signUpSecondHintText,
                          hintStyle: const TextStyle(fontSize: 13),
                        ),
                        onChanged: (e) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.email),
                            filled: true,
                            fillColor: textFieldColor,
                            hintText: signUpThirdHintText,
                            hintStyle: const TextStyle(fontSize: 14),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.password),
                            filled: true,
                            fillColor: textFieldColor,
                            hintText: 'password',
                            hintStyle: const TextStyle(fontSize: 13),
                        ),
                        onChanged: (e) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 45,
                        width: 180,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                backgroundColor: buttonColor),
                            onPressed: () async {
                              // var payload = {
                              //   "phone": contactController.text,
                              //   "isLogin" : false
                              // };
                              // print("Line92 $payload");
                              // setState(() {
                              //   _isLoading = true;
                              // });
                              // var response = await BaseClient().post('https://todo-app-vqmx.onrender.com/api/v1', '/sendotp', payload);
                              // setState(() {
                              //   _isLoading = false;
                              // });
                              // if(response != null){
                              //   print("Line96 $response");
                              //   // Navigator.push(context, MaterialPageRoute(builder: (context)=> Otp(
                              //   //   phone: contactController.text,
                              //   //   name: nameController.text,
                              //   //   email: emailController.text,
                              //   //   isFromLogin: false,
                              //   // )));
                              // }
                            },
                            child: InkWell(
                                onTap: () {
                                  userdata.write(
                                      'contact', contactController.text);
                                  userdata.write(
                                      'password', passwordController.text);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const SignIn()));
                                  Fluttertoast.showToast(msg: "Successfully user created!\nYou can login now");
                                },
                                child: Text(buttonRegister,
                                    style: buttonTextStyle))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Text(signUpBottomText, style: bottomText),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignIn()));
                            },
                            child: Text("Login", style: bottomSecondText),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
