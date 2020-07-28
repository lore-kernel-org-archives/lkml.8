Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F261C4345B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5681A204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GXFztRqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbgG1POk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730906AbgG1POf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:14:35 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC4AC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:14:35 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id w17so15139269otl.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJCizSAjAPUE7EUcp95DY3gcG9GO9i7tyIUefzlKX5w=;
        b=GXFztRqUjiaXnHwPsCQI2viH+duk1rN/9jBepjo358MPV3GNlKgD6ddCAE+dkyQekj
         px8ofpF3S7TNaawtHfNXokQX+TnhWR/9oIdUHLxq/XHX55y1wEvJ7rrmS94IgqTfULJj
         NSGxy3sbOGLzvcY/NRMU9AqQDx8fw8eTfw/mcbcshRWg/wwAOXQu4qWi8EwvDZT4o7vK
         +QXsiuOYeeFncUk5gETEsFlX0X/NEW/Muok1wT9g2oasji0nybDnE727hwQFw3y7pf0M
         Vx+LL+/7W4QpCRVxwEbOIOPfQtXu6tscE/UpUo/6tUtRHj5gOefxfG9DoglCgQui3x25
         +8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJCizSAjAPUE7EUcp95DY3gcG9GO9i7tyIUefzlKX5w=;
        b=rHsztA2ObIc+90T/1WFXVTR1IKWdvgsJWSuphAjv9gfEp+J8u+UYBmynQGfY2hn5Fq
         uLhpFsV1HkpQCPXGtNjDkwyOiVjGukVx8tixDKvCTSB/Ycx1SjW+ObRu3AGBWzD/XZDH
         EZGqA0qte0p3dHAZm2aECOkxNzno+LLoFpFKcnYGcfs282ZnE4QlNcC1Akl30b+dDPdH
         854Th/rS8Cgci1ZZjPmhin2XSto6K/M8aoNNbHXwzh45s/zm3aFZ++H5X21IFiqP/sCM
         sZxAOqIZDW2THGAHN6X7xx3I6NqLW3CY/o/I1LZFtoISNIljxm6RlGo4KOLJhMdeme1J
         8MPg==
X-Gm-Message-State: AOAM531zDsZGe+GjIUO7MESI0765B1xiaMSyu6yG4lr9yqsZLLJUfe0F
        jaBhuxjguFD8Lu37P+7DMd1BFWKo1K282H8NHXVzgg==
X-Google-Smtp-Source: ABdhPJzxmr90Kgq1zjv5pdVRv33Sz5ginE6Zeeta9lsOyRL3cMcEFRA6JsbwcMELigJ3wydbwrDtAEyO36BrC0CUtjo=
X-Received: by 2002:a05:6830:1612:: with SMTP id g18mr8986816otr.251.1595949274880;
 Tue, 28 Jul 2020 08:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200720120348.2406588-1-elver@google.com> <20200728113044.GA233444@gmail.com>
In-Reply-To: <20200728113044.GA233444@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Jul 2020 17:14:21 +0200
Message-ID: <CANpmjNOMQ09N4+W9Dt53j=GKAuj0Sd__agRtqpDkubZEkULAJg@mail.gmail.com>
Subject: Re: [PATCH tip/locking/core] kcsan: Improve IRQ state trace reporting
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 at 13:30, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Marco Elver <elver@google.com> wrote:
>
> > To improve the general usefulness of the IRQ state trace information
> > with KCSAN enabled, save and restore the trace information when entering
> > and exiting the KCSAN runtime as well as when generating a KCSAN report.
> >
> > Without this, reporting the IRQ state trace (whether via a KCSAN report
> > or outside of KCSAN via a lockdep report) is rather useless due to
> > continuously being touched by KCSAN. This is because if KCSAN is
> > enabled, every instrumented memory access causes changes to IRQ state
> > tracking information (either by KCSAN disabling/enabling interrupts or
> > taking report_lock when generating a report).
> >
> > Before "lockdep: Prepare for NMI IRQ state tracking", KCSAN avoided
> > touching the IRQ state trace via raw_local_irq_save/restore() and
> > lockdep_off/on().
> >
> > Fixes: 248591f5d257 ("kcsan: Make KCSAN compatible with new IRQ state tracking")
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
[...]
> > +void kcsan_restore_irqtrace(struct task_struct *task)
> > +{
> > +#ifdef CONFIG_TRACE_IRQFLAGS
> > +     task->irq_events = task->kcsan_save_irqtrace.irq_events;
> > +     task->hardirq_enable_ip = task->kcsan_save_irqtrace.hardirq_enable_ip;
> > +     task->hardirq_disable_ip = task->kcsan_save_irqtrace.hardirq_disable_ip;
> > +     task->hardirq_enable_event = task->kcsan_save_irqtrace.hardirq_enable_event;
> > +     task->hardirq_disable_event = task->kcsan_save_irqtrace.hardirq_disable_event;
> > +     task->softirq_disable_ip = task->kcsan_save_irqtrace.softirq_disable_ip;
> > +     task->softirq_enable_ip = task->kcsan_save_irqtrace.softirq_enable_ip;
> > +     task->softirq_disable_event = task->kcsan_save_irqtrace.softirq_disable_event;
> > +     task->softirq_enable_event = task->kcsan_save_irqtrace.softirq_enable_event;
> > +#endif
>
> Please, make such type of assignment blocks cleaner by using a local
> helper variable, and by aligning the right side vertically as well.
>
> Also, would it make sense to unify the layout between the fields in
> task struct and the new one you introduced? That would allow a simple
> structure copy.

Makes sense, thanks for the suggestion. I think we could introduce a
new struct 'irqtrace_events'. I currently have something that adds
this struct in <linux/irqtrace.h>. AFAIK it also adds readability
improvements on initialization and use of the fields. I'll send a v2
with 2 patches.

Thanks,
-- Marco
