package com.technova.backend.api.module;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ModuleRequestDto {
    private Long courseId;
    private String moduleName;
    private Boolean isActive;
    private Integer displayOrder;
    private Boolean isMockInterviewRequired;
    private Integer duration;
}
