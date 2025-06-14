import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../models/examination.dart';

class AddExaminationScreen extends StatefulWidget {
  final Patient patient;

  const AddExaminationScreen({super.key, required this.patient});

  @override
  State<AddExaminationScreen> createState() => _AddExaminationScreenState();
}

class _AddExaminationScreenState extends State<AddExaminationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _type = 'بصر';
  String _rightEye = '';
  String _leftEye = '';
  String _notes = '';

  void _saveExamination() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final exam = Examination()
        ..type = _type
        ..rightEye = _rightEye
        ..leftEye = _leftEye
        ..notes = _notes
        ..date = DateTime.now()
        ..patient.value = widget.patient;

      exam.save();
      widget.patient.examinations.add(exam);
      widget.patient.save();

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة فحص جديد')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: _type,
                items: const [
                  DropdownMenuItem(value: 'بصر', child: Text('فحص البصر')),
                  DropdownMenuItem(value: 'حول', child: Text('فحص الحول')),
                  DropdownMenuItem(value: 'فيجوال', child: Text('فيجوال اكيوتي')),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => _type = value);
                },
                decoration: const InputDecoration(labelText: 'نوع الفحص'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'العين اليمنى'),
                onSaved: (value) => _rightEye = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'العين اليسرى'),
                onSaved: (value) => _leftEye = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ملاحظات إضافية'),
                maxLines: 3,
                onSaved: (value) => _notes = value ?? '',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveExamination,
                child: const Text('حفظ الفحص'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}