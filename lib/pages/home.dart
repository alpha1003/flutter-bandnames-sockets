import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List<Band> bands = [
      Band(id: '1', name: 'Metallica', votes: 2),
      Band(id: '2', name: 'Heroes del silencio', votes: 7),
      Band(id: '3', name: 'Testament', votes: 5),
      Band(id: '5', name: 'Sodom', votes: 8)
  ];   
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('Band Names', style: TextStyle( color: Colors.black87),),
         backgroundColor: Colors.white,
         elevation: 1,
      ),
      body: ListView.builder(
              itemCount: bands.length,
              itemBuilder: (context, i)  => bandTile(bands[i]),
              
     ),
     floatingActionButton: FloatingActionButton(
        child: Icon( Icons.add),
        elevation: 1,
        onPressed: addNewBand,
     ),
   );
  }

  Widget bandTile(Band band) {
    return Dismissible(
      key:  Key(band.id),
      child: ListTile(
        leading: CircleAvatar(
           child: Text(band.name.substring(0,2)),
           backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text("${band.votes}", style: TextStyle(fontSize: 20.0),),
        onTap: (){
          print(band.name); 
        },
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (direcction) {
          print('Direction: $direcction');
          print('ID: ${band.id}');
          //Call delete method to the server 
      },
      background: Container(
          padding: EdgeInsets.only(left: 8.0),
          color: Colors.red,
          child: Align(
             alignment: Alignment.centerLeft,
             child: Text('Delete Band', style: TextStyle(color: Colors.white, fontSize: 20.0),),
          ),
      ),
    );
  } 

  addNewBand(){ 
    final textController =  TextEditingController(); 

    if (!Platform.isAndroid){
        showDialog(
          context: context,
          builder: ( context ) {
            return AlertDialog(
                actions: [
                   MaterialButton(
                     elevation: 5,
                     onPressed: () => addBandToList( textController.text),
                     child: Text('Add'),
                     textColor: Colors.blue,
                   )
                ],
                title: Text('New Band Name'),
                content: TextField(
                    controller: textController,
                ),
            ); 
          }
      );
    } 

    showCupertinoDialog(
          context: context,
          builder: ( _ ) {
            return CupertinoAlertDialog(
                title: Text('New Band Name: '),
                content: CupertinoTextField(
                    controller: textController,
                ),
                actions: [
                    CupertinoDialogAction(
                      child: Text('Add'),
                      isDefaultAction: true,
                      onPressed: () => addBandToList(textController.text),
                  ),
                    CupertinoDialogAction(
                      child: Text('Dissmiss'),
                      isDefaultAction: true,
                      onPressed: () => Navigator.pop(context),
                  )
                ],
            );
          }
      );

      
  } 

  void addBandToList(String name) { 

    print(name);

      if(name.length > 1) { 
        // podemos agregar
        bands.add(Band(id: DateTime.now().toString(),name: name, votes: 2));
        setState(() {});
      }

      Navigator.pop(context);
  }
}