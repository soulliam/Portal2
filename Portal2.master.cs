using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.DirectoryServices.AccountManagement;
using System.Security.Principal;
using System.DirectoryServices;

public partial class Portal2 : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        loginLabel.Text = Page.User.Identity.Name;
        txtLoggedinUsername.Value = Page.User.Identity.Name;

       

        if (HttpContext.Current.User.Identity.IsAuthenticated)
        {
            Page.Title = "Home page for " + HttpContext.Current.User.Identity.Name;
        }
        else
        {
            Page.Title = "Home page for guest user.";
        }

        IPrincipal userPrincipal = HttpContext.Current.User;
        WindowsIdentity windowsId = userPrincipal.Identity as WindowsIdentity;
        if (windowsId != null)
        {
            SecurityIdentifier sid = windowsId.User;

            using (DirectoryEntry userDe = new DirectoryEntry("LDAP://<SID=" + sid.Value + ">"))
            {
                Guid objectGuid = new Guid(userDe.NativeGuid);

                //userGuid.Text = Convert.ToString(objectGuid);
            }
        }


    }
}
