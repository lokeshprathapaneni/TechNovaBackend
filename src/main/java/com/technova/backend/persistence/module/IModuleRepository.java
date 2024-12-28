package com.technova.backend.persistence.module;

import com.technova.backend.persistence.course.CourseEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface IModuleRepository extends JpaRepository<ModuleEntity,Long> {
    Optional<List<ModuleEntity>> findByCourse(CourseEntity courseEntity);
}
