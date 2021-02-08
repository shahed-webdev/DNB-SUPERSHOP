﻿<%@ Page Title="Sub-Admin Page Access" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Manage_Sub_Admin_Access.aspx.cs" Inherits="DnbBD.AccessAdmin.Sub_Admin.Manage_Sub_Admin_Access" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .mGrid { text-align: left; }
        .mGrid th { text-align: left; padding: 4px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Manage Sub-Admin Page Access</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:DropDownList ID="UserListDropDownList" runat="server" DataSourceID="UserListSQL" DataTextField="Name" DataValueField="UserName" AppendDataBoundItems="True" AutoPostBack="True" CssClass="form-control" OnSelectedIndexChanged="UserListDropDownList_SelectedIndexChanged">
                <asp:ListItem Value="0">[ Select Sub-admin ]</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserListDropDownList" CssClass="EroorStar" ErrorMessage="Select Sub-Admin" InitialValue="0" ValidationGroup="A"></asp:RequiredFieldValidator>
            <asp:SqlDataSource ID="UserListSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Name + '(' + UserName + ')' AS Name, UserName FROM Registration WHERE (Category = @Category) AND (Validation = @Validation)" ProviderName="<%$ ConnectionStrings:DBConnectionString.ProviderName %>">
                <SelectParameters>
                    <asp:Parameter DefaultValue="Sub-Admin" Name="Category" />
                    <asp:Parameter DefaultValue="Valid" Name="Validation" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>

    <div class="alert-info">Add more or remove access pages for sub-admin</div>
    <asp:GridView runat="server" AutoGenerateColumns="False" DataKeyNames="LinkID,RoleName" DataSourceID="LinkPageSQL" ID="LinkGridView" OnDataBound="LinkGridView_DataBound"
        PagerStyle-CssClass="pgr" CssClass="mGrid">
        <AlternatingRowStyle CssClass="alt" />
        <Columns>
            <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category"></asp:BoundField>
            <asp:BoundField DataField="SubCategory" HeaderText="Sub Category" SortExpression="SubCategory"></asp:BoundField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:CheckBox ID="AllCheckBox" runat="server" Text="Page Title (Allow Selected Pages)" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="LinkCheckBox" runat="server" Text='<%#Bind("PageTitle") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>

        <PagerStyle CssClass="pgr"></PagerStyle>
    </asp:GridView>

    <asp:SqlDataSource ID="LinkPageSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Link_Pages.LinkID, Link_Pages.LinkCategoryID, Link_Pages.SubCategoryID, Link_Pages.PageURL, Link_Pages.PageTitle, Link_SubCategory.SubCategory, Link_Category.Category, aspnet_Roles.RoleName FROM Link_Pages LEFT OUTER JOIN aspnet_Roles ON Link_Pages.RoleId = aspnet_Roles.RoleId LEFT OUTER JOIN Link_SubCategory ON Link_Pages.SubCategoryID = Link_SubCategory.SubCategoryID LEFT OUTER JOIN Link_Category ON Link_Pages.LinkCategoryID = Link_Category.LinkCategoryID ORDER BY Link_Category.Ascending, Link_SubCategory.Ascending" ProviderName="<%$ ConnectionStrings:DBConnectionString.ProviderName %>"></asp:SqlDataSource>
    <br />
    <asp:Button ID="UpdateButton" runat="server" CssClass="btn btn-primary" OnClick="UpdateButton_Click" Text="Update" ValidationGroup="A" />
    <asp:SqlDataSource ID="UpdateLinkSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        DeleteCommand="DELETE FROM Link_Users WHERE (LinkID = @LinkID) AND (UserName = @UserName)" InsertCommand="IF NOT EXISTS (SELECT * FROM  [Link_Users] WHERE  LinkID=@LinkID and UserName=@UserName)
     INSERT INTO [Link_Users] ([InstitutionID], [RegistrationID], [LinkID], [UserName]) VALUES (@InstitutionID, @RegistrationID, @LinkID, @UserName)"
        SelectCommand="SELECT * FROM [Link_Users]" ProviderName="<%$ ConnectionStrings:DBConnectionString.ProviderName %>">
        <DeleteParameters>
            <asp:Parameter Name="LinkID" />
            <asp:ControlParameter ControlID="UserListDropDownList" Name="UserName" PropertyName="SelectedValue" />
        </DeleteParameters>
        <InsertParameters>
            <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" />
            <asp:ControlParameter ControlID="UserListDropDownList" Name="UserName" PropertyName="SelectedValue" Type="String" />
            <asp:Parameter Name="LinkID" Type="Int32" />
            <asp:Parameter Name="RegistrationID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

    <script>
        $("[id*=AllCheckBox]").on("click", function () {
            var a = $(this), b = $(this).closest("table");
            $("input[type=checkbox]", b).each(function () {
                a.is(":checked") ? ($(this).attr("checked", "checked"), $("td", $(this).closest("tr")).addClass("selected")) : ($(this).removeAttr("checked"), $("td", $(this).closest("tr")).removeClass("selected"));
            });
        });

        //Add or Remove CheckBox Selected Color
        $("[id*=LinkCheckBox]").on("click", function () {
            $(this).is(":checked") ? ($("td", $(this).closest("tr")).addClass("selected")) : ($("td", $(this).closest("tr")).removeClass("selected"), $($(this).closest("tr")).removeClass("selected"));
        });
    </script>
</asp:Content>
