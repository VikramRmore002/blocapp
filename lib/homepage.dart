import 'dart:async';

import 'package:flutter/material.dart';
import 'employee.dart';
import 'employeeblock.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EmployeeBloc _employeeBloc = EmployeeBloc();




  @override
  void dispose() {
    super.dispose();
    _employeeBloc.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Employee salary",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
      ),
      body: Container(
        child: StreamBuilder<List<Employee>>(
          stream: _employeeBloc._EmployeeListStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<Employee>> snapshot) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return
                    Card(
                        elevation: 5.0,
                        child: Expanded(child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("${snapshot.data![index].id}.",
                              style: const TextStyle(fontSize: 18.0),),
                            Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                              Text("${snapshot.data![index].name}.",
                                style: const TextStyle(fontSize: 16.0),),
                              Text("₹${snapshot.data![index].salary}.",
                                style: const TextStyle(fontSize: 14.0),),

                            ]),

                            Container(
                                child: Column(children: [
                                  IconButton
                                    (onPressed: () {
                                    _employeeBloc._StreamControllerIncreament
                                        .add(snapshot.data![index]);

                                  },
                                    icon: const Icon(Icons.thumb_up),
                                    iconSize: 20.0,
                                    color: Colors.green,),

                                ])),
                            Container(
                                child: Column(children: [
                                  IconButton
                                    (onPressed: () {
                                    _employeeBloc._StreamControllerIncreament
                                        .add(snapshot.data![index]);

                                  },
                                    icon: const Icon(Icons.thumb_down),
                                    iconSize:20.0 ,
                                    color: Colors.red,),

                                ])),
                          ],
                        )
                        ));
                });
          },
        ),
      ),
    );
  }


}


class EmployeeBloc{
  //TODO:list of employee
  List<Employee>employeeList =[
    Employee(1, "employee one",  10000.0),
    Employee(2, "employee two",  20000.0),
    Employee(3, "employee three",30000.0),
    Employee(4, "employee four", 40000.0),
    Employee(5, "employee five", 50000.0),
    Employee(6, "employee six",  60000.0),
  ];
//TODO:stream controller
  final StreamController<List<Employee>> _StreanControllerEmployeeList = StreamController<List<Employee>>();
  final   StreamController<Employee> _StreamControllerIncreament = StreamController<Employee>();
  final  StreamController<Employee> _StreamControllerDecreament = StreamController<Employee>();
//TODO:stream sink getters

  Stream<List<Employee>> get  _EmployeeListStream  => _StreanControllerEmployeeList.stream;
  StreamSink<List<Employee>> get  _EmployeeListSink  => _StreanControllerEmployeeList.sink;
  StreamSink<Employee> get _IncreamentEmployeeSalary   => _StreamControllerIncreament.sink;
  StreamSink<Employee> get _DecreamentEmployeeSalary  => _StreamControllerDecreament.sink;

//TODO:Constructor _ add data : listen to change
  EmployeeBloc(){
    _StreanControllerEmployeeList.add(employeeList);
    _StreamControllerIncreament.stream.listen(_IncrementSalary);
    _StreamControllerDecreament.stream.listen(_DecrementSalary);

  }

//TODO:core function

  _IncrementSalary(Employee employee){
    double salary = employee.salary;

    double increment = salary * 20/100;
    employeeList[employee.id - 1].salary = salary + increment ;
  }
  _DecrementSalary(Employee employee){
    double salary = employee.salary;

    double increment = salary * 20/100;
    employeeList[employee.id - 1].salary = salary - increment ;
  }
//TODO:despose
  void dispose(){
    _StreamControllerIncreament.close();
    _StreamControllerDecreament.close();
    _StreanControllerEmployeeList.close();
  }

}
