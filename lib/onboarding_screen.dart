import 'dart:ui';
import 'package:flutter/material.dart';

// Import your destination screens (replace these with your actual files)
import 'loginscreen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const topColor = Color(0xFF6CDFFF);
    const midColor = Color(0xFF65E3D4);
    const bottomColor = Color(0xFF84FF97);
    const primaryButtonColor = Color(0xFF072729);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [topColor, midColor, bottomColor],
            stops: [0.0, 0.46, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Background eye chart image
            Positioned.fill(
              child: Center(
                child: FractionallySizedBox(
                  heightFactor: 1.30,
                  widthFactor: 1.30,
                  child: Transform.translate(
                    offset: const Offset(0, 20),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.2, sigmaY: 2.2),
                        child: Opacity(
                          opacity: 0.22,
                          child: Image.asset(
                            'assets/eyechart.png',
                            fit: BoxFit.contain,
                            alignment: Alignment.topCenter,
                            color: Colors.white.withOpacity(0.03),
                            colorBlendMode: BlendMode.srcOver,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Foreground content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28.0,
                  vertical: 18.0,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 35),

                    const Text(
                      "Book An Appointment\nFor Your Eyes",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        height: 1.18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF022627),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "within minutes.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Color(0x8A000000)),
                    ),

                    const Spacer(flex: 4),

                    // Buttons
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Sign Up button → Navigate to SignUpScreen
                        SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryButtonColor,
                              elevation: 6,
                              shadowColor: Colors.black45,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Sign In button → Navigate to LoginScreen
                        SizedBox(
                          height: 52,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                color: Color(0xFF072729),
                                width: 2.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF072729),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 26),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
