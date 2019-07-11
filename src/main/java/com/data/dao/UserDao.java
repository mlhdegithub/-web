package com.data.dao;

import com.data.model.User;

import java.util.List;


public interface UserDao {

    List<User> findAll();

    void deleteData(Integer id);

    void save(User user);

    void updateData(User user);
}