Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596C6C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5BD21835
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MA8mM1MR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgAWQOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:14:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40629 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728205AbgAWQOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:14:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579796045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ovowkODEMfX7IvcCl93umTGw/82tkVe50aL1BA3n9Y=;
        b=MA8mM1MRljosw7F5rGHjCjEEC4DSyVcNeTQuMcD8v1huydxMRUMaX8HTYUft3mmtonwNBG
        xD44UYOhhjO2/CbNLNlXkAhx27jPIRd6TUMDde6yTcQmc73JslX9oqdakGigdBin+ujz6u
        9TXieD/9XpOVl0QIrQM494U95q5/mbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-qMt74HqLMiu-i-hmDdM5dg-1; Thu, 23 Jan 2020 11:14:01 -0500
X-MC-Unique: qMt74HqLMiu-i-hmDdM5dg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BD54DB81;
        Thu, 23 Jan 2020 16:14:00 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-12.phx2.redhat.com [10.3.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CCA385780;
        Thu, 23 Jan 2020 16:13:51 +0000 (UTC)
Date:   Thu, 23 Jan 2020 11:13:49 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     nhorman@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH ghak28 V4] audit: log audit netlink multicast bind and
 unbind events
Message-ID: <20200123161349.z55l2dd7qsyhoxbn@madcap2.tricolour.ca>
References: <ca70ee17d85860aa599e0001a75d639d819de7ae.1579292286.git.rgb@redhat.com>
 <CAHC9VhR9p+aOTzv7g-ujuMsMtLvOZKkoKJWsthZnj38rzJe1TA@mail.gmail.com>
 <20200122230742.7vwtvmhhjerray5f@madcap2.tricolour.ca>
 <CAHC9VhTcv9E8DUDJ2Y-PzXmU0_+ufVydbPB3Q_Fhb8-7TUZMmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTcv9E8DUDJ2Y-PzXmU0_+ufVydbPB3Q_Fhb8-7TUZMmg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-23 09:32, Paul Moore wrote:
> On Wed, Jan 22, 2020 at 6:07 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2020-01-22 17:40, Paul Moore wrote:
> > > On Fri, Jan 17, 2020 at 3:21 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> 
> ...
> 
> > > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > > index 17b0d523afb3..478259f3fa53 100644
> > > > --- a/kernel/audit.c
> > > > +++ b/kernel/audit.c
> > > > @@ -1520,20 +1520,60 @@ static void audit_receive(struct sk_buff  *skb)
> > > >         audit_ctl_unlock();
> > > >  }
> > > >
> > > > +/* Log information about who is connecting to the audit multicast socket */
> > > > +static void audit_log_multicast_bind(int group, const char *op, int err)
> > > > +{
> > > > +       const struct cred *cred;
> > > > +       struct tty_struct *tty;
> > > > +       char comm[sizeof(current->comm)];
> > > > +       struct audit_buffer *ab;
> > > > +
> > > > +       if (!audit_enabled)
> > > > +               return;
> > > > +
> > > > +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_EVENT_LISTENER);
> > > > +       if (!ab)
> > > > +               return;
> > > > +
> > > > +       cred = current_cred();
> > > > +       tty = audit_get_tty();
> > > > +       audit_log_format(ab, "pid=%u uid=%u auid=%u tty=%s ses=%u",
> > > > +                        task_pid_nr(current),
> > > > +                        from_kuid(&init_user_ns, cred->uid),
> > > > +                        from_kuid(&init_user_ns, audit_get_loginuid(current)),
> > > > +                        tty ? tty_name(tty) : "(none)",
> > > > +                        audit_get_sessionid(current));
> > >
> > > Don't we already get all of that information as part of the syscall record?
> >
> > Yes.  However, the syscall record isn't always present.  One example is
> > systemd, shown above.
> 
> Assuming that the system supports syscall auditing, the absence of a
> syscall record is a configuration choice made by the admin.  If the
> system doesn't support syscall auditing the obvious "fix" is to do the
> work to enable syscall auditing on that platform ... but now we're
> starting to get off topic.

Well, the system did spit out a syscall record with the example above,
so it has support for syscall auditing.

I'm testing on f30 with an upstream kernel, the standard 30-stig ruleset and
with kernel command line audit=1.  What else is needed to support a syscall
record on systemd before any audit rules have been put in place?  We may still
have a bug here that affects early process auditing.  What am I missing?

If we can get that sorted out, we don't need subject attributes in this record.

> > The other is the disconnect record, shown above,
> > which may be asynchronous, or an unmonitored syscall (It could only be
> > setsockopt, close, shutdown.).
> 
> An unmonitored syscall still falls under the category of a
> configuration choice so I'm not too concerned about that, but the
> async disconnect record is legitimate.  Can you provide more
> information about when this occurs?  I'm guessing this is pretty much
> just an abrupt/abnormal program exit?

Again, what configuration choice are you talking about?  
"-a task,never"?  That isn't active on this system.

The output was produced by the test case quoted in the patch description.

I should not have had to put a rule in place to do syscall auditing on connect,
bind, setsockopt, close, shutdown.

The disconnect would have been due to a perl close() call.  I would not have
expected that to be async, but I don't know the details of what the perl
implementation does.

> > > I'm pretty sure these are the same arguments I made when Steve posted
> > > a prior version of this patch.
> >
> > You did.  I would really like to have dropped them, but they aren't
> > reliably available.
> 
> Personally I'm not too worried if we have duplicate information spread
> across records in a single event, as long as they are consistent.
> However, I remember Steve complaining rather loudly about duplicated
> fields across records in a single event some time back; perhaps that
> is not a concern of his anymore (perhaps it was a narrow case at the
> time), I don't know.
> 
> Here is the deal, either duplicated information is something we are
> okay with, or it is something to avoid; we need to pick one.  As
> mentioned above, I don't really care that much either way (I have a
> slight preference, but I don't feel strongly enough to fight for it),
> so let's hear the arguments both for and against and decide - whatever
> we pick I'll enforce so long as we are stuck with this string format.

Steve, can you say why this order should be the standard?  From:
	http://people.redhat.com/sgrubb/audit/record-fields.html

I get:
        SYSCALL/ANOM_LINK/FEATURE_CHANGE
                ppid    pid     auid    uid     gid     euid    suid    fsuid   egid    sgid    fsgid   tty     ses     comm    exe     subj
        ANOM_ABEND/SECCOMP
                                auid    uid     gid     ses     subj    pid     comm    exe
        LOGIN
                pid     uid     subj    old-auid        auid    tty     old-ses ses
        SYSTEM_BOOT/SYSTEM_SHUTDOWN
                pid     uid     auid    ses     subj    comm    exe
        USER_LOGIN
                pid     uid     auid    ses     subj    uid     exe
        DAEMON_START
                                auid    pid     uid     ses     subj
        DAEMON_CONFIG/DAEMON_END
                                auid    pid     subj
        ANOM_PROMISCUOUS
                                auid    uid     gid     ses
        52msgs
                pid     uid     auid    ses     subj	*
        CONFIG_CHANGE
                                auid    ses     subj

This new record is:
        EVENT_LISTENER
                pid     uid     auid    tty     ses     subj    comm    exe

And using the search criteria following, I get no other matches:
        /pid.*uid.*auid.*tty.*ses.*subj.*comm.*exe
so this appears to be a new field order.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

