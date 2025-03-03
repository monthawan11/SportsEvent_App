import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  String _eventName = '';
  int _participants = 0;
  DateTime _selectedDate = DateTime.now();
  String _category = 'ฟุตบอล';

  final List<String> categories = ['ฟุตบอล', 'บาสเกตบอล', 'วิ่ง', 'ว่ายน้ำ', 'แบดมินตัน', 'เทนนิส', 'ปิงปอง', 
    'วอลเลย์บอล', 'รักบี้', 'มวยไทย', 'เทควันโด', 'กอล์ฟ', 'ยิมนาสติก', 'มาราธอน'];

  Future<void> _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(context, {
        'name': _eventName,
        'participants': _participants,
        'date': '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
        'category': _category,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เพิ่มอีเวนต์กีฬา')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'ชื่ออีเวนต์'),
                validator: (value) =>
                    value!.isEmpty ? 'กรุณากรอกชื่ออีเวนต์' : null,
                onSaved: (value) => _eventName = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'จำนวนผู้เข้าร่วม'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    (value == null || int.tryParse(value) == null)
                        ? 'กรุณากรอกจำนวนที่ถูกต้อง'
                        : null,
                onSaved: (value) => _participants = int.parse(value!),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                      'วันที่จัดงาน: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                  TextButton(
                      onPressed: () => _pickDate(context),
                      child: Text('เลือกวันที่')),
                ],
              ),
              DropdownButtonFormField(
                value: _category,
                items: categories
                    .map((cat) => DropdownMenuItem(
                          child: Text(cat),
                          value: cat,
                        ))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _category = value as String),
                decoration: InputDecoration(labelText: 'ประเภทกีฬา'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('เพิ่มอีเวนต์'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
