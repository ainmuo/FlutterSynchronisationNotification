import 'package:flutter/material.dart';
import 'services.dart';

class HomeScreen extends StatelessWidget {
  final FakeDatabase fakeDatabase = FakeDatabase();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programmation Asynchrone'),
      ),
      body: Column(
        children: [
          // Utilisation de FutureBuilder pour récupérer les données utilisateur
          FutureBuilder<Map<String, String>>(
            future: fakeDatabase.fetchUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erreur: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final userData = snapshot.data!;
                return ListTile(
                  title: Text('Nom: ${userData['name']}'),
                  subtitle: Text('Email: ${userData['email']}'),
                );
              } else {
                return Center(child: Text('Aucune donnée utilisateur'));
              }
            },
          ),
          SizedBox(height: 20),
          // Utilisation de StreamBuilder pour récupérer les notifications
          StreamBuilder<String>(
            stream: fakeDatabase.fetchNotification(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text('Attente de notifications...'));
              } else if (snapshot.hasError) {
                return Center(child: Text('Erreur: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return Text(
                  'Nouvelle notification: ${snapshot.data}',
                  style: const TextStyle(fontSize: 16),
                );
              } else {
                return Center(child: Text('Aucune notification'));
              }
            },
          ),
        ],
      ),
    );
  }
}
