import 'dart:async';

class FakeDatabase {
  Future<Map<String, String>> fetchUserData() async {
    await Future.delayed(const Duration(seconds: 40));
    return {'id': '123', 'name': 'John Doe', 'email': 'john.doe@example.com'};
  }

  Stream<String> fetchNotification() async* {
    for (int i = 1; i <= 50; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield 'Notification $i';
    }
  }
}
