import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'otp verification.dart';
import 'home.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  late String _verificationId;
  late String _selectedCountryCode = '+91';

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google Sign-In was canceled')),
        );
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'uid': userCredential.user?.uid,
        'displayName': userCredential.user?.displayName,
        'email': userCredential.user?.email,
        'photoURL': userCredential.user?.photoURL,
      });

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User signed in successfully')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(user: userCredential.user),
        ),
      );

      return userCredential.user;
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In failed: $e')),
      );
      return null;
    }
  }

  Future<void> verifyPhoneNumber() async {
    final phoneNumber = _phoneController.text;

    if (phoneNumber.isNotEmpty) {
      try {
        final fullPhoneNumber = '$_selectedCountryCode$phoneNumber';

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(child: CircularProgressIndicator()),
        );

        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: fullPhoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance.signInWithCredential(credential);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Phone number verified successfully')),
            );
          },
          verificationFailed: (FirebaseAuthException e) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Verification failed: ${e.message}')),
            );
          },
          codeSent: (String verificationId, int? resendToken) {
            Navigator.pop(context);
            setState(() {
              _verificationId = verificationId;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPVerificationScreen(verificationId: _verificationId),
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error occurred: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.05),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close, color: Colors.black),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Image.asset(
                  'lib/assets/images/logo.png',
                  height: size.height * 0.1,
                ),
                SizedBox(height: size.height * 0.02),
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                const Text(
                  "Login to continue",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                IntlPhoneField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  initialCountryCode: 'IN',
                  onChanged: (phone) {
                    _selectedCountryCode = phone.countryCode;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                ElevatedButton(
                  onPressed: verifyPhoneNumber,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 169, 184),
                    shape: const StadiumBorder(),
                    minimumSize: Size(double.infinity, size.height * 0.07),
                  ),
                  child: const Text(
                    "GET OTP",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                const Text(
                  "Or Continue With",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        signInWithGoogle(context);
                      },
                      icon: Image.asset(
                        'lib/assets/images/google.png',
                        height: size.height * 0.1,
                      ),
                    ),
                    SizedBox(width: size.width * 0.05),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'lib/assets/images/facebook.png',
                        height: size.height * 0.1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
