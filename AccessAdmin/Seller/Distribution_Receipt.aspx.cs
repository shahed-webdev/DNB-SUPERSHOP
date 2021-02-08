﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DnbBD.AccessAdmin.Seller
{
    public partial class Distribution_Receipt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (string.IsNullOrEmpty(Request.QueryString["Distribution"]))
            {
                Response.Redirect("Product_Distribution.aspx");
            }
        }
    }
}