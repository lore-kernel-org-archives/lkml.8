Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8967BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A1A2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JtoU/3Mm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgAWOca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:32:30 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34695 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgAWOca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:32:30 -0500
Received: by mail-lj1-f195.google.com with SMTP id z22so3692026ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 06:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zzl5F0H2fTppXPzngb9Jp7NGZnwhz6mstL88a3OvSS8=;
        b=JtoU/3MmNJEpoxPg4+ByJTZKr7eHKafdfp9eSIsHZVW4hsb8pHHQscUcJkTsGZhM0V
         EIYHYgyLHJv6G2NM9qzgMrL31BrxtPtCDsDUHrWrZgTddUFpWWG3TucOKSq1XauPADky
         mcPz0MVzPhz1HUV9TGddnSDMCy3gclgh6ASNEN0pQQAYNRUbUB4AOScyw8EMA8aSbDXo
         Z2vJEJGJ2/e1RYZy3f8ywBQFSvM9XmPcDK7PignqY6StFyHSMa0RdMg7R7y9QHSqHa0q
         yUd1UsFQFpY4FzPP70DksL21L95e9vNiHiloH+RhNgSZYx6/IK4Nj2l68Pf7A5WR9Sht
         JVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zzl5F0H2fTppXPzngb9Jp7NGZnwhz6mstL88a3OvSS8=;
        b=OQMJLp2TBiEMiTK/DkK5a0XxmxjnxvpX1d/Liyq5LW9R/KU7zHO49oR+64V/LelEo4
         0hwfDVrcNrtvVZTa5IkcEQkCIsTcn5BthktdaAe2rKfW4e9FDBJLPxABBKSGbeS8tQ5X
         b/Zo946h80uJxh1EqPx7hs0/Ih7AbrhrjvWE2D/dvGu+9E9vGbAT37j5bDPxRFqqjXoh
         oDQNYXgH+zznZ9RzUj0MwjFeD93Eau3s1OgnW6fz2W91ultpB8+LZd/aZioW/SvVzL+9
         9Kzh3xBiUuR71zVMq/vxlP3k4G7azxPYKLvvPERucA18QSanxw5EHXGQQIE7RBd8gaB/
         RD9A==
X-Gm-Message-State: APjAAAXdWWIYN18V+qbXeBun3UNXOYmhlewW7INpjlPGVS60M0oak8lg
        Q7DsIrAHQ+CYkJ1JLy2ofMJwrtdFV4TZJe3dOFO0
X-Google-Smtp-Source: APXvYqweMeV6hg3iBF4sGgsCpLPF3tzMYjb0o9EXpZDutTsff2bjLm7SJRaFk53F0mxVQ6G/4Cf3aTCDZJTuXcgm1Lc=
X-Received: by 2002:a2e:9f52:: with SMTP id v18mr23564863ljk.30.1579789947927;
 Thu, 23 Jan 2020 06:32:27 -0800 (PST)
MIME-Version: 1.0
References: <ca70ee17d85860aa599e0001a75d639d819de7ae.1579292286.git.rgb@redhat.com>
 <CAHC9VhR9p+aOTzv7g-ujuMsMtLvOZKkoKJWsthZnj38rzJe1TA@mail.gmail.com> <20200122230742.7vwtvmhhjerray5f@madcap2.tricolour.ca>
In-Reply-To: <20200122230742.7vwtvmhhjerray5f@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Jan 2020 09:32:16 -0500
Message-ID: <CAHC9VhTcv9E8DUDJ2Y-PzXmU0_+ufVydbPB3Q_Fhb8-7TUZMmg@mail.gmail.com>
Subject: Re: [PATCH ghak28 V4] audit: log audit netlink multicast bind and
 unbind events
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sgrubb@redhat.com,
        omosnace@redhat.com, nhorman@redhat.com,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 6:07 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-01-22 17:40, Paul Moore wrote:
> > On Fri, Jan 17, 2020 at 3:21 PM Richard Guy Briggs <rgb@redhat.com> wrote:

...

> > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > index 17b0d523afb3..478259f3fa53 100644
> > > --- a/kernel/audit.c
> > > +++ b/kernel/audit.c
> > > @@ -1520,20 +1520,60 @@ static void audit_receive(struct sk_buff  *skb)
> > >         audit_ctl_unlock();
> > >  }
> > >
> > > +/* Log information about who is connecting to the audit multicast socket */
> > > +static void audit_log_multicast_bind(int group, const char *op, int err)
> > > +{
> > > +       const struct cred *cred;
> > > +       struct tty_struct *tty;
> > > +       char comm[sizeof(current->comm)];
> > > +       struct audit_buffer *ab;
> > > +
> > > +       if (!audit_enabled)
> > > +               return;
> > > +
> > > +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_EVENT_LISTENER);
> > > +       if (!ab)
> > > +               return;
> > > +
> > > +       cred = current_cred();
> > > +       tty = audit_get_tty();
> > > +       audit_log_format(ab, "pid=%u uid=%u auid=%u tty=%s ses=%u",
> > > +                        task_pid_nr(current),
> > > +                        from_kuid(&init_user_ns, cred->uid),
> > > +                        from_kuid(&init_user_ns, audit_get_loginuid(current)),
> > > +                        tty ? tty_name(tty) : "(none)",
> > > +                        audit_get_sessionid(current));
> >
> > Don't we already get all of that information as part of the syscall record?
>
> Yes.  However, the syscall record isn't always present.  One example is
> systemd, shown above.

Assuming that the system supports syscall auditing, the absence of a
syscall record is a configuration choice made by the admin.  If the
system doesn't support syscall auditing the obvious "fix" is to do the
work to enable syscall auditing on that platform ... but now we're
starting to get off topic.

> The other is the disconnect record, shown above,
> which may be asynchronous, or an unmonitored syscall (It could only be
> setsockopt, close, shutdown.).

An unmonitored syscall still falls under the category of a
configuration choice so I'm not too concerned about that, but the
async disconnect record is legitimate.  Can you provide more
information about when this occurs?  I'm guessing this is pretty much
just an abrupt/abnormal program exit?

> > I'm pretty sure these are the same arguments I made when Steve posted
> > a prior version of this patch.
>
> You did.  I would really like to have dropped them, but they aren't
> reliably available.

Personally I'm not too worried if we have duplicate information spread
across records in a single event, as long as they are consistent.
However, I remember Steve complaining rather loudly about duplicated
fields across records in a single event some time back; perhaps that
is not a concern of his anymore (perhaps it was a narrow case at the
time), I don't know.

Here is the deal, either duplicated information is something we are
okay with, or it is something to avoid; we need to pick one.  As
mentioned above, I don't really care that much either way (I have a
slight preference, but I don't feel strongly enough to fight for it),
so let's hear the arguments both for and against and decide - whatever
we pick I'll enforce so long as we are stuck with this string format.

-- 
paul moore
www.paul-moore.com
