import psycopg2

ERROR_FILE_NAME = 'HW6.error'
PHONE_NUMBER_LENGTH = 10
POSTAL_CODE_LENGTH = 5
MAX_USER_TRIES = 3

def main():
    print('Welcome to the flight reservation system.')
    running_object = ReservationSystem()
    user_input_correct_data = running_object.validate_user_input()
    if user_input_correct_data:
        tries = 0
        input_success = False
        while tries < MAX_USER_TRIES:
            input_success = running_object.validate_flight()
            if input_success:
                break
            else:
                tries += 1
        if tries == MAX_USER_TRIES:
            print('Sorry, could not confirm reservation.')
            exit()
        running_object.record_data()
        running_object.print_flight()
    else:
        print('Sorry there were problems with your input.')
        running_object.print_errors()
        print('Please refer to ' + ERROR_FILE_NAME + ' for a full report.')
        running_object.log_errors()
        

class ReservationSystem:
    def __init__(self):
        self.database = psycopg2.connect("dbname=postgres user=postgres")
        self.session = self.database.cursor()
        self.errors = []
        self.user_data = {}

    def validate_user_input(self):
        self.user_data['user_name'] = input('Please input your name.\n')
        self.user_data['street_address'] = input('Please input your street address.\n')
        self.user_data['city'] = input('Please input your city name.\n')
        self.user_data['postal_code'] = input('Please input your postal code (zip code).\n')
        self.user_data['province_state'] = input('Please input your province or state.\n')
        self.user_data['country_code'] = input('Please enter your country code\n')
        self.user_data['phone_number'] = input('Please input your phone number.\n')
        self.user_data['email'] = input('Please input your email address.\n')
        return not self.detect_errors(self.user_data['phone_number'], self.user_data['email'],
                                      self.user_data['postal_code'])
        
    def detect_errors(self, phone_number, email, postal_code): 
        # Remove dashes from the phone number.
        phone_number = phone_number.replace('-','')
        if len(phone_number) != PHONE_NUMBER_LENGTH:
            self.errors.append('The phone number should be ' + str(PHONE_NUMBER_LENGTH)
                               + ' digits.\n It was actually ' + str(len(phone_number))
                               + ' digits.')
        try:
            int(phone_number)
        except ValueError:
            self.errors.append('The phone number was not an integer. It was '
                               + phone_number)
        if '@' not in email:
            self.errors.append('There was no "@" symbol in the email address.')
        if len(postal_code) != POSTAL_CODE_LENGTH:
            self.errors.append('The postal code should be ' + str(POSTAL_CODE_LENGTH)
                               + 'digits. It was actually ' + str(len(postal_code))
                               + ' digits.')
        if self.errors:
            return True
        else:
            return False

    def validate_flight(self):
        self.user_data['origin_city'] = input('Please enter your starting city.')
        cities = self.session.execute('SELECT * FROM city;')
        print(str(cities))
        self.user_data['destination_city'] = input('Please enter your destination.')
        if user_data['destination_city'] not in cities:
            print('The city ' + user_data['destination_city'] + ' is not available.')
            return False
        return True

    def record_data(self):
        mailing_address_statement = str('INSERT INTO mailing_address(street,'
                                    + ' city, province_state, postal_code,'
                                    + ' country_code) VALUES (' + user_data['street_address']
                                    + ', ' + user_data['city'] + ', ' + user_data['province_state']
                                    + ', ' + user_data['postal_code'] + ', ' + user_data['country_code'] + ');')
        self.session.execute(mailing_address_statement)
        # Get the last id so it can be referenced in the customer table.
        mailing_reference = self.session.execute('SELECT id FROM mailing_address ORDER BY id DESC LIMIT 1;')
        (customer_first, customer_last) = self.user_data['user_name'].split(' ')
        customer_entry_statement = str('INSERT INTO customer(first_name, last_name, mailing_address_id)'
                                   + ' VALUES (' + customer_first + ', ' + customer_last + ', '
                                   + mailing_reference + ');')
        self.session.execute(customer_entry_statement)
        phone_number_reference = self.session.execute('SELECT id FROM customer ORDER BY id DESC LIMIT 1;')
        country_code = user_data['phone_number'][0:3]
        area_code = user_data['phone_number'][3:6]
        local_number = user_data['phone_number'][6:10]
        phone_number_entry_statement = str('INSERT INTO phone_number(country_code, area_code,'
                                       + ', local_code) VALUES(' + country_code + ', '
                                       + 'area_code' + ', ' + local_number + ');')
        self.session.execute(phone_number_entry_statement)
        customer_reference = phone_number_reference = self.session.execute('SELECT id FROM phone_number ORDER BY id DESC LIMIT 1;')
        customer_phone_numbers_entry_statement = str('INSERT INTO customer_phone_numbers(customer_id, phone_number_id)'
                                                 + ' VALUES (' + customer_reference + ', ' + phone_number_reference + ');')
        origin_city_reference = self.session.execute('SELECT id FROM city WHERE city.name = ' + self.user_data['origin_city'] + ');')
        destination_city_reference = self.session.execute('SELECT id FROM city WHERE city.name = ' + self.user_data['destination_city'] + ');')
        
        flight_entry_statement = str('INSERT INTO flight(flight_origin_code, flight_destination_code, flying_customer)'
                                + ' VALUES(' + origin_city_reference + ', ' + destination_city_reference + ', '
                                + self.user_data['user_name'] + ');')
        self.session.execute(flight_entry_statement)
        
    def print_flight(self):
        report_data = []
        report_data.append(user_data[user_name] + ', thank you for using the flight reservation system.')
        flight_code = self.session.execute('SELECT unique_flight_number FROM flight ORDER BY unique_flight_number DESC LIMIT 1;')
        report_data.append('Your unique flight number is ' + flight_code)
        for line in report_data:
            print(line)
        report_file = open('HW6.flight', 'w+')
        for line in report_data:
            report_file.write(line)

    def print_errors(self):
        for error in self.errors:
            print(error)
    def log_errors(self):
        error_file = open(ERROR_FILE_NAME, 'w+')
        for error in self.errors:
            error_file.write(error)
            error_file.write('\n')
        error_file.close()

if __name__ == '__main__':
    main()