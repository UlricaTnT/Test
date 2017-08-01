using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LoginWeb.ASHX
{
    /// <summary>
    /// Login 的摘要说明
    /// </summary>
    public class Login : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            //接收传递过来的用户名和密码
            string name = context.Request["name"];
            string pwd = context.Request["pwd"];
            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(pwd))
            {
                context.Response.Write("2");
            }
            else
            {
                if (name == "admin" && pwd == "admin")
                {
                    //用户名和密码正确，保存到cookie中
                    context.Response.Cookies["name"].Value = name;
                    context.Response.Cookies["pwd"].Value = pwd;
                    //设定cookie过期时间为2小时
                    context.Response.Cookies["name"].Expires = DateTime.Now.AddHours(2);
                    context.Response.Cookies["pwd"].Expires = DateTime.Now.AddHours(2);
                    context.Response.Write("1");
                }
                else
                {
                    context.Response.Write("2");
                }
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}