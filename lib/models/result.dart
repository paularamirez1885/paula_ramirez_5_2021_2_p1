
import 'origin.dart';

class Results {
  int? id = 0;
  String name ='';
  String status ='';
  String species ='';
  String type ='';
  String gender ='';
  Origin origin = new Origin(name: '', url: '');
  Origin location = new Origin(name: '', url: '');
  String image ='';
  List<String> episode = [];
  String url ='';
  String created ='';

  Results(
      {
      required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.type,
      required this.gender,
      required this.origin,
      required this.location,
      required this.image,
      required this.episode,
      required this.url,
      required this.created
      });

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    type = json['type'];
    gender = json['gender'];
    origin = Origin.fromJson(json['origin']);
    location = Origin.fromJson(json['location']);
    image = json['image'];
    episode = json['episode'].cast<String>();
    url = json['url'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['species'] = this.species;
    data['type'] = this.type;
    data['gender'] = this.gender;
    data['origin'] = this.origin;
    data['location'] = this.location;
    data['image'] = this.image;
    data['episode'] = this.episode;
    data['url'] = this.url;
    data['created'] = this.created;
    return data;
  }
}