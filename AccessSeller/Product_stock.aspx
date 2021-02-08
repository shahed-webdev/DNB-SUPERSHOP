﻿<%@ Page Title="Stock Details" Language="C#" MasterPageFile="~/Seller.Master" AutoEventWireup="true" CodeBehind="Product_stock.aspx.cs" Inherits="DnbBD.AccessSeller.Product_stock" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .Box { color: #fff; padding: 15px; font-size:15px; margin-bottom:15px; }
         .Box h5 { font-size:20px;}

        .Total_Stock { background-color: #2F4254; }
        .Total_Price { background-color: #6F196E; }
        .Total_Point { background-color: #F39C12; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Product Stock</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:TextBox ID="FindTextBox" placeholder="Find By Code , Name" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="FindButton" runat="server" CssClass="btn btn-primary" Text="Find" />
        </div>
    </div>

    <asp:FormView ID="Stock_FormView" runat="server" DataSourceID="StockSQL" Width="100%">
        <ItemTemplate>
            <div class="row text-center">
                <div class="col-sm-4">
                    <div class="Total_Stock Box">
                        <h5><%# Eval("Total_Stock") %></h5>
                        <small>STOCK QUANTITY</small>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="Total_Price Box">
                        <h5><%# Eval("Total_Price") %> Tk</h5>
                        <small>TOTAL PRICE</small>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="Total_Point Box">
                        <h5><%# Eval("Total_Point") %></h5>
                        <small>TOTAL POINT</small>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="StockSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT SUM(Seller_Product.SellerProduct_Stock) AS Total_Stock, SUM(Seller_Product.SellerProduct_Stock * Product_Point_Code.Product_Point) AS Total_Point, SUM(Seller_Product.SellerProduct_Stock * Product_Point_Code.Product_Price) AS Total_Price FROM Seller_Product INNER JOIN Product_Point_Code ON Seller_Product.Product_PointID = Product_Point_Code.Product_PointID WHERE (Seller_Product.SellerID = @SellerID)">
        <SelectParameters>
            <asp:SessionParameter Name="SellerID" SessionField="SellerID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <div class="table-responsive">
        <asp:GridView ID="ProductStockGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="ProductStockSQL" AllowSorting="True">
            <Columns>
                <asp:BoundField DataField="Product_Code" HeaderText="Code" SortExpression="Product_Code" />
                <asp:BoundField DataField="Product_Name" HeaderText="Name" SortExpression="Product_Name" />
                <asp:BoundField DataField="SellerProduct_Stock" HeaderText="Quantity" SortExpression="SellerProduct_Stock" />
                <asp:BoundField DataField="Product_Point" HeaderText="Unit Point" SortExpression="Product_Point" />
                <asp:BoundField DataField="Product_Price" HeaderText="Unit Price" SortExpression="Product_Price" />
                <asp:BoundField DataField="Total_Point" HeaderText="Total Point" SortExpression="Total_Point" />
                <asp:BoundField DataField="Total_Price" HeaderText="Total Price" SortExpression="Total_Price" />
            </Columns>
            <EmptyDataTemplate>
                No Stock Available
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="ProductStockSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Seller_Product.Product_PointID, Seller_Product.SellerProduct_Stock, Product_Point_Code.Product_Name, Product_Point_Code.Product_Code, Product_Point_Code.Product_Point, Product_Point_Code.Product_Price, Seller_Product.SellerProduct_Stock * Product_Point_Code.Product_Point AS Total_Point, Seller_Product.SellerProduct_Stock * Product_Point_Code.Product_Price AS Total_Price FROM Seller_Product INNER JOIN Product_Point_Code ON Seller_Product.Product_PointID = Product_Point_Code.Product_PointID WHERE (Seller_Product.SellerID = @SellerID) AND (Seller_Product.SellerProduct_Stock &lt;&gt; 0) ORDER BY Seller_Product.SellerProduct_Stock DESC"
            FilterExpression="Product_Name LIKE '{0}%' OR Product_Code LIKE '{0}%'" CancelSelectOnNullParameter="False">
            <FilterParameters>
                <asp:ControlParameter ControlID="FindTextBox" Name="Find" PropertyName="Text" />
            </FilterParameters>
            <SelectParameters>
                <asp:SessionParameter Name="SellerID" SessionField="SellerID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>

    <script>
        $(document).ready(function () {
            $("#Stock").addClass('L_Active');
        });
    </script>
</asp:Content>
