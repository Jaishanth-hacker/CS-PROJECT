import mysql.connector as sql
import random

def connect_to_database():
    try:
        conn = sql.connect(host="localhost", user="root", password="1234", database="BUS_MANAGEMENT")
        if conn.is_connected():
            print("Connection Established Successfully... Process Started...\n")
            return conn
        else:
            print("Connection Failed")
            return None
    except sql.Error as e:
        print(f"Error connecting to the database: {e}")
        return None

def display_available_buses(crsr, destination):
    crsr.execute(f"SELECT * FROM BUSDETAILS WHERE DESTINATION = '{destination}'")
    table = crsr.fetchall()

    if not table:
        print("No buses available for the selected destination.")
        return

    print("{:<8} {:<12} {:<8} {:<20} {:<20} {:<15} {:<15} {:<20}".format("Bus ID", "Bus No", "Source", "Departure Time", "Arrival Time", "Destination", "Duration", "Available Tickets"))
    print("=" * 120)

    for row in table:
        bus_id, bus_no, source, departure_time, arrival_time, destination, duration, available_tickets = row
        print("{:<8} {:<12} {:<8} {:<20} {:<20} {:<15} {:<15} {:<20}".format(bus_id, bus_no, source, str(departure_time), str(arrival_time), destination, str(duration), available_tickets))

def book_ticket(crsr, bookid):
    if len(str(bookid)) != 4:
        print("Invalid Bus ID")
        return

    name = input("Enter name of the passenger: ")
    seatno = input("Enter seat no: ")
    phno = input("Enter passenger phone number: ")
    ticketid = random.randint(1000, 9999)

    try:
        crsr.execute(f"UPDATE BUSDETAILS SET AVAILABLE_TICKETS = AVAILABLE_TICKETS - 1 WHERE BUSID = {bookid} AND AVAILABLE_TICKETS > 0")
        if crsr.rowcount > 0:
            crsr.execute(f"INSERT INTO BOOKINGDETAIL VALUES({ticketid}, {bookid}, '{name}', '{seatno}', {phno});")
            conn.commit()
            crsr.execute(f"SELECT * FROM busdetails INNER JOIN bookingdetail ON bookingdetail.busid = busdetails.busid WHERE bookingdetail.ticket_id = '{ticketid}'")
            booktable = crsr.fetchall()

            if booktable:
                for row in booktable:
                    bus_id, bus_no, source, departure_time, arrival_time, destination, duration, available_tickets, ticket_id, booking_bus_id, passenger_name, seat_number, phone_number = row

                    # Convert timedelta objects to formatted strings
                    departure_time_str = str(departure_time)
                    arrival_time_str = str(arrival_time)
                    duration_str = str(duration)

                    # Display the information
                    print("Bus ID: {}".format(bus_id))
                    print("Bus No: {}".format(bus_no))
                    print("Source: {}".format(source))
                    print("Departure Time: {}".format(departure_time_str))
                    print("Arrival Time: {}".format(arrival_time_str))
                    print("Destination: {}".format(destination))
                    print("Duration: {}".format(duration_str))
                    print("Available Tickets: {}".format(available_tickets))
                    print("Ticket ID: {}".format(ticket_id))
                    print("Passenger Name: {}".format(passenger_name))
                    print("Seat Number: {}".format(seat_number))
                    print("Phone Number: {}".format(phone_number))
                    print("=" * 40)  # Separate each record for better readability
            else:
                print("No booking details found for the given ticket ID.")
            print("Your ticket is booked successfully")
        else:
            print("Selected bus is full or invalid.")
    except sql.Error as e:
        print(f"Error booking ticket: {e}")

def cancel_ticket(crsr, ticketid):
    try:
        crsr.execute(f"DELETE FROM bookingdetail WHERE TICKET_ID = {ticketid}")
        if crsr.rowcount > 0:
            conn.commit()
            print("Ticket cancelled successfully")
        else:
            print("Invalid Ticket ID")
    except sql.Error as e:
        print(f"Error cancelling ticket: {e}")

print("BUS DETAILS PAGE")
print("AVAILABLE SERVICES \n 1. COIMBATORE -- CHENNAI \n 2. COIMBATORE -- BANGALORE \n 3. COIMBATORE -- TRICHY")
destination = input("ENTER YOUR DESTINATION PLACE: ").title()

conn = connect_to_database()

if conn:
    crsr = conn.cursor()
    display_available_buses(crsr, destination)

    print("AVAILABLE OPERATION:-  \n 1. BOOK A TICKET \n 2. CANCEL A TICKET")
    choice = int(input("ENTER YOUR OPERATION:-"))

    if choice == 1:
        bookid = int(input("ENTER THE BUS ID TO BE BOOKED: "))
        book_ticket(crsr, bookid)
    elif choice == 2:
        ticketid = int(input("Enter Ticket ID to cancel the ticket: "))
        cancel_ticket(crsr, ticketid)
    else:
        print("Invalid input")

    conn.close()
import mysql.connector as sql
import random

def connect_to_database():
    try:
        conn = sql.connect(host="localhost", user="root", password="1234", database="BUS_MANAGEMENT")
        if conn.is_connected():
            print("Connection Established Successfully... Process Started...\n")
            return conn
        else:
            print("Connection Failed")
            return None
    except sql.Error as e:
        print(f"Error connecting to the database: {e}")
        return None

def display_available_buses(crsr, destination):
    crsr.execute(f"SELECT * FROM BUSDETAILS WHERE DESTINATION = '{destination}'")
    table = crsr.fetchall()

    if not table:
        print("No buses available for the selected destination.")
        return

    print("{:<8} {:<12} {:<8} {:<20} {:<20} {:<15} {:<15} {:<20}".format("Bus ID", "Bus No", "Source", "Departure Time", "Arrival Time", "Destination", "Duration", "Available Tickets"))
    print("=" * 120)

    for row in table:
        bus_id, bus_no, source, departure_time, arrival_time, destination, duration, available_tickets = row
        print("{:<8} {:<12} {:<8} {:<20} {:<20} {:<15} {:<15} {:<20}".format(bus_id, bus_no, source, str(departure_time), str(arrival_time), destination, str(duration), available_tickets))

def book_ticket(crsr, bookid):
    if len(str(bookid)) != 4:
        print("Invalid Bus ID")
        return

    name = input("Enter name of the passenger: ")
    seatno = input("Enter seat no: ")
    phno = input("Enter passenger phone number: ")
    ticketid = random.randint(1000, 9999)

    try:
        crsr.execute(f"UPDATE BUSDETAILS SET AVAILABLE_TICKETS = AVAILABLE_TICKETS - 1 WHERE BUSID = {bookid} AND AVAILABLE_TICKETS > 0")
        if crsr.rowcount > 0:
            crsr.execute(f"INSERT INTO BOOKINGDETAIL VALUES({ticketid}, {bookid}, '{name}', '{seatno}', {phno});")
            conn.commit()
            crsr.execute(f"SELECT * FROM busdetails INNER JOIN bookingdetail ON bookingdetail.busid = busdetails.busid WHERE bookingdetail.ticket_id = '{ticketid}'")
            booktable = crsr.fetchall()

            if booktable:
                for row in booktable:
                    bus_id, bus_no, source, departure_time, arrival_time, destination, duration, available_tickets, ticket_id, booking_bus_id, passenger_name, seat_number, phone_number = row

                    # Convert timedelta objects to formatted strings
                    departure_time_str = str(departure_time)
                    arrival_time_str = str(arrival_time)
                    duration_str = str(duration)

                    # Display the information
                    print("Bus ID: {}".format(bus_id))
                    print("Bus No: {}".format(bus_no))
                    print("Source: {}".format(source))
                    print("Departure Time: {}".format(departure_time_str))
                    print("Arrival Time: {}".format(arrival_time_str))
                    print("Destination: {}".format(destination))
                    print("Duration: {}".format(duration_str))
                    print("Available Tickets: {}".format(available_tickets))
                    print("Ticket ID: {}".format(ticket_id))
                    print("Passenger Name: {}".format(passenger_name))
                    print("Seat Number: {}".format(seat_number))
                    print("Phone Number: {}".format(phone_number))
                    print("=" * 40)  # Separate each record for better readability
            else:
                print("No booking details found for the given ticket ID.")
            print("Your ticket is booked successfully")
        else:
            print("Selected bus is full or invalid.")
    except sql.Error as e:
        print(f"Error booking ticket: {e}")

def cancel_ticket(crsr, ticketid):
    try:
        crsr.execute(f"DELETE FROM bookingdetail WHERE TICKET_ID = {ticketid}")
        if crsr.rowcount > 0:
            conn.commit()
            print("Ticket cancelled successfully")
        else:
            print("Invalid Ticket ID")
    except sql.Error as e:
        print(f"Error cancelling ticket: {e}")

print("BUS DETAILS PAGE")
print("AVAILABLE SERVICES \n 1. COIMBATORE -- CHENNAI \n 2. COIMBATORE -- BANGALORE \n 3. COIMBATORE -- TRICHY")
destination = input("ENTER YOUR DESTINATION PLACE: ").title()

conn = connect_to_database()

if conn:
    crsr = conn.cursor()
    display_available_buses(crsr, destination)

    print("AVAILABLE OPERATION:-  \n 1. BOOK A TICKET \n 2. CANCEL A TICKET")
    choice = int(input("ENTER YOUR OPERATION:-"))

    if choice == 1:
        bookid = int(input("ENTER THE BUS ID TO BE BOOKED: "))
        book_ticket(crsr, bookid)
    elif choice == 2:
        ticketid = int(input("Enter Ticket ID to cancel the ticket: "))
        cancel_ticket(crsr, ticketid)
    else:
        print("Invalid input")

    conn.close()
