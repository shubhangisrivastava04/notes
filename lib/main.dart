import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      home: NoteListScreen(),
    
      );
  }
}

class NoteListScreen extends StatefulWidget
{
  @override
  _NoteListState createState() => _NoteListState();

}

class _NoteListState extends State<NoteListScreen> {
  List<String> notes =[];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes",style: TextStyle(color: Colors.teal[900]),),
        backgroundColor: Colors.teal[200]
      ),
      body:Container(
        //decoration: BoxDecoration(color:),
        child: ListView.builder(
         itemCount: notes.length,
         itemBuilder:(context, index){
          return Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[100*(index+1)],
            ),
            child: ListTile(title: Text (notes[index]),
              trailing: IconButton(icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context, 
                  builder:(BuildContext context) {
                    return DeleteNote(
                      noteIndex: index,
                      onDelete: (index) {
                        setState(() {
                          notes.removeAt(index);
                        });
                      },
                    );
                  }
                );

              },),
            onTap:() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditNoteScreen())
              );
            },
            
            )
            );
         })),
           floatingActionButton: FloatingActionButton(
           onPressed: (){
             showDialog(
              context: context, 
              builder: (BuildContext context) {
              return AddNoteScreen(
                onNoteAdded: (note) {
                  setState(() {
                    notes.add(note);
                  });
                },
              );
             });
            },
           backgroundColor: Colors.teal[200],
           child: Icon(Icons.add, color: Colors.teal[900]),
        )
    );
  }
}

class AddNoteScreen extends StatelessWidget {

  final Function(String) onNoteAdded;

  const AddNoteScreen({Key? key, required this.onNoteAdded}): super(key:key);


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;


    double dialogHeight = isLandScape ? screenHeight * 0.7 : screenHeight * 0.3;
    
    String note = '';  

    return Dialog(
      child: SizedBox(
        width: screenWidth * 0.8,
        height: dialogHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          child: Scaffold(
            appBar: AppBar(
            title: Text("Add Note")),
            body: Padding(
              padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(decoration: InputDecoration
                      (labelText: "Enter Note"),
                  onChanged: (value)
                  {
                    note=value;
                  },
              ),
              MaterialButton(
                color: Colors.teal[200],
                child: Text ("Save",style: TextStyle(color: Colors.teal[900])),
                onPressed: () {
                  onNoteAdded(note);
                  Navigator.pop(context);
                },)
            ],
          ) )))));
        }
}

class DeleteNote extends StatelessWidget {
  final Function(int) onDelete;
  final int noteIndex;

  const DeleteNote({Key? key, required this.onDelete, required this.noteIndex}):super(key:key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;


    double dialogHeight = isLandScape ? screenHeight * 0.35 : screenHeight * 0.15;

    return Dialog(
      child: SizedBox(
        width: screenWidth * 0.8,
        height: dialogHeight,
        child: ClipRRect(
          borderRadius:BorderRadius.all(Radius.circular(15.0)),
          child: Scaffold(
            appBar: AppBar(title: Text("Delete Note?")),
            body: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    color: Colors.teal[200],
                    child: Text('Delete',style: TextStyle(color: Colors.teal[900])),
                    onPressed: () {
                      onDelete(noteIndex);
                      Navigator.pop(context);
                    },
                    
                  ),
                  MaterialButton(
                    color: Colors.teal[200],
                    child: Text('Cancel',style: TextStyle(color: Colors.teal[900])),
                    onPressed:() {
                      Navigator.pop(context);
                    },
                    ),
                  ],
        )
      )
          )),
      ),
    );
  }
}


class EditNoteScreen extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<EditNoteScreen> {

  String editedNote='';

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Note")),
      body:  Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Edit Note Content'),
              maxLines: null,
              onChanged: (value){
                editedNote=value;
              },
            ),
            SizedBox(height: 20),
            MaterialButton(
              color: Colors.teal[200],
              onPressed: () {
                print("Edited Content: $editedNote");
                Navigator.pop(context);
              },
              child: Text('Save',style: TextStyle(color: Colors.teal[900]),))

          ]
        ),
      ),
    );
  }
}
