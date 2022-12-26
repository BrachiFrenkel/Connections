using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.Net.Mail;
using System.IO;


namespace Connections
{
  class Program
  {
    static void Main(string[] args)
    {

      using (connectionsEntities db = new connectionsEntities())
      {
        string sub = "";
        string msg = File.ReadAllText("MailTemplate.html");

        foreach (var item in db.viewAllMach)
        {

          //if (item.TimeInDay.Hour == (DateTime.Now.Hour - 1) && (item.DayInWeek == Convert.ToInt32(DateTime.Today.DayOfWeek)) && item.machIsActive && item.requestIsActive)
          //{

          request r = db.request.FirstOrDefault(x => x.ID == item.RequestId2);
          users user2 = db.users.FirstOrDefault(x => x.ID == r.UserID);

          msg = msg.Replace("@NAME", item.FirstName.Trim() + " " + item.LastName.Trim());
          msg = msg.Replace("@VERB", item.VerbName.Trim());
          msg = msg.Replace("@PARTNER", user2.FirstName.Trim() + " " + user2.LastName.Trim());
          //mess = "\n" + "שלום " + item.FirstName.Trim() + " " + item.LastName.Trim() + ",\n"
          //    + "רצינו להזכיר לך שקבעת " + item.VerbName.Trim() + " עם" + user2.FirstName + " " + user2.LastName;
          sub = "תזכורת למפגש";
          Send(item.Email, sub, msg);
          //}
        }
      }

    }



    public static void Send(string toEmail, string subject, string message)
    {

      string your_id = "connectionsramatshlomo@gmail.com";//חשבון ג'ימייל 
      string your_password = "1234567890ramatshlomo";//סיסמה
      try
      {
        SmtpClient client = new SmtpClient("smtp.gmail.com", 587);
        client.EnableSsl = true;
        client.DeliveryMethod = SmtpDeliveryMethod.Network;
        client.UseDefaultCredentials = false;
        client.Credentials = new NetworkCredential(your_id, your_password);
        //from - כתובת המייל ממנה נשלח המייל
        //to - כתובת המייל אליה שולחים את המייל
        //subject - נושא המייל
        //message - html-תוכן המייל. ניתן לבנות כ
        MailMessage mm = new MailMessage(your_id, toEmail, subject, message);
        mm.IsBodyHtml = true;
        client.Send(mm);
      }
      catch (Exception e)
      {
        throw e;
      }
    }

  }
}



