using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ConnectionsWebApi.Controllers
{
    public class HomeController : Controller
    {

        //https://localhost:44362/home/GetUserNameByUnique?uniqueID=1B2AC001-D56B-451E-A794-0AFB02E03B0D
        [System.Web.Http.HttpGet]
        public string GetUserNameByUnique(string uniqueID)
        {
            try
            {
                users user = new users();
                using (connectionsEntities db = new connectionsEntities())
                {
                    user = db.users.FirstOrDefault(x => x.UniqeID == uniqueID);
                }
                if (user != null)
                    return user.FirstName + " " + user.LastName;
                return string.Empty;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //https://localhost:44362/home/AddUser?FirstName=MOSHE&LastName=cohen&Gender=0&Email=y0583254741@gmail.com&Phone=0583254245
        [System.Web.Http.HttpGet]
        public void AddUser(string firstName, string lastName, int gender, string email, string phone)
        {

            users user = new users();
            user.FirstName = firstName;
            user.LastName = lastName;
            user.Gender = gender;
            user.Email = email;
            user.Phone = phone;

            user.UniqeID = Guid.NewGuid().ToString();
            using (connectionsEntities db = new connectionsEntities())
            {
                db.users.Add(user);
                db.SaveChanges();
            }
        }

        //https://localhost:44362/home/Addrequest?UserID=3&DayInWeek=2&TimeInDay=16:00&EventID=2
        [System.Web.Http.HttpGet]
        public void AddRequest(int userId, int dayInWeek, DateTime timeInDay, int eventId)
        {
            request req = new request();
            req.UserID = userId;
            req.DayInWeek = dayInWeek;
            req.TimeInDay = timeInDay;
            req.EventID = eventId;
            req.IsActive = true;
            req.CreateDate = DateTime.Now;
            req.CreateDate = DateTime.Now;
            req.UpdateDate = DateTime.Now;

            using (connectionsEntities db = new connectionsEntities())
            {
                db.request.Add(req);
                db.SaveChanges();
            }
        }


        //https://localhost:44362/home/Addmach?RequestId1=3&RequestId2=6
        [System.Web.Http.HttpGet]
        public void AddMach(int requestId1, int requestId2)
        {
            mach match = new mach();
            match.RequestId1 = requestId1;
            match.RequestId2 = requestId2;
            match.Length = 1;
            match.IsActive = true;
            match.CreateDate = DateTime.Now;
            match.UpdateDate = DateTime.Now;

            using (connectionsEntities db = new connectionsEntities())
            {
                db.mach.Add(match);
                db.SaveChanges();
            }
        }

        //https://localhost:44362/home/DeleteMach?ID=4
        [System.Web.Http.HttpGet]
        public void DeleteMach(int ID)
        {
            using (connectionsEntities db = new connectionsEntities())
            {
                mach Mach = db.mach.FirstOrDefault(x => x.ID == ID);
                if (Mach != null)
                {
                    Mach.IsActive = false;
                    Mach.UpdateDate = DateTime.Now;
                    db.SaveChanges();
                }
            }

        }
    



    JsonSerializerSettings settings = new JsonSerializerSettings()
        {
            ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
            Error = (sender, args) =>
            {
                args.ErrorContext.Handled = true;
            },
        };
        public ActionResult Index()
        {
            ViewBag.Title = "Home Page";

            return View();
        }

        //https://localhost:44362/home/GetUserNameByUnique?uniqueID=1B2AC001-D56B-451E-A794-0AFB02E03B0D
        [System.Web.Http.HttpGet]
        public string GetUserNameByUnique(string uniqueID)
        {
            try
            {
                users user = new users();
                using (connectionsEntities db = new connectionsEntities())
                {
                    user = db.users.FirstOrDefault(x => x.UniqeID == uniqueID);
                }
                if (user != null)
                    return user.FirstName + " " + user.LastName;
                return string.Empty;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //https://localhost:44362/home/GetCalendar?uniqueID=1B2AC001-D56B-451E-A794-0AFB02E03B0D
        [System.Web.Http.HttpGet]
        public string GetCalendar(string uniqueID)
        {

            List<CalendarModel> lstCalendarModel = new List<CalendarModel>();
            using (connectionsEntities db = new connectionsEntities())
            {
                users user = db.users.FirstOrDefault(x => x.UniqeID == uniqueID);
                if (user == null)
                    return string.Empty;
                //מעבר על פגישות סגורות
                List<viewAllMach> lstMach = db.viewAllMach.Where(x => x.userID == user.ID && x.machIsActive == true).ToList();
                foreach (var item in lstMach)
                {
                    string msg = item.Name;
                    lstCalendarModel.Add(new CalendarModel(item.DayInWeek, item.TimeInDay, 1, item.machID, msg));
                }
                List<Int64> lstintMach = lstMach.Select(x => x.RequestId1).ToList();
                lstintMach.AddRange(lstMach.Select(x => x.RequestId2).ToList());
                //מעבר על בקשות לפגישות
                List<request> lstRequest = db.request.Where(x => x.UserID == user.ID && x.IsActive == true && !lstintMach.Contains(x.ID)).ToList();
                foreach (var item in lstRequest)
                {
                    events myEvent = db.events.FirstOrDefault(x => x.ID == item.EventID);
                    string msg = "ממתין לשותף ל" + myEvent.Name;
                    lstCalendarModel.Add(new CalendarModel(item.DayInWeek, item.TimeInDay, 2, item.ID, msg));
                }
                //מעבר על בקשות  לפגישות של אנשים אחרים
                List<request> lstOtherRequest = db.request.Where(x => x.UserID != user.ID && x.IsActive == true && !lstintMach.Contains(x.ID)).ToList();
                foreach (var item in lstOtherRequest)
                {
                    events myEvent = db.events.FirstOrDefault(x => x.ID == item.EventID);
                    string msg = "פנוי ל " + myEvent.Name;
                    lstCalendarModel.Add(new CalendarModel(item.DayInWeek, item.TimeInDay, 3, item.ID, msg));
                }
            }
            return JsonConvert.SerializeObject(lstCalendarModel, settings);

        }

        #region Brachi

        public class CalendarModel
        {
            public int Day { get; set; }
            public DateTime Date { get; set; }
            public int Type { get; set; }
            public Int64 MatchIDOrRequestID { get; set; }
            public String Description { get; set; }


            public CalendarModel(int Day, DateTime Date, int Type, Int64 MatchIDOrRequestID, String Description)
            {
                this.Day = Day;
                this.Date = Date;
                this.Type = Type;
                this.MatchIDOrRequestID = MatchIDOrRequestID;
                this.Description = Description;
            }




            #endregion
        }
    }
    //התאמות
    public class MatchModel
    {
        public Int64 requestID { get; set; }
        public int IsMatch { get; set; }
        public String Description { get; set; }



        public MatchModel(Int64 requestID, int IsMatch, String Description)
        {
            this.requestID = requestID;
            this.IsMatch = IsMatch;
            this.Description = Description;
        }

    }

    ////התאמות
    ////https://localhost:44362/home/GetCalendar?uniqueID=1B2AC001-D56B-451E-A794-0AFB02E03B0D
    //[System.Web.Http.HttpGet]

    //public string match1(string uniqueID)
    //{

    //    List<MatchModel> lstMatchModel = new List<MatchModel>();
    //    using (connectionsEntities db = new connectionsEntities())
    //    {
    //        users user = db.users.FirstOrDefault(x => x.UniqeID == uniqueID);
    //        if (user == null)
    //            return string.Empty;
           
    //        //מעבר על בקשות לפגישות
    //        List<request> lstRequest = db.viewAllMach.Where(x => x.userID == user.ID && x.requestIsActive == true && !lstMatchModel.Contains(x.)).ToList();
    //        foreach (var item in lstRequest)
    //        {
    //            events myEvent = db.events.FirstOrDefault(x => x.ID == item.EventID);
    //            string msg = "ממתין לשותף ל" + myEvent.Name;
    //            lstMatchModel.Add(new MatchModel());
    //        }
    //        //מעבר על בקשות  לפגישות של אנשים אחרים
    //        List<request> lstOtherRequest1 = db.request.Where(x => x.UserID != user.ID && x.IsActive == true && !lstintMach.Contains(x.ID)).ToList();
    //        foreach (var item in lstOtherRequest1)
    //        {
    //            events myEvent = db.events.FirstOrDefault(x => x.ID == item.EventID);
    //            string msg = "פנוי ל " + myEvent.Name;
    //            lstMatchModel.Add(new MatchModel(item.DayInWeek, item.TimeInDay, 3, item.ID, msg));
    //        }
    //    }
    //    return JsonConvert.SerializeObject(lstMatchModel, settings);

    }
}