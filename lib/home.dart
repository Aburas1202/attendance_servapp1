import 'package:flutter/material.dart';

@override
Widget build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7C9AB7), // Background color
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  // Top Title & Icons
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'SERV',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: const [
                            Icon(Icons.location_on, color: Colors.white),
                            SizedBox(width: 22),
                            Icon(Icons.warning, color: Colors.white),
                            SizedBox(width: 22),
                            Icon(Icons.person, color: Colors.white),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Full-width black underline
                  Container(
                    height: 3,
                    width: double.infinity,
                    color: Colors.black,
                  ),

                  const SizedBox(height: 40),

                  // Greeting Text
                  const Text(
                    'Hello, Agalya',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'With SERV, You Deserve the Best',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Center Illustration
                  SizedBox(
                    height: 400,
                    child: Image.asset('image/homee.png', fit: BoxFit.contain),
                  ),

                  const SizedBox(height: 30),

                  // Attendance & Emergency Boxes
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Attendance Box
                        Container(
                          width: 160,
                          height: 170,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD3C9F9),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.calendar_month,
                                size: 80,
                                color: Colors.deepPurple,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Attendance',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),

                        // Emergency Box
                        Container(
                          width: 160,
                          height: 170,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFA8A1),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.touch_app,
                                size: 80,
                                color: Colors.redAccent,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Emergency\nButton',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Bottom Navigation Bar
                  Container(
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 201, 187, 160),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        BottomNavItem(
                          icon: Icons.home,
                          label: 'Home',
                          isActive: true,
                        ),
                        BottomNavItem(
                          icon: Icons.person,
                          label: 'Profile',
                          isActive: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: const Color.fromARGB(255, 18, 15, 19)),
        Text(
          label,
          style: TextStyle(
            color: isActive
                ? const Color.fromARGB(255, 46, 56, 22)
                : const Color.fromARGB(255, 46, 56, 22),
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
