using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp2
{
    public class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Please enter postfix expression:");
            string input = Console.ReadLine();
            Console.WriteLine("Output:");
            Console.WriteLine(PostfixToInfix(input));
            Console.ReadKey();
        }

        /// <summary>
        /// PostfixToInfix
        /// </summary>
        /// <param name="postfix"></param>
        /// <returns></returns>
        static string PostfixToInfix(string postfix)
        {
            //假设：要处理的后缀表达式是空格分隔的。
            //将各个令牌拆分为数组进行处理
            //var postfixTokens = postfix.Split(' ');
            var postfixTokens = postfix.ToCharArray();
            //var postfixTokens = postfix.ToCharArray();

            //创建用于保存中间中缀表达式的堆栈
            var stack = new Stack<Intermediate>();

            foreach (char charset in postfixTokens)
            {
                string token = charset.ToString();
                if (token == "+" || token == "-")
                {
                    //从堆栈获取左右操作数。
                    //请注意，由于+和 - 是最低优先级运算符，
                    //我们不必在操作数中添加任何括号。
                    var rightIntermediate = stack.Pop();
                    var leftIntermediate = stack.Pop();

                    //通过组合左和右构造新的中间表达式
                    //使用运算符（令牌）的表达式。
                    var newExpr = "(" + leftIntermediate.expr + token + rightIntermediate.expr + ")";

                    //在堆栈上推新的中间表达式
                    stack.Push(new Intermediate(newExpr, token));
                }
                else if (token == "*" || token == "/")
                {
                    string leftExpr, rightExpr;

                    //从堆栈获取中间表达式。
                    //如果使用较低的先例构建中间表达式
                    //运算符（+或 - ），我们必须在其周围放置圆括号来确保
                    //评估的正确顺序。

                    var rightIntermediate = stack.Pop();
                    if (rightIntermediate.oper == "+" || rightIntermediate.oper == "-")
                    {
                        rightExpr = rightIntermediate.expr;
                    }
                    else
                    {
                        rightExpr = rightIntermediate.expr;
                    }

                    var leftIntermediate = stack.Pop();
                    if (leftIntermediate.oper == "+" || leftIntermediate.oper == "-")
                    {
                        leftExpr = leftIntermediate.expr;
                    }
                    else
                    {
                        leftExpr = leftIntermediate.expr;
                    }

                    //通过组合左和右构造新的中间表达式
                    //使用运算符（令牌）。
                    var newExpr = "(" + leftExpr + token + rightExpr + ")";

                    //在堆栈上推新的中间表达式
                    stack.Push(new Intermediate(newExpr, token));
                }
                else
                {
                    //必须是一个数字。 把它推到堆栈上。
                    stack.Push(new Intermediate(token, ""));
                }
            }
            //上面的循环留下堆栈顶部的最后一个表达式。
            return stack.Peek().expr;
        }
    }
    public class Intermediate
    {
        public string expr;     // 子表达式字符串
        public string oper;     // the operator used to create this expression

        public Intermediate(string expr, string oper)
        {
            this.expr = expr;
            this.oper = oper;
        }
    }
}
