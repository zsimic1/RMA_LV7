import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:list_lv/screens/addNewItem.dart';
import 'package:list_lv/database/moor_database.dart';
import 'package:list_lv/screens/itemDetails.dart';

void main() => runApp(MaterialApp(home: Lists()));

class Lists extends StatefulWidget {
  @override
  _ListsState createState() => new _ListsState();
}

class _ListsState extends State<Lists> {
  int count;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item list'),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder(
          stream: AppDatabase().watchAllItems(),
          builder: (context, AsyncSnapshot<List<Item>> snapshot) {
            if(snapshot.hasData){

              count = snapshot.data.length;
            }
            else{
              count = 0;
            }
            return ListView.builder(
              itemCount: count,
              itemBuilder: (_, index) {
                return GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                itemDetails(item:snapshot.data[index])),
                      );
                    },
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        color: Colors.blue[400],
                        height: 100,
                        padding: const EdgeInsets.all(5),
                        child: Row(children: [
                          Expanded(
                            flex: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:NetworkImage(snapshot.data[index].url),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 14,
                            child: Container(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(snapshot.data[index].name,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      )),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          snapshot.data[index].description,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          Widget cancelButton = TextButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          );
                          Widget continueButton = TextButton(
                            child: Text("Continue"),
                            onPressed: () {
                              setState(() {
                                AppDatabase().deleteItem(snapshot.data[index]);
                                Navigator.of(context).pop();
                              });
                            },
                          );
                          AlertDialog alert = AlertDialog(
                            title: Text("Warning"),
                            content: Text("Selected item will be deleted"),
                            actions: [
                              cancelButton,
                              continueButton,
                            ],
                          );

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );

              },

            );

          }),
      floatingActionButton: FloatingActionButton(
        child: Text('New'),
        onPressed: () async {
          final value = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => newItem()));
          setState(() {});
        },
      ),
    );
  }
}
