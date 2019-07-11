package com.data.control;

import javax.servlet.http.HttpServletRequest;

import com.data.dao.UserDao;
import com.data.model.User;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.Logger;

@Controller
@RequestMapping(value = "/user")
public class UserController {


    @Autowired
    private UserDao userdao;



    @ResponseBody
    @RequestMapping(value = "/showUser.do",method = RequestMethod.POST)
    public String showUser(HttpServletRequest request, HttpServletResponse res) throws Exception{
        /*Integer userId = Integer.parseInt(request.getParameter("id"));*/
        System.out.println("-------------------------------------------------");
        res.setContentType("text/html;charset=UTF-8");
        List<User> list = userdao.findAll();
        for(User user:list){
            user.setCreate_date(user.getCreate_date().toString());
        }
        JSONArray jsonArray = JSONArray.fromObject(list);
        res.reset();
        PrintWriter out = res.getWriter();
        out.println(jsonArray);
        out.flush();
        out.close();
        return null;
    }

    @RequestMapping(value = "/deleteData.do",method = RequestMethod.POST)
    public String deleteData(@RequestParam(value = "ids")String ids, HttpServletResponse response) {
        String dataIds[] = ids.split(",");
        JSONObject json = new JSONObject();
        for (String dataId : dataIds){
            Integer id = Integer.parseInt(dataId);
            try{
                userdao.deleteData(id);
                json.put("success",true);
            }catch (Exception e){
                json.put("success", false);
                e.printStackTrace();
            }
            try{
                PrintWriter out = response.getWriter();
                out.println(json);
                out.flush();
                out.close();
            }catch (Exception e){
               e.printStackTrace();
            }

        }
        return null;
    }

    @RequestMapping(value = "/saveData.do",method = RequestMethod.POST)
    public String saveData(HttpServletResponse res, User user) throws Exception{
        Date date = new Date();
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String now = format.format(date);
        user.setCreate_date(now);
        JSONObject json = new JSONObject();
        try {
            userdao.save(user);
            json.put("success",true);
        }catch (Exception e){
            json.put("success",false);
            e.printStackTrace();
            System.out.println(e.toString());
        }
        res.reset();
        PrintWriter out = res.getWriter();
        out.println(json);
        out.flush();
        out.close();
        return null;
    }

    @RequestMapping(value = "updateData.do", method=RequestMethod.POST)
    public void updateDate(HttpServletResponse res,User user){
        JSONObject json = new JSONObject();
        try{
            userdao.updateData(user);
            System.out.println(user.getId());
            json.put("success",true);
        }catch (Exception e){
            json.put("success",false);
            e.printStackTrace();
        }
        res.reset();
        try{
            PrintWriter out = res.getWriter();
            out.println(json);
            out.flush();
            out.close();
        }catch (Exception e){
            e.printStackTrace();
        }

    }

}