import 'package:ecommerce_trining/logic/authentication_cubit/auth_cubit.dart';
import 'package:ecommerce_trining/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data.dart';

//botton color Default
Color buttoncolor = const Color.fromRGBO(64, 191, 255, 1);

class LoginHome extends StatefulWidget {
  const LoginHome({super.key});

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  //هعمل متغير  خاص بالفورم علشان امرر منه الداتا للكاي وهيبقي من نفس النوع اللي بيحمله الكاي الخاص بالفورم
  GlobalKey<FormState> _keystat = GlobalKey();

  //متغيرلاظهار الباسورد او اخفاءه
  bool _showpassword = true;

  //هعمل متغيرين احفظ فيهم الميل والباسورد
  String? email;
  String? password;

  //متغيرات لحفظ الداتا وعمل كونترول عليها داخل التيكست فيلد
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم تسجيل الدخول بنجاح'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        //Background Color and theme
        body: Container(
          decoration: BackTheme(),
          //باستخدام الميديا كويري هخلي الكونتينر ياخد طول  وعرض الجهاز بالكامل
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //logo image
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: 72,
                        height: 72,
                      ),
                    ),
                    //Text at the bottom of the logo
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Wellcome To mega",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    //Text at the bottom of the logo
                    Text(
                      "Sign in to continue",
                      style: TextStyle(color: Colors.blueGrey[600]),
                    ),
                    const SizedBox(height: 20),
                    //E-mail and pass TextFormField
                    Form(
                      key: _keystat,
                      //autovalidateMode ضيفته في الفورم الاساسي علشان لو عندي اكتر من تيكستفيلد يعمل تشيك عليهم كلهم اوتوماتيك
                      //autovalidateMode: AutovalidateMode.always,
                      //TextFormField for Email and Password
                      child: Column(
                        children: [
                          //E-mail TextFormField
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            //Email TextFormField
                            child: defaultTextFormFiled(
                              //controller لحفظ القيمة او الداتا داخل المتغير واقدر اكنترول عليها او استخدمها
                              controller: emailController,
                              keyboardtype: TextInputType.emailAddress,
                              //validator بيخزن التكست او الداتا اليي بيدخلها المستخدم في المتغير فاليو اللي هو المتغير الخاص بالفانكشن بتاعته
                              //ليه مزايا كتير منها انه لو المستخدم مدخلش داتا في البورد يقدر يظهرله رسالة ان الحقل فارغ
                              //او مثلا حددتله نوع داتا ودخل عكسها او عدد حروف اكبر هنا الفاليديتور بيظهر رسالة للمستخدم بالخطأ اللي بيعمله
                              //تابع الكود علشان تعرف الاستخدام
                              validate: (value) {
                                //هنا هبدأ اديله الاحتمالات بتاعتي والرسايل اللي هتظهر لليوزر
                                if (value!.isEmpty) {
                                  return "email must not be empty";
                                } else if (!value.contains("@") ||
                                    !value.contains(".")) {
                                  return "wrong email format. Example: mail@gamil.com";
                                }
                                ;
                              },
                              label: "E-mail",
                              hint: "Your E-mail",
                              prefix: Icons.email_outlined,
                            ),
                          ),
                          //Password TextFormField
                          defaultTextFormFiled(
                            controller: passwordController,
                            keyboardtype: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Password must not be empty";
                              } else if (value.length < 5) {
                                return "Password is too short";
                              }
                            },
                            label: "Password",
                            hint: "Your Password",
                            prefix: Icons.lock,
                            //obscureText لاخفاء الداتا المكتوبة زي الباسورد
                            isPassword: _showpassword,
                            //هعمل اظهار واخفائ للباسورد عند الضغط علي الايقون الخاصة باخفاء الباسورد
                            suffixicon: IconButton(
                              icon: _showpassword
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _showpassword = !_showpassword;
                                });
                              },
                            ),
                          ),

                          //MaterialButton for sign in
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 15),
                            child: DefaultButton(
                              function: () {
                                //هعمل شرط لو شروط الفالديت الخاصة بالتيكست فيلد اتحققت  النافيجيتور يشتغل ويتم تسجيل الدخول
                                //غير كدا لا
                                if (_keystat.currentState!.validate()) {
                                  // Navigator.of(context)
                                  //     .popAndPushNamed("homelayout");
                                  context.read<AuthCubit>().loginByEmail(
                                        emailController.text,
                                        passwordController.text,
                                      );
                                }
                              },
                              text: "login",
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              height: 2,
                            ),
                          ),
                          const Text("OR"),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              height: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //login Button Google and Facebook
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {},
                      color: Color.fromARGB(255, 239, 239, 245),
                      child: Row(
                        children: [
                          Image.asset("assets/images/google.png", height: 25),
                          const SizedBox(width: 60, height: 70),
                          const Text("Login With Google",
                              style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {},
                      color: Color.fromARGB(255, 239, 239, 245),
                      child: Row(
                        children: [
                          Icon(
                            Icons.facebook,
                            size: 30,
                          ),
                          const SizedBox(width: 60, height: 70),
                          const Text(
                            "Login With Facebook",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 15),
                      child: InkWell(
                        onTap: () {},
                        child: const Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: Color.fromRGBO(64, 191, 255, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have a account?  ",
                          style: TextStyle(color: Colors.black54),
                        ),
                        //Navigator to register screan
                        InkWell(
                          onTap: () {
                            Navigator.of(context).popAndPushNamed("register");
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: Color.fromRGBO(64, 191, 255, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
