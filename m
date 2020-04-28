Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0FAC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF0B206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f41vADlU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgD1SE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbgD1SE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:04:27 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F5AC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:04:26 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id g129so6129823vkh.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odj07kwkBntYPq0VIt2IDXrySYiIYjRiu847Smhep58=;
        b=f41vADlUDP9iAJMu9Oee3QN3JqwKwcrLU6w43uWgQefuPA4TWORP3q0k+6Awu0Iqz/
         6IcrZFSlPx9bsUCuPkcZ+0n44T6H3GHbvobOhWqWn45dGUd2/fIg7ZFewNyECub86vFx
         d/l01f7L5gYOVjNFK4cZzxq5hBNfhdxGJVgZKuyKQktdeqzWJYEKZwfTN2krZWzjIYDn
         umpC2l2JNJUhi+NFf9rytQykxw8D1EEDNUrawMrtTYCsl6LWEtbRgunTOmC3SghH76lt
         eO8RGEQ2XQTjQ63SOt/a8K+9QupxNPvStb+FO5hL1C5UUhVzDAZ5jUiKAXc9AIWgbQ7J
         LGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odj07kwkBntYPq0VIt2IDXrySYiIYjRiu847Smhep58=;
        b=UgZUrXT4fYwEjASc8uHl2EsttNnuDb6TMGmsrQ+KRSkVWcITzUs8ZCuZCjXgCgczz8
         kLOoANxv8OTulfpZA+obY7si9sdqOBbRmwBuMDwp3JzxmP1NAnQtIQF69N+ZzzdcnRdm
         HDlHm014PAjR1LyduldMNT7xxGhX2omNndkRLAQdNlWOu5kBm0V3yWmn8+kRDaUpzXN6
         +bDmT9oh/XWVBzlgGOUbPQIAUdS4AT/8Mwr0Ufse6bOw6yAyW8TQKs0LIXcgrSY2BPsc
         9XOenjVNDEuBKQ+zFs9AK5vhst9mRQ0UNpyHT4pOSyDLlgR2Ws4BOj5H/Rh/ggkcZyVn
         wCKQ==
X-Gm-Message-State: AGi0PuZtMlFKlIEEtnhcGwjEdbq1wxImXx2k5SAI9yYshaJfHnK7QaZ9
        bIFMlYXNny8t2mxqW5TSJU5Rs2SLxtWGGMEY8RW6AA==
X-Google-Smtp-Source: APiQypIgCErFqRpAn63IN1MrD4ot8YhzPcP7NAkFt3QGqihC7F+ytGq4AcjLJrLT2+7uJxihTOFrW+KO6tzYo8W9pdQ=
X-Received: by 2002:a1f:a844:: with SMTP id r65mr21684218vke.56.1588097065304;
 Tue, 28 Apr 2020 11:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200427184358.191624-1-surenb@google.com> <20200428163125.GC16910@hirez.programming.kicks-ass.net>
In-Reply-To: <20200428163125.GC16910@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 28 Apr 2020 11:04:14 -0700
Message-ID: <CAJuCfpGsRwJGwyny0X0APa2yCjyBttyMtTOPr3K5NqcWehtzxw@mail.gmail.com>
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

On Tue, Apr 28, 2020 at 9:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Apr 27, 2020 at 11:43:58AM -0700, Suren Baghdasaryan wrote:
> > A number of kthread-related functions indirectly take task_struct->pi_lock
> > while holding worker->lock in the call chain like this:
> >     spin_lock(&worker->lock)
> >     kthread_insert_work
> >     wake_up_process
> >     try_to_wake_up
> >     raw_spin_lock_irqsave(&p->pi_lock, flags)
> >
> > This lock dependency exists whenever kthread_insert_work is called either
> > directly or indirectly via __kthread_queue_delayed_work in the following
> > functions:
> >     kthread_queue_work
> >     kthread_delayed_work_timer_fn
> >     kthread_queue_delayed_work
> >     kthread_flush_work
> >     kthread_mod_delayed_work
> >
> > This creates possibilities for circular dependencies like the one reported
> > at: https://lkml.org/lkml/2020/4/24/954
>
> Please, do not use lkml.org links.

Thanks for the review! Would
https://lore.kernel.org/lkml/CAJuCfpG4NkhpQvZjgXZ_3gm6Hf1QgN_eUOQ8iX9Cv1k9whLwSQ@mail.gmail.com
be better or should I just add the body of that report here? Or do not
mention it at all?

>
> Also, ideally, we'd pull that kthread_queue_delayed_work() out from
> under rq->lock.

I understand but I don't see an easy way to do that. We need to start
PSI polling whenever a monitored PSI state changes:
https://elixir.bootlin.com/linux/v5.6.7/source/kernel/sched/psi.c#L783.
This is happening under rq->lock because PSI accounting is done from
inside enqueue_task/dequeue_task - the call chain is:

enqueue_task > psi_enqueue > psi_task_change > psi_group_change >
psi_schedule_poll_work > psi_task_change

IIUC enqueue_task/dequeue_task are called with rq->lock taken, so
moving kthread_queue_delayed_work out is not trivial.

>
> In fact, looking at it, WTH is the delayed branch of
> kthread_queue_delayed_work() under that lock? That whole
> delayed_work_list thing smells like bong-hits.

I have the poll_scheduled atomic specifically to ensure that
kthread_queue_delayed_work does not block as commented here:
https://elixir.bootlin.com/linux/v5.7-rc3/source/kernel/sched/psi.c#L551.
I understand this is not ideal. If there is a better way to schedule
that kworker while ensuring it does not block I would be happy to
rework this. Any suggestions?

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
