﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ConnectionsWebApi
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class connectionsEntities : DbContext
    {
        public connectionsEntities()
            : base("name=connectionsEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<events> events { get; set; }
        public virtual DbSet<mach> mach { get; set; }
        public virtual DbSet<request> request { get; set; }
        public virtual DbSet<users> users { get; set; }
    }
}
