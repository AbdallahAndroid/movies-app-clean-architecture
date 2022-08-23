class ResponsePeopleImages {
  int? id;
  List<MProfileImage>? profiles;

  ResponsePeopleImages({this.id, this.profiles});

  ResponsePeopleImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['profiles'] != null) {
      profiles = <MProfileImage>[];
      json['profiles'].forEach((v) {
        profiles!.add(new MProfileImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.profiles != null) {
      data['profiles'] = this.profiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MProfileImage {
  double? aspectRatio;
  int? height;
  Null? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  MProfileImage(
      {this.aspectRatio,
        this.height,
        this.iso6391,
        this.filePath,
        this.voteAverage,
        this.voteCount,
        this.width});

  MProfileImage.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aspect_ratio'] = this.aspectRatio;
    data['height'] = this.height;
    data['iso_639_1'] = this.iso6391;
    data['file_path'] = this.filePath;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    data['width'] = this.width;
    return data;
  }

  String  getImageUrl(  ) {
    if( filePath == null  ) {
      return "";
    }
    return "https://image.tmdb.org/t/p/w500/" + filePath! ;
  }
}
