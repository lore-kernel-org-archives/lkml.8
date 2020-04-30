Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD47C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F1F20836
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wRdo8KS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgD3R5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726285AbgD3R5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 13:57:22 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAADC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 10:57:22 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id g35so2828900uad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TvrAoS5R4+dywx/HVADWV/k83KgwVRDG0yVQjYIscTc=;
        b=wRdo8KS6Y+l1c2hxp4VH+FfXlu6ZsLD2nqmVGb4u9+8P2LirkkGSBo/ZLnA5yPbq6r
         AyuByN9pocAKLZhrH8kt4swHVfsNJJ4Go1z0KRGsAwcM0CpufzSzWUP9aBDpmJdABGw5
         mqzC2jdQ3fGEnMHWjwYTi85HVZjhJP/qT+ws4EVSemtm2dIz9OJ/NyW11EwVQ/5GKtZP
         etseRxKhKm2yQaPtStvFkzVd1h81FdtZzEoyy8hyuZMnrO83s8Kp7GUQFyL1OVNLhqay
         Hq4G/7XSJM+Agd76vVeoEjgzRAbA+LmGLxjtjuaOlX/QrZFrHAzGluHzAzbzJvAeQ8vs
         jENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TvrAoS5R4+dywx/HVADWV/k83KgwVRDG0yVQjYIscTc=;
        b=LSWeILG78keOsFUb6HsP3AVO1dslCv3VVT+JmF+s8TPuXBHrsytagcTlKSKIiAr5wR
         bLyndjBeTxJZSfdZz/TNUj7lYE7O4zwx3JV5JzAt+KUanDIFjrshhfSvGYVA2x8FgEBy
         gN3RBolohkI4s+AwgeOilhFv6vhcs7YvVrlqp+zT/kEQZjdeucWHeZGBJiE0N0ubIeag
         pBNO3fCt3jXYPHu2Fy3GOrRTlfDHwADHyzRe3+P6cyx/wOTn9uijEGc4xybfQ2eCZeCf
         i/x+eHv7QV94dcMdqrR5dprWeEzKOGOuugLyw9NuqKaD9vGB659QPhi+zN+lZozyM56V
         fUSA==
X-Gm-Message-State: AGi0PuaSAkbjINh4F+mO1AmvR/Ygr6Jy486mlaYPVAaO3pT6hEkwQwMr
        ak9GAuwPbRvKyBIIm05MgRuADjrIl1kX49/V1Hm14Q==
X-Google-Smtp-Source: APiQypLXiEZIkfqP+FsSiGgb2p5DkYxQRinoeXOh52SxYozJF8DQ6injClmyChqjk9/JNPz4JCwCNmezWgBtOCbHzxg=
X-Received: by 2002:ab0:1d90:: with SMTP id l16mr3927735uak.13.1588269440967;
 Thu, 30 Apr 2020 10:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200427184358.191624-1-surenb@google.com> <20200428163125.GC16910@hirez.programming.kicks-ass.net>
 <CAJuCfpGsRwJGwyny0X0APa2yCjyBttyMtTOPr3K5NqcWehtzxw@mail.gmail.com>
In-Reply-To: <CAJuCfpGsRwJGwyny0X0APa2yCjyBttyMtTOPr3K5NqcWehtzxw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 30 Apr 2020 10:57:10 -0700
Message-ID: <CAJuCfpEsv4jAMimRnySFFpYmjf7tpxofnR4BzConhh_3iv-kfw@mail.gmail.com>
Subject: Re: [PATCH 1/1] kthread: break dependency between worker->lock and task_struct->pi_lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>, will@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ben.dooks@codethink.co.uk, cl@rock-chips.com, ke.wang@unisoc.com,
        Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:04 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Tue, Apr 28, 2020 at 9:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Apr 27, 2020 at 11:43:58AM -0700, Suren Baghdasaryan wrote:
> > > A number of kthread-related functions indirectly take task_struct->pi_lock
> > > while holding worker->lock in the call chain like this:
> > >     spin_lock(&worker->lock)
> > >     kthread_insert_work
> > >     wake_up_process
> > >     try_to_wake_up
> > >     raw_spin_lock_irqsave(&p->pi_lock, flags)
> > >
> > > This lock dependency exists whenever kthread_insert_work is called either
> > > directly or indirectly via __kthread_queue_delayed_work in the following
> > > functions:
> > >     kthread_queue_work
> > >     kthread_delayed_work_timer_fn
> > >     kthread_queue_delayed_work
> > >     kthread_flush_work
> > >     kthread_mod_delayed_work
> > >
> > > This creates possibilities for circular dependencies like the one reported
> > > at: https://lkml.org/lkml/2020/4/24/954
> >
> > Please, do not use lkml.org links.
>
> Thanks for the review! Would
> https://lore.kernel.org/lkml/CAJuCfpG4NkhpQvZjgXZ_3gm6Hf1QgN_eUOQ8iX9Cv1k9whLwSQ@mail.gmail.com
> be better or should I just add the body of that report here? Or do not
> mention it at all?

Sorry, this time in plain text mode...
If there are no more comments on this patch I'll post a v2 with
lore.kernel.org instead of lkml.org link. Please let me know if there
are more issues that you would like to be addressed.
IMHO, taking kthread_queue_delayed_work() out from under rq->lock (if
we can figure out how to do that cleanly) can be a separate patch and
this one is still useful regardless of that.
Thanks!

>
> >
> > Also, ideally, we'd pull that kthread_queue_delayed_work() out from
> > under rq->lock.
>
> I understand but I don't see an easy way to do that. We need to start
> PSI polling whenever a monitored PSI state changes:
> https://elixir.bootlin.com/linux/v5.6.7/source/kernel/sched/psi.c#L783.
> This is happening under rq->lock because PSI accounting is done from
> inside enqueue_task/dequeue_task - the call chain is:
>
> enqueue_task > psi_enqueue > psi_task_change > psi_group_change >
> psi_schedule_poll_work > psi_task_change
>
> IIUC enqueue_task/dequeue_task are called with rq->lock taken, so
> moving kthread_queue_delayed_work out is not trivial.
>
> >
> > In fact, looking at it, WTH is the delayed branch of
> > kthread_queue_delayed_work() under that lock? That whole
> > delayed_work_list thing smells like bong-hits.
>
> I have the poll_scheduled atomic specifically to ensure that
> kthread_queue_delayed_work does not block as commented here:
> https://elixir.bootlin.com/linux/v5.7-rc3/source/kernel/sched/psi.c#L551.
> I understand this is not ideal. If there is a better way to schedule
> that kworker while ensuring it does not block I would be happy to
> rework this. Any suggestions?
>
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
