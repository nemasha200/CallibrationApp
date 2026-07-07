import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  bool _showUpcoming = true;

  final List<Map<String, dynamic>> _upcomingItems = [
    {
      'name': 'Leica TS16 P',
      'owner': 'James Mutua',
      'category': 'Total Station',
      'date': '2024-07-10',
      'status': 'Overdue',
    },
    {
      'name': 'Nikon AX-2S',
      'owner': 'David Kamau',
      'category': 'Auto Level',
      'date': '2024-04-05',
      'status': 'Overdue',
    },
    {
      'name': 'Hilti POA 30',
      'owner': 'Faith Wanjiku',
      'category': 'Digital Theodolite',
      'date': '2024-07-10',
      'status': 'Overdue',
    },
    {
      'name': 'Trimble R12i',
      'owner': 'Amina Osei',
      'category': 'GNSS Receiver',
      'date': '2024-09-01',
      'status': 'Upcoming',
    },
    {
      'name': 'Pentax W-800 Series',
      'owner': 'Samuel Otieno',
      'category': 'Total Station',
      'date': '2024-10-22',
      'status': 'Upcoming',
    },
    {
      'name': 'Topcon GT-1003',
      'owner': 'Peter Odhiambo',
      'category': 'Total Station',
      'date': '2024-09-12',
      'status': 'Upcoming',
    },
    {
      'name': 'Sokkia CX-101',
      'owner': 'David Kamau',
      'category': 'Total Station',
      'date': '2024-11-20',
      'status': 'Good',
    },
    {
      'name': 'Leica NA720',
      'owner': 'Grace Njeri',
      'category': 'Auto Level',
      'date': '2024-12-01',
      'status': 'Good',
    },
  ];

  final List<Map<String, dynamic>> _historyItems = [
    {
      'name': 'Sokkia CX-101',
      'owner': 'David Kamau',
      'category': 'Total Station',
      'date': '2024-05-10',
      'status': 'Good',
    },
    {
      'name': 'Trimble R12i',
      'owner': 'Amina Osei',
      'category': 'GNSS Receiver',
      'date': '2024-03-01',
      'status': 'Good',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final items = _showUpcoming ? _upcomingItems : _historyItems;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Calibrations',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildInfoCard(),
            const SizedBox(height: 16),
            _buildToggle(),
            const SizedBox(height: 16),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildScheduleCard(
                    name: item['name'],
                    owner: item['owner'],
                    category: item['category'],
                    date: item['date'],
                    status: item['status'],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F0FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.event_available, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '6-Month Calibration Cycle',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 4),
                Text(
                  'All survey equipment must be calibrated every 6 months.',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F0FF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(child: _buildToggleButton('Upcoming', true)),
          Expanded(child: _buildToggleButton('History', false)),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String label, bool value) {
    final isSelected = _showUpcoming == value;
    return GestureDetector(
      onTap: () => setState(() => _showUpcoming = value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.deepPurple,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleCard({
    required String name,
    required String owner,
    required String category,
    required String date,
    required String status,
  }) {
    Color statusColor;
    Color statusBg;
    IconData iconData;
    Color iconColor;
    Color iconBg;

    switch (status) {
      case 'Overdue':
        statusColor = const Color(0xFFDC2626);
        statusBg = const Color(0xFFFEE2E2);
        iconData = Icons.warning_amber_rounded;
        iconColor = const Color(0xFFDC2626);
        iconBg = const Color(0xFFFEE2E2);
        break;
      case 'Upcoming':
        statusColor = const Color(0xFF3B82F6);
        statusBg = const Color(0xFFDBEAFE);
        iconData = Icons.event_note_rounded;
        iconColor = Colors.deepPurple;
        iconBg = const Color(0xFFF3F0FF);
        break;
      default:
        statusColor = const Color(0xFF16A34A);
        statusBg = const Color(0xFFD1FAE5);
        iconData = Icons.event_note_rounded;
        iconColor = Colors.deepPurple;
        iconBg = const Color(0xFFF3F0FF);
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
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 2),
                Text('$owner · $category', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 13, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 6, height: 6, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}