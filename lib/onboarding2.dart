import 'package:flutter/material.dart';
import 'onboarding3.dart';

class Onboarding2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF00A9B8),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.1),
                  Image.asset(
                    'lib/assets/images/online_shopping.png',
                    height: size.height * 0.3,
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(
                  'lib/assets/images/Rectangle.png',
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: size.height * 0.05),
                      const Text(
                        "ONLINE SHOPPING",
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                        child: const Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra quam elementum massa, viverra. Ut turpis consectetur.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                    ],
                  ),
                ),
                Positioned(
                  bottom: size.height * 0.05,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Onboarding3()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width * 0.3),
                          child: Image.asset(
                            'lib/assets/images/Skip__.png',
                            height: size.height * 0.06,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Onboarding3()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: size.width * 0.05),
                          child: Image.asset(
                            'lib/assets/images/next arrow.png',
                            height: size.height * 0.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
