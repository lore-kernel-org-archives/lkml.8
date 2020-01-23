Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A11C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A5A2071E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="a1gxGt8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgAWQ5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:57:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37572 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgAWQ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:57:53 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so2857993lfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 08:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tAU4TO4UPuqedH11PX69S7xczLWO9O6KwtUTPrmTbMo=;
        b=a1gxGt8XEzK9CQCFkcNp0A7rWneknCasCl0uBWApEohHQEDaF+hOHgR1A1cWp6NkZt
         S7jly1/fZvF923aDqCutFxVwmlt7Y+8IZv/e4yLj96pVO4c4PzWTGd8/NOVvFBGfy8C7
         c1YTxJdtlOsLnOGRuEN62rK/kNG2ltKzH/w04WhfheM1bJX/hGp8hYi/CmeKe54EtdmF
         92kY7ci992wZN0mLY5uFKtmsV+ZZaEYGEPy6kY+bV97NPmySOf1NQOVvMzqi6qonMoxI
         0QTxgYNtxxw0yFEnYhUdXoQIU3IaL0xPPh5nTSLbM2Z4sx0JkYIuRxTXEXgM0LabKUeD
         FErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAU4TO4UPuqedH11PX69S7xczLWO9O6KwtUTPrmTbMo=;
        b=NPhgmCfzZR75Qls84hiUWKErGeJwcxD4PQ3+BH+Zpc1cxK0TeYBlmutjota+AEwY6X
         F+Kvfvj1NckbH9VZ5oiNjLk5oa0RGvrmC/vK+4M8FgdGjkWoFE4pBALSVlL0KmyqAM1P
         2yAwZvKw4qDouyY5IXT0CMNSzDh2J87iF53RQ5usNIm1lUd9sLLKJQ9P8GYGhrc/3nnM
         B89fiy5Gjzn+3seXiG1XMITa7smiwK2NTI4Ll9vJjZV6snJqCUk+tNUFjcecNFk7ILiJ
         RNY18FYo3SAfBC6VlJztDz1pU8h87sJ6C+0Lw/eXW2O+Zvx67zLfmNjbsS806VTKRkTX
         fecw==
X-Gm-Message-State: APjAAAXCXQf1bC1K8tkU6sZAUGQsr7dEMQudl/aPuDPcBsnrBUu3Jsei
        wiovq09vSSnP6Ev1iB3l7cve+S6wCYguXyrnIVC5
X-Google-Smtp-Source: APXvYqzwU5mFf0OdaVANPLxDgOiiY6gt16JYgDxiWXtQTUI56T9uqGJ4JiGdv1gP6pQmFdn7+smygq+aNd9GhW2912M=
X-Received: by 2002:ac2:4946:: with SMTP id o6mr5312283lfi.170.1579798670135;
 Thu, 23 Jan 2020 08:57:50 -0800 (PST)
MIME-Version: 1.0
References: <ca70ee17d85860aa599e0001a75d639d819de7ae.1579292286.git.rgb@redhat.com>
 <CAHC9VhR9p+aOTzv7g-ujuMsMtLvOZKkoKJWsthZnj38rzJe1TA@mail.gmail.com>
 <20200122230742.7vwtvmhhjerray5f@madcap2.tricolour.ca> <CAHC9VhTcv9E8DUDJ2Y-PzXmU0_+ufVydbPB3Q_Fhb8-7TUZMmg@mail.gmail.com>
 <20200123161349.z55l2dd7qsyhoxbn@madcap2.tricolour.ca>
In-Reply-To: <20200123161349.z55l2dd7qsyhoxbn@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Jan 2020 11:57:38 -0500
Message-ID: <CAHC9VhTEfZXCV6TwJ4KOoDCea3x5i85_gBmMi=cygGG9OQCGOQ@mail.gmail.com>
Subject: Re: [PATCH ghak28 V4] audit: log audit netlink multicast bind and
 unbind events
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     nhorman@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 11:14 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-01-23 09:32, Paul Moore wrote:
> > On Wed, Jan 22, 2020 at 6:07 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2020-01-22 17:40, Paul Moore wrote:
> > > > On Fri, Jan 17, 2020 at 3:21 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > ...
> >
> > > > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > > > index 17b0d523afb3..478259f3fa53 100644
> > > > > --- a/kernel/audit.c
> > > > > +++ b/kernel/audit.c
> > > > > @@ -1520,20 +1520,60 @@ static void audit_receive(struct sk_buff  *skb)
> > > > >         audit_ctl_unlock();
> > > > >  }
> > > > >
> > > > > +/* Log information about who is connecting to the audit multicast socket */
> > > > > +static void audit_log_multicast_bind(int group, const char *op, int err)
> > > > > +{
> > > > > +       const struct cred *cred;
> > > > > +       struct tty_struct *tty;
> > > > > +       char comm[sizeof(current->comm)];
> > > > > +       struct audit_buffer *ab;
> > > > > +
> > > > > +       if (!audit_enabled)
> > > > > +               return;
> > > > > +
> > > > > +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_EVENT_LISTENER);
> > > > > +       if (!ab)
> > > > > +               return;
> > > > > +
> > > > > +       cred = current_cred();
> > > > > +       tty = audit_get_tty();
> > > > > +       audit_log_format(ab, "pid=%u uid=%u auid=%u tty=%s ses=%u",
> > > > > +                        task_pid_nr(current),
> > > > > +                        from_kuid(&init_user_ns, cred->uid),
> > > > > +                        from_kuid(&init_user_ns, audit_get_loginuid(current)),
> > > > > +                        tty ? tty_name(tty) : "(none)",
> > > > > +                        audit_get_sessionid(current));
> > > >
> > > > Don't we already get all of that information as part of the syscall record?
> > >
> > > Yes.  However, the syscall record isn't always present.  One example is
> > > systemd, shown above.
> >
> > Assuming that the system supports syscall auditing, the absence of a
> > syscall record is a configuration choice made by the admin.  If the
> > system doesn't support syscall auditing the obvious "fix" is to do the
> > work to enable syscall auditing on that platform ... but now we're
> > starting to get off topic.
>
> Well, the system did spit out a syscall record with the example above,
> so it has support for syscall auditing.
>
> I'm testing on f30 with an upstream kernel, the standard 30-stig ruleset and
> with kernel command line audit=1.  What else is needed to support a syscall
> record on systemd before any audit rules have been put in place?  We may still
> have a bug here that affects early process auditing.  What am I missing?
>
> If we can get that sorted out, we don't need subject attributes in this record.

It looks like some debugging is in order.  There must be some sort of
action initiated by userspace which is causing the multicast
"op=connect", right?  Find out what that is and why it isn't
generating a syscall record (maybe it's not a syscall? I don't know
what systemd is doing here).

> > > The other is the disconnect record, shown above,
> > > which may be asynchronous, or an unmonitored syscall (It could only be
> > > setsockopt, close, shutdown.).
> >
> > An unmonitored syscall still falls under the category of a
> > configuration choice so I'm not too concerned about that, but the
> > async disconnect record is legitimate.  Can you provide more
> > information about when this occurs?  I'm guessing this is pretty much
> > just an abrupt/abnormal program exit?
>
> Again, what configuration choice are you talking about?
> "-a task,never"?  That isn't active on this system.
>
> The output was produced by the test case quoted in the patch description.
>
> I should not have had to put a rule in place to do syscall auditing on connect,
> bind, setsockopt, close, shutdown.
>
> The disconnect would have been due to a perl close() call.  I would not have
> expected that to be async, but I don't know the details of what the perl
> implementation does.

You mentioned two cases: unmonitored syscalls and async records (I
assumed these were just "disconnect").  Monitoring a syscall is a
configuration choice, regardless of what the defaults may be, and
since the folks likely to care about these multicast events are the
same sort of folks that care deeply about audit, asking them to do
some additional configuration tweaks seems like a reasonable thing to
get this new record with the proper information.  The async records
are potentially more interesting, but less clear, which is why I asked
for more info.

Regardless, all of this is pretty moot if we decide we don't care
about duplicate information.  Let's make a decision on duplicate
fields across multiple records before we worry too much about the rest
of what we are discussing.

> > > > I'm pretty sure these are the same arguments I made when Steve posted
> > > > a prior version of this patch.
> > >
> > > You did.  I would really like to have dropped them, but they aren't
> > > reliably available.
> >
> > Personally I'm not too worried if we have duplicate information spread
> > across records in a single event, as long as they are consistent.
> > However, I remember Steve complaining rather loudly about duplicated
> > fields across records in a single event some time back; perhaps that
> > is not a concern of his anymore (perhaps it was a narrow case at the
> > time), I don't know.
> >
> > Here is the deal, either duplicated information is something we are
> > okay with, or it is something to avoid; we need to pick one.  As
> > mentioned above, I don't really care that much either way (I have a
> > slight preference, but I don't feel strongly enough to fight for it),
> > so let's hear the arguments both for and against and decide - whatever
> > we pick I'll enforce so long as we are stuck with this string format.
>
> Steve, can you say why this order should be the standard?  From:
>         http://people.redhat.com/sgrubb/audit/record-fields.html
>
> I get:
>         SYSCALL/ANOM_LINK/FEATURE_CHANGE
>                 ppid    pid     auid    uid     gid     euid    suid    fsuid   egid    sgid    fsgid   tty     ses     comm    exe     subj

Oh man, let's please not have *another* debate about field ordering
before we answer the duplicate field question.  If history has shown
us anything, it is that debates around audit record field ordering
tend to kill progress.  Let's try to stay focused.

-- 
paul moore
www.paul-moore.com
