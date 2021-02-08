﻿using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace DnbBD.Handler
{
    /// <summary>
    /// Summary description for Home_Products
    /// </summary>
    public class Home_Products : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT Product_Image from Home_Product where ProductID =" + context.Request.QueryString["Img"] + "", con);
            SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);

            if (reader.Read())
            {
                if (reader.GetValue(0) != DBNull.Value)
                    context.Response.BinaryWrite((Byte[])reader.GetValue(0));
            }

            reader.Close();
            context.Response.End();
            con.Close();
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