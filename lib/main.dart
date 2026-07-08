import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'clients_screen.dart';
import 'equipment_screen.dart';
import 'schedule_screen.dart';
import 'alerts_screen.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SulecoApp());
}

class SulecoApp extends StatelessWidget {
  const SulecoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Suleco Calibrations',
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
      ),
      home: const AuthGate(),
    );
  }
}

// Decides whether to show Login or Home based on current Firebase session
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFFF5F5F7),
            body: Center(child: CircularProgressIndicator(color: Colors.deepPurple)),
          );
        }
        if (snapshot.hasData) {
          return const HomeScreen();
        }
        return const LoginScreen();
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGoodMorningCard(),
              const SizedBox(height: 16),
              _buildStatGrid(),
              const SizedBox(height: 16),
            ],
          ),
        );
      case 1:
        return const SingleChildScrollView(child: ClientsScreen());
      case 2:
        return const SingleChildScrollView(child: EquipmentScreen());
      case 3:
        return const ScheduleScreen();
      case 4:
        return const AlertsScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildHeader() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF8B5CF6), Color(0xFFD946EF)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.build, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SULECO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text('Calibrations', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        const Spacer(),
        OutlinedButton.icon(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            if (!context.mounted) return;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
            );
          },
          icon: const Icon(Icons.logout, size: 16, color: Colors.deepPurple),
          label: const Text('Exit', style: TextStyle(color: Colors.deepPurple)),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.deepPurple),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildGoodMorningCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF7C3AED), Color(0xFFD946EF)],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('GOOD MORNING', style: TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 1.2)),
            const SizedBox(height: 6),
            const Text('My Equipment', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('July 6, 2026', style: TextStyle(color: Colors.white70, fontSize: 13)),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildPill('9 registered'),
                const SizedBox(width: 8),
                _buildPill('3 overdue'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
    );
  }

  Widget _buildStatGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.4,
        children: [
          _buildStatCard(icon: Icons.warning_amber_rounded, iconColor: const Color(0xFFDC2626), iconBg: const Color(0xFFFEE2E2), value: '3', label: 'Overdue', cardColor: const Color(0xFFFEF2F2)),
          _buildStatCard(icon: Icons.access_time_rounded, iconColor: const Color(0xFFD97706), iconBg: const Color(0xFFFEF3C7), value: '1', label: 'Due Soon', cardColor: const Color(0xFFFFFBEB)),
          _buildStatCard(icon: Icons.calendar_today_rounded, iconColor: const Color(0xFF2563EB), iconBg: const Color(0xFFDBEAFE), value: '3', label: 'Upcoming', cardColor: const Color(0xFFEFF6FF)),
          _buildStatCard(icon: Icons.check_circle_rounded, iconColor: const Color(0xFF16A34A), iconBg: const Color(0xFFDCFCE7), value: '2', label: 'Good', cardColor: const Color(0xFFF0FDF4)),
        ],
      ),
    );
  }

  Widget _buildStatCard({required IconData icon, required Color iconColor, required Color iconBg, required String value, required String label, required Color cardColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.people_alt_rounded), label: 'Clients'),
        BottomNavigationBarItem(icon: Icon(Icons.build_rounded), label: 'Equipment'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: 'Schedule'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_rounded), label: 'Alerts'),
      ],
    );
  }
}