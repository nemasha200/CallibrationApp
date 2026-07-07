import 'package:flutter/material.dart';

class EquipmentScreen extends StatelessWidget {
  const EquipmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEquipmentCard(
            stripColor: const Color(0xFFF59E0B),
            name: 'Topcon AT-B4A',
            category: 'Auto Level',
            statusLabel: 'Due Soon',
            statusColor: const Color(0xFFF59E0B),
            statusBg: const Color(0xFFFEF3C7),
            initials: 'JM',
            ownerName: 'James Mutua',
            serial: 'TPC-2023-0198',
            lastCalibration: '2024-02-15',
            nextDue: '2024-08-15',
            nextDueColor: const Color(0xFFD97706),
          ),
          const SizedBox(height: 16),
          _buildEquipmentCard(
            stripColor: const Color(0xFF3B82F6),
            name: 'Trimble R12i',
            category: 'GNSS Receiver',
            statusLabel: 'Upcoming',
            statusColor: const Color(0xFF3B82F6),
            statusBg: const Color(0xFFDBEAFE),
            initials: 'AO',
            ownerName: 'Amina Osei',
            serial: 'TRM-2023-0552',
            lastCalibration: '2024-03-01',
            nextDue: '2024-09-01',
            nextDueColor: const Color(0xFF2563EB),
          ),
          const SizedBox(height: 16),
          _buildEquipmentCard(
            stripColor: const Color(0xFF10B981),
            name: 'Sokkia CX-101',
            category: 'Total Station',
            statusLabel: 'Good',
            statusColor: const Color(0xFF10B981),
            statusBg: const Color(0xFFD1FAE5),
            initials: 'DK',
            ownerName: 'David Kamau',
            serial: 'SKA-2022-0871',
            lastCalibration: '2024-05-10',
            nextDue: '2025-05-10',
            nextDueColor: const Color(0xFF16A34A),
          ),
        ],
      ),
    );
  }

  Widget _buildEquipmentCard({
    required Color stripColor,
    required String name,
    required String category,
    required String statusLabel,
    required Color statusColor,
    required Color statusBg,
    required String initials,
    required String ownerName,
    required String serial,
    required String lastCalibration,
    required String nextDue,
    required Color nextDueColor,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 4, color: stripColor),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              category,
                              style: const TextStyle(color: Colors.deepPurple, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: statusBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              statusLabel,
                              style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFF8B5CF6), Color(0xFFD946EF)],
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          initials,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ownerName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                          Text(serial, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9FB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Last Calibration', style: TextStyle(color: Colors.grey, fontSize: 12)),
                              const SizedBox(height: 2),
                              Text(lastCalibration, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Next Due', style: TextStyle(color: Colors.grey, fontSize: 12)),
                              const SizedBox(height: 2),
                              Text(
                                nextDue,
                                style: TextStyle(color: nextDueColor, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}