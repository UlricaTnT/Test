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
            while (true)
            {
                Console.WriteLine("Please enter postfix expression:");
                string input = Console.ReadLine();
                if (string.IsNullOrEmpty(input))
                {
                    return;
                }
                Console.WriteLine("Output:");
                Console.WriteLine(PostfixToInfix(input));
            }
        }

        /// <summary>
        /// PostfixToInfix
        /// </summary>
        /// <param name="postfix"></param>
        /// <returns></returns>
        static string PostfixToInfix(string postfix)
        {
            var postfixTokens = postfix.ToCharArray();

            //创建用于保存中间中缀表达式的堆栈
            var stack = new Stack<Intermediate>();

            foreach (char charset in postfixTokens)
            {
                string token = charset.ToString();
                if (token == "+" || token == "-" ||token == "*" || token == "/"|| token == "^")
                {
                    var rightIntermediate = stack.Pop();
                    var leftIntermediate = stack.Pop();
                    var newExpr = "(" + leftIntermediate.Expr + token + rightIntermediate.Expr + ")";

                    stack.Push(new Intermediate(newExpr, token));
                }
                
                else
                {
                    stack.Push(new Intermediate(token, ""));
                }
            }
            return stack.Peek().Expr;
        }
    }
    public class Intermediate
    {
        public string Expr;     // 子表达式字符串
        public string Oper;     // the operator used to create this expression

        public Intermediate(string expr, string oper)
        {
            this.Expr = expr;
            this.Oper = oper;
        }
    }
}
