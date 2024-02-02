import 'package:crud_todoapp/add_todoApp.dart';
import 'package:crud_todoapp/edit_todoApp.dart';
import 'package:crud_todoapp/todo.dart';
import 'package:flutter/material.dart';

class TodoAppScreen extends StatefulWidget {
  const TodoAppScreen({super.key});

  @override
  State<TodoAppScreen> createState() => _TodoAppScreenState();
}

class _TodoAppScreenState extends State<TodoAppScreen> {
  List<Todo> todoList= [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Application Bar"),
      ),
      body: Visibility(
        visible: todoList.isNotEmpty,
        ///if we put visible isEmpty then replacement will work
        replacement: const Center(
          child: Text("Todo List Empty"),
        ),
        child: ListView.separated(
            itemCount: todoList.length,
            itemBuilder: (context,index){
              return buildTodoListTile(index);
            },
            separatorBuilder: (context,index){
              return Divider(
                color: Colors.blueGrey.shade400,
                height: 12,
                indent: 16,
                endIndent: 16,
              );
            },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: onPressedAddFab,
            child: const Icon(Icons.add),
        ),
    );
  }

  ListTile buildTodoListTile(int index) {
    return ListTile(
      title: Text(todoList[index].title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(todoList[index].description),
          Text(todoList[index].time.toString()),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(onPressed: (){
            showDeleteConfirmationDialogue(index);
          },icon: const Icon(Icons.delete_forever_outlined),
          ),
          IconButton(onPressed: (){
            onPressedEditIconButton(index);
            }, icon: const Icon(Icons.edit),),
        ],
      ),
    );
  }
  Future<void> onPressedEditIconButton(int index) async{
    final Todo? updatedTodo= await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context)=>EditTodoScreen(todo: todoList[index]),
      ),
    );
    if(updatedTodo!= null){
      todoList[index]= updatedTodo;
      setState(() {});
    }
  }
  Future<void> onPressedAddFab() async{
    final Todo? result= await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddNewTodoScreen(),
        ),
    );
    if(result!= null){
      todoList.add(result);
      setState(() {});
    }
  }
  void showDeleteConfirmationDialogue(index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Warning"),
            content: const Text("Do you want to delete?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  removeTodo(index);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Yes,Delete",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
          );
        });
    }
  void removeTodo(index){
    todoList.removeAt(index);
    setState(() {});
  }
}
