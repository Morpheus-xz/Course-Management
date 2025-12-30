package com.example.demo.controller;

import com.example.demo.model.Vehicle; // keep as it is
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/courses")
public class CourseController {

    private List<Vehicle> courses = new ArrayList<>();
    private int idCounter = 1;

    // SHOW PAGE
    @GetMapping
    public String showCourses(Model model) {
        model.addAttribute("courses", courses);
        model.addAttribute("course", new Vehicle());
        return "courses";   // JSP name unchanged
    }

    // ADD COURSE
    @PostMapping("/add")
    public String addCourse(@RequestParam String number,
                            @RequestParam String owner) {

        Vehicle c = new Vehicle();
        c.setId(idCounter++);
        c.setNumber(number);   // courseCode
        c.setOwner(owner);     // courseName
        courses.add(c);

        return "redirect:/courses";
    }

    // DELETE COURSE
    @GetMapping("/delete/{id}")
    public String deleteCourse(@PathVariable int id) {
        courses.removeIf(c -> c.getId() == id);
        return "redirect:/courses";
    }

    // EDIT COURSE
    @GetMapping("/edit/{id}")
    public String editCourse(@PathVariable int id, Model model) {
        for (Vehicle c : courses) {
            if (c.getId() == id) {
                model.addAttribute("course", c);
                break;
            }
        }
        model.addAttribute("courses", courses);
        return "courses";
    }

    // UPDATE COURSE
    @PostMapping("/update")
    public String updateCourse(@RequestParam int id,
                               @RequestParam String number,
                               @RequestParam String owner) {

        for (Vehicle c : courses) {
            if (c.getId() == id) {
                c.setNumber(number);
                c.setOwner(owner);
                break;
            }
        }
        return "redirect:/courses";
    }
}
