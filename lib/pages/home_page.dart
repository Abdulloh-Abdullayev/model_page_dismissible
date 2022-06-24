import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_page_dismissible/models/note_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _titleController = TextEditingController();

  bool _isActive = false;
  double _importance = 0.0;

  List<NoteModel> _notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Expanded(
                flex: 4,
                child: SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        child: TextFormField(
                           controller: _titleController,
                          decoration: InputDecoration(
                              labelText: "Type here",
                              border: OutlineInputBorder(
                              )
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Active:"),
                          CupertinoSwitch(value: _isActive, onChanged: (bool v){
                            setState((){
                              _isActive = v;
                            });
                          })
                        ],
                      ),

                      Slider(
                          label: _importance.toString(),
                          divisions: 10,
                          value: _importance, onChanged: (value){
                        setState((){
                          _importance = value;
                        });
                      }),

                      MaterialButton(
                        color: Colors.blue,
                        onPressed: (){
                          setState((){
                            _notes.add(NoteModel(title: _titleController.text, active: _isActive, importance: _importance));

                            _titleController.clear();
                            _importance = 0.0;
                            _isActive = false;
                          });
                        },
                        child: Text("Save note"),
                        textColor: Colors.white,
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: SizedBox(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _notes.length,
                  itemBuilder: (context, index){
                    return Dismissible(
                      onDismissed: (v){
                        setState((){
                          _notes.removeAt(index);
                        });
                      },
                      background: Container(
                        color: Colors.red,
                        child: Icon(Icons.delete,color: Colors.white,),
                      ),
                      key: UniqueKey(),
                      child: ListTile(
                        title: Text(_notes[index].title),
                        leading: CircleAvatar(
                          backgroundColor: Colors.lightBlueAccent,
                          child: Text(_notes[index].importance.toString()),
                        ),
                        trailing: CircleAvatar(
                          backgroundColor: _notes[index].active ? Colors.green : Colors.red,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
