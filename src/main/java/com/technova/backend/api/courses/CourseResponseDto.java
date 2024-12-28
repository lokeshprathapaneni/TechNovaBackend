package com.technova.backend.api.courses;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
@Data
@Builder
public class CourseResponseDto {
    private Long id;
    private String name;
    private Integer displayOrder;
    private Integer duration;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String createdBy;
    private String updatedBy;
}
