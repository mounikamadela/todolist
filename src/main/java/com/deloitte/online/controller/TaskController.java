package com.deloitte.online.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.deloitte.online.dao.TaskRepo;
import com.deloitte.online.model.Task;

@RestController
public class TaskController {
	
	@Autowired
	private TaskRepo taskRepo;
	
	@GetMapping("/getAllTasks")
	public List<Task> getAllTasks(){
		return taskRepo.findByUsername(getLoggedInUserName());
	}
	
	@PostMapping("/saveTask")
	public void saveTask(@RequestBody Task task) {		
		task.setUsername(getLoggedInUserName());
		taskRepo.save(task);
	}
	
	@GetMapping("/getTask/{id}")
	public Task getTask(@PathVariable int id) {
		return taskRepo.findById(id).get();
	}

	@GetMapping("/removeTask/{id}")
	public void removeTask(@PathVariable int id) {
		 taskRepo.deleteById(id);
	}
	
	/**
	 * Returns logged in user Name
	 * @return
	 */
	private String getLoggedInUserName() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		return auth.getName();
	}
}
