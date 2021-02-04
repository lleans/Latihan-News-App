import 'package:NewsAppLatihanEzyIndustries/utils/strings.dart';
import 'package:NewsAppLatihanEzyIndustries/server/api_exception.dart';

abstract class ApiExceptionMapper {
  static String toErrorMessage(Object error) {
    if (error is ApiException) {
      if (error is ConnectionException) {
        return String.connectionError;
      } else if (error is ClientErrorException) {
        return String.clientError;
      } else if (error is ServerErrorException) {
        return String.serverError;
      } else if (error is EmptyResultException) {
        return String.emptyResultError;
      } else {
        return String.unknownError;
      }
    } else {
      return String.unknownError;
    }
  }
}
