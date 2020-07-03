Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047B5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFDCB207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k5kmuT62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgGCIa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCIaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:30:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D20C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 01:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XIAMZg1IKGMG/F8eMBkuZrXq4K2/TSruDTB8jNCaSd8=; b=k5kmuT62qM4M0yPSMqRBPOFALo
        pX+IqhTSp6gY4BzsyIBEHjcGVXe1WlkFoTTs/t/x76g6s3Boj8Vn7LRjwK46oHngolQ7SOxlkd6E+
        xeXh2ROqrQ1ZeS8AXTx5Gkmv9rJY7ZC64+niswuF89KZW45yU4tBQD3ffevqBKUdWjy5vnSvvCISb
        Cl15TjBBKLjjD44y2fHtIivVFbpHaO59BjrqQVivfBUSO51kEnK+g81d+UdbFttuq8CIyeZS9McrM
        59k5WPw4yMQWOU4LRtfNT+9Tzh3R+LnMosHsjYbbDz1uQowsTdFugMaVduhE6t3GU8QSQp1SyuAUG
        KEg3FlFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrH5L-0000C0-Pt; Fri, 03 Jul 2020 08:30:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B561D3028C8;
        Fri,  3 Jul 2020 10:30:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9CDC5234E2CB1; Fri,  3 Jul 2020 10:30:12 +0200 (CEST)
Date:   Fri, 3 Jul 2020 10:30:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, mgorman@suse.de,
        Oleg Nesterov <oleg@redhat.com>, david@fromorbit.com
Subject: Re: [RFC][PATCH] sched: Better document ttwu()
Message-ID: <20200703083012.GU4800@hirez.programming.kicks-ass.net>
References: <20200702125211.GQ4800@hirez.programming.kicks-ass.net>
 <jhjd05d92y3.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjd05d92y3.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 07:39:16PM +0100, Valentin Schneider wrote:

> > + * Special state:
> > + *
> > + * System-calls and anything external will use task_rq_lock() which acquires
> > + * both p->lock and rq->lock. As a consequence the state they change is stable
> > + * while holding either lock:
> > + *
> > + *  - sched_setaffinity():	p->cpus_ptr
> > + *  - set_user_nice():		p->se.load, p->static_prio
> > + *  - __sched_setscheduler():	p->sched_class, p->policy, p->*prio, p->se.load,
> > + *				p->dl.dl_{runtime, deadline, period, flags, bw, density}
> 
> Only extra thing that comes to mind is p->uclamp*; dunno how exhaustive you
> want this list to be.

Indeed, I seem to have missed that one.

> > + *  - sched_setnuma():		p->numa_preferred_nid
> > + *  - sched_move_task()/
> > + *    cpu_cgroup_fork():	p->sched_task_group
> > + *

> > + * task_cpu(p): is changed by set_task_cpu(), the rules are:
> > + *
> > + *  - Don't call set_task_cpu() on a blocked task:
> > + *
> > + *    We don't care what CPU we're not running on, this simplifies hotplug,
> > + *    the CPU assignment of blocked tasks isn't required to be valid.
> > + *
> 
> That's more of a good practice rather than a hard rule, right? We do that
> with proxy execution (the whole migrate to owner's rq thing), at least in
> its current shape.

Yeah, but all of that isn't upstream yet. That said; the distinguishing
feature there is that we create a class of blocked tasks that will still
be 'runnable'. And as such we'll care about their placement.

> > + *  - for try_to_wake_up(), called under p->pi_lock:
> > + *
> > + *    This allows try_to_wake_up() to only take one rq->lock, see its comment.
> > + *
> > + *  - for migration called under rq->lock:
> > + *    [ see task_on_rq_migrating() in task_rq_lock() ]
> > + *
> > + *    o move_queued_task()
> > + *    o __migrate_swap_task()
> 
> Isn't that one under double_rq_lock()?

Indeed, /me moves.

> > + *    o detach_task()
> > + *
> > + *  - for migration called under double_rq_lock():
> > + *
> > + *    o push_rt_task() / pull_rt_task()
> > + *    o push_dl_task() / pull_dl_task()
> > + *    o dl_task_offline_migration()
> > + *
> > + */

> >  /*
> > - * Called in case the task @p isn't fully descheduled from its runqueue,
> > - * in this case we must do a remote wakeup. Its a 'light' wakeup though,
> > - * since all we need to do is flip p->state to TASK_RUNNING, since
> > - * the task is still ->on_rq.
> > + * Consider @p being inside a wait loop:
> > + *
> > + *   for (;;) {
> > + *           set_current_state(TASK_UNINTERRUPTIBLE);
> > + *
> > + *           if (CONDITION)
> > + *         break;
> 
> For some reason the alignment is off in my mail view, but looks okay once
> applied.

I'll go eradicate tabstops :-)

> > + *
> > + *           schedule();
> > + *   }
> > + *   __set_current_state(TASK_RUNNING);
> > + *
> > + * between set_current_state() and schedule(). In this case @p is still
> > + * runnable, so all that needs doing is change p->state back to TASK_RUNNING in
> > + * an atomic manner.
> > + *
> 
> Sorry if I'm being dense; don't you mean "running" here? If it stops being
> current inbetween set_current_state() and schedule(), __schedule() will
> deactivate() it, so AFAICT it can only be either running or deactivated.

Runnable, the task could be preempted. At this point we don't care if it
is actually running or not.

> > + * By taking task_rq(p)->lock we serialize against schedule(), if @p->on_rq
> > + * then schedule() must still happen and p->state can be changed to
> > + * TASK_RUNNING. Otherwise we lost the race, schedule() has happened, and we
> > + * need to do a full wakeup with enqueue.
> > + *
> > + * Returns: %true when the wakeup is done,
> > + *          %false otherwise.
> >   */
> > -static int ttwu_remote(struct task_struct *p, int wake_flags)
> > +static int ttwu_runnable(struct task_struct *p, int wake_flags)
> >  {
> >       struct rq_flags rf;
> >       struct rq *rq;


> > + * Tries really hard to only take one task_rq(p)->lock for performance.
> > + * Takes rq->lock in:
> > + *  - ttwu_runnable()    -- old rq, unavoidable, see comment there;
> > + *  - ttwu_queue()       -- new rq, for enqueue of the task;
> > + *  - psi_ttwu_dequeue() -- much sadness :-( accounting will kill us.
> > + *
> > + * As a concequence we race really badly with just about everything. See the
> 
> s/concequence/consequence/

ta!

> > @@ -3134,8 +3274,12 @@ static inline void prepare_task(struct task_struct *next)
> >       /*
> >        * Claim the task as running, we do this before switching to it
> >        * such that any running task will have this set.
> > +	 *
> > +	 * __schedule()'s rq->lock and smp_mb__after_spin_lock() orders this
> > +	 * store against prior state change of @next, also see
> > +	 * try_to_wake_up(), specifically smp_load_acquire(&p->on_cpu).
> 
> smp_*cond*_load_acquire(&p->on_cpu, <blah>)

Both, but yeah.. arguably the cond one is the more important one.

> 
> >        */
> > -	next->on_cpu = 1;
> > +	WRITE_ONCE(next->on_cpu, 1);
> >  #endif
> >  }

> > +/*
> > + * Lockdep annotation that avoid accidental unlock; any
> > + * raw_spin_unlock(&rq->lock) without preceding rq_unpin_lock() with the
> > + * correct cookie will result in a WARN.
> > + *
> 
> ISTR that being described (by yourself?) as a "sticky/continuous
> lockdep_assert_held()", which I think gets the point across.

Ah indeed! Clever of my past self :-) I'll go reword it.
