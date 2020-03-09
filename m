Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5D1C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BDB2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="OK9y5uxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgCIXzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 19:55:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40093 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgCIXzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 19:55:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id a13so14106238edu.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 16:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATqnQFBKPT1p02ELSnKePY0l7WbFZ/CxC65rj6GAtS4=;
        b=OK9y5uxeOtwWiidksXhYaVK4jkScyMg+oTpIGBM1pueUB1XTGD5EWl6TIqMBEw3XN4
         RvWkUwuYMi9MCPCr9HywHIcZV9WZH5fW2R13ZQ3UyTI3ASjT5OtlTYST2XZqcZQ+8xxJ
         sUrMPyPyaJIKIYo+calWbHw/E4MH+dVtKBla7U0+CXS/FhUkezgtGpSr5L6Wd6W0jTyE
         oqbHbNBwB1IMZ1EAdU7tKHIaXOCBTUhoHxGbCTS3UH14qavULkZv4YcghAaqZYdNZa3Z
         chCc1L7hEFADkkB/40RsQiVZLiL9/o9vuSHdT5AExvk9jDCWsoAdez4us7pL8q4Niu0P
         KwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATqnQFBKPT1p02ELSnKePY0l7WbFZ/CxC65rj6GAtS4=;
        b=FDOJv6bVr5OT2LWGXygI5GN2fHiXcMJcA9DGWhx7X93dAgrCicU4PxDhs1WENVIa8d
         pQuMV/7DThb0w2fZvBtYsli7lOjvCeLxD3rEB9+9WL49TDw9QCJw33S5OmoiFOMOCBPT
         mVwvvQbFYlcvhUJpbz/juvJI2mOUsp6U7Gz7KluQ+M3Ks4/NoQy/05xtiOT/7IcEnHR/
         X361g8bNYvIaA88A8e6MEjPY46yJbzt74AsBVYHOjBht4pWJAmY5OpUaX/7VmeNHo5fi
         mQhUSHN0W3m1dt2AKodQvKcIrwpvl+cWbRe8/Xf+QwlfcEd7aD4jl1Jk5QMy6U/80S9w
         qyTg==
X-Gm-Message-State: ANhLgQ3x+0aaiagaDrAQsojc50A/p1RYmsMmxfxZCq9aIIXUEGZtE7gr
        dv81ydw3Wp9qX5Np3ZIeb/gwtIUFEt4NoNKgr5JCD08=
X-Google-Smtp-Source: ADFU+vvnIEUY2LquWLpQEiyPqq4E2JonnD7e9IvoOIGc2cvHJUi1zup/+MFTXAnNNmaIGMUuiFN3E+NqOXjIAw3CZ6g=
X-Received: by 2002:aa7:c50e:: with SMTP id o14mr12184408edq.164.1583798120055;
 Mon, 09 Mar 2020 16:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <e75e80e820f215d2311941e083580827f6c1dbb6.1582059594.git.rgb@redhat.com>
 <CAHC9VhTXFg_w8xJChPZZFY=HMpF722p-_NYy=06xjSkLFSCzbg@mail.gmail.com> <20200309203107.lzhshn6uzknhmosu@madcap2.tricolour.ca>
In-Reply-To: <20200309203107.lzhshn6uzknhmosu@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Mar 2020 19:55:09 -0400
Message-ID: <CAHC9VhS9o7wmBEfvF=+=cfUzvfcTs9Hu15KcLJjW+92KxBxQ3g@mail.gmail.com>
Subject: Re: [PATCH ghak120] audit: trigger accompanying records when no rules present
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sgrubb@redhat.com,
        omosnace@redhat.com, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 4:31 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-02-27 20:02, Paul Moore wrote:
> > On Tue, Feb 18, 2020 at 4:01 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > >
> > > When there are no audit rules registered, mandatory records (config,
> > > etc.) are missing their accompanying records (syscall, proctitle, etc.).
> > >
> > > This is due to audit context dummy set on syscall entry based on absence
> > > of rules that signals that no other records are to be printed.
> > >
> > > Clear the dummy bit in auditsc_set_stamp() when the first record of an
> > > event is generated.
> > >
> > > Please see upstream github issue
> > > https://github.com/linux-audit/audit-kernel/issues/120
> > >
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  kernel/auditsc.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > index 4effe01ebbe2..31195d122344 100644
> > > --- a/kernel/auditsc.c
> > > +++ b/kernel/auditsc.c
> > > @@ -2176,6 +2176,8 @@ int auditsc_get_stamp(struct audit_context *ctx,
> > >         t->tv_sec  = ctx->ctime.tv_sec;
> > >         t->tv_nsec = ctx->ctime.tv_nsec;
> > >         *serial    = ctx->serial;
> > > +       if (ctx->dummy)
> > > +               ctx->dummy = 0;
> >
> > Two comments:
> >
> > * Why even bother checking to see if ctx->dummy is true?  If it is
> > true you set it to false/0; if it is already false you leave it alone.
> > Either way ctx->dummy is going to be set to false when you are past
> > these two lines, might as well just always set ctx->dummy to false/0.
>
> Ok, no problem.
>
> > * Why are you setting ->dummy to false in auditsc_get_stamp() and not
> > someplace a bit more obvious like audit_log_start()?  Is it because
> > auditsc_get_stamp() only gets called once per event?  I'm willing to
> > take the "hit" of one extra assignment in audit_log_start() to keep
> > this in a more obvious place and not buried in auditsc_get_stamp().
>
> It is because the context is only available when syscall logging is
> enabled (which is on most platforms and hopefully eventually all) and
> makes for cleaner code and lack of need to check existance of the
> context.

At the very least let's create some sort of accessor function for
dummy then, hiding this in auditsc_get_stamp() seems very wrong to me.

-- 
paul moore
www.paul-moore.com
