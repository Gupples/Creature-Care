import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creature_care/components/animal_card.dart';
import 'package:creature_care/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget{
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // User
  final user = FirebaseAuth.instance.currentUser!;

  // Animal information parts
  final TextEditingController nameController = TextEditingController();
  final TextEditingController speciesController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final DatabaseService _databaseService = DatabaseService();

  void signUserOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
  }

  void openAnimalViewer(AnimalCard animal) {
    // Populate the controllers with the values.
    nameController.text = animal.name;
    genderController.text = animal.gender;
    ageController.text = animal.age.toString();
    speciesController.text = animal.species;
    sizeController.text = animal.size;
    notesController.text = animal.note;

    // Display the information.
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Animal Information"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: "),
                Text("\t\t\t\t${nameController.text}",),
                SizedBox(height: 15,),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Gender: "),
                Text("\t\t\t\t${genderController.text}",),
                SizedBox(height: 15,),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Species: "),
                Text("\t\t\t\t${speciesController.text}",),
                SizedBox(height: 15,),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Age: "),
                Text("\t\t\t\t${ageController.text}",),
                SizedBox(height: 15,),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Size: "),
                Text("\t\t\t\t${sizeController.text}",),
                SizedBox(height: 15,),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Notes: "),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("${notesController.text}", maxLines: 5,),
                ),
                SizedBox(height: 15,),
              ],
            ),
            
          ],
        ),
      ),
    );
  }

  void openAnimalEditor({DocumentSnapshot? document}) {

    // Populate the controllers with any existing data
    if (document != null) {
      final animal = document.data() as AnimalCard;
      nameController.text = animal.name;
      genderController.text = animal.gender;
      ageController.text = animal.age.toString();
      speciesController.text = animal.species;
      sizeController.text = animal.size;
      notesController.text = animal.note;
    }
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Animal Information"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
              ),
            ),
            TextField(
              controller: genderController,
              decoration: InputDecoration(
                labelText: "Gender",
              ),
            ),
            TextField(
              controller: speciesController,
              decoration: InputDecoration(
                labelText: "Species",
              ),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(
                labelText: "Age",
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
            ),
            TextField(
              controller: sizeController,
              decoration: InputDecoration(
                labelText: "Size",
              ),
            ),
            TextField(
              controller: notesController,
              decoration: InputDecoration(
                labelText: "Notes",
              ),
              maxLines: 5,
            ),
          ],
        ),
      actions: [
        ElevatedButton(
          onPressed: () {
            
            if (document == null) {
              // Add the new animal
              _databaseService.addAnimal(AnimalCard(
                name: nameController.text, 
                species: speciesController.text, 
                age: double.tryParse(ageController.text) ?? 0.0, 
                size: sizeController.text, 
                gender: genderController.text, 
                note: notesController.text, 
                user: user.uid));

            } else {
              
              _databaseService.updateAnimal(document.id, AnimalCard(
                name: nameController.text, 
                species: speciesController.text, 
                age: double.tryParse(ageController.text) ?? 0.0, 
                size: sizeController.text, 
                gender: genderController.text, 
                note: notesController.text, 
                user: user.uid));
            }

              // Clear the input fields
            nameController.clear();
            speciesController.clear();
            ageController.clear();
            sizeController.clear();
            genderController.clear();
            notesController.clear();

            // Close the box
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
          ), 
          child: Text(
            document == null ? "Add animal" : "Edit animal", 
            style: TextStyle(
              color: Colors.white,
              ),),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        title: 
            Text(
              "Creature Care",
              style: TextStyle(
              ),
            ),
        actions: [
            Text(
              "LOGGED IN AS: " + user.email!,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.33,
            ),
          IconButton(
          onPressed: () => signUserOut(context), icon: Icon(Icons.logout),
          iconSize: 40.0,)
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAnimalEditor,
        child: const Icon(Icons.add),
        ),
      body: StreamBuilder(
        stream: _databaseService.getAnimalStream(), 
        builder: (context, snapshot) {
          // if we have data, get all the docs
          if (snapshot.hasData) {
            List<DocumentSnapshot> animalList = snapshot.data!.docs.where((doc) {
              final data = doc.data() as AnimalCard;
              return data.user == user.uid;
            }).toList();
            
            // display as a list
            return ListView.builder(
              itemCount: animalList.length,
              itemBuilder: (context, index) {
                // Get each individual document
                DocumentSnapshot document = animalList[index];

                // Get the animal name from the document
                AnimalCard data = document.data() as AnimalCard;
                String nameText = data.name;

                // display as a list tile.
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: GestureDetector(
                    onTap: () => openAnimalViewer(data),
                    child: ListTile(
                      title: Text(nameText),
                      subtitle: Text(data.species),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // VIEW
                          IconButton(
                            onPressed: () => openAnimalViewer(data), 
                            icon: const Icon(Icons.remove_red_eye_outlined),
                            ),
                    
                          // UPDATE
                          IconButton(
                            onPressed: () => openAnimalEditor(document: document), 
                            icon: const Icon(Icons.settings),
                            ),
                    
                          // DELETE
                          IconButton(
                            onPressed: () => _databaseService.deleteAnimal(document.id), 
                            icon: const Icon(Icons.delete),
                            ),
                        ],
                      ),
                    
                    ),
                  ),
                );
              },
            );
          } else {
            return const Text("Whoops! No animals!");
          }
        }),
    );
  }
}