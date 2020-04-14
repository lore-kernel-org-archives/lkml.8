Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E76C38A29
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C82B2063A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X0eMbb36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbgDNNhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbgDNNgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:36:39 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B700C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i3jcObQ1vdav50ldxNhtVCe8a46a/U4kdAqgwx5ESuM=; b=X0eMbb36iwhR4VdDSQxnG0tWm7
        Kxah5NIGH2thE5ssOklGspEYwPafA6otILvhSMgKNxRdBG+Tr9qLTB9/P9IuP+wYT/Kwb16TBAHIm
        kITyMIOzEhloWhGqV5duv1RtoRx2UduE4pJ/I5ljBAiEx7k2QTzKFNSYYl8irDgQMvMzhPtJ9beOO
        LzX4Zv7XbVPbcnsAM2NMUTaH25mwntiN3YdzqdaRuvoExt7wNYBmsxVAg1sqOhN8MAdSREWL3VPuR
        NLPTCwAtGgaagE2k/6chetmeNibpCaNKfxUyAPMhZYX3EnyW7NAmnBSXtmRkV2izpSQ+9kcylqD4I
        lfg4k0qg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOLjP-0000OG-CK; Tue, 14 Apr 2020 13:36:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 01D6C304D58;
        Tue, 14 Apr 2020 15:35:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C254D2038BC5A; Tue, 14 Apr 2020 15:35:59 +0200 (CEST)
Date:   Tue, 14 Apr 2020 15:35:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     vpillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: Re: [RFC PATCH 07/13] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200414133559.GT20730@hirez.programming.kicks-ass.net>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <e942da7fd881977923463f19648085c1bfaa37f8.1583332765.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e942da7fd881977923463f19648085c1bfaa37f8.1583332765.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 04:59:57PM +0000, vpillai wrote:
> +static struct task_struct *
> +pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> +{
> +	struct task_struct *next, *max = NULL;
> +	const struct sched_class *class;
> +	const struct cpumask *smt_mask;
> +	int i, j, cpu;
> +	bool need_sync = false;

AFAICT that assignment is superfluous. Also, you violated the inverse
x-mas tree.

> +
> +	cpu = cpu_of(rq);
> +	if (cpu_is_offline(cpu))
> +		return idle_sched_class.pick_next_task(rq);

Are we actually hitting this one?

> +	if (!sched_core_enabled(rq))
> +		return __pick_next_task(rq, prev, rf);
> +
> +	/*
> +	 * If there were no {en,de}queues since we picked (IOW, the task
> +	 * pointers are all still valid), and we haven't scheduled the last
> +	 * pick yet, do so now.
> +	 */
> +	if (rq->core->core_pick_seq == rq->core->core_task_seq &&
> +	    rq->core->core_pick_seq != rq->core_sched_seq) {
> +		WRITE_ONCE(rq->core_sched_seq, rq->core->core_pick_seq);
> +
> +		next = rq->core_pick;
> +		if (next != prev) {
> +			put_prev_task(rq, prev);
> +			set_next_task(rq, next);
> +		}
> +		return next;
> +	}
> +
> +	prev->sched_class->put_prev_task(rq, prev);
> +	if (!rq->nr_running)
> +		newidle_balance(rq, rf);

This is wrong per commit:

  6e2df0581f56 ("sched: Fix pick_next_task() vs 'change' pattern race")

> +	smt_mask = cpu_smt_mask(cpu);
> +
> +	/*
> +	 * core->core_task_seq, core->core_pick_seq, rq->core_sched_seq
> +	 *
> +	 * @task_seq guards the task state ({en,de}queues)
> +	 * @pick_seq is the @task_seq we did a selection on
> +	 * @sched_seq is the @pick_seq we scheduled
> +	 *
> +	 * However, preemptions can cause multiple picks on the same task set.
> +	 * 'Fix' this by also increasing @task_seq for every pick.
> +	 */
> +	rq->core->core_task_seq++;
> +	need_sync = !!rq->core->core_cookie;
> +
> +	/* reset state */
> +	rq->core->core_cookie = 0UL;
> +	for_each_cpu(i, smt_mask) {
> +		struct rq *rq_i = cpu_rq(i);
> +
> +		rq_i->core_pick = NULL;
> +
> +		if (rq_i->core_forceidle) {
> +			need_sync = true;
> +			rq_i->core_forceidle = false;
> +		}
> +
> +		if (i != cpu)
> +			update_rq_clock(rq_i);
> +	}
> +
> +	/*
> +	 * Try and select tasks for each sibling in decending sched_class
> +	 * order.
> +	 */
> +	for_each_class(class) {
> +again:
> +		for_each_cpu_wrap(i, smt_mask, cpu) {
> +			struct rq *rq_i = cpu_rq(i);
> +			struct task_struct *p;
> +
> +			if (cpu_is_offline(i)) {
> +				rq_i->core_pick = rq_i->idle;
> +				continue;
> +			}

Why are we polluting the 'fast' path with offline crud? Why isn't this
the natural result of running pick_task() on an empty runqueue?

> +
> +			if (rq_i->core_pick)
> +				continue;
> +
> +			/*
> +			 * If this sibling doesn't yet have a suitable task to
> +			 * run; ask for the most elegible task, given the
> +			 * highest priority task already selected for this
> +			 * core.
> +			 */
> +			p = pick_task(rq_i, class, max);
> +			if (!p) {
> +				/*
> +				 * If there weren't no cookies; we don't need
> +				 * to bother with the other siblings.
> +				 */
> +				if (i == cpu && !need_sync)
> +					goto next_class;
> +
> +				continue;
> +			}
> +
> +			/*
> +			 * Optimize the 'normal' case where there aren't any
> +			 * cookies and we don't need to sync up.
> +			 */
> +			if (i == cpu && !need_sync && !p->core_cookie) {
> +				next = p;
> +				goto done;
> +			}
> +
> +			rq_i->core_pick = p;
> +
> +			/*
> +			 * If this new candidate is of higher priority than the
> +			 * previous; and they're incompatible; we need to wipe
> +			 * the slate and start over. pick_task makes sure that
> +			 * p's priority is more than max if it doesn't match
> +			 * max's cookie.
> +			 *
> +			 * NOTE: this is a linear max-filter and is thus bounded
> +			 * in execution time.
> +			 */
> +			if (!max || !cookie_match(max, p)) {
> +				struct task_struct *old_max = max;
> +
> +				rq->core->core_cookie = p->core_cookie;
> +				max = p;
> +
> +				if (old_max) {
> +					for_each_cpu(j, smt_mask) {
> +						if (j == i)
> +							continue;
> +
> +						cpu_rq(j)->core_pick = NULL;
> +					}
> +					goto again;
> +				} else {
> +					/*
> +					 * Once we select a task for a cpu, we
> +					 * should not be doing an unconstrained
> +					 * pick because it might starve a task
> +					 * on a forced idle cpu.
> +					 */
> +					need_sync = true;
> +				}
> +
> +			}
> +		}
> +next_class:;
> +	}
> +
> +	rq->core->core_pick_seq = rq->core->core_task_seq;
> +	next = rq->core_pick;
> +	rq->core_sched_seq = rq->core->core_pick_seq;
> +
> +	/*
> +	 * Reschedule siblings
> +	 *
> +	 * NOTE: L1TF -- at this point we're no longer running the old task and
> +	 * sending an IPI (below) ensures the sibling will no longer be running
> +	 * their task. This ensures there is no inter-sibling overlap between
> +	 * non-matching user state.
> +	 */
> +	for_each_cpu(i, smt_mask) {
> +		struct rq *rq_i = cpu_rq(i);
> +
> +		if (cpu_is_offline(i))
> +			continue;

Another one; please explain how an offline cpu can be part of the
smt_mask. Last time I checked it got cleared in stop-machine.

> +
> +		WARN_ON_ONCE(!rq_i->core_pick);
> +
> +		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
> +			rq_i->core_forceidle = true;
> +
> +		if (i == cpu)
> +			continue;
> +
> +		if (rq_i->curr != rq_i->core_pick)
> +			resched_curr(rq_i);
> +
> +		/* Did we break L1TF mitigation requirements? */
> +		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));

That comment is misleading...

> +	}
> +
> +done:
> +	set_next_task(rq, next);
> +	return next;
> +}

----8<----

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a9eeef896c78..8432de767730 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4080,6 +4080,13 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  		update_min_vruntime(cfs_rq);
>  }
>  
> +static inline bool
> +__entity_slice_used(struct sched_entity *se)
> +{
> +	return (se->sum_exec_runtime - se->prev_sum_exec_runtime) >
> +		sched_slice(cfs_rq_of(se), se);
> +}
> +
>  /*
>   * Preempt the current task with a newly woken task if needed:
>   */
> @@ -10285,6 +10292,34 @@ static void core_sched_deactivate_fair(struct rq *rq)
>  #endif
>  #endif /* CONFIG_SMP */
>  
> +#ifdef CONFIG_SCHED_CORE
> +/*
> + * If runqueue has only one task which used up its slice and
> + * if the sibling is forced idle, then trigger schedule
> + * to give forced idle task a chance.
> + */
> +static void resched_forceidle_sibling(struct rq *rq, struct sched_entity *se)
> +{
> +	int cpu = cpu_of(rq), sibling_cpu;
> +	if (rq->cfs.nr_running > 1 || !__entity_slice_used(se))
> +		return;
> +
> +	for_each_cpu(sibling_cpu, cpu_smt_mask(cpu)) {
> +		struct rq *sibling_rq;
> +		if (sibling_cpu == cpu)
> +			continue;
> +		if (cpu_is_offline(sibling_cpu))
> +			continue;
> +
> +		sibling_rq = cpu_rq(sibling_cpu);
> +		if (sibling_rq->core_forceidle) {
> +			resched_curr(sibling_rq);
> +		}
> +	}
> +}
> +#endif
> +
> +
>  /*
>   * scheduler tick hitting a task of our scheduling class.
>   *
> @@ -10308,6 +10343,11 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  
>  	update_misfit_status(curr, rq);
>  	update_overutilized_status(task_rq(curr));
> +
> +#ifdef CONFIG_SCHED_CORE
> +	if (sched_core_enabled(rq))
> +		resched_forceidle_sibling(rq, &curr->se);
> +#endif
>  }
>  
>  /*

This ^ seems like it should be in it's own patch.

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 03d502357599..a829e26fa43a 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1003,11 +1003,16 @@ struct rq {
>  #ifdef CONFIG_SCHED_CORE
>  	/* per rq */
>  	struct rq		*core;
> +	struct task_struct	*core_pick;
>  	unsigned int		core_enabled;
> +	unsigned int		core_sched_seq;
>  	struct rb_root		core_tree;
> +	bool			core_forceidle;

Someone forgot that _Bool shouldn't be part of composite types?

>  	/* shared state */
>  	unsigned int		core_task_seq;
> +	unsigned int		core_pick_seq;
> +	unsigned long		core_cookie;
>  #endif
>  };
