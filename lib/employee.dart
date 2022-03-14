class Employee{

 late int _id ;
 late String _name;
 late double _salary ;


 Employee(this._id,this._name,this._salary);


 //getters

 int get id => _id;

 String get name => _name;
 double get salary => _salary;
//setters

 set id(int id) {
  _id = id;
 }

 set name(String name) {
  _name = name;
 }

 set salary(double salary) {
  _salary = salary;
 }



}