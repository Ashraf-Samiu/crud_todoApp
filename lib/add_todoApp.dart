import 'package:crud_todoapp/todo.dart';
import 'package:flutter/material.dart';

class AddNewTodoScreen extends StatefulWidget {
  const AddNewTodoScreen({super.key});

  @override
  State<AddNewTodoScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewTodoScreen> {
  final TextEditingController _titleController= TextEditingController();
  final TextEditingController _descriptionController= TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                validator: (String? input){
                  final v= input?? "";
                  if(v.trim().isEmpty){
                    return "Enter your title";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),
              const SizedBox(height: 16,),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                maxLength: 100,
                validator: (String? value){
                  if(value?.trim().isEmpty??true){
                    return "Enter your description";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
              ),
              const SizedBox(height: 16,),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                  child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          Todo todo= Todo(_titleController.text.trim(),
                              _descriptionController.text.trim(),
                              DateTime.now(),
                          );
                          Navigator.pop(context,todo);
                        }
                      },child: const Text("Add"),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose(){
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
