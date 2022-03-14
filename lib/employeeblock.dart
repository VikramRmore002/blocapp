
//TODO:import
import 'employee.dart';
import 'dart:async';

class EmployeeBloc{
  //TODO:list of employee
  List<Employee>employeeList =[
  Employee(1, "emp one",  10000.0),
  Employee(2, "emp two",  20000.0),
  Employee(3, "emp three",30000.0),
  Employee(4, "emp four", 40000.0),
  Employee(5, "emp five", 50000.0),
  Employee(6, "emp six",  60000.0),
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