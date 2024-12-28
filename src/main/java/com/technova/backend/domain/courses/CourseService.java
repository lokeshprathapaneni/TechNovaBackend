package com.technova.backend.domain.courses;


import com.technova.backend.api.courses.CourseRequestDto;
import com.technova.backend.api.courses.CourseResponseDto;
import com.technova.backend.persistence.course.CourseEntity;
import com.technova.backend.persistence.course.ICourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;


@Service
public class CourseService {

    @Autowired
    private ICourseRepository ICourseRepository;

    private final static ICourseMapper mapper = ICourseMapper.INSTANCE;


    /**
     * Get all courses
     *
     * @return List of courses
     */
    public List<CourseResponseDto> getAllCourses() {
        List<CourseEntity> courses = ICourseRepository.findAll();
        return courses.stream().map(mapper::toDto).toList();
    }

    /**
     * Get a course by its ID
     *
     * @param id Course ID
     * @return Optional containing the course, if found
     */
    public CourseResponseDto getCourseById(Long id) {
        Optional<CourseEntity> course = ICourseRepository.findById(id);
        return mapper.toDto(course.orElseThrow(RuntimeException::new));
    }

    /**
     * Create a new course
     *
     * @param course Course entity
     * @return The saved course
     */
    public CourseResponseDto createCourse(CourseRequestDto course) {
        return mapper.toDto(ICourseRepository.save(mapper.toEntity(course)));
    }

    /**
     * Update an existing course by ID
     *
     * @param id     Course ID
     * @param newCourse Updated course entity
     * @return The updated course
     */
    public CourseResponseDto updateCourse(Long id, CourseRequestDto newCourse) {
        CourseEntity courseEntity = ICourseRepository.findById(id)
                .map(course -> {
                    course.setName(newCourse.getName());
                    course.setDisplayOrder(newCourse.getDisplayOrder());
                    course.setDuration(newCourse.getDuration());
                    return ICourseRepository.save(course);
                })
                .orElseThrow(() -> new RuntimeException("Course not found with id: " + id));
        return mapper.toDto(courseEntity);
    }

    /**
     * Delete a course by its ID
     *
     * @param id Course ID
     */
    public void deleteCourse(Long id) {
        if (!ICourseRepository.existsById(id)) {
            throw new RuntimeException("Course not found with id: " + id);
        }
        ICourseRepository.deleteById(id);
    }
}

