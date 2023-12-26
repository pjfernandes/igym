class GymUser {
  final String id;
  final String name;
  // final String firstName;
  // final String lastName;
  final String email;
  String height = '';
  String weight = '';
  String age = '';
  String sex = '';

  GymUser({
    required this.id,
    required this.name,
    // required this.firstName,
    // required this.lastName,
    required this.email,
    required this.height,
    required this.weight,
    required this.age,
    required this.sex,
  });
}
