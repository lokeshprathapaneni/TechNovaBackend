package com.technova.backend.domain.courses;

import com.technova.backend.api.courses.CourseRequestDto;
import com.technova.backend.api.courses.CourseResponseDto;
import com.technova.backend.persistence.course.CourseEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;
@Mapper
public interface ICourseMapper {
    ICourseMapper INSTANCE = Mappers.getMapper(ICourseMapper.class);

    @Mapping(target = "id", source = "id")
    @Mapping(target = "name", source = "name")
    @Mapping(target = "displayOrder", source = "displayOrder")
    @Mapping(target = "duration", source = "duration")
    @Mapping(target = "createdAt", source = "createdAt")
    @Mapping(target = "updatedAt", source = "updatedAt")
    @Mapping(target = "createdBy", source = "createdBy")
    @Mapping(target = "updatedBy", source = "updatedBy")
    CourseResponseDto toDto(CourseEntity course);

    @Mapping(target = "name", source = "name")
    @Mapping(target = "displayOrder", source = "displayOrder")
    @Mapping(target = "duration", source = "duration")
    CourseEntity toEntity(CourseRequestDto course);
}
