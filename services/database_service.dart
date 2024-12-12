// CONTINUE Animal implementation at
// https://youtu.be/G0rsszX4E9Q?feature=shared&t=608

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creature_care/components/animal.dart';

const String ANIMAL_COLLECTION_REF = "animal";

class DatabaseService {
    final _firestore = FirebaseFirestore.instance;

    late final CollectionReference _animalsRef;

    DatabaseService() {
        _animalsRef = _firestore.collection(ANIMAL_COLLECTION_REF).withConverter<Animal>(fromFirestore: (snapshots, _) => Animal.fromJson(snapshots.data()!), toFirestore: (animalCard, _) => animalCard.toJson());
    }

    // Add an animal to Firestore - CREATE
    Future<void> addAnimal(Animal animal) async {
        _animalsRef.add(animal);
    }

    // Get animals from the database - READ
    Stream<QuerySnapshot> getAnimalStream(String orderBy, bool isAscending) {
      // descending is named this way to make it descending by default.
        final animalStream = _animalsRef.orderBy(orderBy, descending: !isAscending).snapshots();
        return animalStream;
    }

    // Continue with CRUD:
    // https://youtu.be/iQOvD0y-xnw?feature=shared&t=602
    /* Possible fix for threading; Isolates.
    https://www.youtube.com/watch?v=0x5imSrJATI */

    // Edit an existing animal - UPDATE
    Future<void> updateAnimal(String docID, Animal animal) {
        return _animalsRef.doc(docID).update(animal.toJson());
    }

    // Remove an existing animal - DELETE
    Future<void> deleteAnimal(String docID) {
        return _animalsRef.doc(docID).delete();
    }
}