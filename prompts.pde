String[] sports1 = {"Football", "Curling", "Baseball", "Tennis", "Vollyball"};
String[] sports2 = {"Cricket", "Handball", "Rugby", "Badminton",  "Dogeball", "Golf", "Softball", "Lacrosse", "Kickball", "Hockey"};
String[] sports3 = {"Fencing", "WaterPolo","Paintball", "Judo", "Skiing", "Chess", "Wrestling", "Airsoft", "Archery", "Boxing", "Karate", "Surfing", "Bowling", "Cycling", "Sumo"};

// Method to generate numbers
int[] generateNumbers(int count, int max) {
  int[] numbers = new int[count];
  for (int i = 0; i < numbers.length; i++) {
    numbers[i] = (int) random(max); // Generates a number between 0 and (max - 1)
  }
  return numbers;
}

int [] prompts1 = generateNumbers(40, 5); // Generates 40 numbers from 0 to 4 for sports1
int [] prompts2 = generateNumbers(40, 10); // Generates 40 numbers from 0 to 9 for sports2
int [] prompts3 = generateNumbers(40, 15); // Generates 40 numbers from 0 to 14 for sports3
