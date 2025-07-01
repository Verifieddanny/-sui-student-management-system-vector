#[test_only]
module school_management_system::school_management_system_tests;
// uncomment this line to import the module
use school_management_system::school_management_system::{Self, School, Class};

use sui::test_scenario;
use std::debug;


/// Intiialization

#[test]
fun test_school_management_system_initialize() {
    let principal = @0x1;

    let mut scenario = test_scenario::begin(principal);
    {

    school_management_system::init_for_testing(scenario.ctx());
    };
    scenario.next_tx(principal);
    {
    let school: School = test_scenario::take_shared<School>(&scenario);

    // debug::print(&b"Initialized school: ".to_string());
    // debug::print(&school);

    test_scenario::return_shared(school)

    };
    
    test_scenario::end(scenario);


}


/// Class Management System

#[test]
fun test_add_class() {
    let principal = @0x1;

    let mut scenario = test_scenario::begin(principal);
    {
        school_management_system::init_for_testing(scenario.ctx());
    };
    scenario.next_tx(principal);
    {
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        // debug::print(&b"School before adding class".to_string());
        // debug::print(&school);

        let test_school = b"SS3C".to_string();

        school_management_system::add_class(scenario.ctx(), &mut school, test_school);

        // debug::print(&b"School after adding class".to_string());
        // debug::print(&school);

        // let class = test_scenario::most_recent_id_shared<Class>();
        // let mut class = school_management_system::fetch_recent_class(&mut school);
        // // debug::print(&b"Inserted Class".to_string());
        // debug::print(&class);

        test_scenario::return_shared(school)

    };

    test_scenario::end(scenario);
}

#[test]
fun test_remove_last_class(){
    let principal = @0x1;


    let mut scenario = test_scenario::begin(principal);
    {
        school_management_system::init_for_testing(scenario.ctx());

    };

    scenario.next_tx(principal);
     {
        // Adding the first class to school
        let mut school: School = test_scenario::take_shared<School>(&scenario);
       

        let test_school = b"SS3C".to_string();

        school_management_system::add_class(scenario.ctx(), &mut school, test_school);

        // debug::print(&b"School after adding first class".to_string());
        // debug::print(&school);

        // let class = test_scenario::most_recent_id_shared<Class>();
        

        test_scenario::return_shared(school)
     };

         scenario.next_tx(principal);
     {
        // Adding the second class to school
        let mut school: School = test_scenario::take_shared<School>(&scenario);
       

        let test_school = b"SS3A".to_string();

        school_management_system::add_class(scenario.ctx(), &mut school, test_school);


        // debug::print(&b"School after adding second class".to_string());
        // debug::print(&school);

        test_scenario::return_shared(school)
     };

     scenario.next_tx(principal);
     {
        // Removing the First Class
        let mut school: School = test_scenario::take_shared<School>(&scenario);


        school_management_system::remove_last_class(&mut school);

        // debug::print(&b"School after removing second class".to_string());
        // debug::print(&school);

        test_scenario::return_shared(school)

     };

    test_scenario::end(scenario);

}



#[test]
fun test_get_number_of_classes() {
    let principal = @0x1;


    let mut scenario = test_scenario::begin(principal);
    {
        school_management_system::init_for_testing(scenario.ctx());

    };

    scenario.next_tx(principal);
        {
        // Adding the first class to school
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        

        let test_school = b"SS3C".to_string();

        school_management_system::add_class(scenario.ctx(), &mut school, test_school);

        test_scenario::return_shared(school)
        };

        scenario.next_tx(principal);
        {
        // Adding the second class to school
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        

        let test_school = b"SS3A".to_string();

        school_management_system::add_class(scenario.ctx(), &mut school, test_school);

        test_scenario::return_shared(school)
        };

        scenario.next_tx(principal);
        {
        // Check if class size is 2
        let school: School = test_scenario::take_shared<School>(&scenario);


        let num_of_classes = school_management_system::get_number_of_class(&school);

        assert!(num_of_classes == 2, 0);

        test_scenario::return_shared(school)

        };

    test_scenario::end(scenario);

}


#[test]
fun test_swap_classes(){
    let principal = @0x1;


    let mut scenario = test_scenario::begin(principal);
    {
        school_management_system::init_for_testing(scenario.ctx());

    };

    scenario.next_tx(principal);
        {
        // Adding the first class to school
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        

        let test_school = b"SS3C".to_string();

        school_management_system::add_class(scenario.ctx(), &mut school, test_school);

        test_scenario::return_shared(school)
        };

        scenario.next_tx(principal);
        {
        // Adding the second class to school
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        

        let test_school = b"SS3A".to_string();

        school_management_system::add_class(scenario.ctx(), &mut school, test_school);

        test_scenario::return_shared(school)
        };

        scenario.next_tx(principal);
        {
        // Swap classes
        let mut school: School = test_scenario::take_shared<School>(&scenario);


        school_management_system::swap_classes(&mut school, 0, 1);

        // debug::print(&school);
        test_scenario::return_shared(school)

        };

    test_scenario::end(scenario);
}




#[test]
fun test_reverse_classes(){
    let principal = @0x1;


    let mut scenario = test_scenario::begin(principal);
    {
        school_management_system::init_for_testing(scenario.ctx());

    };

    scenario.next_tx(principal);
        {
        // Adding the first class to school
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        

        let test_school = b"SS3C".to_string();

        school_management_system::add_class(scenario.ctx(), &mut school, test_school);

        test_scenario::return_shared(school)
        };

        scenario.next_tx(principal);
        {
        // Adding the second class to school
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        

        let test_school = b"SS3A".to_string();

        school_management_system::add_class(scenario.ctx(), &mut school, test_school);

        test_scenario::return_shared(school)
        };

        scenario.next_tx(principal);
        {
        // Reverse classes
        let mut school: School = test_scenario::take_shared<School>(&scenario);


        school_management_system::reverse_classes_order(&mut school);

        test_scenario::return_shared(school)

        };

    test_scenario::end(scenario);
}


#[test]
fun test_classes_not_empty() {
    let principal = @0x1;


    let mut scenario = test_scenario::begin(principal);
    {
        school_management_system::init_for_testing(scenario.ctx());

    };

    scenario.next_tx(principal);
    {
    // Adding the first class to school
    let mut school: School = test_scenario::take_shared<School>(&scenario);
    

    let test_school = b"SS3C".to_string();

    school_management_system::add_class(scenario.ctx(), &mut school, test_school);

    test_scenario::return_shared(school)
    };

    scenario.next_tx(principal);

    {
        let school: School = test_scenario::take_shared<School>(&scenario);

        let is_empty = school_management_system::is_class_vector_empty(&school);

        assert!(is_empty == false, 0);

        test_scenario::return_shared(school)
    };

    test_scenario::end(scenario);
}


#[test]
fun test_classes_empty() {
    let principal = @0x1;


    let mut scenario = test_scenario::begin(principal);
    {
        school_management_system::init_for_testing(scenario.ctx());

    };

    scenario.next_tx(principal);

    {
        let school: School = test_scenario::take_shared<School>(&scenario);

        let is_empty = school_management_system::is_class_vector_empty(&school);

        assert!(is_empty == true, 0);

        test_scenario::return_shared(school)
    };

    test_scenario::end(scenario);
}


#[test]
fun test_insert_class_at(){
    let principal = @0x1;


    let mut scenario = test_scenario::begin(principal);
    {
        school_management_system::init_for_testing(scenario.ctx());

    };

    scenario.next_tx(principal);
        {
        // Adding the first class to school
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        

        let test_school = b"SS3C".to_string();

        school_management_system::add_class(scenario.ctx(), &mut school, test_school);

        test_scenario::return_shared(school)
        };

        scenario.next_tx(principal);
        {
        // Adding the second class to school
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        

        let test_school = b"SS3A".to_string();

        school_management_system::add_class(scenario.ctx(), &mut school, test_school);

        test_scenario::return_shared(school)
        };

        scenario.next_tx(principal);
        {
        // insert classes at index 1
        let mut school: School = test_scenario::take_shared<School>(&scenario);

        let test_name = b"SS3E".to_string();

        school_management_system::insert_class_at(scenario.ctx(), &mut school, 1, test_name);

        test_scenario::return_shared(school)

        };

    test_scenario::end(scenario);
}


/// Student Management System

#[test]
fun test_add_student() {
    let principal = @0x1;

    let mut scenario = test_scenario::begin(principal);
    {
        school_management_system::init_for_testing(scenario.ctx());
    };
    scenario.next_tx(principal);
    {
        let test_class = b"SS3C".to_string();

        school_management_system::create_class(scenario.ctx(), test_class);

    };
    scenario.next_tx(principal);
    {
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        let mut class: Class = test_scenario::take_shared<Class>(&scenario);

        school_management_system::add_student(&mut class, b"DevDanny".to_string(), 15, b"Male".to_string(),&mut school);
        
        test_scenario::return_shared(class);

        test_scenario::return_shared(school);

    };

    test_scenario::end(scenario);
}

#[test]
fun test_remove_student() {
    let principal = @0x1;

    let mut scenario = test_scenario::begin(principal);
    {
        school_management_system::init_for_testing(scenario.ctx());
    };
    scenario.next_tx(principal);
    {
        let test_class = b"SS3C".to_string();

        school_management_system::create_class(scenario.ctx(), test_class);

    };
    scenario.next_tx(principal);
    {
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        let mut class: Class = test_scenario::take_shared<Class>(&scenario);

        school_management_system::add_student(&mut class, b"DevDanny".to_string(), 15, b"Male".to_string(),&mut school);
        
        test_scenario::return_shared(class);

        test_scenario::return_shared(school);

    };
    scenario.next_tx(principal);
    {
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        let mut class: Class = test_scenario::take_shared<Class>(&scenario);

        school_management_system::remove_last_student(&mut class, &mut school);
        
        test_scenario::return_shared(class);

        test_scenario::return_shared(school);
    };

    test_scenario::end(scenario);
}


#[test]
fun test_get_number_of_students() {
    let principal = @0x1;

    let mut scenario = test_scenario::begin(principal);
    {
        school_management_system::init_for_testing(scenario.ctx());
    };
    scenario.next_tx(principal);
    {
        let test_class = b"SS3C".to_string();

        school_management_system::create_class(scenario.ctx(), test_class);

    };
    scenario.next_tx(principal);
    {
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        let mut class: Class = test_scenario::take_shared<Class>(&scenario);

        school_management_system::add_student(&mut class, b"DevDanny".to_string(), 15, b"Male".to_string(),&mut school);
        
        test_scenario::return_shared(class);

        test_scenario::return_shared(school);

    };
    scenario.next_tx(principal);
    {
        let class: Class = test_scenario::take_shared<Class>(&scenario);

        let num_students = school_management_system::get_number_of_students(&class);

        assert!(num_students == 1, 0);
        
        test_scenario::return_shared(class);

    };

    test_scenario::end(scenario);
}


#[test]
fun test_swap_student() {
    let principal = @0x1;

    let mut scenario = test_scenario::begin(principal);
    {
        school_management_system::init_for_testing(scenario.ctx());
    };
    scenario.next_tx(principal);
    {
        let test_class = b"SS3C".to_string();

        school_management_system::create_class(scenario.ctx(), test_class);

    };
    scenario.next_tx(principal);
    {
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        let mut class: Class = test_scenario::take_shared<Class>(&scenario);

        school_management_system::add_student(&mut class, b"DevDanny".to_string(), 15, b"Male".to_string(),&mut school);
        
        test_scenario::return_shared(class);

        test_scenario::return_shared(school);

    };
    scenario.next_tx(principal);
    {
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        let mut class: Class = test_scenario::take_shared<Class>(&scenario);

        school_management_system::add_student(&mut class, b"Minke".to_string(), 15, b"Male".to_string(),&mut school);
        
        test_scenario::return_shared(class);

        test_scenario::return_shared(school);

    };
    scenario.next_tx(principal);
    {
        let mut class: Class = test_scenario::take_shared<Class>(&scenario);

        school_management_system::swap_students(&mut class, 1, 0);
        
        test_scenario::return_shared(class);

    };    

    test_scenario::end(scenario);
}

#[test]
fun test_reverse_student() {
    let principal = @0x1;

    let mut scenario = test_scenario::begin(principal);
    {
        school_management_system::init_for_testing(scenario.ctx());
    };
    scenario.next_tx(principal);
    {
        let test_class = b"SS3C".to_string();

        school_management_system::create_class(scenario.ctx(), test_class);

    };
    scenario.next_tx(principal);
    {
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        let mut class: Class = test_scenario::take_shared<Class>(&scenario);

        school_management_system::add_student(&mut class, b"DevDanny".to_string(), 15, b"Male".to_string(),&mut school);
        
        test_scenario::return_shared(class);

        test_scenario::return_shared(school);

    };
    scenario.next_tx(principal);
    {
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        let mut class: Class = test_scenario::take_shared<Class>(&scenario);

        school_management_system::add_student(&mut class, b"Minke".to_string(), 15, b"Male".to_string(),&mut school);
        
        test_scenario::return_shared(class);

        test_scenario::return_shared(school);

    };
    scenario.next_tx(principal);
    {
        let mut class: Class = test_scenario::take_shared<Class>(&scenario);

        school_management_system::reverse_students(&mut class);
        
        test_scenario::return_shared(class);

    };    

    test_scenario::end(scenario);
}

#[test]
fun test_students_not_empty() {
    let principal = @0x1;

    let mut scenario = test_scenario::begin(principal);
    {
        school_management_system::init_for_testing(scenario.ctx());
    };
    scenario.next_tx(principal);
    {
        let test_class = b"SS3C".to_string();

        school_management_system::create_class(scenario.ctx(), test_class);

    };
    scenario.next_tx(principal);
    {
        let mut school: School = test_scenario::take_shared<School>(&scenario);
        let mut class: Class = test_scenario::take_shared<Class>(&scenario);

        school_management_system::add_student(&mut class, b"DevDanny".to_string(), 15, b"Male".to_string(),&mut school);
        
        test_scenario::return_shared(class);

        test_scenario::return_shared(school);

    };
    scenario.next_tx(principal);
    {
        let class: Class = test_scenario::take_shared<Class>(&scenario);

        let is_empty = school_management_system::is_student_vector_empty(&class);

        assert!(is_empty == false, 0);
        
        test_scenario::return_shared(class);
    };

    test_scenario::end(scenario);
}

#[test]
fun test_students_empty() {
    let principal = @0x1;

    let mut scenario = test_scenario::begin(principal);
    {
        school_management_system::init_for_testing(scenario.ctx());
    };
    scenario.next_tx(principal);
    {
        let test_class = b"SS3C".to_string();

        school_management_system::create_class(scenario.ctx(), test_class);

    };
    scenario.next_tx(principal);
    {
        let class: Class = test_scenario::take_shared<Class>(&scenario);

        let is_empty = school_management_system::is_student_vector_empty(&class);

        assert!(is_empty == true, 0);
        
        test_scenario::return_shared(class);
    };

    test_scenario::end(scenario);
}

#[test]
fun test_insert_student_at() {
    let principal = @0x1;

    let mut scenario = test_scenario::begin(principal);
    scenario.next_tx(principal);
    {
        let test_class = b"SS3C".to_string();

        school_management_system::create_class(scenario.ctx(), test_class);

    };
    scenario.next_tx(principal);
    {
        let mut class: Class = test_scenario::take_shared<Class>(&scenario);

        school_management_system::insert_student_at(&mut class, 0,  b"DevDanny".to_string(), 15, b"Male".to_string());
        
        test_scenario::return_shared(class);

    };

    test_scenario::end(scenario);
}