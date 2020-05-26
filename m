Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD172C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A192E20787
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OWLNLeHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388740AbgEZMJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 08:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbgEZMJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 08:09:02 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1192FC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 05:09:02 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w15so12116758lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 05:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kulYH3lmmnPKwAS9+Zs0TnGDE8yYdLKMfltc9Vjgfe0=;
        b=OWLNLeHWpYS7i/mjtJQHfLmxjDJmeg6ICAaWI/gjdUNUqCB6IuyVTO3eP7+6UaC9ov
         AFjSHUDGNDJ1F0y6zoLxRQkI+u+GCITEap29n+N7q/KNHktDRarjizn+r2g8uaYGc/mm
         iiVuQ20JoEyWLI+XWZqkaCO6zAQNhRuJiIhTIo/E+HfOLxCilnr932+hDAQsTtHUTKtD
         s4XAXhljFRdvW6SEOkVELKzX2jEqdEFA3eIRpFlBtdw2ak8F1+Fi057vTVdyIip0jhTI
         Hq6HdPM1KYBA9lgf40mvhYM5b39Dau58MnQvxieRNn3qGidz5S49im0uzna4N0PPInUS
         lvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kulYH3lmmnPKwAS9+Zs0TnGDE8yYdLKMfltc9Vjgfe0=;
        b=fNqNvcVCPT7AZpgtrBlITAAxauQyETwmp9gIjLPEoBNtfEcgmu02X/nVZM3hyf7Gce
         CEqNEftc95o6knsNVheDEobF9vMWfTeAOljPeGamr968lLMPKgE6SNTBC+9QDlR3bdUJ
         Cj1zb/1laUEc22W6WR2c4obWt2/9twkiXsZDSa3Yl1X6i9HCaKvnGKVNZP5gONkIe+Jc
         zw72wU7FqpGVWPcer5CW6fEiW4DL10ePG5mqKCMN6npM7Jy8CFoEmSz4+WI/23H/no+R
         btVN86na7D+u/uP2Wyop66ePOlJm2EfKTzuZGlrN9tXn6BtDrBFkonL0KKXkdAEBlEKB
         2ldg==
X-Gm-Message-State: AOAM532Dz1DQLNPa2R87KH+TZ4G5YT6hRyXi/B+XU/q8XghN5uuJ0jbY
        WTdBKSvxeuaQ1GJ6dqR5xzZEsmxVGkKJzjGTVxxhmA==
X-Google-Smtp-Source: ABdhPJxnUrjRwYL1PCx9h/92qPSRPfBbMYlzq9PSv1CkoagdOL2NPMTdT2aIY/vV/6tokloW2gHDWvIe512j8u603Vg=
X-Received: by 2002:a05:6512:2027:: with SMTP id s7mr378257lfs.15.1590494940286;
 Tue, 26 May 2020 05:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <1590158071-15325-1-git-send-email-sumit.garg@linaro.org>
 <20200522160258.yq63iigp74u3ngtn@holly.lan> <CAFA6WYPrB1m1YDf54-OFNWmmTOv+8T5ZyTx14fxqZ-Jvx6fQQQ@mail.gmail.com>
 <20200526111050.qfvdlw3jp2gokktg@holly.lan>
In-Reply-To: <20200526111050.qfvdlw3jp2gokktg@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 26 May 2020 17:38:48 +0530
Message-ID: <CAFA6WYPhf5WEp7K7++J5Qisy=H2UF8tmShmad=Xzr23ctkOuAA@mail.gmail.com>
Subject: Re: [RFC] kdb: Switch kdb_printf to use safer console poll APIs
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

On Tue, 26 May 2020 at 16:40, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, May 26, 2020 at 01:16:17PM +0530, Sumit Garg wrote:
> > On Fri, 22 May 2020 at 21:33, Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Fri, May 22, 2020 at 08:04:31PM +0530, Sumit Garg wrote:
> > > > In kgdb NMI context, polling driver APIs are more safer to use instead
> > > > of console APIs since the polling drivers know they will execute from
> > > > all sorts of crazy places. And for the most common use cases this would
> > > > also result in no console handler ever being called. So switch to use
> > > > polling driver APIs in case a particular console supports polling mode.
> > >
> > > This comment seems rather half hearted, not least because it doesn't
> > > explain what the current problem is nor why using the polling API is
> > > safer.
> > >
> >
> > TBH, some sentences in the above comment were borrowed from your
> > suggestion here [1]. But I agree that it doesn't portray the complete
> > picture. So how about:
> >
> > ====
> > In kgdb NMI context, calling console handlers isn't safe due to locks
> > used in those handlers which could lead to a deadlock. Although, using
> > oops_in_progress increases the chance to bypass locks in most console
> > handlers but it might not be sufficient enough in case a console uses
> > more locks (VT/TTY is good example).
> >
> > So instead switch to use lockless polling driver APIs in case a
> > particular console supports polling mode which is common for most kdb
> > use-cases and would result in no console handler ever being called.
> > ====
>
> Better, although the later paragraph still seems rather vague to me.
> Compare to:
>
> Currently when a driver provides both polling I/O and a console then kdb
> will output using the console. We can increase robustness by using the
> currently active polling I/O driver (which should be lockless) instead
> of the corresponding console. For several common cases (e.g. an
> embedded system with a single serial port that is used both for console
> output and debugger I/O) this will result in no console handler being
> used.
>

Looks good, will use it instead.

>
> > [1] https://lkml.org/lkml/2020/5/20/356
> >
> > > Compare the above against the advice in
> > > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
> > > and I think it comes up short. Perhaps also consider Ingo Molnar's much
> > > more concise suggestion on describing changes:
> > >
> > > : Please use the customary changelog style we use in the kernel:
> > > :   " Current code does (A), this has a problem when (B).
> > > :   We can improve this doing (C), because (D)."
> > > -- http://lkml.iu.edu/hypermail//linux/kernel/1311.1/01157.html
> >
> > Thanks for the pointers.
> >
> > >
> > >
> > > > Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >  kernel/debug/kdb/kdb_io.c | 39 +++++++++++++++++++++++++++++++++------
> > > >  1 file changed, 33 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > > > index 3a5a068..8e0d581 100644
> > > > --- a/kernel/debug/kdb/kdb_io.c
> > > > +++ b/kernel/debug/kdb/kdb_io.c
> > > > @@ -24,6 +24,7 @@
> > > >  #include <linux/kgdb.h>
> > > >  #include <linux/kdb.h>
> > > >  #include <linux/kallsyms.h>
> > > > +#include <linux/tty_driver.h>
> > > >  #include "kdb_private.h"
> > > >
> > > >  #define CMD_BUFLEN 256
> > > > @@ -699,11 +700,24 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> > > >                       }
> > > >               }
> > > >               for_each_console(c) {
> > > > +                     int line;
> > > > +                     struct tty_driver *p;
> > > > +
> > > >                       if (!(c->flags & CON_ENABLED))
> > > >                               continue;
> > > > -                     ++oops_in_progress;
> > > > -                     c->write(c, cp, retlen - (cp - kdb_buffer));
> > > > -                     --oops_in_progress;
> > > > +                     p = c->device ? c->device(c, &line) : NULL;
> > > > +                     if (p && p->ops && p->ops->poll_put_char) {
> > >
> > > What prevents this logic from matching an active console that hasn't
> > > been selected as the polling driver?
> >
> > Yes you are correct and it could lead to invoking poll_put_char()
> > without poll_init(). And we couldn't invoke poll_init() here as that
> > still comes with locks and could sleep. So one way to overcome this
> > would be to pass selected polling driver via dbg_io_ops and use
> > polling APIs only if the underlying console driver matches that
> > polling driver.
>
> Agree.
>
> Note that this is all I ever expected to look at when I commented about
> before.

Okay.

>
>
> > > > +                             len = retlen - (cp - kdb_buffer);
> > > > +                             cp2 = cp;
> > > > +                             while (len--) {
> > > > +                                     p->ops->poll_put_char(p, line, *cp2);
> > > > +                                     cp2++;
> > > > +                             }
> > >
> > > Assuming it is possible to identify the console that matches the
> > > currently selected polling driver can't we just drop the
> > > is_console test and get rid of this branch entirely.
> >
> > Have a look at my suggested approach above.
> >
> > >
> > > The only reason for the is_console test is to avoid issuing messages
> > > twice so if we are able to suppress the c->write() for the same UART
> > > then is_console check becomes pointless and can go.
> >
> > I did consider removing is_console check but it looks like it's not
> > only limited to polling drivers but also used at other places (see [1]
> > [2]) as well.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/early/ehci-dbgp.c#n1061
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/kgdb_nmi.c#n48
>
> IIUC you mean that the logic to match devices only works for tty drivers
> and there examples are not tty drivers.
>
> This could probably be solved but no need to get too tied in knots. It's
> fine to keep the is_console check for now.
>

Okay.

> However rather than replicate the polled I/O write code a third and
> fourth time lets get the I/O logic pulled out into proper functions.
>

Sure, will do the refactoring.

-Sumit

>
>
> Daniel.
