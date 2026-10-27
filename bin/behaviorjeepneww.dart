import 'dart:async';

// ABSTRACT CLASS - WEEK 10
abstract class FareService {
  double calculateFare(int passengers);
}

// MIXIN - WEEK 10
mixin MaintenanceLog {
  void checkMaintenance() {
    print('Maintenance check completed.');
  }
}

// STEP 1: BASE CLASS FROM WEEK 9
class Jeepney {
  String route;
  int capacity;
  int _passengers;

  Jeepney(this.route, this.capacity, this._passengers);

  // Encapsulation
  int get passengers => _passengers;

  // Boarding passengers
  void boardPassengers(int count) {
    if (count > 0 && _passengers + count <= capacity) {
      _passengers += count;
      print('$count passenger(s) boarded the $route jeepney.');
    } else {
      print(
        'Cannot board passengers. Capacity limit reached or invalid count.',
      );
    }
  }

  // Display information
  void displayInfo() {
    print('Route: $route');
    print('Capacity: $capacity');
    print('Current Passengers: $_passengers');
    print('Available Seats: ${capacity - _passengers}');
    print('---------------------------');
  }

  // STEP 2: ASYNC METHOD RETURNING A FUTURE
  Future<String> savePassengerRecord() async {
    // STEP 3: SIMULATE A 2-SECOND DELAY
    await Future.delayed(const Duration(seconds: 2));

    return 'Passenger record for $route saved successfully! '
        'Total passengers: $_passengers';
  }
}

// DERIVED CLASS 1 - INHERITANCE AND POLYMORPHISM
class TraditionalJeepney extends Jeepney
    with MaintenanceLog
    implements FareService {
  TraditionalJeepney(String route, int capacity, int passengers)
    : super(route, capacity, passengers);

  @override
  void displayInfo() {
    print('=== TRADITIONAL JEEPNEY ===');
    super.displayInfo();
  }

  @override
  double calculateFare(int passengers) {
    return passengers * 13.0;
  }
}

// DERIVED CLASS 2 - INHERITANCE AND POLYMORPHISM
class ModernJeepney extends Jeepney implements FareService {
  ModernJeepney(String route, int capacity, int passengers)
    : super(route, capacity, passengers);

  @override
  void displayInfo() {
    print('=== MODERN JEEPNEY ===');
    super.displayInfo();
  }

  @override
  double calculateFare(int passengers) {
    return passengers * 14.0;
  }
}

// SEPARATE CLASS USING MIXIN
class MaintenanceStation with MaintenanceLog {
  String stationName;

  MaintenanceStation(this.stationName);

  void displayStation() {
    print('Maintenance Station: $stationName');
  }
}

// STEP 4: ASYNC MAIN FUNCTION
Future<void> main() async {
  // Create Jeepney objects
  TraditionalJeepney jeepney1 = TraditionalJeepney('Cubao - Divisoria', 20, 10);

  ModernJeepney jeepney2 = ModernJeepney('Pasig - Divisoria', 15, 5);

  // Store objects in a list
  List<Jeepney> jeepneys = [jeepney1, jeepney2];

  print('=== JEEPNEY MANAGEMENT SYSTEM ===');

  // Display initial information
  for (Jeepney jeepney in jeepneys) {
    jeepney.displayInfo();
  }

  // Board passengers
  jeepney1.boardPassengers(5);
  jeepney2.boardPassengers(8);

  print('\n=== UPDATED JEEPNEY INFORMATION ===');

  for (Jeepney jeepney in jeepneys) {
    jeepney.displayInfo();
  }

  // Fare calculation
  print('\n=== FARE CALCULATION ===');

  print(
    'Traditional Jeepney Fare: PHP '
    '${jeepney1.calculateFare(jeepney1.passengers)}',
  );

  print(
    'Modern Jeepney Fare: PHP '
    '${jeepney2.calculateFare(jeepney2.passengers)}',
  );

  // Maintenance
  print('\n=== MAINTENANCE CHECK ===');

  jeepney1.checkMaintenance();

  MaintenanceStation station = MaintenanceStation('Quezon City Station');

  station.displayStation();
  station.checkMaintenance();

  // WEEK 11: ASYNCHRONOUS PROGRAMMING
  print('\n=== ASYNCHRONOUS PASSENGER RECORD SAVING ===');

  // Start asynchronous saving
  Future<String> saving = jeepney1.savePassengerRecord();

  // STEP 5: SHOW NON-BLOCKING BEHAVIOR
  print('Saving passenger record...');
  print('System is still running while saving...');

  // Wait for saving to finish
  String result = await saving;

  // Display result after the delay
  print(result);

  print('All operations completed!');
}
