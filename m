Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AF5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 458C52084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eRChNU0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388789AbgEZLK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 07:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388683AbgEZLK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 07:10:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932F7C03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 04:10:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so19988473wrt.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 04:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6RAM8Sj52MEn9Pq3/CfMGq4xvMrRRJlBrM0wddYyE9s=;
        b=eRChNU0BPToFg/f5+T8hjxG/g/Qj0asd99BaepOtZNY6qh3JapmOtcjj0vCtg0Le7J
         8/0hzVo3Pdh09jpgC3fnV1NO+enuLsphHdxU5+jYaJuTpFHpnbyP4mLE4P2nbkW7IjZn
         XdpaD9mpikrOBNjW6CiccEJqEkQVAThQI3CC+zC80S8bSZPAkHcPQFedtFS3W/6W8s8B
         gwC/AKo9eb5VTSPOV3NInocOLF3cW2nidD2Zusd7reLENYZkIAJP6GRcgaioaC76zpfU
         wzANgk2QVhBxEQXk2915zmtpXu+P8qqlSoTrp5+TtRiNJdkz0zP9dNboTjGyfMDtTC/x
         tUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6RAM8Sj52MEn9Pq3/CfMGq4xvMrRRJlBrM0wddYyE9s=;
        b=q5GpKknr8Wv7NiHOviJUulavbKv95lDqhLgep5r68Zwb8OkSO5lJwkG61mXEj3WrXz
         8hek7dRKepR+9C6/bN8sbwtK4GbYGxXpc9Ha7mOo4j8RFD20g5zVNCWQcwQ+GsIFyRdm
         vCefFJfAzEBgcoD5mpl2oWK+jJGKEZENzbSQWhpznbAudzO+T7e831XL0gZTSrI+zjQ6
         lKL6OkU/xvTOTy/uzHspsd4Pwwmr53pdDh8/oj0PsCMFXvnlgDvaILe2pRzUhKhbH23T
         4h8b4xS5bvEBFvvTMLgJGyjVvjfBhI2aB0q0iPwGgXtzJstosJrAKTpcp/tQyyMIKILN
         nP8g==
X-Gm-Message-State: AOAM532Nmyf6G2/DIFwUXwgyiz15J10lDMtbjE1GTN/WBiUwgkIkDxYx
        SW0TdizyhkPkdM/xaVvwitJutg==
X-Google-Smtp-Source: ABdhPJwV+/d2vA+iTFlb6VnoI7LO+cPJNhi0t8+UkVY08VpuS+3L6yE14T3S0uWQnnVdN/sEo6jDaw==
X-Received: by 2002:adf:df03:: with SMTP id y3mr11531546wrl.376.1590491452888;
        Tue, 26 May 2020 04:10:52 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id d4sm20656648wre.22.2020.05.26.04.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 04:10:52 -0700 (PDT)
Date:   Tue, 26 May 2020 12:10:50 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] kdb: Switch kdb_printf to use safer console poll APIs
Message-ID: <20200526111050.qfvdlw3jp2gokktg@holly.lan>
References: <1590158071-15325-1-git-send-email-sumit.garg@linaro.org>
 <20200522160258.yq63iigp74u3ngtn@holly.lan>
 <CAFA6WYPrB1m1YDf54-OFNWmmTOv+8T5ZyTx14fxqZ-Jvx6fQQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPrB1m1YDf54-OFNWmmTOv+8T5ZyTx14fxqZ-Jvx6fQQQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 01:16:17PM +0530, Sumit Garg wrote:
> On Fri, 22 May 2020 at 21:33, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Fri, May 22, 2020 at 08:04:31PM +0530, Sumit Garg wrote:
> > > In kgdb NMI context, polling driver APIs are more safer to use instead
> > > of console APIs since the polling drivers know they will execute from
> > > all sorts of crazy places. And for the most common use cases this would
> > > also result in no console handler ever being called. So switch to use
> > > polling driver APIs in case a particular console supports polling mode.
> >
> > This comment seems rather half hearted, not least because it doesn't
> > explain what the current problem is nor why using the polling API is
> > safer.
> >
> 
> TBH, some sentences in the above comment were borrowed from your
> suggestion here [1]. But I agree that it doesn't portray the complete
> picture. So how about:
> 
> ====
> In kgdb NMI context, calling console handlers isn't safe due to locks
> used in those handlers which could lead to a deadlock. Although, using
> oops_in_progress increases the chance to bypass locks in most console
> handlers but it might not be sufficient enough in case a console uses
> more locks (VT/TTY is good example).
> 
> So instead switch to use lockless polling driver APIs in case a
> particular console supports polling mode which is common for most kdb
> use-cases and would result in no console handler ever being called.
> ====

Better, although the later paragraph still seems rather vague to me.
Compare to:

Currently when a driver provides both polling I/O and a console then kdb
will output using the console. We can increase robustness by using the
currently active polling I/O driver (which should be lockless) instead
of the corresponding console. For several common cases (e.g. an
embedded system with a single serial port that is used both for console
output and debugger I/O) this will result in no console handler being
used.


> [1] https://lkml.org/lkml/2020/5/20/356
> 
> > Compare the above against the advice in
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
> > and I think it comes up short. Perhaps also consider Ingo Molnar's much
> > more concise suggestion on describing changes:
> >
> > : Please use the customary changelog style we use in the kernel:
> > :   " Current code does (A), this has a problem when (B).
> > :   We can improve this doing (C), because (D)."
> > -- http://lkml.iu.edu/hypermail//linux/kernel/1311.1/01157.html
> 
> Thanks for the pointers.
> 
> >
> >
> > > Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  kernel/debug/kdb/kdb_io.c | 39 +++++++++++++++++++++++++++++++++------
> > >  1 file changed, 33 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > > index 3a5a068..8e0d581 100644
> > > --- a/kernel/debug/kdb/kdb_io.c
> > > +++ b/kernel/debug/kdb/kdb_io.c
> > > @@ -24,6 +24,7 @@
> > >  #include <linux/kgdb.h>
> > >  #include <linux/kdb.h>
> > >  #include <linux/kallsyms.h>
> > > +#include <linux/tty_driver.h>
> > >  #include "kdb_private.h"
> > >
> > >  #define CMD_BUFLEN 256
> > > @@ -699,11 +700,24 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> > >                       }
> > >               }
> > >               for_each_console(c) {
> > > +                     int line;
> > > +                     struct tty_driver *p;
> > > +
> > >                       if (!(c->flags & CON_ENABLED))
> > >                               continue;
> > > -                     ++oops_in_progress;
> > > -                     c->write(c, cp, retlen - (cp - kdb_buffer));
> > > -                     --oops_in_progress;
> > > +                     p = c->device ? c->device(c, &line) : NULL;
> > > +                     if (p && p->ops && p->ops->poll_put_char) {
> >
> > What prevents this logic from matching an active console that hasn't
> > been selected as the polling driver?
> 
> Yes you are correct and it could lead to invoking poll_put_char()
> without poll_init(). And we couldn't invoke poll_init() here as that
> still comes with locks and could sleep. So one way to overcome this
> would be to pass selected polling driver via dbg_io_ops and use
> polling APIs only if the underlying console driver matches that
> polling driver.

Agree.

Note that this is all I ever expected to look at when I commented about
before.


> > > +                             len = retlen - (cp - kdb_buffer);
> > > +                             cp2 = cp;
> > > +                             while (len--) {
> > > +                                     p->ops->poll_put_char(p, line, *cp2);
> > > +                                     cp2++;
> > > +                             }
> >
> > Assuming it is possible to identify the console that matches the
> > currently selected polling driver can't we just drop the
> > is_console test and get rid of this branch entirely.
> 
> Have a look at my suggested approach above.
> 
> >
> > The only reason for the is_console test is to avoid issuing messages
> > twice so if we are able to suppress the c->write() for the same UART
> > then is_console check becomes pointless and can go.
> 
> I did consider removing is_console check but it looks like it's not
> only limited to polling drivers but also used at other places (see [1]
> [2]) as well.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/early/ehci-dbgp.c#n1061
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/kgdb_nmi.c#n48

IIUC you mean that the logic to match devices only works for tty drivers
and there examples are not tty drivers.

This could probably be solved but no need to get too tied in knots. It's
fine to keep the is_console check for now.

However rather than replicate the polled I/O write code a third and
fourth time lets get the I/O logic pulled out into proper functions.



Daniel.
