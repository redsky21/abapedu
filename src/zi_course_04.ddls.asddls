@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'interface view for cousre 04 for lg04'
define root view entity zi_course_04
  as select from zcourse_04
  association[0..1] to I_Country as _Country on $projection.Country = _Country.Country
  association[0..1] to I_Currency as _Currency on $projection.CurrencyCode = _Currency.Currency
  
{
  key course_uuid     as CourseUuid,
      course_id       as CourseId,
      course_name     as CourseName,
      @Consumption.valueHelpDefinition: [{entity:{ name: 'I_Country', element: 'Country' } }]
      country         as Country,
      price           as Price,
      currency_code   as CurrencyCode,
      blocked         as Blocked,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,
      _Country,
      _Currency
}
