import 'package:flutter/material.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Overdue: Leica TS16 P',
      'description': 'James Mutua — Leica TS16 P calibration is 3 months overdue.',
      'time': '2026-07-06 09:00',
      'unread': true,
      'type': 'urgent',
    },
    {
      'title': 'Overdue: Nikon AX-2S',
      'description': 'David Kamau — Nikon AX-2S Auto Level calibration is 3 months overdue.',
      'time': '2026-07-06 09:00',
      'unread': true,
      'type': 'urgent',
    },
    {
      'title': 'Overdue: Hilti POA 30',
      'description': 'Faith Wanjiku — Hilti POA 30 Theodolite calibration is overdue since Jul 10.',
      'time': '2026-07-06 09:00',
      'unread': true,
      'type': 'urgent',
    },
    {
      'title': 'Due Soon: Topcon AT-B4A',
      'description': 'James Mutua — Topcon AT-B4A calibration is due in 5 days.',
      'time': '2026-07-05 14:20',
      'unread': true,
      'type': 'warning',
    },
    {
      'title': 'Info: New equipment registered',
      'description': 'Amina Osei added Trimble R12i to her equipment list.',
      'time': '2026-07-04 11:10',
      'unread': false,
      'type': 'info',
    },
    {
      'title': 'Calibration Complete: Sokkia CX-101',
      'description': 'David Kamau — Sokkia CX-101 was successfully calibrated.',
      'time': '2026-07-02 16:45',
      'unread': false,
      'type': 'success',
    },
  ];

  void _markAllRead() {
    setState(() {
      for (var n in _notifications) {
        n['unread'] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((n) => n['unread'] == true).length;
    final urgentCount = _notifications.where((n) => n['type'] == 'urgent').length;
    final warningCount = _notifications.where((n) => n['type'] == 'warning').length;
    final infoCount = _notifications.where((n) => n['type'] == 'info').length;
    final successCount = _notifications.where((n) => n['type'] == 'success').length;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Notifications',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$unreadCount unread',
                      style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                OutlinedButton(
                  onPressed: _markAllRead,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.deepPurple),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Mark all read', style: TextStyle(color: Colors.deepPurple)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildStatChip(urgentCount, 'Urgent', const Color(0xFFDC2626), const Color(0xFFFEE2E2))),
                const SizedBox(width: 8),
                Expanded(child: _buildStatChip(warningCount, 'Warning', const Color(0xFFD97706), const Color(0xFFFEF3C7))),
                const SizedBox(width: 8),
                Expanded(child: _buildStatChip(infoCount, 'Info', const Color(0xFF2563EB), const Color(0xFFDBEAFE))),
                const SizedBox(width: 8),
                Expanded(child: _buildStatChip(successCount, 'Success', const Color(0xFF16A34A), const Color(0xFFD1FAE5))),
              ],
            ),
            const SizedBox(height: 16),
            ..._notifications.map((n) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildNotificationCard(n),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(int count, String label, Color color, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text('$count', style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> n) {
    IconData iconData;
    Color iconColor;
    Color iconBg;

    switch (n['type']) {
      case 'urgent':
        iconData = Icons.error_outline_rounded;
        iconColor = const Color(0xFFDC2626);
        iconBg = const Color(0xFFFEE2E2);
        break;
      case 'warning':
        iconData = Icons.warning_amber_rounded;
        iconColor = const Color(0xFFD97706);
        iconBg = const Color(0xFFFEF3C7);
        break;
      case 'success':
        iconData = Icons.check_circle_outline_rounded;
        iconColor = const Color(0xFF16A34A);
        iconBg = const Color(0xFFD1FAE5);
        break;
      default:
        iconData = Icons.info_outline_rounded;
        iconColor = const Color(0xFF2563EB);
        iconBg = const Color(0xFFDBEAFE);
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
            child: Icon(iconData, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(n['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(n['description'], style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 12, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(n['time'], style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          if (n['unread'] == true)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 4),
              decoration: const BoxDecoration(color: Colors.deepPurple, shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }
}