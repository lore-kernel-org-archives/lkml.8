Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47252C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A55A2468C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOnngqoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBZOXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:23:53 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45368 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBZOXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:23:53 -0500
Received: by mail-io1-f65.google.com with SMTP id w9so3475430iob.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 06:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BeNWEAdLUwurTRAu4WEqbTLswFUOMRIguNpdcSr0Tds=;
        b=iOnngqoOYmXsacqkDSMrBkMWzxQgRV/ODDWvY2p3gD7nr+4Xfw3hmFjUut/UqTxMTD
         rXQiXTadY/RG9GpL90SZZ+qY8nj3wgqwNuQAYLyLxX3wYPp7SyAg6Rni9lq3sEQt9e0p
         3JIGJ1Sm4aEWANsOV88sIh5OEKrbphs4WmD3n3fhWYQGGV/rNiB3w1SB03PR3gQX9J3C
         5N7TgwZFIBnJMpNgIjmYbtMuxfRLutuWOlq4+GFav1qAgAXmCPUkd1z0nRXTw8GHl24B
         5UP2FGnQ4X0jFOpw2zDIOPvWMqtNor21vVnBGAjBTP26aQGKkYxoCcvvfFrS0xuV9Xqv
         Iwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BeNWEAdLUwurTRAu4WEqbTLswFUOMRIguNpdcSr0Tds=;
        b=W9khRcPEAEZFQFM89o5RV4uMwj5hY1Tx8BSN/o3R9EV9lP/ho01cnRjMYrySWTW/lV
         DOFqp22f9sNkb3L4x9wrOEbX0m6VQmZzQLDD3fpIXeb82ZHLlWweytRDx5/A5fNARn5X
         sQx73iDOwaRYudQlh9tXNg3UCLHHiZDucdgDffBoqAaywXdJEIPNEmanpnjaDAMJY7tr
         gQjckVEr3vLUBKpR31Kx+Kr4zJyW8iHPP0k+I/czaKdkEGgpPhRG7QktUtdbgO1bKngw
         uKSWFGv4orGYC3lRc1zp8UbshQBvJHMAtkwtwHaA/R1qCBE90BmNRMSpoMH6mV+nGY8h
         9suQ==
X-Gm-Message-State: APjAAAWE5iCQJThV/7GKpF971hdge4fx5KqAwo4WiHVlqH+4PWowoM03
        8BGGQzDOUI3qs5gKpaMII+Y726MKFikDC4xkjNA=
X-Google-Smtp-Source: APXvYqzSiNs5ZunngLzbnJNQm/953PyIVPIh6ZpAYW26lLSU4xUyryuSUjFFWvkyh4um9jwgaLrnQ2UPO/sUFkYEEOA=
X-Received: by 2002:a02:b615:: with SMTP id h21mr4543900jam.109.1582727032643;
 Wed, 26 Feb 2020 06:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20200222144647.10120-1-laoar.shao@gmail.com> <20200224162516.GA1674@cmpxchg.org>
In-Reply-To: <20200224162516.GA1674@cmpxchg.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 26 Feb 2020 22:23:16 +0800
Message-ID: <CALOAHbBOx7moLeVNVDOkstR9QWyaKOmJXmUxtiJL0Uhyg7CDgg@mail.gmail.com>
Subject: Re: [PATCH] psi: move PF_MEMSTALL into psi specific psi_flags
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mingo@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 12:25 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hello Yafang,
>
> On Sat, Feb 22, 2020 at 09:46:47AM -0500, Yafang Shao wrote:
> > The task->flags is a 32-bits flag, in which 31 bits have already been
> > consumed. So it is hardly to introduce other new per process flag.
> > As there's a psi specific flag psi_flags, we'd better move the psi specific
> > per process flag PF_MEMSTALL into it.
>
> Currently, psi_flags is used only for debugging:
>
>         if (((task->psi_flags & set) ||
>              (task->psi_flags & clear) != clear) &&
>             !psi_bug) {
>                 printk_deferred(KERN_ERR "psi: inconsistent task state! task=%d:%s cpu=%d psi_flags=%x clear=%x set=%x\n",
>                                 task->pid, task->comm, cpu,
>                                 task->psi_flags, clear, set);
>                 psi_bug = 1;
>         }
>
>         task->psi_flags &= ~clear;
>         task->psi_flags |= set;
>
> While this has caught a few bugs while the code was new, I'm planning
> on moving it to a CONFIG option that is only enabled in debug builds.
>

Got it. Many thanks for you explanation.

> If you need the room in task->flags, can you please make the memstall
> state a single bit in task_struct instead? AFAICS there is still space
> in this section:
>
>         /* Force alignment to the next boundary: */
>         unsigned                        :0;
>
>         /* Unserialized, strictly 'current' */
>
>         ...
>
> #ifdef CONFIG_PSI
>         unsigned                        in_memstall:1;
> #endif
>
> It would also avoid the mixed-bit masking headache:
>

Seems that's a better solution. I will update with it.
Thanks for your suggestion.

> > @@ -17,11 +17,21 @@ enum psi_task_count {
> >       NR_PSI_TASK_COUNTS = 3,
> >  };
> >
> > -/* Task state bitmasks */
> > +/*
> > + * Task state bitmasks:
> > + * These flags are stored in the lower PSI_TSK_BITS bits of
> > + * task->psi_flags, and the higher bits are set with per process flag which
> > + * persists across sleeps.
> > + */
> > +#define PSI_TSK_STATE_BITS 16
> > +#define PSI_TSK_STATE_MASK ((1 << PSI_TSK_STATE_BITS) - 1)
> >  #define TSK_IOWAIT   (1 << NR_IOWAIT)
> >  #define TSK_MEMSTALL (1 << NR_MEMSTALL)
> >  #define TSK_RUNNING  (1 << NR_RUNNING)
> >
> > +/* Stalled due to lack of memory, that's per process flag. */
> > +#define PSI_PF_MEMSTALL (1 << PSI_TSK_STATE_BITS)
> > +
> >  /* Resources that workloads could be stalled on */
> >  enum psi_res {
> >       PSI_IO,
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index f314790cb527..2d4c04d35d9b 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1025,7 +1025,11 @@ struct task_struct {
> >
> >       struct task_io_accounting       ioac;
> >  #ifdef CONFIG_PSI
> > -     /* Pressure stall state */
> > +     /*
> > +      * Pressure stall state:
> > +      * Bits 0 ~ PSI_TSK_STATE_BITS-1: PSI task states
> > +      * Bits PSI_TSK_STATE_BITS ~ 31: Per process flags
> > +      */
> >       unsigned int                    psi_flags;
> >  #endif
> >  #ifdef CONFIG_TASK_XACCT
>
> Thanks



-- 
Yafang Shao
DiDi
