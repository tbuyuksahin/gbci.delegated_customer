// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:delegated_resources_customer/helper/app_box_decoration.dart';
import 'package:delegated_resources_customer/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:particles_fly/particles_fly.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_text_form_field.dart';
import 'dashboard_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool obscureText = true;
  TextEditingController? userName = TextEditingController();
  TextEditingController? password = TextEditingController();
  GlobalKey<FormState> userForm = GlobalKey<FormState>();
  bool isButtonEnabled = false;

  suffixIcon() {
    return GestureDetector(
      onTap: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
      child: const Icon(Icons.lock, color: Color(0xffdfff57)),
    );
  }

  Future<void> userLogin(String userName, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse('https://delegate.gbcinst.com/api/Account/create-token'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'emailAddress': userName.toString(),
        'password': password.toString(),
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> apiResponse = jsonDecode(response.body);
      print('response: $apiResponse');

      if (apiResponse.containsKey('Token') && apiResponse['Token'] != null) {
        prefs.setString('Token', apiResponse['Token']);
        prefs.setString('ApiKey', apiResponse['ApiKey']);
        print('Shared token: ${prefs.getString('Token')}');
        print('Shared ApiKey: ${prefs.getString('ApiKey')}');

        String? token = prefs.getString('Token');
        if (token != null && token.isNotEmpty) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const DashboardView()));
        }
      } else {
        print('Invalid username or password');
      }
    } else {
      print('Failed to create token. Status code: ${response.statusCode}');
      // Farklı durum kodlarını uygun şekilde ele alabilirsiniz.
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          ParticlesFly(
            height: size.height,
            width: size.width,
            connectDots: true,
            numberOfParticles: 30,
            speedOfParticles: 0.5,
            lineColor: AppColors.yellow,
            particleColor: const Color(0xffdfff57),
          ),
          Form(
            key: userForm,
            child: Center(
              child: Container(
                width: 500,
                height: 300,
                decoration: AppBoxDecoration.getBoxDecoration(),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppTextFormField(
                          hintText: 'Kullanıcı Adı',
                          obscureText: false,
                          controller: userName!,
                          onChanged: (value) {},
                          suffixIcon: false,
                        ),
                        const SizedBox(height: 20),
                        AppTextFormField(
                          hintText: 'Şifre',
                          obscureText: true,
                          controller: password!,
                          onChanged: (value) {},
                          suffixIcon: true,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: AppBoxDecoration.getElevatedButton(),
                                  onPressed: () {
                                    userLogin(userName!.text, password!.text);
                                  }, // Disable the button if not enabled
                                  child: const Text('Giriş Yap'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
