package com.deloitte.online.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.deloitte.online.model.Task;

public interface TaskRepo extends JpaRepository<Task, Integer>{
	   List<Task> findByUsername( String username);
}
