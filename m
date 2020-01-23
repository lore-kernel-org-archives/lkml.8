Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FF6C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B081820665
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="FkFiUQ+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAWVpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 16:45:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45206 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgAWVpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 16:45:20 -0500
Received: by mail-lj1-f195.google.com with SMTP id j26so5402133ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 13:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14Phm8+YcLeBER1tUmYRr6u2IEB1IiJoYWbH7UYZiVo=;
        b=FkFiUQ+QKLXb0B0bW8Dkh0idUJ/db0OxoHdnOxNAp1boJLPUkSnF0i7Bdi1TnSHg31
         7DLxaMiuAxaLeTfpvYGTB5pDNYF4brL6mBnAtQ50VspqngrmvJeH/+0eJLoTUZwwcNur
         JAyFY0lEOW/cQuhfOdHnCYnqVkBNxdDhqQ3OlUfpJNAuoTfxaOt3y6cUFoLlHZmgwLI4
         4Lkic2ibNKtNZ0+gjR5pgpO7uhwUR3no6Ynmw5sz8oUizYKwrpA2JOd4FinkN6SiZTM5
         oJjkoj0cwM7s2n6b/q6hbwIegVIvRgqr09h1A/K86vcXBXGaqQ1OQrhHJm6RBnSPHVPv
         7m4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14Phm8+YcLeBER1tUmYRr6u2IEB1IiJoYWbH7UYZiVo=;
        b=GfTuOnEzDkeD4ZNrupTuO98LCiAd38myYHMLGDS7yBoPI5mQVrRPzqooNn7mqC4jay
         /tZC5sVTI4UYdErCBPlPFCKHRMViVViumVVtFk+rIUGq8sfilYEXAtCcg8S/MumPoMsM
         ATRMEZ4Wgoa1vD2CfUg+UlIWSFfGPsjBAjMZ47F8rbb2sfz+eiub1iONaa778lHqzgZH
         baMCnBDsfLSReBTlYYDSHz2iczIUo8NPEq1up5pnlPRs2q1VPBW2fWqfLp/syALBDFqo
         3TVR5uRLrQCGcGDSInGkeGOmPgYUo78LoDtwFT28WPz9s2cevIJJdhFdVLXqMjYb/KpP
         IZqw==
X-Gm-Message-State: APjAAAWhOhb4QbKkV09NF+SvccKH/xEcWSw5lOcn4PCnXMmlgo88CL+M
        I/Gqp8qE0cksLMPQ/39iEZydIQvMXor+lH2yTj3QTms=
X-Google-Smtp-Source: APXvYqyeJRF7GdpSJouygYcw2FtawzW1+7XH4sU4JZtZF7oRd79p7FnopINhaoh+EW2YgGAP3IzlLPlnhyW/dWQlAVs=
X-Received: by 2002:a2e:9b03:: with SMTP id u3mr256015lji.87.1579815917614;
 Thu, 23 Jan 2020 13:45:17 -0800 (PST)
MIME-Version: 1.0
References: <ca70ee17d85860aa599e0001a75d639d819de7ae.1579292286.git.rgb@redhat.com>
 <CAHC9VhR9p+aOTzv7g-ujuMsMtLvOZKkoKJWsthZnj38rzJe1TA@mail.gmail.com>
 <20200122230742.7vwtvmhhjerray5f@madcap2.tricolour.ca> <CAHC9VhTcv9E8DUDJ2Y-PzXmU0_+ufVydbPB3Q_Fhb8-7TUZMmg@mail.gmail.com>
 <20200123161349.z55l2dd7qsyhoxbn@madcap2.tricolour.ca> <CAHC9VhTEfZXCV6TwJ4KOoDCea3x5i85_gBmMi=cygGG9OQCGOQ@mail.gmail.com>
 <20200123185149.sr4b4u4s2ec7renc@madcap2.tricolour.ca> <CAHC9VhSPwfNqqoMid+bHRa-XTj4b+DbE6+ov8=MsCxMBuHbjWg@mail.gmail.com>
 <20200123201541.emtse6l5wrnrpqgc@madcap2.tricolour.ca>
In-Reply-To: <20200123201541.emtse6l5wrnrpqgc@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Jan 2020 16:45:06 -0500
Message-ID: <CAHC9VhQxRGCzmJB0p06_4k8cwyWOz1j=DCOYjLqGvDVNpMoYfA@mail.gmail.com>
Subject: Re: [PATCH ghak28 V4] audit: log audit netlink multicast bind and
 unbind events
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Eric Paris <eparis@parisplace.org>, nhorman@redhat.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 3:15 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-01-23 14:07, Paul Moore wrote:
> > On Thu, Jan 23, 2020 at 1:52 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2020-01-23 11:57, Paul Moore wrote:
> > > > On Thu, Jan 23, 2020 at 11:14 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > On 2020-01-23 09:32, Paul Moore wrote:
> > > > > > On Wed, Jan 22, 2020 at 6:07 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > > > On 2020-01-22 17:40, Paul Moore wrote:
> > > > > > > > On Fri, Jan 17, 2020 at 3:21 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > > > > > > > index 17b0d523afb3..478259f3fa53 100644
> > > > > > > > > --- a/kernel/audit.c
> > > > > > > > > +++ b/kernel/audit.c
> > > > > > > > > @@ -1520,20 +1520,60 @@ static void audit_receive(struct sk_buff  *skb)
> > > > > > > > >         audit_ctl_unlock();
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +/* Log information about who is connecting to the audit multicast socket */
> > > > > > > > > +static void audit_log_multicast_bind(int group, const char *op, int err)
> > > > > > > > > +{
> > > > > > > > > +       const struct cred *cred;
> > > > > > > > > +       struct tty_struct *tty;
> > > > > > > > > +       char comm[sizeof(current->comm)];
> > > > > > > > > +       struct audit_buffer *ab;
> > > > > > > > > +
> > > > > > > > > +       if (!audit_enabled)
> > > > > > > > > +               return;
> > > > > > > > > +
> > > > > > > > > +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_EVENT_LISTENER);
> > > > > > > > > +       if (!ab)
> > > > > > > > > +               return;
> > > > > > > > > +
> > > > > > > > > +       cred = current_cred();
> > > > > > > > > +       tty = audit_get_tty();
> > > > > > > > > +       audit_log_format(ab, "pid=%u uid=%u auid=%u tty=%s ses=%u",
> > > > > > > > > +                        task_pid_nr(current),
> > > > > > > > > +                        from_kuid(&init_user_ns, cred->uid),
> > > > > > > > > +                        from_kuid(&init_user_ns, audit_get_loginuid(current)),
> > > > > > > > > +                        tty ? tty_name(tty) : "(none)",
> > > > > > > > > +                        audit_get_sessionid(current));
> > > > > > > >
> > > > > > > > Don't we already get all of that information as part of the syscall record?
> > > > > > >
> > > > > > > Yes.  However, the syscall record isn't always present.  One example is
> > > > > > > systemd, shown above.
> > > > > >
> > > > > > Assuming that the system supports syscall auditing, the absence of a
> > > > > > syscall record is a configuration choice made by the admin.  If the
> > > > > > system doesn't support syscall auditing the obvious "fix" is to do the
> > > > > > work to enable syscall auditing on that platform ... but now we're
> > > > > > starting to get off topic.
> > > > >
> > > > > Well, the system did spit out a syscall record with the example above,
> > > > > so it has support for syscall auditing.
> > > > >
> > > > > I'm testing on f30 with an upstream kernel, the standard 30-stig ruleset and
> > > > > with kernel command line audit=1.  What else is needed to support a syscall
> > > > > record on systemd before any audit rules have been put in place?  We may still
> > > > > have a bug here that affects early process auditing.  What am I missing?
> > > > >
> > > > > If we can get that sorted out, we don't need subject attributes in this record.
> > > >
> > > > It looks like some debugging is in order.  There must be some sort of
> > > > action initiated by userspace which is causing the multicast
> > > > "op=connect", right?  Find out what that is and why it isn't
> > > > generating a syscall record (maybe it's not a syscall? I don't know
> > > > what systemd is doing here).
> > >
> > > One clue is that subj=kernel and auid, ttye and ses are unset, despite
> > > the rest checking out:
> > >         pid=1 uid=root auid=unset tty=(none) ses=unset subj=kernel comm=systemd exe=/usr/lib/systemd/systemd
> >
> > Does Fedora use systemd in its initramfs (I'm guessing the answer is
> > "yes")?  If so, I wonder if that is the source of this record.
>
> Asking around, I got: "yes, dracut uses systemd these days"
>
> So, yes, that is the source of this record.
>
> So if there is no syscall associated with that record, it appears we
> need those subject attributes.

Well, I'm fairly certain that the record in question was the result of
a syscall made by systemd, the question is why was it not recorded?
That is something that needs to be answered.

-- 
paul moore
www.paul-moore.com
