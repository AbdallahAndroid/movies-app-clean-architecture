

import 'package:app_example/data/models/response_people_images.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/widgets.dart';

class ItemGalleryPeople extends StatelessWidget {


  MProfileImage mProfileImage;

  ItemGalleryPeople(   this.mProfileImage);

  BuildContext? context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return _photo();
  }


  Widget _photo(){
    double size = DeviceTools.getHalfWidth(context!);

    return ImageViewTemplate(
      widthNeeded: size,
      heightNeeded: size,
      context: context! ,
      radius_all: 20,
      // assetAspectRatio: DrawableProject.images( "logo"),
      boxFit_background: BoxFit.cover,
      urlBackground: getUrlPhoto()  ,
    );
  }


  String? getUrlPhoto() {
    return  mProfileImage.getImageUrl();
  }



}