Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B9AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B2DC208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hui1DnMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgE1Hmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgE1Hmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:42:54 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B924FC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:42:53 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u16so14249246lfl.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSEppCnMjooqv/+hpmajhkWVfY46SE18er3CWPFn//o=;
        b=hui1DnMSPQC8PalrmA2xNhPN47Qgt0NGSGYl98vRy0j+p5BNUKzW8ao4PnCHdNLZjf
         8YMJvNVzze8CKA1S01XNUb5YZ+3hbOJqlL4hYKbqftLsRFamH3vto3EDzI2EeSgH1L2o
         y/8XLjs8fOKBOHXLFirMZhvzwDKyjiB3/lCHq1hVsAbbiq5WqaY3YfdMizYkdgXoUk64
         omQp38by/IReL9pn3bEj3wXKW6QJEdQAe9VOT7EWenE1dogEOCQj4aiQ34hwaaoO69vx
         zg6gCmLT5Qa7RHGKa28X+dhsr5NLbOapGO5iqNAvitE/VArwygmcTv5Y6PycMvDoQztu
         4sWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSEppCnMjooqv/+hpmajhkWVfY46SE18er3CWPFn//o=;
        b=DlHvB/FM2+6BC8zUFDArKcqxJUb4vSA2kpZdgkLLTvk+E5mw0Bb3pXZRCMzlxQYhad
         lOBR8ARZRKbwjfaL4yhr1c2acAl51uOsejS0l8t30//WHNo1ccUMO7uFKiKCr8vL8UPd
         IyDyxOogGcRIMLAFvq2Kry+9Z+qHRlFKLtRiQyd9tOfX8FYZ6u7GVXVfgxP78csL1Zvx
         i8DYKJbUhaIm7VgV+CqRQIGTou/opWhrfp+yG6Lu0OuzyoEIs8k+f5dk1/5tpKzYmaxJ
         LIgmJe4ZKbZSDkmikLS/YtiwRQJv5NGsqd5l/rEecPtytlNXXAAEGQ20CTvqPGX28QdP
         Seew==
X-Gm-Message-State: AOAM5326u9xh+UBIKXXIoB4Bt4YYUWn2cNb02ADbQRhJfaHafxObi9L4
        a5bCoLkUNhvLFUfQPt9fijaGT4KqmBScW/i5hryi3w==
X-Google-Smtp-Source: ABdhPJwYhDoQO6Cp5QbjY4T1T1tzuKF/ozZxhlC6wEzxvYQ17TmXwrSXZSVTlT7S0TURw1ma+1cobn5lIjFOjE7gGTY=
X-Received: by 2002:ac2:4293:: with SMTP id m19mr1009321lfh.204.1590651772089;
 Thu, 28 May 2020 00:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <1590560759-21453-1-git-send-email-sumit.garg@linaro.org>
 <1590560759-21453-4-git-send-email-sumit.garg@linaro.org> <20200527142617.t7dzal7ok5i3exra@holly.lan>
In-Reply-To: <20200527142617.t7dzal7ok5i3exra@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 28 May 2020 13:12:40 +0530
Message-ID: <CAFA6WYNY1tk=Md84tuSHOBgmB330eAAV8yWM1XLT0sDcbWus6A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] kdb: Make kdb_printf robust to run in NMI context
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 at 19:56, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, May 27, 2020 at 11:55:58AM +0530, Sumit Garg wrote:
> > While rounding up CPUs via NMIs, its possible that a rounded up CPU
>
> This problem does not just impact NMI roundup (breakpoints,

I guess here via breakpoints you meant if we add a compiled breakpoint
or runtime breakpoint in console handler code while its holding the
spin lock could lead to a deadlock, correct?

> including
> implicit breakpoint-on-oops can have the same effect).
>

Isn't the breakpoint-on-oops case already handled via bust_spinlocks()
usage in panic handler here [1]?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/panic.c#n207

>
> > maybe holding a console port lock leading to kgdb master CPU stuck in
> > a deadlock during invocation of console write operations. So in order
> > to avoid such a deadlock, enable oops_in_progress prior to invocation
> > of console handlers.
> >
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  kernel/debug/kdb/kdb_io.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > index 349dfcc..f848482 100644
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -566,7 +566,17 @@ static void kdb_msg_write(char *msg, int msg_len)
> >       for_each_console(c) {
> >               if (!(c->flags & CON_ENABLED))
> >                       continue;
> > +             /*
> > +              * While rounding up CPUs via NMIs, its possible that
>
> Ditto.
>
> > +              * a rounded up CPU maybe holding a console port lock
> > +              * leading to kgdb master CPU stuck in a deadlock during
> > +              * invocation of console write operations. So in order
> > +              * to avoid such a deadlock, enable oops_in_progress
> > +              * prior to invocation of console handlers.
>
> Actually looking at this comment as a whole I think it spends to many
> words on what and not enough on why (e.g. what the tradeoffs are and
> why we are not using bust_spinlocks() which would be a more obvious
> approach).
>
>   Set oops_in_progress to encourage the console drivers to disregard
>   their internal spin locks: in the current calling context
>   the risk of deadlock is a bigger problem than risks due to
>   re-entering the console driver. We operate directly on
>   oops_in_progress rather than using bust_spinlocks() because
>   the calls bust_spinlocks() makes on exit are not appropriate
>   for this calling context.

Sounds reasonable, will use it instead.

-Sumit

>
>
> Daniel.
>
>
> > +              */
> > +             ++oops_in_progress;
> >               c->write(c, msg, msg_len);
> > +             --oops_in_progress;
> >               touch_nmi_watchdog();
> >       }
> >  }
> > --
> > 2.7.4
> >
