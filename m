Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B46CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EF820643
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3zy8N5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbgEMNfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388498AbgEMNfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:35:02 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C50C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:35:02 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id r17so10608123lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AbLaM0zuS8RSNZ5KCHHZ6Ac152Q0ScrgI1ljQOu9aJE=;
        b=Z3zy8N5e/5EgnatAgskbT9OXirHcNqQ7fTlo/YKqHV1m5BM1RVkKBpuiIyRaEQWi7A
         zO6YxV0ROpQ6WIuWP9zXO7fqir2p3ilOa6tRn/Sk3FLWOMVdmfVet/OBGYLotV2ovWuF
         Hrds8StM+QFbwfMZbrm1xouLulRg/WzYRi305dZ8QDIuF/vaH+uB/GZm6iSOVPqxl/g3
         Xlxwd39klDGBj45LEzSyGeKLdICjpN+To1D5o2xAS1FchGZ5tPXjAikGdum/gp+y23Bh
         llqYknMfCUZRZGmHkN0z7/eyytGU+4k9LSObmyuXIWY/uqRHd9fMpbBZn5eap5HGsqxn
         9wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AbLaM0zuS8RSNZ5KCHHZ6Ac152Q0ScrgI1ljQOu9aJE=;
        b=C3Ys1FVyQZ7FCwOrba2pUYR7vqDAnYDjJFXwTgNX4e4FUjy7vYvgJZU5BuOZdEk2hb
         K97NkWpsLYpkNMDqApIg13XO7vrLWcwwnp1vdBuY9rd4Krs/5NUejQBjnOCz9HzVtY39
         TBtOGrBtS/jUVncTicUG3QD5c54VG6rTd4xrpxbfOEq9VxJQEf3p17oiTNN23QFJVaN/
         iQS8sVe/SLFLLy/i/Si8m3dSN7M+4ivKWTB07HmT+2amtgJKgT/rvhzUzfX10k13qeXJ
         I0Fw02z+Im7yElGMM5Q9SRLTtUpjYQBW6HhxgucZZK/+nI7pgo3aWTK+ERX4rET/OQtV
         fdLw==
X-Gm-Message-State: AOAM532MQPxjBtBxi85nIBgg7I1lduoQRJbNUzTq/E8aoH9b2I2yQk+a
        /+yLXgZC01Y5mKMDKnP8HirtXjhhi1PjGJmxciPX3A==
X-Google-Smtp-Source: ABdhPJwfDPLhZmMoBn1O6IHENozAHHXWYdX6zwDLq85eaDYbcafk51r8oY0LcH3KbleB+lci1jFw6H8KtWuXpRg1hpU=
X-Received: by 2002:ac2:4293:: with SMTP id m19mr8978614lfh.204.1589376899941;
 Wed, 13 May 2020 06:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org> <20200512142533.ta4uejwmq5gchtlx@holly.lan>
In-Reply-To: <20200512142533.ta4uejwmq5gchtlx@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 13 May 2020 19:04:48 +0530
Message-ID: <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Fix broken handling of printk() in NMI context
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 at 19:55, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, May 12, 2020 at 02:18:34PM +0530, Sumit Garg wrote:
> > Since commit 42a0bb3f7138 ("printk/nmi: generic solution for safe printk
> > in NMI"), kgdb entry in NMI context defaults to use safe NMI printk()
>
> I didn't see the author on Cc: nor any of the folks whose hands it
> passed through. It would definitely be good to involve them in this
> discussion.
>

Thanks for updating the Cc: list.

>
> > which involves CPU specific buffers and deferred printk() until exit from
> > NMI context.
> >
> > But kgdb being a stop-the-world debugger, we don't want to defer printk()
> > especially backtrace on corresponding CPUs. So instead switch to normal
> > printk() mode in kgdb_cpu_enter() if entry is in NMI context.
>
> So, firstly I should *definitely* take a mea cupla for not shouting
> about this at the time (I was on Cc:... twice). Only thing I can say
> confidently is that the test suite didn't yell about this and so I
> didn't look at this as closely as I should have done (and that it
> didn't yell is mostly because I'm still building out the test suite
> coverage).
>
> Anyhow...
>
> This feels a little like we are smearing the printk() interception logic
> across the kernel in ways that make things hard to read. If we accepted
> this patch we then have, the new NMI interception logic, the old kdb
> interception logic and some hacks in the kgdb trap handler to defang the
> NMI interception logic and force the kdb logic to kick in.
>
> Wouldn't it be better to migrate kdb interception logic up a couple of
> levels so that it continues to function even when we are in nmi printk
> mode. That way *all* the printk() interception code would end up in
> one place.
>

Yes it would be better to have all printk() interception code at one
place. Let me see if I can come up with an integrated logic.

> Finally some clue description of how to provoke the problem would be
> useful... that sort of things helps me to grow the test suite coverage.
>

Sure I will update the description. BTW, this issue can be easily
reproduced via issuing a backtrace (kdb command: "bt or btc") on a CPU
which entered kgdb in NMI context.

-Sumit

>
> Daniel.
>
>
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >
> > Similar change was posted earlier specific to arm64 here [1]. But after
> > discussions it emerged out that this broken handling of printk() in NMI
> > context should be a common problem that is relevant to other archs as well.
> > So fix this handling in kgdb_cpu_enter() as there can be multiple entry
> > points to kgdb in NMI context.
> >
> > [1] https://lkml.org/lkml/2020/4/24/328
> >
> >  kernel/debug/debug_core.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index 2b7c9b6..ab2933f 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -567,6 +567,15 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
> >       kgdb_info[ks->cpu].enter_kgdb++;
> >       kgdb_info[ks->cpu].exception_state |= exception_state;
> >
> > +     /*
> > +      * kgdb entry in NMI context defaults to use safe NMI printk() which
> > +      * involves CPU specific buffers and deferred printk() until exit from
> > +      * NMI context. But kgdb being a stop-the-world debugger, we don't want
> > +      * to defer printk(). So instead switch to normal printk() mode here.
> > +      */
> > +     if (in_nmi())
> > +             printk_nmi_exit();
> > +
> >       if (exception_state == DCPU_WANT_MASTER)
> >               atomic_inc(&masters_in_kgdb);
> >       else
> > @@ -635,6 +644,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
> >                       atomic_dec(&slaves_in_kgdb);
> >                       dbg_touch_watchdogs();
> >                       local_irq_restore(flags);
> > +                     if (in_nmi())
> > +                             printk_nmi_enter();
> >                       return 0;
> >               }
> >               cpu_relax();
> > @@ -772,6 +783,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
> >       raw_spin_unlock(&dbg_master_lock);
> >       dbg_touch_watchdogs();
> >       local_irq_restore(flags);
> > +     if (in_nmi())
> > +             printk_nmi_enter();
> >
> >       return kgdb_info[cpu].ret_state;
> >  }
> > --
> > 2.7.4
> >
