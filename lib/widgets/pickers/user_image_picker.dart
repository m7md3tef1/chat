import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
class UserImagePicker extends StatefulWidget {
   const UserImagePicker(this.imagePickFn, {super.key}) ;
final void Function(File pickedImage) imagePickFn;
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  final ImagePicker _picker=ImagePicker();
  void _pickImage(ImageSource src)async{
    final  pickedImageFile =await _picker.pickImage(source: src,imageQuality: 50,maxWidth: 150);
    if(pickedImageFile!=null){
      setState(() {
        _pickedImage=File(pickedImageFile.path);
      });
      widget.imagePickFn(_pickedImage!);
    }else{
      print("No Image Selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage!=null?FileImage(_pickedImage!):null,
        ),
       const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: ()=>_pickImage(ImageSource.camera), icon: const Icon(Icons.photo_camera_outlined),
              label: const Text('Add Image \n from Camera',textAlign: TextAlign.center,),

            ),
            TextButton.icon(onPressed: ()=>_pickImage(ImageSource.gallery), icon: const Icon(Icons.image_outlined),
              label: const Text('Add Image \n from Gallery',textAlign: TextAlign.center,),

            ),
          ],
        )
      ],
    );
  }
}

