using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace Login
{
    public class POST
    {
        /// <summary>
        /// 获取POST请求后响应的数据
        /// </summary>
        /// <param name="postURL">请求地址</param>
        /// <param name="referURL">请求引用地址</param>
        /// <param name="data">请求带的参数</param>
        /// <returns></returns>
        public string PostLogin(string postURL,string referURL,string data)
        {
            string result = "";
            try
            {
                //创建一个新的webRequest实例
                HttpWebRequest request = WebRequest.Create(postURL) as HttpWebRequest;
                //封装请求报文中的参数
                request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8";
                request.Referer = referURL;
                request.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36";
                request.ContentType = "application/x-www-form-urlencoded; charset=UTF-8";
                request.Method = "POST";
                request.KeepAlive = false;//取消常连接
                request.Headers.Add("Accept-Encoding", "gzip, deflate, br");
                //请求消息正文的长度
                request.ContentLength = data.Length;
                //获取用于写请求报文的对象
                Stream postStream = request.GetRequestStream();
                byte[] postData = Encoding.UTF8.GetBytes(data);
                //将消息正文写入请求流
                postStream.Write(postData, 0, postData.Length);
                postStream.Dispose();//释放资源

                //通过请求获取响应
                HttpWebResponse response = request.GetResponse() as HttpWebResponse;
                //判断响应的信息是否为压缩信息，若为压缩信息，则解压后返回
                if (response.ContentEncoding=="gzip")
                {
                    MemoryStream ms = new MemoryStream();
                    GZipStream zip = new GZipStream(response.GetResponseStream(), CompressionMode.Decompress);
                    byte[] buffer = new byte[1024];
                    int len = zip.Read(buffer, 0, buffer.Length);
                    while (len>0)
                    {
                        ms.Write(buffer, 0, len);
                        len = zip.Read(buffer, 0, buffer.Length);
                    }
                    ms.Dispose();
                    zip.Dispose();
                    result = Encoding.UTF8.GetString(ms.ToArray());
                }
                return result;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
