
-- Creating tables and inserting sample data for Technova Institute

-- Create the Courses table
CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    display_order INT NOT NULL,
    duration INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

-- Create the Batch table
CREATE TABLE batch (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    total_students INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    current_module_id INT,
    course_id INT REFERENCES courses(id) ON DELETE CASCADE,
    start_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

-- Create the Batch_Course table
--CREATE TABLE batch_course (
--    id SERIAL PRIMARY KEY,
--    batch_id INT REFERENCES batch(id) ON DELETE CASCADE,
--    course_id INT REFERENCES courses(id) ON DELETE CASCADE,
--    current_module_id INT,
--    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--    created_by VARCHAR(100),
--    updated_by VARCHAR(100)
--);

-- Create the Student table
CREATE TABLE student (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    degree VARCHAR(100),
    college_name VARCHAR(255),
    contact_no VARCHAR(15),
    passed_out_year INT,
    work_experience INT DEFAULT 0,
    course_id INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    current_streak INT DEFAULT 0,
    target_streak_points INT DEFAULT 0,
    streak_start_time TIMESTAMP,
    solved_points INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

-- Create the Student_Batch table used to store all batches
CREATE TABLE student_batch (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES student(id) ON DELETE CASCADE,
    batch_id INT REFERENCES batch(id) ON DELETE CASCADE,
    is_current_batch BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

-- Create the Batch_Class table used to store all class links for a batch
CREATE TABLE batch_class (
    id SERIAL PRIMARY KEY,
    batch_id INT REFERENCES batch(id) ON DELETE CASCADE,
    class_id INT NOT NULL,
    scheduled_date DATE NOT NULL,
    scheduled_time TIME NOT NULL,
    live_link TEXT,
    notes_link TEXT,
    recording_link TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

-- Create the Student_Class table used to save student details of every class
CREATE TABLE student_class (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES student(id) ON DELETE CASCADE,
    class_id INT NOT NULL,
    attended BOOLEAN DEFAULT FALSE,
    total_solved_assignments INT DEFAULT 0,
    total_solved_bonus_assignments INT DEFAULT 0,
    feedback_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

-- Create the Student_Modules table
CREATE TABLE student_modules (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES student(id) ON DELETE CASCADE,
    module_id INT NOT NULL,
    is_current_module BOOLEAN DEFAULT FALSE,
    mock_expiry DATE,
    mock_scheduled DATE,
    mock_cleared BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

-- Create the Student_Interview table
CREATE TABLE student_interview (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES student(id) ON DELETE CASCADE,
    trainer_id INT,
    module_id INT,
    feedback TEXT,
    rating INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

-- Create the Student_Question table
CREATE TABLE student_question (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES student(id) ON DELETE CASCADE,
    question_id INT NOT NULL,
    submission_count INT DEFAULT 0,
    test_cases_passed INT DEFAULT 0,
    points_acquired INT DEFAULT 0,
    solved_time TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

-- Create the Special_Classes table
CREATE TABLE special_classes (
    id SERIAL PRIMARY KEY,
    trainer_id INT,
    topic VARCHAR(255) NOT NULL,
    batch_id INT REFERENCES batch(id) ON DELETE CASCADE,
    scheduled_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);



-- Create the Modules table
CREATE TABLE modules (
    id SERIAL PRIMARY KEY,
    course_id INT REFERENCES courses(id) ON DELETE CASCADE,
    module_name VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    display_order INT NOT NULL,
    is_mock_interview_required BOOLEAN DEFAULT FALSE,
    duration INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

-- Create the Classes table
CREATE TABLE classes (
    id SERIAL PRIMARY KEY,
    module_id INT REFERENCES modules(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    display_order INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

-- Insert sample data into Courses
-- Insert sample data into Courses table

    
    -- Insert modules for Full Stack Development (course_id = 1)

	 INSERT INTO courses (id,name, display_order, duration, created_by, updated_by, created_at, updated_at)
VALUES
    (1,'Full Stack Development', 1, 6, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2,'Data Science', 2, 8, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3,'DevOps', 3, 4, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO modules ( course_id, module_name, is_active, display_order, is_mock_interview_required, duration, created_by, updated_by, created_at, updated_at)
VALUES
    ( 1, 'Core Java', TRUE, 1, FALSE, 40, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ( 1, 'Database Design', TRUE, 2, FALSE, 30, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ( 1, 'Spring Framework', TRUE, 3, FALSE, 35, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ( 1, 'Frontend Development with HTML, CSS', TRUE, 1, FALSE, 30, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ( 1, 'JavaScript', TRUE, 2, FALSE, 40, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ( 1, 'React', TRUE, 3, FALSE, 45, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ( 2, 'Data Science Fundamentals', TRUE, 1, FALSE, 35, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ( 2, 'Python for Data Analysis', TRUE, 2, FALSE, 40, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ( 2, 'Machine Learning Algorithms', TRUE, 3, FALSE, 45, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Data Visualization with Python', TRUE, 4, FALSE, 30, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ( 3, 'Introduction to DevOps', TRUE, 1, FALSE, 30, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ( 3, 'Continuous Integration and Delivery', TRUE, 2, FALSE, 40, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ( 3, 'Infrastructure as Code with Terraform', TRUE, 3, FALSE, 35, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ( 3, 'Monitoring and Logging in DevOps', TRUE, 4, FALSE, 30, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ( 3, 'Containerization and Orchestration with Docker & Kubernetes', TRUE, 5, FALSE, 50, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

   
    -- 10 Classes for Core Java (module_id = 1)
INSERT INTO classes (module_id, name, is_active, display_order, created_by, updated_by, created_at, updated_at)
VALUES
    (1, 'Core Java - Introduction to OOPs', TRUE, 1, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Core Java - Java Collections Framework', TRUE, 2, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Core Java - Exception Handling', TRUE, 3, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Core Java - Multithreading and Concurrency', TRUE, 4, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Core Java - Java Streams API', TRUE, 5, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Core Java - Java 8 Features', TRUE, 6, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Core Java - JDBC Basics', TRUE, 7, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Core Java - JavaFX for GUI Applications', TRUE, 8, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Core Java - File I/O and Serialization', TRUE, 9, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Core Java - Unit Testing with JUnit', TRUE, 10, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


INSERT INTO classes (module_id, name, is_active, display_order, created_by, updated_by, created_at, updated_at)
VALUES
    (2, 'Database Design - Normalization', TRUE, 1, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Database Design - SQL Queries', TRUE, 2, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Database Management - Indexing and Optimization', TRUE, 3, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Database Design - Advanced SQL Queries', TRUE, 4, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Database Design - Triggers and Stored Procedures', TRUE, 5, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Database Management - Database Backup and Recovery', TRUE, 6, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Database Design - Views and Subqueries', TRUE, 7, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Database Design - Data Integrity and Constraints', TRUE, 8, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Database Design - ACID Properties and Transactions', TRUE, 9, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Database Design - Advanced Indexing Techniques', TRUE, 10, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
    
 INSERT INTO classes (module_id, name, is_active, display_order, created_by, updated_by, created_at, updated_at)
VALUES
    (3, 'Introduction to Spring Framework', TRUE, 1, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Spring Boot Setup and REST APIs', TRUE, 2, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Spring Boot Data Access with JPA', TRUE, 3, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Spring Boot: RESTful Web Services', TRUE, 4, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Spring Boot Security and Authentication', TRUE, 5, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Spring Boot Testing and Validation', TRUE, 6, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Spring Boot: Configuration and Properties', TRUE, 7, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Spring Boot: Actuator for Monitoring', TRUE, 8, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Spring Boot: Caching with Redis', TRUE, 9, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Spring Boot: Microservices with Spring Cloud', TRUE, 10, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
    
    
  -- 10 Classes for Frontend Development with HTML, CSS (module_id = 4)
INSERT INTO classes (module_id, name, is_active, display_order, created_by, updated_by, created_at, updated_at)
VALUES
    (4, 'HTML Basics and Page Structure', TRUE, 1, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'CSS Basics and Styling', TRUE, 2, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'Responsive Web Design with CSS', TRUE, 3, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'CSS Flexbox and Grid Layout', TRUE, 4, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'CSS Animations and Transitions', TRUE, 5, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'HTML5 New Elements and Forms', TRUE, 6, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'CSS Variables and Preprocessors', TRUE, 7, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'Responsive Design with Media Queries', TRUE, 8, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'CSS Grid and Layout Techniques', TRUE, 9, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'HTML5 Accessibility and SEO', TRUE, 10, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


-- 10 Classes for JavaScript (module_id = 5)
INSERT INTO classes (module_id, name, is_active, display_order, created_by, updated_by, created_at, updated_at)
VALUES
    (5, 'JavaScript Basics', TRUE, 1, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (5, 'JavaScript DOM Manipulation', TRUE, 2, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (5, 'JavaScript Advanced Functions', TRUE, 3, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (5, 'JavaScript Event Handling', TRUE, 4, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (5, 'JavaScript ES6+ Features', TRUE, 5, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (5, 'Asynchronous JavaScript with Promises and Async/Await', TRUE, 6, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (5, 'JavaScript Closures and Scopes', TRUE, 7, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (5, 'JavaScript Prototypes and Inheritance', TRUE, 8, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (5, 'JavaScript Modules and Bundlers', TRUE, 9, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (5, 'JavaScript Testing with Jest', TRUE, 10, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


-- 10 Classes for React (module_id = 6)
INSERT INTO classes (module_id, name, is_active, display_order, created_by, updated_by, created_at, updated_at)
VALUES
    (6, 'React Introduction and JSX', TRUE, 1, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (6, 'State and Props in React', TRUE, 2, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (6, 'React Hooks and Context API', TRUE, 3, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (6, 'React Router for Navigation', TRUE, 4, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (6, 'React State Management with Redux', TRUE, 5, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (6, 'React Performance Optimization', TRUE, 6, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
    
    
-- Classes for Data Science Fundamentals (module_id = 1)
INSERT INTO classes (module_id, name, is_active, display_order, created_by, updated_by, created_at, updated_at)
VALUES
    (1, 'Introduction to Data Science', TRUE, 1, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Data Science Lifecycle and Process', TRUE, 2, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Understanding Data with Pandas', TRUE, 3, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Data Preprocessing and Cleaning', TRUE, 4, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Exploratory Data Analysis', TRUE, 5, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Data Science Tools and Libraries', TRUE, 6, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Data Wrangling with Python', TRUE, 7, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Data Science with NumPy', TRUE, 8, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Data Visualization with Matplotlib', TRUE, 9, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (1, 'Introduction to Machine Learning', TRUE, 10, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


-- Classes for Python for Data Analysis (module_id = 2)
INSERT INTO classes (module_id, name, is_active, display_order, created_by, updated_by, created_at, updated_at)
VALUES
    (2, 'Introduction to Python for Data Analysis', TRUE, 1, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Python Data Structures for Data Science', TRUE, 2, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Python Libraries for Data Analysis: NumPy', TRUE, 3, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Data Manipulation with Pandas', TRUE, 4, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Data Cleaning and Preprocessing in Python', TRUE, 5, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Exploratory Data Analysis with Python', TRUE, 6, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Visualization with Matplotlib and Seaborn', TRUE, 7, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Working with CSV and Excel Data Files', TRUE, 8, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Statistical Analysis with Python', TRUE, 9, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'Introduction to Machine Learning with Python', TRUE, 10, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


-- Classes for Machine Learning Algorithms (module_id = 3)
INSERT INTO classes (module_id, name, is_active, display_order, created_by, updated_by, created_at, updated_at)
VALUES
    (3, 'Introduction to Machine Learning Algorithms', TRUE, 1, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Supervised Learning: Regression', TRUE, 2, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Supervised Learning: Classification', TRUE, 3, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Unsupervised Learning: Clustering', TRUE, 4, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Dimensionality Reduction with PCA', TRUE, 5, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Model Evaluation and Validation', TRUE, 6, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Overfitting and Underfitting in ML', TRUE, 7, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Ensemble Methods: Random Forest', TRUE, 8, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Support Vector Machines (SVM)', TRUE, 9, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'Deep Learning: Introduction to Neural Networks', TRUE, 10, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


-- Classes for Data Visualization with Python (module_id = 4)
INSERT INTO classes (module_id, name, is_active, display_order, created_by, updated_by, created_at, updated_at)
VALUES
    (4, 'Introduction to Data Visualization', TRUE, 1, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'Data Visualization with Matplotlib', TRUE, 2, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'Advanced Plotting with Seaborn', TRUE, 3, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'Interactive Data Visualizations with Plotly', TRUE, 4, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'Data Visualization with Geospatial Data', TRUE, 5, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'Data Visualization with Dash', TRUE, 6, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'Advanced Visualization: Heatmaps and Contour Plots', TRUE, 7, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'Data Presentation and Storytelling with Visualizations', TRUE, 8, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'Data Visualization Best Practices', TRUE, 9, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (4, 'Creating Dashboards with Python Visualization Tools', TRUE, 10, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


-- Classes for Introduction to DevOps (module_id = 6)
INSERT INTO classes (module_id, name, is_active, display_order, created_by, updated_by, created_at, updated_at)
VALUES
    (6, 'Introduction to DevOps and its Benefits', TRUE, 1, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (6, 'DevOps Tools and Technologies', TRUE, 2, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (6, 'DevOps Pipeline Overview', TRUE, 3, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (6, 'Continuous Integration with Jenkins', TRUE, 4, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (6, 'Source Code Management with Git', TRUE, 5, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (6, 'Version Control and Branching Strategies', TRUE, 6, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
   
-- Classes for Continuous Integration and Delivery (module_id = 7)
INSERT INTO classes (module_id, name, is_active, display_order, created_by, updated_by, created_at, updated_at)
VALUES
    (7, 'Overview of Continuous Integration (CI)', TRUE, 1, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (7, 'Jenkins for CI/CD Pipeline Automation', TRUE, 2, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (7, 'GitLab CI/CD Integration', TRUE, 3, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (7, 'Building and Testing Automation', TRUE, 4, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (7, 'Continuous Delivery and Deployment', TRUE, 5, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (7, 'Blue-Green and Canary Deployment Strategies', TRUE, 6, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (7, 'Automated Testing for CI/CD', TRUE, 7, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (7, 'CI/CD Best Practices and Tools', TRUE, 8, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (7, 'Monitoring CI/CD Pipelines', TRUE, 9, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (7, 'Scaling CI/CD Pipelines for Large Teams', TRUE, 10, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
    
    
    -- Classes for Infrastructure as Code with Terraform (module_id = 8)
INSERT INTO classes (module_id, name, is_active, display_order, created_by, updated_by, created_at, updated_at)
VALUES
    (8, 'Introduction to Terraform and Infrastructure as Code', TRUE, 1, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (8, 'Terraform Setup and Configuration', TRUE, 2, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (8, 'Terraform Providers and Resources', TRUE, 3, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (8, 'Writing Terraform Configuration Files', TRUE, 4, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (8, 'Terraform State Management', TRUE, 5, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (8, 'Terraform Modules and Reusability', TRUE, 6, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (8, 'Version Control and Best Practices with Terraform', TRUE, 7, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (8, 'Terraform for Cloud Platforms (AWS, Azure, GCP)', TRUE, 8, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (8, 'Automating Infrastructure with Terraform', TRUE, 9, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (8, 'Advanced Terraform Features: Workspaces, Provisioners', TRUE, 10, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


-- Classes for Monitoring and Logging in DevOps (module_id = 9)
INSERT INTO classes (module_id, name, is_active, display_order, created_by, updated_by, created_at, updated_at)
VALUES
    (9, 'Introduction to Monitoring and Logging', TRUE, 1, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (9, 'Prometheus and Grafana for Monitoring', TRUE, 2, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (9, 'Setting Up Log Management with ELK Stack (Elasticsearch, Logstash, Kibana)', TRUE, 3, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (9, 'Centralized Logging with Fluentd and Loki', TRUE, 4, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (9, 'Application Performance Monitoring (APM) Tools', TRUE, 5, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (9, 'Integrating Monitoring with CI/CD Pipelines', TRUE, 6, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (9, 'Alerting and Notifications in DevOps', TRUE, 7, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (9, 'Log Aggregation and Search Techniques', TRUE, 8, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (9, 'Monitoring Cloud Infrastructure with AWS CloudWatch', TRUE, 9, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (9, 'Scaling Monitoring and Logging in Distributed Systems', TRUE, 10, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


-- Classes for Containerization and Orchestration with Docker & Kubernetes (module_id = 10)
INSERT INTO classes (module_id, name, is_active, display_order, created_by, updated_by, created_at, updated_at)
VALUES
    (10, 'Introduction to Docker and Containers', TRUE, 1, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (10, 'Docker Images and Containers', TRUE, 2, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (10, 'Docker Networking and Volumes', TRUE, 3, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (10, 'Docker Compose for Multi-Container Applications', TRUE, 4, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (10, 'Kubernetes Architecture and Components', TRUE, 5, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (10, 'Deploying Applications with Kubernetes', TRUE, 6, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (10, 'Kubernetes Networking and Services', TRUE, 7, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (10, 'Kubernetes Persistent Storage', TRUE, 8, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (10, 'Scaling and Managing Kubernetes Clusters', TRUE, 9, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (10, 'CI/CD with Docker and Kubernetes', TRUE, 10, 'ADMIN', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

