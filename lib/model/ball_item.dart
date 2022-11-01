class BallItem {
  final int id;
  final String team;
  final String group;
  final String flagImage;

  BallItem({
    required this.id,
    required this.team,
    required this.group,
    required this.flagImage,
  });

  factory BallItem.fromJson(Map<String, dynamic> json) {
    return BallItem(
      id: json['id'],
      team: json['team'],
      group: json['group'],
      flagImage: json['flagImage'],
    );
  }
}
