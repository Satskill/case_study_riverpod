import 'package:hive/hive.dart';

class authLocalService {
  ProfileInsertDB(Map token) async {
    final collection = Hive.box('Profile');
    await collection.put('token', token);
  }

  ProfileGetInfos() async {
    final collection = Hive.box('Profile');
    return await collection.get('token');
  }

  ProfileDeleteDB() async {
    final collection = Hive.box('Profile');
    await collection.clear();
  }
}
