Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5FFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A75C20782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="ShLps7zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGCUV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 16:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGCUV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 16:21:59 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EA6C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 13:21:58 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k4so27391092oik.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 13:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sLkqvxMUai9zJEAac/8nCc6H5oky+BvNLpyW18OXuk8=;
        b=ShLps7zggUGl5QvjZxnryP46LPQ2Bp0eSz4f5UefxaWrbCU4TwVUyNTg359ndt4j6e
         55Wknur77A/8sa+xEKrQ8dfZwMvS1revJClO7vQykK/zEaUkHhIfG/rkVjXiV6YY4ZCh
         6Fdj5FuP2ge1Vy7gqVgyTjFdNYhMEYq4OGUj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sLkqvxMUai9zJEAac/8nCc6H5oky+BvNLpyW18OXuk8=;
        b=A8xft/kOLl2fWru2nQvW2mvctRedn6dXWrwrVf6WGKh2sp6Rr26cD00lv9ivLYOKMx
         cxuIWh2nqmqUZM76e9sbbPpX8ZPE4Xr5bAghnR1cndcYVVjiXqLjMib4yLChBIxgX7v8
         Lj8r7DifQjS6Vy3VWV4iY4X4JVtqZoCl9GR8QFPbua+/vZAZ4yt3aQAVh/T52OPIO0Os
         HOjvODMdziug45XtReuB6Zsk7m/ML/dg2SzpR1o8X9qfT3va82VoTkhkq05aJcsw8i8N
         GilXJqrxcLYIM0r0sei2Mz2MbV8GcTe7qrRIvfvgaLjIE7cgqZXXzsa7KpJ5Vco0+dI5
         D01g==
X-Gm-Message-State: AOAM533Er62AcaycVQHEu3gEAC9D1EWDPDBzvVVKKDrJHKzQtU+BwotL
        iHSeQYT19BldA2guojlJQxP0fFhC1pfJAn0qN7UpcQ==
X-Google-Smtp-Source: ABdhPJzU0QQcs3E47V44554/vTlZ6rzEsSlOb5FeL4mOzSINIbGdKL79Kn8pUTJpbL+CAEe5lgF1HjfQTeA89e1lmc8=
X-Received: by 2002:aca:c4cc:: with SMTP id u195mr23455766oif.160.1593807718009;
 Fri, 03 Jul 2020 13:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <ed924e2cb450a4cce4a1b5a2c44d29e968467154.1593530334.git.vpillai@digitalocean.com>
 <20200701232847.GA439212@google.com>
In-Reply-To: <20200701232847.GA439212@google.com>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Fri, 3 Jul 2020 16:21:46 -0400
Message-ID: <CANaguZDtZrXbjmot2crLM0ComgY=NfqxWYs7GzUEY8aLeaUVrg@mail.gmail.com>
Subject: Re: [RFC PATCH 06/16] sched: Add core wide task selection and scheduling.
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 7:28 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] sched: Fix CPU hotplug causing crashes in task selection logic
>
> The selection logic does not run correctly if the current CPU is not in the
> cpu_smt_mask (which it is not because the CPU is offlined when the stopper
> finishes running and needs to switch to idle).  There are also other issues
> fixed by the patch I think such as: if some other sibling set core_pick to
> something, however the selection logic on current cpu resets it before
> selecting. In this case, we need to run the task selection logic again to
> make sure it picks something if there is something to run. It might end up
> picking the wrong task.
>
I am not sure if this can happen. If the other sibling sets core_pick, it
will be under the core wide lock and it should set the core_sched_seq also
before releasing the lock. So when this cpu tries, it would see the core_pick
before resetting it. Is this the same case you were mentioning? Sorry if I
misunderstood the case you mentioned..

> Yet another issue was, if the stopper thread is an
> unconstrained pick, then rq->core_pick is set. The next time task selection
> logic runs when stopper needs to switch to idle, the current CPU is not in
> the smt_mask. This causes the previous ->core_pick to be picked again which
> happens to be the unconstrained task! so the stopper keeps getting selected
> forever.
>
I did not clearly understand this. During an unconstrained pick, current
cpu's core_pick is not set and tasks are not picked for siblings as well.
If it is observed being set in the v6 code, I think it should be a bug.

> That and there are a few more safe guards and checks around checking/setting
> rq->core_pick. To test it, I ran rcutorture and made it tag all torture
> threads. Then ran it in hotplug mode (hotplugging every 200ms) and it hit the
> issue. Now it runs for an hour or so without issue. (Torture testing debug
> changes: https://bit.ly/38htfqK ).
>
> Various fixes were tried causing varying degrees of crashes.  Finally I found
> that it is easiest to just add current CPU to the smt_mask's copy always.
> This is so that task selection logic always runs on the current CPU which
> called schedule().
>
> [...]
>         cpu = cpu_of(rq);
> -       smt_mask = cpu_smt_mask(cpu);
> +       /* Make a copy of cpu_smt_mask as we should not set that. */
> +       cpumask_copy(&select_mask, cpu_smt_mask(cpu));
> +
> +       /*
> +        * Always make sure current CPU is added to smt_mask so that below
> +        * selection logic runs on it.
> +        */
> +       cpumask_set_cpu(cpu, &select_mask);
>
I like this idea. Probably we can optimize it a bit. We get here with cpu
not in smt_mask only during an offline and online(including the boot time
online) phase. So we could probably wrap it in an "if (unlikely())". Also,
during this time, it would be idle thread or some hotplug online thread that
would be runnable and no other tasks should be runnable on this cpu. So, I
think it makes sense to do an unconstrained pick rather than a costly sync
of all siblings. Probably something like:

cpumask_copy(&select_mask, cpu_smt_mask(cpu));
if (unlikely(cpumask_test_cpu(cpu, &select_mask))) {
    cpumask_set_cpu(cpu, &select_mask);
    need_sync = false;
}

By setting need_sync to false, we will do an unconstrained pick and will
not sync with other siblings. I guess we need to reset need_sync after
or in the following for_each_cpu loop, because the loop may set it.

>         /*
>          * core->core_task_seq, core->core_pick_seq, rq->core_sched_seq
> @@ -4351,7 +4358,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)

>                         if (i == cpu && !need_sync && !p->core_cookie) {
>                                 next = p;
> +                               rq_i->core_pick = next;
> +                               rq_i->core_sched_seq = rq_i->core->core_pick_seq;
>
I think we would not need these here. core_pick needs to be set only
for siblings if we are picking a task for them. For unconstrained pick,
we pick only for ourselves. Also, core_sched_seq need not be synced here.
We might already be synced with the existing core->core_pick_seq. Even
if it is not synced, I don't think it will cause an issue in subsequent
schedule events.


>  done:
> +       /*
> +        * If we reset a sibling's core_pick, make sure that we picked a task
> +        * for it, this is because we might have reset it though it was set to
> +        * something by another selector. In this case we cannot leave it as
> +        * NULL and should have found something for it.
> +        */
> +       for_each_cpu(i, &select_mask) {
> +               WARN_ON_ONCE(!cpu_rq(i)->core_pick);
> +       }
> +
I think this check will not be true always. For unconstrained pick, we
do not pick tasks for siblings and hence do not set core_pick for them.
So this WARN_ON will fire for unconstrained pick. Easily reproducible
by creating an empty cgroup and tagging it. Then only unconstrained
picks will happen and this WARN_ON fires. I guess this check after the
done label does not hold and could be removed.

Thanks,
Vineeth
