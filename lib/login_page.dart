// unchanged imports
import 'package:flutter/material.dart';
import 'home.dart'; // Your HomePage

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isNumericInput = false;
  bool isPasswordVisible = false;
  String selectedCountryCode = '+91';

  final List<Map<String, String>> countryList = [
    {'code': '+91', 'name': 'India', 'flag': '🇮🇳'},
    {'code': '+1', 'name': 'USA', 'flag': '🇺🇸'},
    {'code': '+44', 'name': 'UK', 'flag': '🇬🇧'},
    {'code': '+61', 'name': 'Australia', 'flag': '🇦🇺'},
    {'code': '+81', 'name': 'Japan', 'flag': '🇯🇵'},
    {'code': '+971', 'name': 'UAE', 'flag': '🇦🇪'},
    {'code': '+49', 'name': 'Germany', 'flag': '🇩🇪'},
    {'code': '+33', 'name': 'France', 'flag': '🇫🇷'},
    {'code': '+86', 'name': 'China', 'flag': '🇨🇳'},
    {'code': '+92', 'name': 'Pakistan', 'flag': '🇵🇰'},
    {'code': '+880', 'name': 'Bangladesh', 'flag': '🇧🇩'},
  ];

  @override
  void initState() {
    super.initState();
    idController.addListener(_checkInputType);
  }

  void _checkInputType() {
    final input = idController.text.trim();
    setState(() {
      isNumericInput = RegExp(r'^\d+$').hasMatch(input);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Logo
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFCC00),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset('image/logipage.png', fit: BoxFit.cover),
                ),
                SizedBox(height: 20),
                Text(
                  'Sign In',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),

                // Email / Mobile Label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Email / Mobile ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),

                Row(
                  children: [
                    if (isNumericInput)
                      Container(
                        width: 140,
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedCountryCode,
                            icon: Icon(Icons.arrow_drop_down),
                            isExpanded: true,
                            items: countryList.map((country) {
                              return DropdownMenuItem(
                                value: country['code'],
                                child: Row(
                                  children: [
                                    Text(country['flag'] ?? ''),
                                    SizedBox(width: 6),
                                    Text(
                                      '${country['code']} ${country['name']}',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() => selectedCountryCode = value!);
                            },
                          ),
                        ),
                      ),
                    Expanded(
                      child: TextFormField(
                        controller: idController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _inputDecoration(hint: "Email / Mobile"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty)
                            return "Required";
                          final trimmed = value.trim();
                          final isNumeric = RegExp(
                            r'^\d{10}$',
                          ).hasMatch(trimmed);
                          if (isNumericInput && !isNumeric)
                            return "Enter 10-digit mobile number";
                          if (!isNumericInput) {
                            final emailRegex = RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                            );
                            if (!emailRegex.hasMatch(trimmed))
                              return "Enter valid email";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24),

                // Password
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Password ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: _inputDecoration(hint: "Password").copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () => setState(
                        () => isPasswordVisible = !isPasswordVisible,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),

                // Forgot Password
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () => _showForgotPasswordDialog(context),
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ),

                // Sign in button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please enter both ID and password"),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1E2F5B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      "Sign in as employee",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 12),

                // Sign in as admin (no action yet)
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1E2F5B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      "Sign in as admin",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    final TextEditingController contactController = TextEditingController();
    final GlobalKey<FormState> _dialogFormKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Forgot Password"),
        content: Form(
          key: _dialogFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Enter registered email or phone"),
              SizedBox(height: 12),
              TextFormField(
                controller: contactController,
                decoration: InputDecoration(
                  hintText: "Email or phone",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  final contact = value?.trim() ?? '';
                  final isPhone = RegExp(r'^\d{10}$').hasMatch(contact);
                  final isEmail = RegExp(
                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                  ).hasMatch(contact);
                  if (contact.isEmpty) return "Please enter email or mobile";
                  if (!isPhone && !isEmail)
                    return "Enter valid 10-digit mobile or valid email";
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1E2F5B)),
            onPressed: () {
              if (_dialogFormKey.currentState!.validate()) {
                final contact = contactController.text.trim();
                Navigator.pop(context);
                _showOtpDialog(context, contact);
              }
            },
            child: Text("Next"),
          ),
        ],
      ),
    );
  }

  void _showOtpDialog(BuildContext context, String contact) {
    final TextEditingController otpController = TextEditingController();
    final isPhone = RegExp(r'^\d{10}$').hasMatch(contact);
    String masked = isPhone
        ? contact.replaceRange(2, 8, '*' * 6)
        : contact.replaceRange(3, contact.indexOf('@'), '*' * 5);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Verify Code"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Enter 6-digit code sent to $masked"),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _showForgotPasswordDialog(context);
                },
                child: Text(
                  "Change",
                  style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                counterText: '',
                hintText: "Enter code",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () {}, child: Text("Resend Code")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1E2F5B)),
            onPressed: () {
              if (otpController.text.length == 6) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Code verified! Password reset link sent."),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please enter a valid 6-digit code")),
                );
              }
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({String hint = ""}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      hintStyle: TextStyle(fontSize: 14, color: Colors.grey[600]),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.blue.shade300),
      ),
    );
  }
}
