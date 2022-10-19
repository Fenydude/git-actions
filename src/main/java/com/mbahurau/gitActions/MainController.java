package com.mbahurau.gitActions;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MainController {
    @GetMapping("/api")
    public String getHelloWorld(){
        return "Hello World";
    }
}
