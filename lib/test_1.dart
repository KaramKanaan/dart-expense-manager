import 'dart:io';
import 'dart:async';
import 'dart:isolate';


/// Tammam is here my dude, coming to rescue.
/// ===============================
/// Input Functions
/// ===============================

String readString(String message) {
  while (true) {
    stdout.write(message);
    String? input = stdin.readLineSync();

    if (input != null && input.trim().isNotEmpty) {
      return input.trim();
    }

    print("Invalid input. Please enter a non-empty text.");
  }
}

int readInt(String message) {
  while (true) {
    stdout.write(message);
    String? input = stdin.readLineSync();
    int? value = int.tryParse(input ?? "");

    if (value != null) {
      return value;
    }

    print("Invalid input. Please enter a valid integer.");
  }
}

double readDouble(String message) {
  while (true) {
    stdout.write(message);
    String? input = stdin.readLineSync();
    double? value = double.tryParse(input ?? "");

    if (value != null) {
      return value;
    }

    print("Invalid input. Please enter a valid number.");
  }
}

/// ===============================
/// Section 1 Helper Functions
/// ===============================

double calculateTotalExpenses(List<double> expenses) {
  double total = 0;
  for (double expense in expenses) {
    total += expense;
  }
  return total;
}

String evaluateExpense(double amount) {
  if (amount < 500) {
    return "منخفض";
  } else if (amount >= 500 && amount < 1000) {
    return "عادي";
  } else if (amount >= 1000 && amount < 1500) {
    return "متوسط";
  } else {
    return "مرتفع جدا";
  }
}

String getMonthName(int month) {
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      return "Invalid Month";
  }
}

/// ===============================
/// SECTION 1
/// ===============================
void runSection1() {
  print("\n===============================");
  print("SECTION 1 - Basics");
  print("===============================\n");

  // 1) تعريف المتغيرات وإدخال القيم
  String userName = readString("Enter user name: ");
  int age = readInt("Enter age: ");
  double income = readDouble("Enter income: ");
  String category = readString("Enter expense category: ");
  double amount = readDouble("Enter one expense amount: ");
  String expenseDate = readString("Enter expense date (YYYY-MM-DD): ");



  print("\n===== User Information =====");
  print("User Name: $userName");
  print("Age: $age");
  print("Income: $income");
  print("Category: $category");
  print("Expense Amount: $amount");
  print("Expense Date: $expenseDate");


  // 2) إدخال قائمة مصروفات شهرية وحساب الإجمالي
  int count = readInt("\nHow many monthly expenses do you want to enter? ");
  List<double> monthlyExpenses = [];

  for (int i = 0; i < count; i++) {
    double expense = readDouble("Enter expense ${i + 1}: ");
    monthlyExpenses.add(expense);
  }

  double totalMonthlyExpenses = calculateTotalExpenses(monthlyExpenses);

  print("\n===== Monthly Expenses =====");
  print("Expenses List: $monthlyExpenses");
  print("Total Monthly Expenses = $totalMonthlyExpenses");

  // 3) تقييم المصروف باستخدام if
  print("\n===== Expense Evaluation =====");
  print("Evaluation: ${evaluateExpense(totalMonthlyExpenses)}");

  // 4) switch لعرض اسم الشهر مع مقارنة الشهر الحالي بالشهر السابق
  int currentMonth = DateTime.now().month;
  int previousMonth = currentMonth == 1 ? 12 : currentMonth - 1;

  print("\n===== Month Comparison =====");
  print("Current Month Number: $currentMonth");
  print("Current Month Name: ${getMonthName(currentMonth)}");
  print("Previous Month Number: $previousMonth");
  print("Previous Month Name: ${getMonthName(previousMonth)}");

  // 5) for لطباعة مصاريف 3 أشهر
  print("\n===== Enter Expenses For 3 Months =====");

  Map<String, List<double>> expensesBy3Months = {};

  for (int monthIndex = 0; monthIndex <= 2; monthIndex++) {
    String monthName = getMonthName(currentMonth - monthIndex > 0 ? currentMonth - monthIndex : currentMonth - monthIndex + 12 );
    int expenseCount =
    readInt("How many expenses for $monthName? ");

    List<double> monthExpenses = [];

    for (int i = 0; i < expenseCount; i++) {
      double expense =
      readDouble("Enter expense ${i + 1} for $monthName: ");
      monthExpenses.add(expense);
    }

    expensesBy3Months[monthName] = monthExpenses;
  }

  print("\n===== Expenses for 3 Months =====");
  for (String month in expensesBy3Months.keys) {
    List<double> expenses = expensesBy3Months[month]!;
    double total = calculateTotalExpenses(expenses);

    print("\nMonth: $month");
    for (int i = 0; i < expenses.length; i++) {
      print("Expense ${i + 1}: ${expenses[i]}");
    }

    print("Total of $month = $total");
    print("Evaluation of $month = ${evaluateExpense(total)}");
  }
}

/// ===============================
/// SECTION 2
/// ===============================
void runSection2() {
  print("\n===============================");
  print("SECTION 2 - Collections");
  print("===============================\n");

  /// 1) LIST
  print("===== LIST PART =====");
  List<String> activities = [];

  int activityCount =
  readInt("How many activities/expense categories do you want to add? ");

  for (int i = 0; i < activityCount; i++) {
    String activity = readString("Enter activity ${i + 1}: ");
    activities.add(activity);
  }

  print("\nActivities after adding items:");
  print(activities);

  // تحديث عنصر
  if (activities.isNotEmpty) {
    int updateIndex = readInt(
        "Enter the index of activity to update (0 to ${activities.length - 1}): ");

    if (updateIndex >= 0 && updateIndex < activities.length) {
      String newValue = readString("Enter new activity value: ");
      activities[updateIndex] = newValue;
      print("Activity updated successfully.");
    } else {
      print("Invalid index. No update done.");
    }
  }

  // حذف عنصر
  if (activities.isNotEmpty) {
    String removeName = readString(
        "Enter the name of activity to remove");

    if (activities.contains(removeName)) {
      activities.remove(removeName);
      print("Removed activity");
    } else {
      print("Invalid Name. No deletion done.");
    }
  }

  print("\nFinal Activities List:");
  for (String activity in activities) {
    print(activity);
  }

  /// 2) SET
  print("\n===== SET PART =====");
  Set<String> expenseTypes = {};

  int typeCount =
  readInt("How many expense types do you want to enter (duplicates allowed)? ");

  for (int i = 0; i < typeCount; i++) {
    String type = readString("Enter expense type ${i + 1}: ");
    expenseTypes.add(type); // التكرار لن يُخزن
  }

  print("\nUnique expense types:");
  expenseTypes.forEach((type) {
    print(type);
  });

  /// 3) MAP
  print("\n===== MAP PART =====");
  Map<String, List<double>> dailyExpenseRecord = {};

  int dayCount = readInt("How many days do you want to store? ");

  for (int i = 0; i < dayCount; i++) {
    String day = readString("\nEnter day/date ${i + 1} (YYYY-MM-DD): ");
    int expensesCount =
    readInt("How many expenses for $day? ");

    List<double> dayExpenses = [];
    for (int j = 0; j < expensesCount; j++) {
      double expense =
      readDouble("Enter expense ${j + 1} for $day: ");
      dayExpenses.add(expense);
    }

    dailyExpenseRecord[day] = dayExpenses;
  }

  print("\nDaily record after adding days:");
  print(dailyExpenseRecord);

  // تحديث يوم
  if (dailyExpenseRecord.isNotEmpty) {
    String updateDay =
    readString("\nEnter a day to update its expenses: ");

    if (dailyExpenseRecord.containsKey(updateDay)) {
      int newCount = readInt("How many new expenses for $updateDay? ");
      List<double> newExpenses = [];

      for (int i = 0; i < newCount; i++) {
        newExpenses.add(
          readDouble("Enter new expense ${i + 1}: "),
        );
      }

      dailyExpenseRecord[updateDay] = newExpenses;
      print("Day updated successfully.");
    } else {
      print("Day not found. No update done.");
    }
  }

  // حذف يوم
  if (dailyExpenseRecord.isNotEmpty) {
    String removeDay = readString("Enter a day to remove: ");

    if (dailyExpenseRecord.containsKey(removeDay)) {
      dailyExpenseRecord.remove(removeDay);
      print("Day removed successfully.");
    } else {
      print("Day not found. No deletion done.");
    }
  }

  print("\n===== FINAL DAILY RECORD =====");
  print(dailyExpenseRecord);

  /// 4) Loops

  // for loop لطباعة سجل المصروف اليومي
  print("\n===== DAILY RECORD USING FOR LOOP =====");
  List<String> days = dailyExpenseRecord.keys.toList();
  for (int i = 0; i < days.length; i++) {
    String day = days[i];
    print("Day: $day -> Expenses: ${dailyExpenseRecord[day]}");
  }


  // for-in لطباعة جميع الأنشطة
  print("\n===== ACTIVITIES USING FOR-IN =====");
  for (String activity in activities) {
    print(activity);
  }

  // forEach لطباعة أنواع المصاريف
  print("\n===== EXPENSE TYPES USING FOREACH =====");
  expenseTypes.forEach((type) {
    print(type);
  });
}

/// =======================================================
/// SECTION 3 - OOP
/// =======================================================

/// 3.1 Abstract Class
abstract class ExpenseBase {
  void displayExpense();
  double calculateMonthlyExpense();
}

/// 3.4 Mixin
mixin ExpenseHelper {
  void showWarning(double amount) {
    if (amount > 1500) {
      print("WARNING: This expense is very high!");
    }
  }

  void showTip() {
    print("TIP: Try to track your daily spending and reduce unnecessary expenses.");
  }

  double calculateAverageExpense(List<double> expenses) {
    if (expenses.isEmpty) return 0;
    double total = 0;
    for (double expense in expenses) {
      total += expense;
    }
    return total / expenses.length;
  }
}

/// 3.1 Main Expense Class
class Expense extends ExpenseBase with ExpenseHelper {
  // private fields
  String _category;
  double _amount;
  String _date;

  /// Normal constructor
  Expense(this._category, this._amount, this._date);

  /// Named constructor with default values
  Expense.withDefaults()
      : _category = "General",
        _amount = 0.0,
        _date = "2026-01-01";

  /// Getters
  String get category => _category;
  double get amount => _amount;
  String get date => _date;

  /// Setters with simple validation
  set category(String value) {
    if (value.trim().isNotEmpty) {
      _category = value;
    }
  }

  set amount(double value) {
    if (value >= 0) {
      _amount = value;
    }
  }

  set date(String value) {
    if (value.trim().isNotEmpty) {
      _date = value;
    }
  }

  /// Method to display expense details
  @override
  void displayExpense() {
    print("Category: $_category");
    print("Amount: $_amount");
    print("Date: $_date");
  }

  /// Calculate monthly expense (for a single object returns its own amount)
  @override
  double calculateMonthlyExpense() {
    return _amount;
  }
}

/// 3.2 Inheritance - FoodExpense
class FoodExpense extends Expense {
  String _restaurantName;

  FoodExpense(
      String category,
      double amount,
      String date,
      this._restaurantName,
      ) : super(category, amount, date);

  String get restaurantName => _restaurantName;

  set restaurantName(String value) {
    if (value.trim().isNotEmpty) {
      _restaurantName = value;
    }
  }

  @override
  void displayExpense() {
    print("===== Food Expense =====");
    print("Category: $category");
    print("Amount: $amount");
    print("Date: $date");
    print("Restaurant / Place: $_restaurantName");
  }
}

/// 3.2 Inheritance - TransportExpense
class TransportExpense extends Expense {
  int _distance;

  TransportExpense(
      String category,
      double amount,
      String date,
      this._distance,
      ) : super(category, amount, date);

  int get distance => _distance;

  set distance(int value) {
    if (value >= 0) {
      _distance = value;
    }
  }

  @override
  void displayExpense() {
    print("===== Transport Expense =====");
    print("Category: $category");
    print("Amount: $amount");
    print("Date: $date");
    print("Distance: $_distance km");
  }
}

/// 3.2 Inheritance - ShoppingExpense
class ShoppingExpense extends Expense {
  ShoppingExpense(String category, double amount, String date)
      : super(category, amount, date);

  @override
  void displayExpense() {
    print("===== Shopping Expense =====");
    print("Category: $category");
    print("Amount: $amount");
    print("Date: $date");
  }
}

/// 3.2 Inheritance - UtilityExpense
class UtilityExpense extends Expense {
  UtilityExpense(String category, double amount, String date)
      : super(category, amount, date);

  @override
  void displayExpense() {
    print("===== Utility Expense =====");
    print("Category: $category");
    print("Amount: $amount");
    print("Date: $date");
  }
}

/// =======================================================
/// SECTION 4 - ERROR HANDLING
/// =======================================================

/// 4.1 Custom Exception
class InvalidExpenseException implements Exception {
  final String message;

  InvalidExpenseException(this.message);

  @override
  String toString() {
    return "InvalidExpenseException: $message";
  }
}

/// Validation function
void validateExpenseData(String category, double amount) {
  if (category.trim().isEmpty) {
    throw InvalidExpenseException("Expense category cannot be empty.");
  }

  if (amount < 0) {
    throw InvalidExpenseException("Expense amount cannot be negative.");
  }

  if (amount == 0) {
    throw InvalidExpenseException("Expense amount cannot be zero.");
  }
}

/// 4.3 Rethrow function
void addExpenseWithRethrow(String category, double amount, String date) {
  try {
    validateExpenseData(category, amount);
    Expense expense = Expense(category, amount, date);
    print("Expense added successfully:");
    expense.displayExpense();
  } catch (e) {
    print("Warning inside addExpenseWithRethrow(): $e");
    rethrow;
  }
}

/// =======================================================
/// RUN SECTION 3
/// =======================================================
void runSection3() {
  print("\n===============================");
  print("SECTION 3 - OOP");
  print("===============================\n");

  /// Create normal Expense
  Expense expense1 = Expense("Food", 300.0, "2026-07-01");

  print("Basic Expense Object:");
  expense1.displayExpense();

  /// Use setters
  expense1.amount = 450.0;
  expense1.category = "Updated Food";
  expense1.date = "2026-07-02";

  print("\nAfter updating using setters:");
  expense1.displayExpense();

  /// Named constructor
  Expense defaultExpense = Expense.withDefaults();
  print("\nExpense created with default constructor:");
  defaultExpense.displayExpense();

  /// FoodExpense
  FoodExpense foodExpense = FoodExpense(
    "Food",
    500.0,
    "2026-07-03",
    "Burger House",
  );

  print("\nFoodExpense object:");
  foodExpense.displayExpense();
  foodExpense.showTip();
  foodExpense.showWarning(foodExpense.amount);

  /// TransportExpense
  TransportExpense transportExpense = TransportExpense(
    "Transport",
    200.0,
    "2026-07-04",
    15,
  );

  print("\nTransportExpense object:");
  transportExpense.displayExpense();

  /// ShoppingExpense
  ShoppingExpense shoppingExpense = ShoppingExpense(
    "Shopping",
    900.0,
    "2026-07-05",
  );

  print("\nShoppingExpense object:");
  shoppingExpense.displayExpense();

  /// UtilityExpense
  UtilityExpense utilityExpense = UtilityExpense(
    "Bills",
    700.0,
    "2026-07-06",
  );

  print("\nUtilityExpense object:");
  utilityExpense.displayExpense();

  /// calculateAverageExpense from mixin
  List<double> sampleExpenses = [300, 500, 200, 900, 700];
  double average = expense1.calculateAverageExpense(sampleExpenses);
  print("\nAverage expense = $average");
}

/// =======================================================
/// RUN SECTION 4
/// =======================================================
void runSection4() {
  print("\n===============================");
  print("SECTION 4 - Error Handling");
  print("===============================\n");

  /// 4.2 try / on / catch / finally
  try {
    String category = readString("Enter expense category: ");
    double amount = readDouble("Enter expense amount: ");
    String date = readString("Enter expense date: ");

    validateExpenseData(category, amount);

    Expense expense = Expense(category, amount, date);
    print("\nExpense added successfully:");
    expense.displayExpense();
  } on InvalidExpenseException catch (e) {
    print("Custom Exception Caught: $e");
  } catch (e) {
    print("General Exception Caught: $e");
  } finally {
    print("Operation attempted");
  }

  /// 4.3 Rethrow demonstration
  print("\n===== Rethrow Example =====");
  try {
    String category = readString("Enter another expense category: ");
    double amount = readDouble("Enter another expense amount: ");
    String date = readString("Enter another expense date: ");

    addExpenseWithRethrow(category, amount, date);
  } on InvalidExpenseException catch (e) {
    print("Handled in main after rethrow: $e");
  } catch (e) {
    print("General error after rethrow: $e");
  }
}


/// =======================================================
/// SECTION 5 - Asynchronous Programming
/// =======================================================

/// -------------------------------------------------------
/// 5.1 + 5.2 Future + async/await
/// -------------------------------------------------------
/// اسم مختلف حتى لا يتعارض مع دالة Section 1
Future<double> calculateExpenseTotalAsync(List<Expense> expenses) async {
  await Future.delayed(Duration(seconds: 1));

  double total = 0;
  for (Expense expense in expenses) {
    total += expense.amount;
  }

  return total;
}

/// تصنيف مستوى الإنفاق
String classifyExpenseLevel(double total) {
  if (total < 500) {
    return "منخفض";
  } else if (total >= 500 && total < 1000) {
    return "عادي";
  } else if (total >= 1000 && total < 1500) {
    return "متوسط";
  } else {
    return "مرتفع جدا";
  }
}

/// -------------------------------------------------------
/// 5.3 Stream
/// كلاس لإدارة المصروفات وإرسال تحديثات مباشرة للإجمالي
/// -------------------------------------------------------
class ExpenseManager {
  final List<Expense> _expenses = [];

  final StreamController<double> _totalController =
  StreamController<double>.broadcast();

  Stream<double> get totalStream => _totalController.stream;

  List<Expense> get expenses => _expenses;

  void addExpense(Expense expense) {
    _expenses.add(expense);
    _emitCurrentTotal();
  }

  void updateExpense(int index, Expense newExpense) {
    if (index >= 0 && index < _expenses.length) {
      _expenses[index] = newExpense;
      _emitCurrentTotal();
    }
  }

  void removeExpense(int index) {
    if (index >= 0 && index < _expenses.length) {
      _expenses.removeAt(index);
      _emitCurrentTotal();
    }
  }

  void _emitCurrentTotal() {
    double total = 0;
    for (Expense expense in _expenses) {
      total += expense.amount;
    }
    _totalController.add(total);
  }

  void close() {
    _totalController.close();
  }
}

/// -------------------------------------------------------
/// 5.4 Isolate
/// حساب الإحصائيات في الخلفية
/// -------------------------------------------------------

/// نحول المصروفات إلى Map حتى يكون نقلها إلى Isolate أبسط
List<Map<String, dynamic>> convertExpensesToSimpleData(List<Expense> expenses) {
  List<Map<String, dynamic>> result = [];

  for (Expense expense in expenses) {
    result.add({
      "category": expense.category,
      "amount": expense.amount,
      "date": expense.date,
    });
  }

  return result;
}

/// الدالة التي تعمل داخل الـ Isolate
void expenseStatisticsIsolate(Map<String, dynamic> isolateData) {
  SendPort sendPort = isolateData["sendPort"];
  List<Map<String, dynamic>> expenses = isolateData["expenses"];

  double total = 0;
  double average = 0;
  int count = expenses.length;

  Map<String, double> categoryTotals = {};
  String topCategory = "None";
  double highestCategoryAmount = 0;

  for (var item in expenses) {
    String category = item["category"];
    double amount = item["amount"];

    total += amount;

    if (categoryTotals.containsKey(category)) {
      categoryTotals[category] = categoryTotals[category]! + amount;
    } else {
      categoryTotals[category] = amount;
    }
  }

  if (count > 0) {
    average = total / count;
  }

  categoryTotals.forEach((category, amount) {
    if (amount > highestCategoryAmount) {
      highestCategoryAmount = amount;
      topCategory = category;
    }
  });

  Map<String, dynamic> result = {
    "total": total,
    "average": average,
    "topCategory": topCategory,
    "count": count,
  };

  sendPort.send(result);
}

/// -------------------------------------------------------
/// 5.5 Full integrated simulation
/// -------------------------------------------------------
Future<void> runSection5() async {
  print("\n===============================");
  print("SECTION 5 - Asynchronous Programming");
  print("===============================\n");

  ExpenseManager manager = ExpenseManager();

  /// الاستماع إلى التحديثات المستمرة من الـ Stream
  StreamSubscription<double> subscription =
  manager.totalStream.listen((total) {
    print("Stream Update -> Current Total Expenses = $total");
  });

  /// ------------------------------------------
  /// محاكاة يوم كامل من المصروفات
  /// ------------------------------------------
  print("Adding expenses...\n");

  manager.addExpense(
    FoodExpense("Food", 250.0, "2026-07-06", "Pizza House"),
  );

  manager.addExpense(
    TransportExpense("Transport", 120.0, "2026-07-06", 10),
  );

  manager.addExpense(
    ShoppingExpense("Shopping", 300.0, "2026-07-06"),
  );

  manager.addExpense(
    UtilityExpense("Bills", 180.0, "2026-07-06"),
  );

  print("\nUpdating one expense...\n");
  manager.updateExpense(
    1,
    TransportExpense("Transport", 200.0, "2026-07-06", 15),
  );

  print("\nRemoving one expense...\n");
  manager.removeExpense(0);

  /// ------------------------------------------
  /// 5.1 Future using then() and catchError()
  /// ------------------------------------------
  print("\n===== Future using then() / catchError() =====");

  await calculateExpenseTotalAsync(manager.expenses)
      .then((total) {
    print("Total expenses using then() = $total");
  })
      .catchError((error) {
    print("Error while calculating total: $error");
  });

  /// ------------------------------------------
  /// 5.2 async / await
  /// ------------------------------------------
  print("\n===== Future using async / await =====");

  double finalTotal = await calculateExpenseTotalAsync(manager.expenses);
  print("Final Total Expenses = $finalTotal");

  String level = classifyExpenseLevel(finalTotal);
  print("Expense Level = $level");

  /// إذا وصل الإنفاق إلى حد معين
  if (finalTotal >= 500) {
    print("\nDaily spending reached the threshold (500).");
    print("Spending classification: $level");
  }

  /// ------------------------------------------
  /// 5.4 Isolate - حساب الإحصائيات في الخلفية
  /// ------------------------------------------
  print("\n===== Isolate Statistics =====");

  ReceivePort receivePort = ReceivePort();

  List<Map<String, dynamic>> simpleExpenses =
  convertExpensesToSimpleData(manager.expenses);

  await Isolate.spawn(
    expenseStatisticsIsolate,
    {
      "sendPort": receivePort.sendPort,
      "expenses": simpleExpenses,
    },
  );

  Map<String, dynamic> stats = await receivePort.first;

  /// ------------------------------------------
  /// التقرير النهائي لليوم
  /// ------------------------------------------
  print("\n===== Final Daily Report =====");
  print("Total Expenses: ${stats["total"]}");
  print("Average Expense: ${stats["average"]}");
  print("Top Category: ${stats["topCategory"]}");
  print("Number of Recorded Expenses: ${stats["count"]}");

  await subscription.cancel();
  manager.close();
}

/// ===============================
/// MAIN
/// ===============================
Future<void> main() async {
  runSection1();
  runSection2();
  runSection3();
  runSection4();
  await runSection5();
}