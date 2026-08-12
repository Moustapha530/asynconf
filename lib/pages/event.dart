import 'package:flutter/material.dart';


class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  final events = [
    {
      'speaker': 'Lior chama',
      'time': '13h - 13h30',
      'subject': 'The code legacy',
      'avatar': 'lior',
    },
    {
      'speaker': 'Damien Cavaailles',
      'time': '17h - 17h30',
      'subject': 'git blame --no-offense',
      'avatar': 'damien',
    },
    {
      'speaker': 'Defend Intelligence',
      'time': '18h - 18h30',
      'subject': 'Discovering generative AI',
      'avatar': 'defendintelligence',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Salon planing'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final eventData = events[index];
              return Card(
                child: ListTile(
                  leading: Image.asset('assets/images/${eventData['avatar']}.jpg'),
                  title: Text('${eventData['speaker']} (${eventData['time']})'),
                  subtitle: Text(eventData['subject'] ?? ''),
                  trailing: const Icon(Icons.info_outline),
                  onTap: () {
                    // Handle events tap
                  },
                ),
              );
            }
          ),
      ),
    );
  }
}
