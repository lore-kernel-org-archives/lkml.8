Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F8FC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63C320866
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCFQ4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:56:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgCFQ4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:56:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB6320848;
        Fri,  6 Mar 2020 16:56:13 +0000 (UTC)
Date:   Fri, 6 Mar 2020 11:56:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: Pinning down a blocked task to extract diagnostics
Message-ID: <20200306115611.3d265296@gandalf.local.home>
In-Reply-To: <20200306014027.GA11942@paulmck-ThinkPad-P72>
References: <20200305005049.GA21120@paulmck-ThinkPad-P72>
 <20200305080755.GS2596@hirez.programming.kicks-ass.net>
 <20200305081337.GA2619@hirez.programming.kicks-ass.net>
 <20200305142245.GB2935@paulmck-ThinkPad-P72>
 <20200305092845.4296c35e@gandalf.local.home>
 <20200305153638.GC2935@paulmck-ThinkPad-P72>
 <20200306014027.GA11942@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 17:40:27 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> commit e2821ae6c6a6adaabc89ccd9babf4375a78e0626
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Mar 5 16:53:58 2020 -0800
> 
>     sched/core: Add functions to prevent sleepers from awakening
>     
>     In some cases, it is necessary to examine a consistent version of a
>     sleeping process's state, in other words, it is necessary to keep
>     that process in sleeping state.  This commit therefore provides a
>     try_to_keep_sleeping() function that acquires ->pi_lock to prevent
>     wakeups from proceeding, returning true if the function is still asleep,
>     and otherwise releasing ->pi_lock and returning false.
>     
>     This commit also provides an allow_awake() function (as suggested by
>     by Steven Rostedt) that reverses the effect of a successful call to
>     try_to_keep_sleeping(), allowing the process to once again be awakened.
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     [ paulmck: Apply feedback from Peter Zijlstra and Steven Rostedt. ]
>     Cc: Ingo Molnar <mingo@redhat.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Juri Lelli <juri.lelli@redhat.com>
>     Cc: Vincent Guittot <vincent.guittot@linaro.org>
>     Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>     Cc: Steven Rostedt <rostedt@goodmis.org>
>     Cc: Ben Segall <bsegall@google.com>
>     Cc: Mel Gorman <mgorman@suse.de>
> 
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index 3283c8d..aefea4a 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -1148,4 +1148,7 @@ int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, i
>  		(wait)->flags = 0;						\
>  	} while (0)
>  
> +bool try_to_keep_sleeping(struct task_struct *p);
> +void allow_awake(struct task_struct *p);
> +
>  #endif /* _LINUX_WAIT_H */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fc1dfc0..b665ff7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2654,6 +2654,48 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  }
>  
>  /**
> + * try_to_keep_sleeping - Attempt to force task to remain off runqueues
> + * @p: The process to remain asleep.
> + *
> + * Acquires the process's ->pi_lock and checks state.  If the process
> + * is still blocked, returns @true and leave ->pi_lock held, otherwise
> + * releases ->pi_locked and returns @false.

I would add a comment here that this is paired with allow_awake(). As well
as a "Returns" statement.

 * Returns:
 *   false if the task is awake, then no lock is taken.
 *   true if the task is sleeping, and then task's pi_lock will be held.
 *        allow_awake() must be used to release the pi_lock and let
 *        task @p awake again.

> + */
> +bool try_to_keep_sleeping(struct task_struct *p)
> +{
> +	lockdep_assert_irqs_enabled();
> +	raw_spin_lock_irq(&p->pi_lock);
> +	switch (p->state) {
> +	case TASK_RUNNING:
> +	case TASK_WAKING:
> +		raw_spin_unlock_irq(&p->pi_lock);
> +		return false;
> +
> +	default:
> +		smp_rmb(); /* See comments in try_to_wake_up(). */

I remember Peter asking to add a comment in try_to_wake_up() stating that
this is used, so that if that code is changed, this code may also need to
be updated.

-- Steve

> +		if (p->on_rq) {
> +			raw_spin_unlock_irq(&p->pi_lock);
> +			return false;
> +		}
> +		return true;  /* Process is now stuck in blocked state. */
> +	}
> +	/* NOTREACHED */
> +}
> +
> +/**
> + * allow_awake - Allow a kept-sleeping process to awaken
> + * @p: Process to be allowed to awaken.
> + *
> + * Given that @p was passed to an earlier call to try_to_keep_sleeping
> + * that returned @true, hence preventing @p from waking up, allow @p
> + * to once again be awakened.
> + */
> +void allow_awake(struct task_struct *p)
> +{
> +	raw_spin_unlock_irq(&p->pi_lock);
> +}
> +
> +/**
>   * wake_up_process - Wake up a specific process
>   * @p: The process to be woken up.
>   *

