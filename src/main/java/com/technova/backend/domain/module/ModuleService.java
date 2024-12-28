package com.technova.backend.domain.module;



import com.technova.backend.api.module.ModuleRequestDto;
import com.technova.backend.api.module.ModuleResponseDto;
import com.technova.backend.persistence.course.CourseEntity;
import com.technova.backend.persistence.course.ICourseRepository;
import com.technova.backend.persistence.module.IModuleRepository;
import com.technova.backend.persistence.module.ModuleEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ModuleService {

    private final IModuleRepository moduleRepository;
    private final ICourseRepository courseRepository;
    private final IModuleMapper moduleMapper=IModuleMapper.INSTANCE;

    public ModuleService(IModuleRepository moduleRepository, ICourseRepository courseRepository) {
        this.moduleRepository = moduleRepository;
        this.courseRepository = courseRepository;
    }

    /**
     * Create a new module
     */
    @Transactional
    public ModuleResponseDto createModule(ModuleRequestDto requestDto) {
        // Fetch Course entity
        CourseEntity course = courseRepository.findById(requestDto.getCourseId())
                .orElseThrow(() -> new RuntimeException("Course not found with id: " + requestDto.getCourseId()));

        // Map DTO to Entity
        ModuleEntity module = moduleMapper.toEntity(requestDto);
        module.setCourse(course); // Set course reference

        // Save module and return response DTO
        module = moduleRepository.save(module);
        return moduleMapper.toDto(module);
    }

    /**
     * Get all modules
     */
    @Transactional(readOnly = true)
    public List<ModuleResponseDto> getAllModules() {
        List<ModuleEntity> modules = moduleRepository.findAll();
        return modules.stream()
                .map(moduleMapper::toDto)
                .collect(Collectors.toList());
    }

    /**
     * Get modules by course ID
     */
    @Transactional(readOnly = true)
    public List<ModuleResponseDto> getModulesByCourseId(Long courseId) {
        CourseEntity courseEntity = new CourseEntity();
        courseEntity.setId(courseId);
        List<ModuleEntity> modules = moduleRepository.findByCourse(courseEntity).orElseThrow(RuntimeException::new);
        return modules.stream()
                .map(moduleMapper::toDto)
                .collect(Collectors.toList());
    }

    /**
     * Get a single module by ID
     */
    @Transactional(readOnly = true)
    public ModuleResponseDto getModuleById(Long id) {
        ModuleEntity module = moduleRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Module not found with id: " + id));
        return moduleMapper.toDto(module);
    }

    /**
     * Update a module
     */
    @Transactional
    public ModuleResponseDto updateModule(Long id, ModuleRequestDto requestDto) {
        // Fetch the existing module
        ModuleEntity module = moduleRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Module not found with id: " + id));

        // Update course if necessary
        if (!module.getCourse().getId().equals(requestDto.getCourseId())) {
            CourseEntity course = courseRepository.findById(requestDto.getCourseId())
                    .orElseThrow(() -> new RuntimeException("Course not found with id: " + requestDto.getCourseId()));
            module.setCourse(course);
        }

        // Update fields using the mapper
        moduleMapper.updateEntityFromDto(requestDto, module);

        // Save updated module and return response DTO
        module = moduleRepository.save(module);
        return moduleMapper.toDto(module);
    }

    /**
     * Delete a module by ID
     */
    @Transactional
    public void deleteModule(Long id) {
        if (!moduleRepository.existsById(id)) {
            throw new RuntimeException("Module not found with id: " + id);
        }
        moduleRepository.deleteById(id);
    }
}

