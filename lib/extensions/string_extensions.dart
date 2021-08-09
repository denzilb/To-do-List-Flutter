extension StringExtensions on String {
  String capitalise() {
    return this.substring(0, 1).toUpperCase() + this.substring(1);
  }
}
