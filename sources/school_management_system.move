/// Module: school_management_system
module school_management_system::school_management_system;

use std::string::String;
// use sui::dynamic_object_field;

public struct Student has store, drop {
    name: String,
    age: u8,
    gender: String,
}

public struct Class has key, store {
    id: UID,
    name: String,
    number_of_students: u8,
    students: vector<Student>,
}

public struct School has key, store {
    id: UID,
    number_of_classes: u8,
    number_of_students: u16,
    classes: vector<Class>
}

fun init(ctx: &mut TxContext){
    let school = School{
        id: object::new(ctx),
        number_of_classes: 0,
        number_of_students: 0,
        classes: vector::empty<Class>(),
    };

    transfer::share_object(school);
}

/// Student Management Functions

public fun add_student(class: &mut Class, student_name: String, age: u8, gender: String, school: &mut School){
    let student = Student {
        name: student_name,
        age,
        gender,
    };

    vector::push_back(&mut class.students, student);
    class.number_of_students = class.number_of_students + 1;
    school.number_of_students = school.number_of_students + 1;
}

//dof
public fun remove_student(class: &mut Class, student: Student, school: &mut School) {
    let (_isContained, index) = vector::index_of(&class.students, &student);

    vector::remove(&mut class.students, index);
    class.number_of_students = class.number_of_students - 1;
    school.number_of_students = school.number_of_students - 1;

}

public fun get_number_of_students(class: &Class): u8 {
    class.number_of_students
}

//dof
public fun check_student_exists(class: &Class, student: &Student): bool {
    vector::contains(&class.students, student)
}

public fun swap_students(class: &mut Class, index1: u64, index2: u64) {
    vector::swap(&mut class.students, index1, index2)
}

public fun reverse_students(class: &mut Class) {
    vector::reverse(&mut class.students)
}

public fun is_student_vector_empty(class: &Class): bool {
    vector::is_empty(&class.students)
}

public fun remove_last_student(class: &mut Class, school: &mut School): Student {
    let last_student = vector::pop_back(&mut class.students);
    class.number_of_students = class.number_of_students - 1;
    school.number_of_students = school.number_of_students - 1;
    last_student
}

public fun insert_student_at(class: &mut Class, index: u64, student_name: String, age: u8, gender: String,) {
        let student = Student {
        name: student_name,
        age,
        gender,
    };

    vector::insert(&mut class.students, student, index)
}


/// Class Management Functions

public fun add_class(ctx: &mut TxContext, school: &mut School, class_name: String) {
    let new_class = Class {
        id: object::new(ctx),
        name: class_name,
        number_of_students: 0,
        students: vector::empty<Student>(),
    };

    vector::push_back(&mut school.classes, new_class);
    school.number_of_classes = school.number_of_classes + 1;

}

/// this will be better using dof;
public fun remove_class(school: &mut School, class: &mut Class) {
    let (_isContained, index) = vector::index_of(&school.classes, class);
    let class_removed = vector::remove(&mut school.classes, index);
    let Class {
        id,
        name: _,
        number_of_students,
        students: _,
    } = class_removed;
    id.delete();


    
    school.number_of_classes = school.number_of_classes - 1;
    school.number_of_students = school.number_of_students - (number_of_students as u16);

}

public fun get_number_of_class(school: &School): u8 {
    school.number_of_classes
}

// this too dof
public fun check_class_exists(school: &School, class: &Class): bool{
    vector::contains(&school.classes, class)
}

public fun swap_classes(school: &mut School, index1: u64, index2: u64){
    vector::swap(&mut school.classes, index1, index2);
}

public fun reverse_classes_order(school: &mut School) {
    vector::reverse(&mut school.classes)
}

public fun is_class_vector_empty(school: &School): bool{
    vector::is_empty(&school.classes)
}

public fun remove_last_class(school: &mut School) {
    let class_removed = vector::pop_back(&mut school.classes);
    let Class {
        id,
        name: _,
        number_of_students,
        students: _
    } = class_removed;
    id.delete();


    school.number_of_classes = school.number_of_classes - 1;
    school.number_of_students = school.number_of_students - (number_of_students as u16);
}

public fun insert_class_at(ctx: &mut TxContext, school: &mut School, index: u64, class_name: String){

    let new_class = Class {
        id: object::new(ctx),
        name: class_name,
        number_of_students: 0,
        students: vector::empty<Student>(),
    };
    vector::insert(&mut school.classes, new_class, index)
}


public fun create_class(ctx: &mut TxContext, name: String){
        let new_class = Class {
        id: object::new(ctx),
        name,
        number_of_students: 0,
        students: vector::empty<Student>(),
    };

    transfer::share_object(new_class)

}


/// testing initialization function
#[test_only]
public fun init_for_testing(ctx: &mut TxContext) {
    init(ctx);
}


/*

vector 
SCHOOL {
metadata, 
 [{}, {}, {}]
}

{} -> Classes

dof

SCHOOl {
metadata,
  {  (owner: SCHOOL, element: {}, indexing), (owner: SCHOOL, element{})  }
}



*/