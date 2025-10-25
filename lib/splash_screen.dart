import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _circleController;
  late AnimationController _logoController;
  late Animation<double> _circleAnimation;
  late Animation<double> _logoOpacity;

  @override
  void initState() {
    super.initState();

    // Expanding circle animation
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _circleAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeInOut),
    );

    // Logo fade-in animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    await _circleController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    await _logoController.forward();

    // 👇 Navigate to Onboarding screen after animation
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    }
  }

  @override
  void dispose() {
    _circleController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Expanding gradient background
          AnimatedBuilder(
            animation: _circleAnimation,
            builder: (context, child) {
              return ClipPath(
                clipper: CircleClipper(_circleAnimation.value),
                child: Container(
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF6CDFFF), // Aqua blue
                        Color(0xFF65E3D4), // Teal
                        Color(0xFF84FF97), // Mint green
                      ],
                      stops: [0.0, 0.46, 1.0],
                    ),
                  ),
                ),
              );
            },
          ),

          // Logo fade-in animation
          Center(
            child: FadeTransition(
              opacity: _logoOpacity,
              child: Image.asset('assets/logo.png', width: 150, height: 150),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  final double progress;
  CircleClipper(this.progress);

  @override
  Path getClip(Size size) {
    final path = Path();
    final radius = (size.width + size.height) / 2 * progress;
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: radius,
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(CircleClipper oldClipper) =>
      oldClipper.progress != progress;
}
