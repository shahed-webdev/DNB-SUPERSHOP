﻿<%@ Page Title="Point & Service Charge Report" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Point_Report.aspx.cs" Inherits="DnbBD.AccessAdmin.Product_Point.Point_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/PointReport.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Point & Service Charge Report <small class="Date"></small></h3>

    <div class="form-inline NoPrint">
        <div class="form-group">
            <asp:TextBox ID="From_TextBox" placeholder="From Date" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false" runat="server" CssClass="datepicker form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="TO_TextBox" placeholder="To Date" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false" runat="server" CssClass="datepicker form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="FindButton" runat="server" CssClass="btn btn-primary" Text="Find" />
        </div>
    </div>


    <h4>POINT REPORT</h4>
    <div class="row">
        <div class="col-sm-6">
            <asp:FormView ID="PointFormView" runat="server" DataSourceID="PointSQL" Width="100%">
                <ItemTemplate>
                    <div class="statistic d-flex align-items-center bg-white has-shadow">
                        <div class="icon bg-red"><i class="fa fa-star"></i></div>
                        <div class="text">
                            <strong><%# Eval("Point","{0:N}") %></strong><br />
                            <small>Total Point</small>
                        </div>
                    </div>
                    <div class="statistic d-flex align-items-center bg-white has-shadow">
                        <div class="icon bg-green"><i class="fa fa-money"></i></div>
                        <div class="text">
                            <strong><%# Eval("Amount","{0:N}") %></strong>
                            <small>TK</small><br />
                            <small>Total Amount</small>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="PointSQL" runat="server" CancelSelectOnNullParameter="False" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT ISNULL(SUM(ShoppingAmount),0) AS Amount, ISNULL(SUM(ShoppingPoint),0) AS Point FROM Shopping WHERE ((ShoppingDate  BETWEEN ISNULL(@From_Date, '1-1-1000') AND ISNULL(@To_Date, '1-1-3000')))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="From_TextBox" Name="From_Date" PropertyName="Text" />
                    <asp:ControlParameter ControlID="TO_TextBox" Name="To_Date" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <div class="col-sm-6">
            <asp:FormView ID="MatchingFormView" runat="server" DataSourceID="MatchingSQL" Width="100%">
                <ItemTemplate>
                    <div class="statistic d-flex align-items-center bg-white has-shadow">
                        <div class="icon bg-MatchPoint"><i class="fa fa-star"></i></div>
                        <div class="text">
                            <strong><%# Eval("MatchPoint","{0:N}") %></strong><br />
                            <small>Matching Point</small>
                        </div>
                    </div>
                    <div class="statistic d-flex align-items-center bg-white has-shadow">
                        <div class="icon bg-FlashPoint"><i class="fa fa-star"></i></div>
                        <div class="text">
                            <strong><%# Eval("FlashPoint","{0:N}") %></strong><br />
                            <small>Flash Point</small>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="MatchingSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT ISNULL(SUM(Matching_Point),0) AS MatchPoint, ISNULL(SUM(Flash_Point),0) AS FlashPoint FROM Member_Bouns_Records_Infinity_Matching WHERE (CAST(Insert_Date AS DATE) BETWEEN ISNULL(@From_Date, '1-1-1000') AND ISNULL(@To_Date, '1-1-3000'))" CancelSelectOnNullParameter="False">
                <SelectParameters>
                    <asp:ControlParameter ControlID="From_TextBox" Name="From_Date" PropertyName="Text" />
                    <asp:ControlParameter ControlID="TO_TextBox" Name="To_Date" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>

    <asp:FormView ID="CarryFormView" runat="server" DataSourceID="CarrySQL" Width="100%">
        <ItemTemplate>
            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Left Carry Forward</th>
                                    <th>Right Carry Forward</th>
                                    <th>Total Carry Forward</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><%# Eval("TeamA","{0:N}") %></td>
                                    <td><%# Eval("TeamB","{0:N}") %></td>
                                    <td><%# Eval("Total","{0:N}") %></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="CarrySQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT SUM(Total_Left_Point) AS TeamA, SUM(Total_Right_Point) AS TeamB, SUM(Total_Left_Point + Total_Right_Point) AS Total FROM Member" CancelSelectOnNullParameter="False">
    </asp:SqlDataSource>


    <h4>Tax And Service Charge Report</h4>
    <asp:FormView ID="ServiceChargeFormView" runat="server" DataSourceID="Total_SChargeSQL" Width="100%">
        <ItemTemplate>
            <div class="row">
                <div class="col-md-4">
                    <div class="statistic d-flex align-items-center bg-white has-shadow">
                        <div class="icon bg-amount"><i class="fa fa-money"></i></div>
                        <div class="text">
                            <strong><%# Eval("Amount","{0:N}") %></strong>
                            <small>TK</small><br />
                            <small>Total Amount</small>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="statistic d-flex align-items-center bg-white has-shadow">
                        <div class="icon bg-service"><i class="fa fa-bar-chart"></i></div>
                        <div class="text">
                            <strong><%# Eval("Service_Charge","{0:N}") %></strong>
                            <small>TK</small><br />
                            <small>Tax & Service Charge</small>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="statistic d-flex align-items-center bg-white has-shadow">
                        <div class="icon bg-net"><i class="fa fa-bar-chart"></i></div>
                        <div class="text">
                            <strong><%# Eval("Net","{0:N}") %></strong>
                            <small>TK</small><br />
                            <small>Net Amount</small>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="Total_SChargeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT ISNULL(SUM(ALL_Table.Amount),0) AS Amount, ISNULL(SUM(ALL_Table.Tax_Service_Charge),0) AS Service_Charge, ISNULL(SUM(ALL_Table.Net),0) AS Net  FROM(
SELECT  SUM(ISNULL(Amount,0)) AS Amount, SUM(ISNULL(Tax_Service_Charge,0)) AS Tax_Service_Charge, SUM(ISNULL(Net_Amount,0)) AS Net  FROM Member_Bouns_Records_Infinity_Matching WHERE (CAST(Insert_Date AS DATE) BETWEEN ISNULL(@From_Date, '1-1-1000') AND ISNULL(@To_Date, '1-1-3000'))
union
SELECT SUM(ISNULL(Commission_Amount,0)) AS Amount, SUM(ISNULL(Tax_Service_Charge,0)) AS Tax_Service_Charge, SUM(ISNULL(Net_Amount,0)) AS Net  FROM  Member_Bouns_Records_Referral WHERE (CAST(Insert_Date AS DATE) BETWEEN ISNULL(@From_Date, '1-1-1000') AND ISNULL(@To_Date, '1-1-3000'))
union
SELECT SUM(ISNULL(Commission_Amount,0)) AS Amount,   SUM(ISNULL(Tax_Service_Charge,0)) AS Tax_Service_Charge, SUM(ISNULL(Net_Amount,0)) AS Net FROM Member_Bouns_Records_Gen_Retails WHERE (CAST(Insert_Date AS DATE) BETWEEN ISNULL(@From_Date, '1-1-1000') AND ISNULL(@To_Date, '1-1-3000'))) AS ALL_Table"
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="From_TextBox" Name="From_Date" PropertyName="Text" />
            <asp:ControlParameter ControlID="TO_TextBox" Name="To_Date" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <div class="card">
        <div class="card-body">
            <asp:Repeater ID="SChargeRepeater" runat="server" DataSourceID="BonusNetSQL">
                <HeaderTemplate>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Amount</th>
                                <th>Tax & Service Charge</th>
                                <th>Net</th>
                            </tr>
                        </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tbody>
                        <tr>
                            <td><%# Eval("NAME") %></td>
                            <td><%# Eval("Amount","{0:N}") %></td>
                            <td><%# Eval("Tax_Service_Charge","{0:N}") %></td>
                            <td><%# Eval("Net","{0:N}") %></td>
                        </tr>
                    </tbody>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </div>
    <asp:SqlDataSource ID="BonusNetSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT 'Duplex Commission' as NAME, ISNULL(SUM(Amount),0) AS Amount, ISNULL(SUM(Tax_Service_Charge),0) AS Tax_Service_Charge, ISNULL(SUM(Net_Amount),0) AS Net  FROM Member_Bouns_Records_Infinity_Matching WHERE (CAST(Insert_Date AS DATE) BETWEEN ISNULL(@From_Date, '1-1-1000') AND ISNULL(@To_Date, '1-1-3000'))
union
SELECT 'Reference &amp; Spot Commission' as NAME, ISNULL(SUM(Commission_Amount),0) AS Amount, ISNULL(SUM(Tax_Service_Charge),0) AS Tax_Service_Charge, ISNULL(SUM(Net_Amount),0) AS Net FROM  Member_Bouns_Records_Referral WHERE (CAST(Insert_Date AS DATE) BETWEEN ISNULL(@From_Date, '1-1-1000') AND ISNULL(@To_Date, '1-1-3000'))
union
SELECT 'Retail Commission' as NAME, ISNULL(SUM(Commission_Amount),0) AS Amount, ISNULL(SUM(Tax_Service_Charge),0) AS Tax_Service_Charge, ISNULL(SUM(Net_Amount),0) AS Net FROM Member_Bouns_Records_Gen_Retails WHERE (CAST(Insert_Date AS DATE) BETWEEN ISNULL(@From_Date, '1-1-1000') AND ISNULL(@To_Date, '1-1-3000'))"
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="From_TextBox" Name="From_Date" PropertyName="Text" />
            <asp:ControlParameter ControlID="TO_TextBox" Name="To_Date" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


    <script type="text/javascript">
        $(function () {
            $('.datepicker').datepicker({
                format: 'dd M yyyy',
                todayBtn: "linked",
                todayHighlight: true,
                autoclose: true
            });

            //get date in label
            var from = $("[id*=From_TextBox]").val();
            var To = $("[id*=TO_TextBox]").val();

            var tt;
            var Brases1 = "";
            var Brases2 = "";
            var A = "";
            var B = "";
            var TODate = "";

            if (To == "" || from == "" || To == "" && from == "") {
                tt = "";
                A = "";
                B = "";
            }
            else {
                tt = " To ";
                Brases1 = "(";
                Brases2 = ")";
            }

            if (To == "" && from == "") { Brases1 = ""; }

            if (To == from) {
                TODate = "";
                tt = "";
                var Brases1 = "";
                var Brases2 = "";
            }
            else { TODate = To; }

            if (from == "" && To != "") {
                B = " Before ";
            }

            if (To == "" && from != "") {
                A = " After ";
            }

            if (from != "" && To != "") {
                A = "";
                B = "";
            }

            $(".Date").text(Brases1 + B + A + from + tt + TODate + Brases2);
        });

        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
    </script>
</asp:Content>
