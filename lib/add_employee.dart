import 'package:flutter/material.dart';
import 'package:sqflite_crud_flutter/my_database.dart';
import 'package:sqflite_crud_flutter/employee.dart';
import 'package:sqflite_crud_flutter/home.dart';

class AddEmployee extends StatefulWidget {
  final MyDatabase myDatabase;
  const AddEmployee({super.key, required this.myDatabase});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  //
  bool isFemale = false;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Emp Id
              TextField(
                controller: idController,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Employee Id',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Emp Name
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Employee Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Emp Designation
              TextField(
                controller: designationController,
                decoration: const InputDecoration(
                  hintText: 'Employee Designation',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Emp Gender
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Male',
                        style: TextStyle(
                          fontWeight:
                              isFemale ? FontWeight.normal : FontWeight.bold,
                          color: isFemale ? Colors.grey : Colors.blue,
                        ),
                      ),
                      Icon(
                        Icons.male,
                        color: isFemale ? Colors.grey : Colors.blue,
                      ),
                    ],
                  ),
                  Switch(
                      value: isFemale,
                      onChanged: (newValue) {
                        //
                        setState(() {
                          isFemale = newValue;
                        });
                        //
                      }),
                  Row(
                    children: [
                      Text(
                        'Female',
                        style: TextStyle(
                          fontWeight:
                              isFemale ? FontWeight.bold : FontWeight.normal,
                          color: isFemale ? Colors.pink : Colors.grey,
                        ),
                      ),
                      Icon(
                        Icons.male,
                        color: isFemale ? Colors.pink : Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        //
                        Employee employee = Employee(
                            empId: int.parse(idController.text),
                            empName: nameController.text,
                            empDesignation: designationController.text,
                            isMale: !isFemale);
                        await widget.myDatabase.insertEmp(employee);

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('${employee.empName} added.')));
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                              (route) => false);
                        }

                        //
                      },
                      child: const Text('Add')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey),
                      onPressed: () {
                        //
                        idController.text = '';
                        nameController.text = '';
                        designationController.text = '';
                        isFemale = false;
                        setState(() {});
                        _focusNode.requestFocus();
                        //
                      },
                      child: const Text('Reset')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
