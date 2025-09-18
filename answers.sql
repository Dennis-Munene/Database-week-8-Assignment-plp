
-- create database
CREATE DATABASE university_db;
-- use created university_db
USE university_db;

-- 1. Departments

CREATE TABLE Department (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    building VARCHAR(100) NOT NULL
);


-- 2. Professors

CREATE TABLE Professor (
    professor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    hire_date DATE NOT NULL,
    department_id INT NOT NULL,
    CONSTRAINT fk_professor_department 
        FOREIGN KEY (department_id) REFERENCES Department(department_id)
        ON DELETE CASCADE
);


-- 3. Students

CREATE TABLE Student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    enrollment_date DATE NOT NULL
);


-- 4. Student Profiles (One-to-One with Student)
CREATE TABLE StudentProfile (
    student_id INT PRIMARY KEY,
    date_of_birth DATE NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20) UNIQUE,
    CONSTRAINT fk_profile_student 
        FOREIGN KEY (student_id) REFERENCES Student(student_id)
        ON DELETE CASCADE
);


-- 5. Courses

CREATE TABLE Course (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(10) NOT NULL UNIQUE,
    title VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits > 0),
    department_id INT NOT NULL,
    professor_id INT NOT NULL,
    CONSTRAINT fk_course_department 
        FOREIGN KEY (department_id) REFERENCES Department(department_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_course_professor 
        FOREIGN KEY (professor_id) REFERENCES Professor(professor_id)
        ON DELETE SET NULL
);


-- 6. Enrollment (Many-to-Many between Students & Courses)
CREATE TABLE Enrollment (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    grade CHAR(2),
    PRIMARY KEY (student_id, course_id),
    CONSTRAINT fk_enrollment_student 
        FOREIGN KEY (student_id) REFERENCES Student(student_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_enrollment_course 
        FOREIGN KEY (course_id) REFERENCES Course(course_id)
        ON DELETE CASCADE
);
