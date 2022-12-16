@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'interface view for travel 04 for lg04'
define view entity zi_travel_04
  as select from zi_course_04
{
  key CourseUuid,
      CourseId,
      CourseName,
      Country,
      Price,
      CurrencyCode,
      Blocked,
      LastChangedAt,
      LastChangedBy,
      /* Associations */
      _Country,
      _Currency
}
