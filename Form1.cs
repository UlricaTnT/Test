using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Login
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            //获取用户在文本框中输入的用户名和密码
            string name = this.txtUserName.Text.Trim();
            string pwd = this.txtPwd.Text.Trim();
            StringBuilder sb = new StringBuilder();
            sb.AppendFormat("name={0}&pwd={1}", name, pwd);
            POST post = new POST();
            string result = post.PostLogin("http://localhost:2030/ASHX/Login.ashx","",sb.ToString());//将用户名和密码通过参数的形式传递给一般处理程序
            switch (result)
            {
                case "1":MessageBox.Show("登录成功");
                    break;
                case "2":MessageBox.Show("登录失败");
                    break;
                default:MessageBox.Show("登录参数错误");
                    break;
            }

        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
