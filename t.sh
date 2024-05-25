#!/bin/bash

# Function to get user credentials
get_user_credentials() {
    read -p "Enter your username: " username
    read -sp "Enter your password: " password
    echo ""
}

# Function to display countries and get user input
choose_departure_city() {
    echo "Please choose your departure city:"
    echo "1. Jeddah"
    echo "2. Makkah"
    echo "3. Madina"
    echo "4. Yanbu"
    read -p "Enter the number of your choice: " departure_choice

    
    case $departure_choice in
        1) departure_city="Jeddah";;
        2) departure_city="Makkah";;
        3) departure_city="Madina";;
        4) departure_city="Makkah";;
        *) echo "Invalid choice. Please try again."; choose_departure_city 
        return 
        ;;
        
    esac
 
}


# Function to display cities and get user input for arrival city
choose_arrival_city() {
  echo "Please choose your arrival city:"
    if [ "$departure_city" != "Jeddah" ]; then echo "1. Jeddah"; fi
    if [ "$departure_city" != "Makkah" ]; then echo "2. Makkah"; fi
    if [ "$departure_city" != "Madina" ]; then echo "3. Madina"; fi
    if [ "$departure_city" != "Yanbu" ]; then echo "4. Yanbu"; fi

    read -p "Enter the number of your choice: " arrival_choice

    case $arrival_choice in
        1) 
            if [ "$departure_city" != "Jeddah" ]; then
                arrival_city="Jeddah"
            else
                echo "Invalid choice. Departure and arrival cities cannot be the same."
                choose_arrival_city  
                return
            fi
            ;;
        2) 
            if [ "$departure_city" != "Makkah" ]; then
                arrival_city="Makkah"
            else
                echo "Invalid choice. Departure and arrival cities cannot be the same."
                choose_arrival_city  
                return
            fi
            ;;
        3) 
            if [ "$departure_city" != "Madina" ]; then
                arrival_city="Madina"
            else
                echo "Invalid choice. Departure and arrival cities cannot be the same."
                choose_arrival_city   
                return
            fi
            ;;
        4) 
            if [ "$departure_city" != "Yanbu" ]; then
                arrival_city="Yanbu"
            else
                echo "Invalid choice. Departure and arrival cities cannot be the same."
                choose_arrival_city  
                return
            fi
            ;;
        *) 
            echo "Invalid choice. Please try again."
            choose_arrival_city  
            return
            ;;
    esac

    
}



# Function to display available times and get user input
choose_time() {
    echo "Available times is :"
    echo "1. Morning (8:00 AM)"
    echo "2. Afternoon (1:00 PM)"
    echo "3. Evening (7:00 PM)"
    read -p "Enter the number of your choice: " time_choice

    case $time_choice in
        1) time="Morning (8:00 AM)";;
        2) time="Afternoon (1:00 PM)";;
        3) time="Evening (7:00 PM)";;
        *) echo "Invalid choice. Please try again."; choose_time;;
    esac
