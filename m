Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B640DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A1D2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732751AbgF2TaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:30:05 -0400
Received: from foss.arm.com ([217.140.110.172]:40664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730063AbgF2T34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:29:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22FB9147A;
        Mon, 29 Jun 2020 05:21:53 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 794443F73C;
        Mon, 29 Jun 2020 05:21:51 -0700 (PDT)
Date:   Mon, 29 Jun 2020 13:21:49 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200629122148.klgi4mi3znhnzaf7@e107158-lin.cambridge.arm.com>
References: <20200625154352.24767-1-qais.yousef@arm.com>
 <20200625154352.24767-3-qais.yousef@arm.com>
 <87bll6ngrr.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bll6ngrr.derkling@matbug.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/20 14:38, Patrick Bellasi wrote:
> 
> On Thu, Jun 25, 2020 at 17:43:52 +0200, Qais Yousef <qais.yousef@arm.com> wrote...
> 
> [...]
> 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 235b2cae00a0..e2f1fffa013c 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -794,6 +794,25 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
> >  /* All clamps are required to be less or equal than these values */
> >  static struct uclamp_se uclamp_default[UCLAMP_CNT];
> >  
> > +/*
> > + * This static key is used to reduce the uclamp overhead in the fast path. It
> > + * only disables the call to uclamp_rq_{inc, dec}() in enqueue/dequeue_task().
> > + *
> > + * This allows users to continue to enable uclamp in their kernel config with
> > + * minimum uclamp overhead in the fast path.
> > + *
> > + * As soon as userspace modifies any of the uclamp knobs, the static key is
> > + * enabled, since we have an actual users that make use of uclamp
> > + * functionality.
> > + *
> > + * The knobs that would enable this static key are:
> > + *
> > + *   * A task modifying its uclamp value with sched_setattr().
> > + *   * An admin modifying the sysctl_sched_uclamp_{min, max} via procfs.
> > + *   * An admin modifying the cgroup cpu.uclamp.{min, max}
> > + */
> > +static DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
> 
> This is me being choosy, but given that:

ulcamp_enabled is already used. And technically uclamp is enabled but not used
here. We can use active too, but I prefer this term as it refers to userspace
opting in using util clamp.

> 
> ---8<---
> % grep -e '_used[ )]' fair.c core.c
> fair.c:	return static_key_false(&__cfs_bandwidth_used);
> fair.c:	static_key_slow_inc_cpuslocked(&__cfs_bandwidth_used);
> fair.c:	static_key_slow_dec_cpuslocked(&__cfs_bandwidth_used);
> 
> % grep -e '_enabled[ )]' fair.c core.c
> fair.c:	if (!cfs_bandwidth_used() || !cfs_rq->runtime_enabled)
> fair.c:	if (!cfs_rq->runtime_enabled || cfs_rq->nr_running)
> fair.c:	if (!cfs_rq->runtime_enabled || cfs_rq->curr)
> fair.c:	if (likely(!cfs_rq->runtime_enabled || cfs_rq->runtime_remaining > 0))
> fair.c:	cfs_rq->runtime_enabled = 0;
> fair.c:		cfs_rq->runtime_enabled = cfs_b->quota != RUNTIME_INF;
> fair.c:		if (!cfs_rq->runtime_enabled)
> fair.c:		cfs_rq->runtime_enabled = 0;
> core.c:	if (static_key_false((&paravirt_steal_rq_enabled))) {
> core.c:	if (unlikely(!p->sched_class->uclamp_enabled))
> core.c:	if (unlikely(!p->sched_class->uclamp_enabled))
> core.c:	 * Prevent race between setting of cfs_rq->runtime_enabled and
> core.c:	runtime_enabled = quota != RUNTIME_INF;
> core.c:	runtime_was_enabled = cfs_b->quota != RUNTIME_INF;
> core.c:	if (runtime_enabled && !runtime_was_enabled)
> core.c:	if (runtime_enabled)
> core.c:		cfs_rq->runtime_enabled = runtime_enabled;
> core.c:	if (runtime_was_enabled && !runtime_enabled)
> ---8<---
> 
> even just for consistency shake, I would still prefer sched_uclamp_enabled for
> the static key name.
> 
> > +
> >  /* Integer rounded range for each bucket */
> >  #define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
> >  
> > @@ -994,9 +1013,16 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
> >  	lockdep_assert_held(&rq->lock);
> >  
> >  	bucket = &uc_rq->bucket[uc_se->bucket_id];
> > -	SCHED_WARN_ON(!bucket->tasks);
> > -	if (likely(bucket->tasks))
> > -		bucket->tasks--;
> > +
> > +	/*
> > +	 * This could happen if sched_uclamp_used was enabled while the
> > +	 * current task was running, hence we could end up with unbalanced call
> > +	 * to uclamp_rq_dec_id().
> > +	 */
> > +	if (unlikely(!bucket->tasks))
> > +		return;
> > +
> > +	bucket->tasks--;
> >  	uc_se->active = false;
> 
> In this chunk you are indeed changing the code.
> 
> Are we sure there are not issues with patterns like:
> 
>   enqueue(taskA)
>   // uclamp gets enabled
>   enqueue(taskB)
>   dequeue(taskA)
>   // bucket->tasks is now 0
>   dequeue(taskB)

Hmm I don't know to be honest if this ordering problem could happen.

> 
> TaskB has been enqueued with with uclamp enabled, thus it
> has got uc_se->active=True and enforced its clamp value at RQ level.
> 
> But with your change above we don't reset that anymore.
> 
> As per my previous proposal: why not just removing the SCHED_WARN_ON?
> That's the only real problem in the code above, since now we are not
> more granted to have balanced inc/dec.

Yeah I agree. I'll re-instate it and add a comment of this ordering issue too.

> 
> [...]
> 
> > +bool uclamp_is_enabled(void)
> > +{
> > +	return static_branch_likely(&sched_uclamp_used);
> > +}
> > +
> 
> The above and the following changes are not necessary if we just
> add the guards at the beginning of uclamp_rq_util_with() instead of what
> you do in PATCH1.

I addressed that in patch 1 and hopefully my reasoning made sense of why we
can't do what you're suggesting in uclamp_rq_util_with().

> 
> I think this will give better overheads removal by avoiding not
> necessary min/max clamps for both RT and CFS.

As I stated earlier, uclamp_rq_util_with() is called from schedutil_cpu_util()
and find_energy_efficient_cpu(). I don't think it's an overhead if they continue
to call it since it'll not break correctness and speed is not an issue.

But as I think this could be potential cause of confusion at least. I'll add
a comment there and probably make it return early so it's more readable and
future proof.

Thanks

--
Qais Yousef

>   
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 7fbaee24c824..3f4e296ccb67 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -210,7 +210,7 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
> >  	unsigned long dl_util, util, irq;
> >  	struct rq *rq = cpu_rq(cpu);
> >  
> > -	if (!IS_BUILTIN(CONFIG_UCLAMP_TASK) &&
> > +	if (!uclamp_is_enabled() &&
> >  	    type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
> >  		return max;
> >  	}
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 1d4e94c1e5fe..aff5430331e4 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2371,6 +2371,8 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> >  
> >  	return clamp(util, min_util, max_util);
> >  }
> > +
> > +bool uclamp_is_enabled(void);
> >  #else /* CONFIG_UCLAMP_TASK */
> >  static inline
> >  unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> > @@ -2378,6 +2380,11 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> >  {
> >  	return util;
> >  }
> > +
> > +static inline bool uclamp_is_enabled(void)
> > +{
> > +	return false;
> > +}
> >  #endif /* CONFIG_UCLAMP_TASK */
> >  
> >  #ifdef arch_scale_freq_capacity
> 
