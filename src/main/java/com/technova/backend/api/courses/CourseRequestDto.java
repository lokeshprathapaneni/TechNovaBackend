package com.technova.backend.api.courses;


import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CourseRequestDto {

    @NotNull(message = "Course name must not be empty")
    @Size(max = 255, message = "Course name must not exceed 255 characters")
    private String name;

    @NotNull(message = "Display order is required")
    @Positive(message = "Display order must be a positive number")
    private Integer displayOrder;

    @NotNull(message = "Duration is required")
    @Positive(message = "Duration must be a positive number")
    private Integer duration;
}