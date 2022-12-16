@EndUserText.label: 'Projection View for ZI_COURSE_04'
@AccessControl.authorizationCheck: #CHECK@Metadata.allowExtensions: true
@Search.searchable: true //global search 기능 
define root view entity ZC_COURSE_04 as projection on zi_course_04 {
    key CourseUuid,
    CourseId,
    @Search.defaultSearchElement: true  //Global Search 대상 컬럼여부
    CourseName,
    Country,
    Price,
    @Search.defaultSearchElement: true  //Global Search 대상 컬럼여부
    CurrencyCode,
    Blocked,
    LastChangedAt,
    LastChangedBy,
    /* Associations */
    _Country,
    _Currency
}
