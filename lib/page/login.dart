import 'package:flutter/material.dart';
import 'package:recipe_app/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  String? userName,password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(child: _buildUi(context)),
    );
  }

  Widget _buildUi(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _title(),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _title() {
    return const Text('Receipe Book',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300));
  }

  Widget _loginForm(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.90,
        height: MediaQuery.sizeOf(context).height * 0.30,
        child: Form(
            key: _loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  initialValue: "kminchelle",
                  onSaved: (value){
                    setState(() {
                      userName = value;
                    });
                  },
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Enter User Name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "UserName",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            style: BorderStyle.solid, color: Colors.black, width: 2),
                      )),
                ),
                TextFormField(
                  initialValue: "0lelplR",
                  onSaved: (value){
                    setState(() {
                      password = value;
                    });
                  },
                  obscureText: true,
                  validator: (value){
                    if(value == null || value.length < 5){
                      return "Enter valid Password";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            style: BorderStyle.solid, color: Colors.black, width: 2),
                      )),
                ),
                _loginButton(context)
              ],
            )),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.60,
      child: ElevatedButton(onPressed: () async {
        if(_loginFormKey.currentState?.validate() ?? false){
            _loginFormKey.currentState?.save();
            print("$userName username $password password");
            bool result = await AuthService().login(userName!, password!);
            if(result){
                Navigator.pushReplacementNamed(context, "/home");
            }else{
              StatusAlert.show(
                  context,
                  duration: const Duration(seconds: 2),
                  title: "Login Failed",
                  subtitle: "Please try Again",
                  configuration: const IconConfiguration(
                    icon: Icons.error
                  ),
                  maxWidth: 260
              );
            }
        }
      }, child: const Text("Login")),
    );
  }

}
