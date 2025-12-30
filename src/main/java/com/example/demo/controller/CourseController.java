package com.example.demo.controller;

import com.example.demo.model.Course;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/courses")
public class CourseController {

    private List<Course> courses = new ArrayList<>();
    private int idCounter = 1;

    // READ - show all courses
    @GetMapping
    public String showCourses(Model model) {
        model.addAttribute("courses", courses);
        model.addAttribute("course", new Course());
        return "courses";
    }

    // CREATE - add course
    @PostMapping("/add")
    public String addCourse(@RequestParam String courseCode,
                            @RequestParam String courseName) {

        Course course = new Course();
        course.setId(idCounter++);
        course.setCourseCode(courseCode);
        course.setCourseName(courseName);

        courses.add(course);
        return "redirect:/courses";
    }

    // DELETE
    @GetMapping("/delete/{id}")
    public String deleteCourse(@PathVariable int id) {
        courses.removeIf(c -> c.getId() == id);
        return "redirect:/courses";
    }

    // UPDATE (load data)
    @GetMapping("/edit/{id}")
    public String editCourse(@PathVariable int id, Model model) {
        for (Course c : courses) {
            if (c.getId() == id) {
                model.addAttribute("course", c);
                break;
            }
        }
        model.addAttribute("courses", courses);
        return "courses";
    }

    // UPDATE (save data)
    @PostMapping("/update")
    public String updateCourse(@RequestParam int id,
                               @RequestParam String courseCode,
                               @RequestParam String courseName) {

        for (Course c : courses) {
            if (c.getId() == id) {
                c.setCourseCode(courseCode);
                c.setCourseName(courseName);
                break;
            }
        }
        return "redirect:/courses";
    }
}
