import 'package:flutter/material.dart';
import 'AddPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> events = [];

  void _navigateToAddPage() async {
    final newEvent = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPage()),
    );

    if (newEvent != null) {
      setState(() {
        events.add(newEvent);
      });
    }
  }

  
  void _deleteEvent(int index) {
    setState(() {
      events.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('รายการอีเวนต์กีฬา')),
      body: events.isEmpty
          ? Center(child: Text('ยังไม่มีอีเวนต์กีฬา'))
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Dismissible(
                  key: Key(event['name']),
                  onDismissed: (direction) => _deleteEvent(index),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      title: Text(event['name'],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          'ประเภท: ${event['category']} | วันที่: ${event['date']}'),
                      trailing: Text(
                        '${event['participants']} คน',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddPage,
        child: Icon(Icons.add),
      ),
    );
  }
}
