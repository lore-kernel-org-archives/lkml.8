Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D74C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DF52467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ECuSEsL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgCJMIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:08:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33846 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgCJMIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:08:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id c21so16023816edt.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=He80gN+PoQea1vofurK2Qjmrv3YqUU2ZePh0yVQWrzo=;
        b=ECuSEsL27iHjpyfwE91w5cyROG15xN7CwPE5WzLVq+sj0kE353k/mvmEQJT/gTE1nt
         I9wmc+abYGuAKe8UJIodPzXXmwT8duHqR+ipOe3omJq8O0xyXEY4zp3+6PqzJ1Icy3RK
         2Um6KnBw3jzqRmvFiKy2Gg5jpvKC3k9v/FSPuSXqv3f9ZCtwi1xWkGJrHfk5FOIcdbIe
         GiAhWV9dl1ohcFNKcSeaEbcCfhdgmDl+HNIMHSgdQ+9biW6KXj0JaSXNzZt3tx/q1pLn
         XvvbbiXSTQRafoR6bTRt6l7AqkBuGGLAxpe88nfgGsZZIaeCkb4aesjdpCEAWY6UA7Lk
         CL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=He80gN+PoQea1vofurK2Qjmrv3YqUU2ZePh0yVQWrzo=;
        b=fIG6zHb1Qg82QrjL0OspuK6RhFQYUTTAUgLS2DWhW9r2LS0Afisx9WfWHCrA+c8KoR
         IyogqZPzgHyah0DU2fQ5PecJqge09BZ0/xe1ohnbJFntGoXzC2+3zoRisNKsHcWQmy07
         nPVOjx9GxZ6F1UU2skCKcQ8xMjVB8V3xSp/8gAUXMYk0Gk9+i4txrAZfRx7JiTuHw9MI
         OsIkSlrxB2XGsNP76W/8ntx218sccFZGSEjwDDjK3vK8uTTWTNDJ9P+asChfcCO40Sva
         Rb4+jPql5vLwPTlYc/eodpBT5IP9TlOL88sgVrKtGUmKbq+y4KBXywbVygakQyVI2TP8
         t3FA==
X-Gm-Message-State: ANhLgQ0OFLjhe1RWJYd+QatzkcQF4Bl1SBrhdSqLNIdDthxovIDgiETN
        pmjgK7DzSlQDf9hExIyt++a6zpV8ZmnRAerC5PS6
X-Google-Smtp-Source: ADFU+vu+XJ6RuvL6RFbYQ8x+3M18Y184Yr8DMbLsYkxeLPPLMtPjry1x82KS1y+J9d/vPeI9OncTJ5s/PsJnQLMQLWM=
X-Received: by 2002:a17:906:7fc9:: with SMTP id r9mr18335708ejs.77.1583842101112;
 Tue, 10 Mar 2020 05:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <e75e80e820f215d2311941e083580827f6c1dbb6.1582059594.git.rgb@redhat.com>
 <CAHC9VhTXFg_w8xJChPZZFY=HMpF722p-_NYy=06xjSkLFSCzbg@mail.gmail.com>
 <20200309203107.lzhshn6uzknhmosu@madcap2.tricolour.ca> <CAHC9VhS9o7wmBEfvF=+=cfUzvfcTs9Hu15KcLJjW+92KxBxQ3g@mail.gmail.com>
 <20200310005858.m4s23fl3huwevyp5@madcap2.tricolour.ca>
In-Reply-To: <20200310005858.m4s23fl3huwevyp5@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 10 Mar 2020 08:08:10 -0400
Message-ID: <CAHC9VhSz1puQ5oQCnO5-Vq8GUsJh2BvbSmpoY_RqLLPQKd6udA@mail.gmail.com>
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

On Mon, Mar 9, 2020 at 8:59 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> On 2020-03-09 19:55, Paul Moore wrote:
> > On Mon, Mar 9, 2020 at 4:31 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2020-02-27 20:02, Paul Moore wrote:
> > > > On Tue, Feb 18, 2020 at 4:01 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > >
> > > > > When there are no audit rules registered, mandatory records (config,
> > > > > etc.) are missing their accompanying records (syscall, proctitle, etc.).
> > > > >
> > > > > This is due to audit context dummy set on syscall entry based on absence
> > > > > of rules that signals that no other records are to be printed.
> > > > >
> > > > > Clear the dummy bit in auditsc_set_stamp() when the first record of an
> > > > > event is generated.
> > > > >
> > > > > Please see upstream github issue
> > > > > https://github.com/linux-audit/audit-kernel/issues/120
> > > > >
> > > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > > ---
> > > > >  kernel/auditsc.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > > index 4effe01ebbe2..31195d122344 100644
> > > > > --- a/kernel/auditsc.c
> > > > > +++ b/kernel/auditsc.c
> > > > > @@ -2176,6 +2176,8 @@ int auditsc_get_stamp(struct audit_context *ctx,
> > > > >         t->tv_sec  = ctx->ctime.tv_sec;
> > > > >         t->tv_nsec = ctx->ctime.tv_nsec;
> > > > >         *serial    = ctx->serial;
> > > > > +       if (ctx->dummy)
> > > > > +               ctx->dummy = 0;
> > > >
> > > > Two comments:
> > > >
> > > > * Why even bother checking to see if ctx->dummy is true?  If it is
> > > > true you set it to false/0; if it is already false you leave it alone.
> > > > Either way ctx->dummy is going to be set to false when you are past
> > > > these two lines, might as well just always set ctx->dummy to false/0.
> > >
> > > Ok, no problem.
> > >
> > > > * Why are you setting ->dummy to false in auditsc_get_stamp() and not
> > > > someplace a bit more obvious like audit_log_start()?  Is it because
> > > > auditsc_get_stamp() only gets called once per event?  I'm willing to
> > > > take the "hit" of one extra assignment in audit_log_start() to keep
> > > > this in a more obvious place and not buried in auditsc_get_stamp().
> > >
> > > It is because the context is only available when syscall logging is
> > > enabled (which is on most platforms and hopefully eventually all) and
> > > makes for cleaner code and lack of need to check existance of the
> > > context.
> >
> > At the very least let's create some sort of accessor function for
> > dummy then, hiding this in auditsc_get_stamp() seems very wrong to me.
>
> Ok.  Anything else?

I'm not sure how many more words we can spill over a two line patch :)

Work up the v2, post it, and we can go from there.

-- 
paul moore
www.paul-moore.com
