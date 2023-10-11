// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyData _$$_MyDataFromJson(Map<String, dynamic> json) => _$_MyData(
      categoryId: json['categoryId'] as String,
      name: json['name'] as List<dynamic>?,
      slug: json['slug'] as String,
      description: json['description'] as String,
      parentID: json['parentID'] as String,
      type: json['type'] as int?,
      attributeSet: json['attributeSet'] as String?,
      categoryNumber: json['categoryNumber'] as int?,
      level: json['level'] as int,
      featured: json['featured'] as bool?,
      icon: json['icon'] as String?,
      image: json['image'] as List<dynamic>?,
      status: json['status'] as bool?,
      createDate: json['create_date'] as String,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => MyData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_MyDataToJson(_$_MyData instance) => <String, dynamic>{
      'categoryId': instance.categoryId,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'parentID': instance.parentID,
      'type': instance.type,
      'attributeSet': instance.attributeSet,
      'categoryNumber': instance.categoryNumber,
      'level': instance.level,
      'featured': instance.featured,
      'icon': instance.icon,
      'image': instance.image,
      'status': instance.status,
      'create_date': instance.createDate,
      'children': instance.children,
    };
