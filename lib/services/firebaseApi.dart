import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/playerModel.dart';

class FirebaseApiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future addPlayersToFirebase() async {
    // print("deleting players");
    // //! Start deleting players from the firestore
    // try {
    //   final instance = FirebaseFirestore.instance;
    //   final batch = instance.batch();
    //   var collection = instance.collection('players');
    //   var snapshots = await collection.get();
    //   for (var doc in snapshots.docs) {
    //     batch.delete(doc.reference);
    //   }
    //   await batch.commit();
    // } catch (e) {
    //   print(e);
    // }
    // print("done deleting players");

    //! End deleting players from the firestore
    //! Start adding players to the firestore
    print("adding players to the firestore");
    List<PlayerModel> playersList = [];
    for (Map<String, dynamic> player in players) {
      playersList.add(PlayerModel.fromJson(player));
    }

    for (var playerModel in playersList) {
      try {
        await _firestore
            .collection('players')
            .add(playerModel.toJson())
            .then((value) => print("Player Uploaded successfully"));
      } catch (e) {
        print(e);
      }
    }

    print("done adding players to the firestore");
    //! End adding players to the firestore
    return;
  }

  Future<void> createNews(String title, String imageUrl) async {
    final CollectionReference newsCollection = _firestore.collection('news');
    await newsCollection.add({
      'title': title,
      'imageUrl': imageUrl,
    });
  }

  readFromFirestore(String s) {}
}
