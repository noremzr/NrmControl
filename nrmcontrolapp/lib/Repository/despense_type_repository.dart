import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nrmcontrolapp/Repository/base_repository.dart';

import '../Models/CustomException/custom_exception.dart';
import '../Models/DespenseType/despense_type.dart';
import '../Services/http_service.dart';

class DespenseTypeRepository {
  static const String _route = "/despense-type";

  Future<List<DespenseType>> getDespenseTypesByUser(
      String userId, BuildContext context) async {
    String methodRoute = '${BaseRepository().urlBase}$_route/$userId';
    final response = await HttpService().get(
      methodRoute,
      context,
    );
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<DespenseType> listaDespesas = body
          .map(
            (dynamic item) => DespenseType.fromJson(item),
          )
          .toList();

      return listaDespesas;
    }
    CustomException customException =
        CustomException.fromJson(jsonDecode(response.body));
    throw customException.detail;
  }

  Future<DespenseType> createDespenseType(
      DespenseType despenseType, BuildContext context) async {
    String methodRoute = '${BaseRepository().urlBase}$_route';
    dynamic response = await HttpService().post(
      methodRoute,
      despenseType,
      context,
    );
    if (response.statusCode == 200) {
      return DespenseType.fromJson(json.decode(response.body.toString()));
    }
    CustomException customException =
        CustomException.fromJson(jsonDecode(response.data));
    throw customException.detail;
  }

  Future<DespenseType> updateDespenseType(
      DespenseType despenseType, BuildContext context) async {
    String methodRoute = '${BaseRepository().urlBase}$_route';
    dynamic response =
        await HttpService().put(methodRoute, despenseType, context);
    if (response.statusCode == 200) {
      return DespenseType.fromJson(json.decode(response.body.toString()));
    }
    CustomException customException =
        CustomException.fromJson(jsonDecode(response.data));
    throw customException.detail;
  }

  Future deleteDespenseType(
      DespenseType despenseType, BuildContext context) async {
    String methodRoute =
        '${BaseRepository().urlBase}$_route/${despenseType.id}';
    dynamic response = await HttpService().delete(
      methodRoute,
      context,
    );
    if (response.statusCode != 200) {
      CustomException customException =
          CustomException.fromJson(jsonDecode(response.data));
      throw customException.detail;
    }
  }
}
