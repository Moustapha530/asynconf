import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Events').snapshots(), 
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text('No events found');
            }
            else if (snapshot.hasError) {
              return const Text('Error fetching events');
            }
            else {
              List<dynamic> events = [];
              snapshot.data!.docs.forEach((doc) {
                events.add(doc);
              });
              return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  final avatar = event['avatar'] ?? '';
                  final conferenceName = event['subject'] ?? '';
                  final speakerName = event['speaker'] ?? '';
                  final confDate = event['date'] != null ? (event['date'] as Timestamp).toDate() : null;
                  final confType = event['type'] ?? '';

                  return Card(
                    child: ListTile(
                      title: Text(conferenceName),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/$avatar.jpg'),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Speaker: $speakerName'),
                          if (confDate != null)
                            Text('Date: ${confDate.toLocal().toString().split(' ')[0]}'),
                          Text('Type: $confType'),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        )
      );
  }
}
