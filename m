Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13242C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DECC9206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbgF3Jqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:46:32 -0400
Received: from foss.arm.com ([217.140.110.172]:60944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731983AbgF3Jq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:46:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F415A30E;
        Tue, 30 Jun 2020 02:46:27 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 541523F68F;
        Tue, 30 Jun 2020 02:46:26 -0700 (PDT)
Date:   Tue, 30 Jun 2020 10:46:24 +0100
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
Subject: Re: [PATCH v5 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200630094623.hnlqtgavauqlsuyd@e107158-lin.cambridge.arm.com>
References: <20200629162633.8800-1-qais.yousef@arm.com>
 <20200629162633.8800-3-qais.yousef@arm.com>
 <87366dnfaq.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87366dnfaq.derkling@matbug.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick

On 06/30/20 10:11, Patrick Bellasi wrote:
> 
> Hi Qais,
> here are some more 2c from me...
> 
> On Mon, Jun 29, 2020 at 18:26:33 +0200, Qais Yousef <qais.yousef@arm.com> wrote...
> 
> [...]
> 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 235b2cae00a0..8d80d6091d86 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -794,6 +794,26 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
> >  /* All clamps are required to be less or equal than these values */
> >  static struct uclamp_se uclamp_default[UCLAMP_CNT];
> >  
> > +/*
> > + * This static key is used to reduce the uclamp overhead in the fast path. It
> > + * primarily disables the call to uclamp_rq_{inc, dec}() in
> > + * enqueue/dequeue_task().
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
> 
> I guess this list can be obtained with a grep or git changelog, moreover
> this text will require maintenance.
> 
> What about replacing this full comment with something shorted like:
> 
> ---8<---
>       Static key to reduce uclamp overhead in the fast path by disabling
>       calls to uclamp_rq_{inc, dec}().
> ---8<---

If you don't mind, I rather more verbose info. As a relatively new comer, lack
of comments about expectation of some functions is still a challenge.

> 
> > + */
> > +DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
> > +
> >  /* Integer rounded range for each bucket */
> >  #define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
> >  
> > @@ -994,9 +1014,30 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
> >  	lockdep_assert_held(&rq->lock);
> >  
> >  	bucket = &uc_rq->bucket[uc_se->bucket_id];
> > -	SCHED_WARN_ON(!bucket->tasks);
> > +
> > +	/*
> > +	 * bucket->tasks could be zero if sched_uclamp_used was enabled while
> > +	 * the current task was running, hence we could end up with unbalanced
> > +	 * call to uclamp_rq_dec_id().
> > +	 *
> > +	 * Need to be careful of the following enqeueue/dequeue order
> > +	 * problem too
> > +	 *
> > +	 *	enqueue(taskA)
> > +	 *	// sched_uclamp_used gets enabled
> > +	 *	enqueue(taskB)
> > +	 *	dequeue(taskA)
> > +	 *	// bucket->tasks is now 0
> > +	 *	dequeue(taskB)
> > +	 *
> > +	 * where we could end up with uc_se->active of the task set to true and
> > +	 * the wrong bucket[uc_se->bucket_id].value.
> > +	 *
> > +	 * Hence always make sure we reset things properly.
> > +	 */
> >  	if (likely(bucket->tasks))
> >  		bucket->tasks--;
> > +
> >  	uc_se->active = false;
> 
> Better than v4, what about just using this active flag?
> 
> ---8<---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8f360326861e..465a7645713b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -990,6 +990,13 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>  
>         lockdep_assert_held(&rq->lock);
>  
> +       /*
> +        * If a task was already enqueue at uclamp enable time
> +        * nothing has been accounted for it.
> +        */
> +       if (unlikely(!uc_se->active))
> +               return;
> +
>         bucket = &uc_rq->bucket[uc_se->bucket_id];
>         SCHED_WARN_ON(!bucket->tasks);
>         if (likely(bucket->tasks))
> ---8<---
> 
> This will allow also to keep in all the ref count checks we have,
> e.g. the SChed_WARN_ON().

Works for me. Though I'd like to expand on the comment more just because there
were few things that were caught out and worth documenting IMO.

> 
> 
> >  	/*
> > @@ -1032,6 +1073,13 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
> >  {
> >  	enum uclamp_id clamp_id;
> >  
> > +	/*
> > +	 * Avoid any overhead until uclamp is actually used by the userspace.
> > +	 * Including the branch if we use static_branch_likely()
> 
> I still find this last sentence hard to parse, but perhaps it's just me
> still missing a breakfast :)

It used to be

	 * Including the JMP if we use static_branch_likely()

Note s/branch/JMP/

Effectively the condition is written such that we produce a NOP when uclamp is
not used. I'll rephrase.

> 
> > +	 */
> > +	if (!static_branch_unlikely(&sched_uclamp_used))
> > +		return;
> 
> I'm also still wondering if the optimization is still working when we
> have that ! in front.

It does. I looked at the generated code before posting.

> 
> Had a check at:
> 
>    https://elixir.bootlin.com/linux/latest/source/include/linux/jump_label.h#L399
> 
> and AFAIU, it all boils down to cook a __branch_check()'s compiler hint,
> and ISTR that those are "anti-patterns"?
> 
> That said we do have some usages for this pattern too:
> 
> $ git grep '!static_branch_unlikely' | wc -l       36
> $ git grep 'static_branch_unlikely' | wc -l       220
> 
> ?
> 
> > +
> >  	if (unlikely(!p->sched_class->uclamp_enabled))
> >  		return;
> >  
> 
> [...]
> 
> > +/**
> > + * uclamp_rq_util_with - clamp @util with @rq and @p effective uclamp values.
> > + * @rq:		The rq to clamp against. Must not be NULL.
> > + * @util:	The util value to clamp.
> > + * @p:		The task to clamp against. Can be NULL if you want to clamp
> > + *		against @rq only.
> > + *
> > + * Clamps the passed @util to the max(@rq, @p) effective uclamp values.
> > + *
> > + * If sched_uclamp_used static key is disabled, then just return the util
> > + * without any clamping since uclamp aggregation at the rq level in the fast
> > + * path is disabled, rendering this operation a NOP.
> > + *
> > + * Use uclamp_eff_value() if you don't care about uclamp values at rq level. It
> > + * will return the correct effective uclamp value of the task even if the
> > + * static key is disabled.
> 
> Well, if you don't care about rq, you don't call a uclamp_rq_* method.
> 
> I would say that the above paragraph is redundant, moreover it adds some
> cross-reference to a different method (name) which required maintenance.
> 
> What about removing it?

I'd rather keep this one too. It helps explaining what the expected way to use
this code. I don't think the maintenance is a big issue? We have to maintain
the code anyway?

> 
> > + */
> >  static __always_inline
> >  unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> >  				  struct task_struct *p)
> >  {
> > -	unsigned long min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
> > -	unsigned long max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
> > +	unsigned long min_util;
> > +	unsigned long max_util;
> > +
> > +	if (!static_branch_likely(&sched_uclamp_used))
> > +		return util;
> > +
> > +	min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
> > +	max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
> 
> I think moving the initialization is not required, the compiler should
> be smart enough to place theme where's better.

I did look at the generated code before posting. The compiler doesn't optimize
the reads. Likely because of the READ_ONCE() which implies volatile access.

> 
> >  	if (p) {
> >  		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
> > @@ -2371,6 +2396,11 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> >  
> >  	return clamp(util, min_util, max_util);
> >  }
> > +
> > +static inline bool uclamp_is_enabled(void)
> > +{
> > +	return static_branch_likely(&sched_uclamp_used);
> > +}
> 
> Looks like here we mix up terms, which can be confusing.
> AFAIKS, we use:
> - *_enabled for the sched class flags (compile time)
> - *_used    for the user-space opting in (run time)

I wanted to add a comment here.

I can rename it to uclamp_is_used() if you want.

Thanks

--
Qais Yousef

> 
> Thus, perhaps we can just use the same pattern used by the
> sched_numa_balancing static key:
> 
>   $ git grep sched_numa_balancing
>   kernel/sched/core.c:DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
>   kernel/sched/core.c:            static_branch_enable(&sched_numa_balancing);
>   kernel/sched/core.c:            static_branch_disable(&sched_numa_balancing);
>   kernel/sched/core.c:    int state = static_branch_likely(&sched_numa_balancing);
>   kernel/sched/fair.c:    if (!static_branch_likely(&sched_numa_balancing))
>   kernel/sched/fair.c:    if (!static_branch_likely(&sched_numa_balancing))
>   kernel/sched/fair.c:    if (!static_branch_likely(&sched_numa_balancing))
>   kernel/sched/fair.c:    if (static_branch_unlikely(&sched_numa_balancing))
>   kernel/sched/sched.h:extern struct static_key_false sched_numa_balancing;
> 
> IOW: unconditionally define sched_uclamp_used as non static in core.c,
> and use it directly on schedutil too.
> 
> >  #else /* CONFIG_UCLAMP_TASK */
> >  static inline
> >  unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> > @@ -2378,6 +2408,11 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
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
> Best,
> Patrick
