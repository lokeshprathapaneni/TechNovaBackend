package com.technova.backend.domain.module;

import com.technova.backend.api.module.ModuleRequestDto;
import com.technova.backend.api.module.ModuleResponseDto;
import com.technova.backend.persistence.module.ModuleEntity;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import org.mapstruct.factory.Mappers;

@Mapper
public interface IModuleMapper {
    IModuleMapper INSTANCE = Mappers.getMapper(IModuleMapper.class);

//    @Mapping(source = "module.id", target = "courseId")
    ModuleResponseDto toDto(ModuleEntity module);

    // Map request DTO to entity
//    @Mapping(source = "courseId", target = "course.id")
    ModuleEntity toEntity(ModuleRequestDto requestDto);

    // Update entity from request DTO
//    @Mapping(source = "courseId", target = "course.id")
    void updateEntityFromDto(ModuleRequestDto requestDto, @MappingTarget ModuleEntity module);

}
