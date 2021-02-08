﻿<%@ Page Title="Product Buying Records" Language="C#" MasterPageFile="~/Member.Master" AutoEventWireup="true" CodeBehind="Product_Buying_Records.aspx.cs" Inherits="DnbBD.AccessMember.Product_Buying_Records" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <style>
        .mGrid td table td { text-align: right; border: none; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Product Buying Records</h3>
    <div class="NoPrint form-inline">
        <div class="form-group">
            <asp:TextBox ID="From_TextBox" placeholder="From Date" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false" runat="server" CssClass="form-control datepicker"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="TO_TextBox" placeholder="To Date" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false" runat="server" CssClass="form-control datepicker"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="FindButton" runat="server" CssClass="btn btn-primary" Text="Find" />
        </div>
    </div>
 
    <div class="table-responsive">
        <asp:GridView ID="Sellingeport_GridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="ShoppingID" DataSourceID="SellingeportSQL" AllowPaging="True" PageSize="50">
            <Columns>
                <asp:BoundField DataField="Shopping_SN" HeaderText="Receipt No" InsertVisible="False" ReadOnly="True" SortExpression="Shopping_SN" />
                <asp:TemplateField HeaderText="Details">
                    <ItemTemplate>
                        <asp:DataList ID="RecordsDataList" runat="server" DataSourceID="Selling_RecordsSQL" Width="100%">
                            <ItemTemplate>
                                <asp:Label ID="Product_NameLabel" runat="server" Text='<%# Eval("Product_Name") %>' Font-Bold="True" ForeColor="#009933" />
                                <br />
                                Quantity:
                     <asp:Label ID="SellingQuantityLabel" runat="server" Text='<%# Eval("SellingQuantity") %>' />
                                <br />
                                Unit Price:
                     <asp:Label ID="SellingUnitPriceLabel" runat="server" Text='<%# Eval("SellingUnitPrice") %>' />
                                <br />
                                Unit Point:
                     <asp:Label ID="SellingUnitPointLabel" runat="server" Text='<%# Eval("SellingUnitPoint") %>' />
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:HiddenField ID="ShoppingID_HF" runat="server" Value='<%# Eval("ShoppingID") %>' />
                        <asp:SqlDataSource ID="Selling_RecordsSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Product_Selling_Records.SellingQuantity, Product_Selling_Records.SellingUnitPrice, Product_Selling_Records.SellingUnitPoint, Product_Point_Code.Product_Name, Product_Point_Code.Product_Code FROM Product_Selling_Records INNER JOIN Product_Point_Code ON Product_Selling_Records.ProductID = Product_Point_Code.Product_PointID WHERE (Product_Selling_Records.ShoppingID = @ShoppingID)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ShoppingID_HF" Name="ShoppingID" PropertyName="Value" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ShoppingAmount" HeaderText="Total Amount" SortExpression="ShoppingAmount" />
                <asp:BoundField DataField="ShoppingPoint" HeaderText="Total Point" SortExpression="ShoppingPoint" />
                <asp:BoundField DataField="ShoppingDate" HeaderText="Date" SortExpression="ShoppingDate" DataFormatString="{0:d MMM yyyy}" />
            </Columns>
            <EmptyDataTemplate>
                No Records
            </EmptyDataTemplate>
            <PagerStyle CssClass="pgr" />
        </asp:GridView>
        <asp:SqlDataSource ID="SellingeportSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT ShoppingID, Shopping_SN, ShoppingAmount, ShoppingPoint, ShoppingDate FROM Shopping WHERE (CAST(ShoppingDate AS DATE) BETWEEN ISNULL(@From_Date, '1-1-1000') AND ISNULL(@To_Date, '1-1-3000')) AND (MemberID = @MemberID)" CancelSelectOnNullParameter="False">
            <SelectParameters>
                <asp:ControlParameter ControlID="From_TextBox" Name="From_Date" PropertyName="Text" />
                <asp:ControlParameter ControlID="TO_TextBox" Name="To_Date" PropertyName="Text" />
                <asp:SessionParameter Name="MemberID" SessionField="MemberID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>

    <script>
        $(function () {
            $("#Product").addClass('L_Active');

            $('.datepicker').datepicker({
                format: 'dd M yyyy',
                todayBtn: "linked",
                todayHighlight: true,
                autoclose: true
            });
        });
    </script>
</asp:Content>
