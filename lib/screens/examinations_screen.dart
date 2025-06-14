import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../widgets/examination_list.dart';
import '../screens/add_examination_screen.dart';

class ExaminationsScreen extends StatefulWidget {
  final Patient patient;

  const ExaminationsScreen({super.key, required this.patient});

  @override
  State<ExaminationsScreen> createState() => _ExaminationsScreenState();
}

class _ExaminationsScreenState extends State<ExaminationsScreen> {
  String _filterType = 'الكل';

  void _addExamination() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExaminationScreen(patient: widget.patient),
      ),
    );
    setState(() {}); // Refresh after adding
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فحوصات المريض'),
        actions: [
          IconButton(
            onPressed: _addExamination,
            icon: const Icon(Icons.add),
            tooltip: 'إضافة فحص جديد',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.patient.notes != null && widget.patient.notes!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📌 ملاحظات المريض:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(widget.patient.notes!),
                  const Divider(),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButton<String>(
              value: _filterType,
              items: const [
                DropdownMenuItem(value: 'الكل', child: Text('الكل')),
                DropdownMenuItem(value: 'بصر', child: Text('فحص البصر')),
                DropdownMenuItem(value: 'حول', child: Text('فحص الحول')),
                DropdownMenuItem(value: 'فيجوال', child: Text('فيجوال اكيوتي')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _filterType = value;
                  });
                }
              },
              isExpanded: true,
            ),
          ),
          Expanded(
            child: ExaminationList(patient: widget.patient, filter: _filterType),
          ),
        ],
      ),
    );
  }
}