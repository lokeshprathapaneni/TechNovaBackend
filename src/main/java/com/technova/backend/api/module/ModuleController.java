package com.technova.backend.api.module;

import com.technova.backend.domain.module.ModuleService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/modules")
//@Tag(name = "Modules", description = "Operations related to modules")
public class ModuleController {

    private final ModuleService moduleService;

    public ModuleController(ModuleService moduleService) {
        this.moduleService = moduleService;
    }

    /**
     * Create a new module
     */
//    @Operation(summary = "Create a new module", description = "Creates a new module and returns the created module")
    @PostMapping
    public ResponseEntity<ModuleResponseDto> createModule(@RequestBody ModuleRequestDto requestDto) {
        ModuleResponseDto responseDto = moduleService.createModule(requestDto);
        return new ResponseEntity<>(responseDto, HttpStatus.CREATED);
    }

    /**
     * Get all modules
     */
//    @Operation(summary = "Get all modules", description = "Returns a list of all modules")
    @GetMapping
    public ResponseEntity<List<ModuleResponseDto>> getAllModules() {
        List<ModuleResponseDto> responseDtos = moduleService.getAllModules();
        return ResponseEntity.ok(responseDtos);
    }

    /**
     * Get modules by course ID
     */
//    @Operation(summary = "Get modules by course ID", description = "Returns a list of modules belonging to a specific course")
    @GetMapping("/course/{courseId}")
    public ResponseEntity<List<ModuleResponseDto>> getModulesByCourseId(@PathVariable Long courseId) {
        List<ModuleResponseDto> responseDtos = moduleService.getModulesByCourseId(courseId);
        return ResponseEntity.ok(responseDtos);
    }

    /**
     * Get a module by ID
     */
//    @Operation(summary = "Get module by ID", description = "Returns a module by its ID")
    @GetMapping("/{id}")
    public ResponseEntity<ModuleResponseDto> getModuleById(@PathVariable Long id) {
        ModuleResponseDto responseDto = moduleService.getModuleById(id);
        return ResponseEntity.ok(responseDto);
    }

    /**
     * Update a module by ID
     */
//    @Operation(summary = "Update a module", description = "Updates an existing module by its ID")
    @PutMapping("/{id}")
    public ResponseEntity<ModuleResponseDto> updateModule(@PathVariable Long id, @RequestBody ModuleRequestDto requestDto) {
        ModuleResponseDto responseDto = moduleService.updateModule(id, requestDto);
        return ResponseEntity.ok(responseDto);
    }

    /**
     * Delete a module by ID
     */
//    @Operation(summary = "Delete a module", description = "Deletes a module by its ID")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteModule(@PathVariable Long id) {
        moduleService.deleteModule(id);
        return ResponseEntity.noContent().build();
    }
}
