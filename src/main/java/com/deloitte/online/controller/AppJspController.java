package com.deloitte.online.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AppJspController {

	@RequestMapping("/")
	public String showTasks() {
		return "tasklist.jsp";
	}
	
}
