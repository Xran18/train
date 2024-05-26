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

# Function to get passenger details
get_passenger_details() {
    read -p "Enter your full name: " name
    read -p "Enter your email address: " email
    read -p "Enter your phone number: " phone
}

# Function to allow user to choose seat type
choose_seat_type() {
    read -p "Please choose your seat type (Normal/Business): " seat_type
    case $seat_type in
        Normal|normal|N|n) seat_type="Normal";;
        Business|business|B|b) seat_type="Business";;
        *) echo "Invalid choice. Please enter Normal or Business."; choose_seat_type;;
    esac
}

# Function to apply discount based on discount code
apply_discount() {
    local discount_codes="LAR RAN AML"  # Initialize discount codes within the function
   
    # Check if discount_code matches any of the discount codes
    if echo "$discount_codes" | grep -q -w "$discount_code"; then
        discounted_price=$((ticket_price - 100))  # Apply discount
        echo "Discount applied: 100 off"
    else
        discounted_price=$ticket_price  # No discount applied
        echo "Discount not found"
    fi
}

# Function to generate ticket and display information
generate_ticket() {
    ticket_file="ticket_${ticket_number}.txt"
    {
        echo "Ticket Details:"
        echo "----------------"
        echo "Departure City: $departure_city"
        echo "Arrival City: $arrival_city"
        echo "Date of Travel: $travel_date"
        echo "Time: $time"
        echo "Plane: XYZ123"
        echo "Seat: $seat"
        echo "Seat Type: $seat_type"
        echo "Ticket Number: $ticket_number"
        echo "Name: $name"
        echo "Email: $email"
        echo "Phone: $phone"
        echo "Ticket Price: $discounted_price SAR"
        echo "----------------"
    } > "$ticket_file"
    cat "$ticket_file"
     if [ ! -z "$return_date" ]; then
        echo ""
        echo "Return Ticket:"
        echo "----------------"
        echo "Departure City: $arrival_city"
        echo "Arrival City: $departure_city"
        echo "Date of Travel: $return_date"
        echo "Time: $time"
        echo "Plane: XYZ123"
        echo "Seat Type: $seat_type"
        echo "Ticket Number: $ticket_number"
        echo "Name: $name"
        echo "Email: $email"
        echo "Phone: $phone"
        echo "Ticket Price: $discounted_price SAR"
        echo "----------------"
    fi > "$ticket_file"
    cat "$ticket_file"
}

modify_ticket() {
    local ticket_file="ticket_${ticket_number}.txt"
    local field
    local new_value

    while true; do
        echo "Which field do you want to modify?"
        echo "1. Departure City"
        echo "2. Arrival City"
        echo "3. Date of Travel"
        echo "4. Time"
        echo "5. Seat Type"
        echo "6. Name"
        echo "7. Email"
        echo "8. Phone"
        echo "Enter the number of your choice (or 0 to stop): "
        read -r field

        if [ "$field" -eq 0 ]; then
            break
        fi
    case $field in
        1) read -p "Enter new Departure City: JEDDAH , MAKKAH , MADINA , YANBU " new_value
           sed -i "s/^Departure City:.*/Departure City: $new_value/" "$ticket_file"
           ;;
        2) read -p "Enter new Arrival City: JEDDHA , MAKKAH , MADINA , YANBU " new_value
           sed -i "s/^Arrival City:.*/Arrival City: $new_value/" "$ticket_file"
           ;;
        3) read -p "Enter new Date of Travel: " new_value
           sed -i "s/^Date of Travel:.*/Date of Travel: $new_value/" "$ticket_file"
           ;;
        4) read -p "Enter new Time: " new_value
           sed -i "s/^Time:.*/Time: $new_value/" "$ticket_file"
           ;;
        5) read -p "Enter new Seat Type: " new_value
           sed -i "s/^Seat Type:.*/Seat Type: $new_value/" "$ticket_file"
           ;;
        6) read -p "Enter new Name: " new_value
           sed -i "s/^Name:.*/Name: $new_value/" "$ticket_file"
           ;;
        7) read -p "Enter new Email: " new_value
           sed -i "s/^Email:.*/Email: $new_value/" "$ticket_file"
           ;;
        8) read -p "Enter new Phone: " new_value
           sed -i "s/^Phone:.*/Phone: $new_value/" "$ticket_file"
           ;;
        *) echo "Invalid choice. Please try again."
           modify_ticket
           return
           ;;
    esac

    echo "Modified Ticket Details:"
    cat "$ticket_file"
  done
}


# Function to validate return date
validate_return_date() {
    while true; do
        read -p "Enter the return date (YYYY-MM-DD): " return_date
        if [[ "$return_date" < "$travel_date" ]]; then
            echo "Return date must be after the travel date. Please enter a valid return date."
        else
            break
        fi
    done
}

# Function to choose payment method
choose_payment_method() {
    echo "Choose your payment method:"
    echo "1. Credit Card"
    echo "2. Apple Pay"
    read -p "Enter the number of your choice: " payment_choice

    case $payment_choice in
        1) payment_method="Credit Card";;
        2) payment_method="Apple Pay";;
        *) echo "Invalid choice. Please try again."; choose_payment_method;;
    esac    
# Main program
echo "Welcome to our Magic Train system!"
echo "Enjoy the ease and speed of booking train tickets through Magic Train"
# Get user credentials
get_user_credentials

choose_departure_city
choose_arrival_city
read -p "Enter the date of travel (YYYY-MM-DD): " travel_date
choose_time
declare -i num_tickets
read -p "Enter the number of tickets you want to book: " num_tickets
read -p "Do you want to book round trip? (yes/no): " round_trip

if [ "$round_trip" = "yes" ]; then
    validate_return_date
fi

read -p "Do you have a discount code? (yes/no): " has_discount

declare -i ticket_price
if [ "$has_discount" = "yes" ]; then
    read -p "Enter your discount code: " discount_code
fi

# Loop to book multiple tickets
for ((i=1; i<=$num_tickets; i++))
do
    echo ""
    echo "Ticket $i:"
    get_passenger_details
    choose_seat_type

    # Generate a unique ticket number
    declare -i ticket_number
    ticket_number="${RANDOM}"

    # Calculate ticket price based on seat type
    case $seat_type in
        "Normal") ticket_price=500;;
        "Business") ticket_price=1000;;
        *) ticket_price=0;;
    esac

    # Apply discount if applicable
    apply_discount

    # Offer payment options
    #if [ $i -eq $num_tickets ]; then
        #choose_payment_method
    #fi

    # Generate the ticket
    generate_ticket
    
    # Ask if user wants to modify the ticket
    read -p "Do you want to modify any details of your ticket? (yes/no): " modify_choice
    if [ "$modify_choice" = "yes" ]; then
        modify_ticket
        
        
    fi

    # Offer payment options
    if [ $i -eq $num_tickets ]; then
        choose_payment_method
    fi

    # For round trip, generate return ticket
    if [ "$round_trip" = "yes" ]; then
        echo ""
        echo "Return Ticket $i:"
        # Generate a unique ticket number for return
        ticket_number="${RANDOM}"

        # Use the stored passenger details for return ticket
        generate_ticket

       
        

        # Ask if user wants to modify the return ticket
        read -p "Do you want to modify any details of your return ticket? (yes/no): " modify_choice
        if [ "$modify_choice" = "yes" ]; then
            modify_ticket
        fi
        
         # Offer payment options for return ticket
        if [ $i -eq $num_tickets ]; then
            choose_payment_method
        fi
        
        echo "Your booking is confirmed! We are waiting to serve you with our best."
    fi
done
