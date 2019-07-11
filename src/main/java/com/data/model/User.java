package com.data.model;

import java.util.Date;

public class User {
    private Integer id;				//活动ID
    private String create_date;		//创建时间
    private Integer plan_send_num;	//计划派数量
    private Integer send_num;		//已找到的数据量（不需要填写）
    private String latn_name;		//地州名称
    private String area_id;			//地州所对应的区县
    private String tsp_name;		//运营商
    private String call_lang;		//语言
    private Integer age_min;		//最小年龄
    private Integer age_max;		//最大年龄
    private Integer avg_min_fee;	//最低消费
    private Integer avg_max_fee;	//最高消费
    private Integer avg_stream;		//平均流量
    private String send_type;		//常规派数，还是专项活动
    private String active_name;		//活动名称
    private String staff_type;		//派单岗位
    private String staff_id;		//派单工号
    private String sheet_chnl;		//渠道名称
    private Integer is_complete;	//是否完成派送：1完成，0：未完成
    private Integer is_force;		//是否强制派送

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCreate_date() {
        return create_date;
    }

    public void setCreate_date(String create_date) {
        this.create_date = create_date;
    }

    public Integer getPlan_send_num() {
        return plan_send_num;
    }

    public void setPlan_send_num(Integer plan_send_num) {
        this.plan_send_num = plan_send_num;
    }

    public Integer getSend_num() {
        return send_num;
    }

    public void setSend_num(Integer send_num) {
        this.send_num = send_num;
    }

    public String getLatn_name() {
        return latn_name;
    }

    public void setLatn_name(String latn_name) {
        this.latn_name = latn_name;
    }

    public String getArea_id() {
        return area_id;
    }

    public void setArea_id(String area_id) {
        this.area_id = area_id;
    }

    public String getTsp_name() {
        return tsp_name;
    }

    public void setTsp_name(String tsp_name) {
        this.tsp_name = tsp_name;
    }

    public String getCall_lang() {
        return call_lang;
    }

    public void setCall_lang(String call_lang) {
        this.call_lang = call_lang;
    }

    public Integer getAge_min() {
        return age_min;
    }

    public void setAge_min(Integer age_min) {
        this.age_min = age_min;
    }

    public Integer getAge_max() {
        return age_max;
    }

    public void setAge_max(Integer age_max) {
        this.age_max = age_max;
    }

    public Integer getAvg_min_fee() {
        return avg_min_fee;
    }

    public void setAvg_min_fee(Integer avg_min_fee) {
        this.avg_min_fee = avg_min_fee;
    }

    public Integer getAvg_max_fee() {
        return avg_max_fee;
    }

    public void setAvg_max_fee(Integer avg_max_fee) {
        this.avg_max_fee = avg_max_fee;
    }

    public Integer getAvg_stream() {
        return avg_stream;
    }

    public void setAvg_stream(Integer avg_stream) {
        this.avg_stream = avg_stream;
    }

    public String getSend_type() {
        return send_type;
    }

    public void setSend_type(String send_type) {
        this.send_type = send_type;
    }

    public String getActive_name() {
        return active_name;
    }

    public void setActive_name(String active_name) {
        this.active_name = active_name;
    }

    public String getStaff_type() {
        return staff_type;
    }

    public void setStaff_type(String staff_type) {
        this.staff_type = staff_type;
    }

    public String getStaff_id() {
        return staff_id;
    }

    public void setStaff_id(String staff_id) {
        this.staff_id = staff_id;
    }

    public String getSheet_chnl() {
        return sheet_chnl;
    }

    public void setSheet_chnl(String sheet_chnl) {
        this.sheet_chnl = sheet_chnl;
    }

    public Integer getIs_complete() {
        return is_complete;
    }

    public void setIs_complete(Integer is_complete) {
        this.is_complete = is_complete;
    }

    public Integer getIs_force() {
        return is_force;
    }

    public void setIs_force(Integer is_force) {
        this.is_force = is_force;
    }

}