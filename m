Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1738C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645092068D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pT0dqlfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbgEZHqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgEZHqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:46:31 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7783DC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:46:30 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z18so23253796lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQ87BRHcrbqQygTpbGAEYk24csbidXVhewCA+tV163o=;
        b=pT0dqlfYxNrmxZdJ7WcBG4vZvY0NSYhHnfTgOqxbzTgplNWrJvfxj2dwhgG/ZYJ+d2
         K+qSDuDx2TIaYLEHN/5AhVNqf2paivkjNzq8qsUwOCW+oYXLut0oPOFgkL0SK4pZJ7Tf
         MdsveoS22AHeRiuF+n5JfJ92kQHFs74x1/InPAnwc3pD7tK66aYEiMxm/Doxseo3Ewu+
         Ll9IxV6NfRNUOr+JV/pNljARCa8v5goHEUePN4aSQ8GVQgRVSGS5Yf+eCuCjm4KWAPz3
         DSXkrVVMKfXnPOfBFu574U+SmKIKsOoPJf/vkXAaq3WZ9TWxReJXujA47v2tTuprGdUd
         s/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQ87BRHcrbqQygTpbGAEYk24csbidXVhewCA+tV163o=;
        b=rcG+k8CIGEvgCCyg1y9oZt6Q1x0q9hujweqzvK5pTBorEtrHm4inLhFNbnOvDHJHQL
         0qtcrCJgIobJ/NYK0vpv14jZXfkIk9Z0ZxIA21YnyRAAVLJ4J/BCqPVBEej2PQ23qq+6
         rE595mZAcHGlovbIapTS4ozyWU1fIdo3AeCgknWbCLISHbbeXkN+xDfnUipsqVOHdg+P
         xeX1xNOR287C9ZmhwBI91ss7YAb8ur7+c0LvF3XXIGgS6G9sqq4MHNJ4PvAWqFTGZVjQ
         AovmXMVT8TT064pEOc18B1Bby6buLAXqkoGDmlz3zDW6M1W1aAqy1J4+knxeCy129ay7
         Ze3w==
X-Gm-Message-State: AOAM530AXHJyTiYDF3QHSMs3xUYwJ0++PT33GHht4X5+ELMzUXSXdsws
        54Cubau0bvqEtBBOcCpWHbWFtUUgtHGSB0UT5dVpmA==
X-Google-Smtp-Source: ABdhPJyrR0ZnDKgzWGnWJfcKQzfDfE5kOqq6TuQGhpDG/FxS6lpzsuhsxTuhxNGYNouSj0csLuiPjgvGwKcVgeMt/Fk=
X-Received: by 2002:a2e:2204:: with SMTP id i4mr1157007lji.110.1590479188783;
 Tue, 26 May 2020 00:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <1590158071-15325-1-git-send-email-sumit.garg@linaro.org> <20200522160258.yq63iigp74u3ngtn@holly.lan>
In-Reply-To: <20200522160258.yq63iigp74u3ngtn@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 26 May 2020 13:16:17 +0530
Message-ID: <CAFA6WYPrB1m1YDf54-OFNWmmTOv+8T5ZyTx14fxqZ-Jvx6fQQQ@mail.gmail.com>
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

On Fri, 22 May 2020 at 21:33, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, May 22, 2020 at 08:04:31PM +0530, Sumit Garg wrote:
> > In kgdb NMI context, polling driver APIs are more safer to use instead
> > of console APIs since the polling drivers know they will execute from
> > all sorts of crazy places. And for the most common use cases this would
> > also result in no console handler ever being called. So switch to use
> > polling driver APIs in case a particular console supports polling mode.
>
> This comment seems rather half hearted, not least because it doesn't
> explain what the current problem is nor why using the polling API is
> safer.
>

TBH, some sentences in the above comment were borrowed from your
suggestion here [1]. But I agree that it doesn't portray the complete
picture. So how about:

====
In kgdb NMI context, calling console handlers isn't safe due to locks
used in those handlers which could lead to a deadlock. Although, using
oops_in_progress increases the chance to bypass locks in most console
handlers but it might not be sufficient enough in case a console uses
more locks (VT/TTY is good example).

So instead switch to use lockless polling driver APIs in case a
particular console supports polling mode which is common for most kdb
use-cases and would result in no console handler ever being called.
====

[1] https://lkml.org/lkml/2020/5/20/356

> Compare the above against the advice in
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
> and I think it comes up short. Perhaps also consider Ingo Molnar's much
> more concise suggestion on describing changes:
>
> : Please use the customary changelog style we use in the kernel:
> :   " Current code does (A), this has a problem when (B).
> :   We can improve this doing (C), because (D)."
> -- http://lkml.iu.edu/hypermail//linux/kernel/1311.1/01157.html

Thanks for the pointers.

>
>
> > Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  kernel/debug/kdb/kdb_io.c | 39 +++++++++++++++++++++++++++++++++------
> >  1 file changed, 33 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > index 3a5a068..8e0d581 100644
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/kgdb.h>
> >  #include <linux/kdb.h>
> >  #include <linux/kallsyms.h>
> > +#include <linux/tty_driver.h>
> >  #include "kdb_private.h"
> >
> >  #define CMD_BUFLEN 256
> > @@ -699,11 +700,24 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> >                       }
> >               }
> >               for_each_console(c) {
> > +                     int line;
> > +                     struct tty_driver *p;
> > +
> >                       if (!(c->flags & CON_ENABLED))
> >                               continue;
> > -                     ++oops_in_progress;
> > -                     c->write(c, cp, retlen - (cp - kdb_buffer));
> > -                     --oops_in_progress;
> > +                     p = c->device ? c->device(c, &line) : NULL;
> > +                     if (p && p->ops && p->ops->poll_put_char) {
>
> What prevents this logic from matching an active console that hasn't
> been selected as the polling driver?

Yes you are correct and it could lead to invoking poll_put_char()
without poll_init(). And we couldn't invoke poll_init() here as that
still comes with locks and could sleep. So one way to overcome this
would be to pass selected polling driver via dbg_io_ops and use
polling APIs only if the underlying console driver matches that
polling driver.

>
>
> > +                             len = retlen - (cp - kdb_buffer);
> > +                             cp2 = cp;
> > +                             while (len--) {
> > +                                     p->ops->poll_put_char(p, line, *cp2);
> > +                                     cp2++;
> > +                             }
>
> Assuming it is possible to identify the console that matches the
> currently selected polling driver can't we just drop the
> is_console test and get rid of this branch entirely.

Have a look at my suggested approach above.

>
> The only reason for the is_console test is to avoid issuing messages
> twice so if we are able to suppress the c->write() for the same UART
> then is_console check becomes pointless and can go.

I did consider removing is_console check but it looks like it's not
only limited to polling drivers but also used at other places (see [1]
[2]) as well.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/early/ehci-dbgp.c#n1061
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/kgdb_nmi.c#n48

>
>
> > +                     } else {
> > +                             ++oops_in_progress;
> > +                             c->write(c, cp, retlen - (cp - kdb_buffer));
> > +                             --oops_in_progress;
> > +                     }
> >                       touch_nmi_watchdog();
> >               }
> >       }
> > @@ -765,11 +779,24 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> >                       }
> >               }
> >               for_each_console(c) {
> > +                     int line;
> > +                     struct tty_driver *p;
> > +
> >                       if (!(c->flags & CON_ENABLED))
> >                               continue;
> > -                     ++oops_in_progress;
> > -                     c->write(c, moreprompt, strlen(moreprompt));
> > -                     --oops_in_progress;
> > +                     p = c->device ? c->device(c, &line) : NULL;
> > +                     if (p && p->ops && p->ops->poll_put_char) {
> > +                             len = strlen(moreprompt);
> > +                             cp = moreprompt;
> > +                             while (len--) {
> > +                                     p->ops->poll_put_char(p, line, *cp);
> > +                                     cp++;
> > +                             }
> > +                     } else {
> > +                             ++oops_in_progress;
> > +                             c->write(c, moreprompt, strlen(moreprompt));
> > +                             --oops_in_progress;
> > +                     }
>
> Maybe also consider pulling the string emit to a separate function.
>

Okay.

-Sumit

>
> Daniel.
