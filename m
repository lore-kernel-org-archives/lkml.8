Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B149C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA0D20671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kkmrCP9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgEOFrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725899AbgEOFrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:47:08 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAA3C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:47:07 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 82so781208lfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qT+j8TJJ9iCnluDMt3Pn9caZLk/zokXSMj6l5Z16g+s=;
        b=kkmrCP9Gx0JjbKINF0Mhte17DK/Hk7blYGJ6tZPU42+CqxZaHjv4IbruGvl43g4R/2
         wbRyyI27sIX8CTY9HgdyiRqWSiATQy/a2eV4ZjU43Z+KPaIMYvrtVt0xgIrDN3qRs/mV
         x+ruIEYM7j4Mfldd8Hu8j0zB1LgDGgD1NVDof+rbyigq4q9IT9osIHoyDVm0HPh9mJOJ
         z6vmt3vV+7dNurDkB/ZbdCmGeYKnTZqL38k8vJYvuHhyNFmJpm+lQBacAVkTdma5ck2a
         dPeRwGfqo3Wm2I42EKj/WI9YPvuz1BFMTG93O10/Za6GQGYJD1AERm9XcJ7UtyMf/jRb
         Epsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qT+j8TJJ9iCnluDMt3Pn9caZLk/zokXSMj6l5Z16g+s=;
        b=evtdovTwJ9QGYQKVDfUhRLvvC1fGNr2eQ3WYQU209FQO2z6YCcXdMl+A/MET0f4ncu
         F1rOke4cLs2f510znSJ1bFkbRgd9cb/kgDBa94DAyVk02FsrlqQqA6Gn1h5Pj17PHix9
         +o6A0gxw4bQ/V7D0glFFx/URKRyK7f73RzuxpYXb88drreC+oNihvRn0+900Q7G6bePk
         w7JuUaJ2/J8tVPQTRma6nAtjohaiqPa4/aDsMBVNGWW0nVnt1+RtzQhK8ho2sliH7kq6
         limENcfkBi/KhZNKoN+376UJ773HvY2LkLFANyky5FYGt4D37mLDyDDUqwF+wXGy4lrn
         ueBg==
X-Gm-Message-State: AOAM532C9hYo5/kLWowmLoB8shvAUUe243fViRhVIWnCqUf5P5+KwBnS
        drtmle9lnzUIiReINniygZGF1WIUoFdVTjNLn9y6mQ==
X-Google-Smtp-Source: ABdhPJxcrxR+ThiPtxW1/TnXXheQ5A39xJ4bcu6PTv+fcQLASiAieu7AF7+kRZeYxcHIbg1H1cARbAQGiTaekTo6v/A=
X-Received: by 2002:ac2:5106:: with SMTP id q6mr1178193lfb.59.1589521626102;
 Thu, 14 May 2020 22:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
 <20200512142533.ta4uejwmq5gchtlx@holly.lan> <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei>
In-Reply-To: <20200514084230.GO17734@linux-b0ei>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 15 May 2020 11:16:54 +0530
Message-ID: <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Fix broken handling of printk() in NMI context
To:     Petr Mladek <pmladek@suse.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Thu, 14 May 2020 at 14:13, Petr Mladek <pmladek@suse.com> wrote:
>
> On Wed 2020-05-13 19:04:48, Sumit Garg wrote:
> > On Tue, 12 May 2020 at 19:55, Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Tue, May 12, 2020 at 02:18:34PM +0530, Sumit Garg wrote:
> > > > Since commit 42a0bb3f7138 ("printk/nmi: generic solution for safe printk
> > > > in NMI"), kgdb entry in NMI context defaults to use safe NMI printk()
> > >
> > > I didn't see the author on Cc: nor any of the folks whose hands it
> > > passed through. It would definitely be good to involve them in this
> > > discussion.
> > >
> >
> > Thanks for updating the Cc: list.
> >
> > >
> > > > which involves CPU specific buffers and deferred printk() until exit from
> > > > NMI context.
> > > >
> > > > But kgdb being a stop-the-world debugger, we don't want to defer printk()
> > > > especially backtrace on corresponding CPUs. So instead switch to normal
> > > > printk() mode in kgdb_cpu_enter() if entry is in NMI context.
> > >
> > > So, firstly I should *definitely* take a mea cupla for not shouting
> > > about this at the time (I was on Cc:... twice). Only thing I can say
> > > confidently is that the test suite didn't yell about this and so I
> > > didn't look at this as closely as I should have done (and that it
> > > didn't yell is mostly because I'm still building out the test suite
> > > coverage).
> > >
> > > Anyhow...
> > >
> > > This feels a little like we are smearing the printk() interception logic
> > > across the kernel in ways that make things hard to read. If we accepted
> > > this patch we then have, the new NMI interception logic, the old kdb
> > > interception logic and some hacks in the kgdb trap handler to defang the
> > > NMI interception logic and force the kdb logic to kick in.
> > >
> > > Wouldn't it be better to migrate kdb interception logic up a couple of
> > > levels so that it continues to function even when we are in nmi printk
> > > mode. That way *all* the printk() interception code would end up in
> > > one place.
> > >
> >
> > Yes it would be better to have all printk() interception code at one
> > place. Let me see if I can come up with an integrated logic.
>
> It might be enough to move the kdb_check from vprintk_default()
> to vprintk_func().
>
> I have never used kdb. I did not know that it was able to stop
> kernel in any context.
>
> Would this work? It is only compile tested!

Thanks for this fix patch. It did resolve the issue and now I am able
to see the backtrace in the kdb shell. So we can go ahead with your
patch and drop mine.

>
> From 14ae6c9f0cbd1479cb898c864c7ab46e20f3cf6f Mon Sep 17 00:00:00 2001
> From: Petr Mladek <pmladek@suse.com>
> Date: Thu, 14 May 2020 10:37:44 +0200
> Subject: [PATCH] printk/kdb: Redirect printk messages into kdb in any context
>
> kdb is able to stop kernel even in NMI context where printk() is redirected
> to the printk_safe() lockless variant. Move the check and redirect to kdb
> even in this case.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/printk/printk.c      | 14 +-------------
>  kernel/printk/printk_safe.c |  8 ++++++++
>  2 files changed, 9 insertions(+), 13 deletions(-)
>

Reported-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 9a9b6156270b..63a1aa377cd9 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -35,7 +35,6 @@
>  #include <linux/memblock.h>
>  #include <linux/syscalls.h>
>  #include <linux/crash_core.h>
> -#include <linux/kdb.h>
>  #include <linux/ratelimit.h>
>  #include <linux/kmsg_dump.h>
>  #include <linux/syslog.h>
> @@ -2036,18 +2035,7 @@ EXPORT_SYMBOL(vprintk);
>
>  int vprintk_default(const char *fmt, va_list args)
>  {
> -       int r;
> -
> -#ifdef CONFIG_KGDB_KDB
> -       /* Allow to pass printk() to kdb but avoid a recursion. */
> -       if (unlikely(kdb_trap_printk && kdb_printf_cpu < 0)) {
> -               r = vkdb_printf(KDB_MSGSRC_PRINTK, fmt, args);
> -               return r;
> -       }
> -#endif
> -       r = vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
> -
> -       return r;
> +       return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
>  }
>  EXPORT_SYMBOL_GPL(vprintk_default);
>
> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> index d9a659a686f3..81734497c625 100644
> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -6,6 +6,7 @@
>  #include <linux/preempt.h>
>  #include <linux/spinlock.h>
>  #include <linux/debug_locks.h>
> +#include <linux/kdb.h>
>  #include <linux/smp.h>
>  #include <linux/cpumask.h>
>  #include <linux/irq_work.h>
> @@ -359,6 +360,13 @@ void __printk_safe_exit(void)
>
>  __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
>  {
> +#ifdef CONFIG_KGDB_KDB
> +       /* Allow to pass printk() to kdb but avoid a recursion. */
> +       if (unlikely(kdb_trap_printk && kdb_printf_cpu < 0)) {
> +               return vkdb_printf(KDB_MSGSRC_PRINTK, fmt, args);
> +       }
> +#endif
> +
>         /*
>          * Try to use the main logbuf even in NMI. But avoid calling console
>          * drivers that might have their own locks.
> --
> 2.26.1
>
