package com.technova.backend.api.module;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ModuleResponseDto {
    private Long id;
    private Long courseId; // For referencing the associated course
    private String moduleName;
    private Boolean isActive;
    private Integer displayOrder;
    private Boolean isMockInterviewRequired;
    private Integer duration;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
