Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599A2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8722078D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgFZMjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:39:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37515 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZMjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:39:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id g20so6575536edm.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 05:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=xE7TyWw+xU2oS6vSkWB5R5ZqLQ0SPJp1BxXS338RiCU=;
        b=C0cFsCFbYK05Z/BqYwBzYNOWgsTfGmshzNBZYBvvxXGZGQziQ1IEtZZp7TzGBY3rJA
         3rmosInDR465GXy5CmQs14MTtT5iRh9biMFs/ghDwSnuj/Q82FuHIBzU5UjpMzl/+tDU
         wlSb4kOYVeX/9zhfky+e+60vb50NdxgGsNfJVp0bSpBt7JVUrreJWFnzHEFELqQGO6DZ
         MkzVD3Y+29jiNfQTnttPr1KLbGlotXB7FCgC8Nb88s5qYWCug/4kFwh1hkH9FWbfggwj
         5jgCA6+dJyGU1paqDOQRAdvx7mNuQSkJj7CEo/LOGBwzqWfD2w/CdrTXCn6Tys4TpQNf
         FnEw==
X-Gm-Message-State: AOAM532axbP0Q4GK71ljq454OPPGoqtu8p+HTxS4yP1KqGIpHODH+9YS
        ZVeGnF2gPGIRz1aayRx1cToJK8NbiVY=
X-Google-Smtp-Source: ABdhPJy474szPm85RGqkquFI7tsN6hFthwhGhI1PGCwIwSEEO3wDU3S73yJ7+HiRQCcwaugJZ6ES9A==
X-Received: by 2002:aa7:c714:: with SMTP id i20mr3177941edq.215.1593175139280;
        Fri, 26 Jun 2020 05:38:59 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id c4sm18974596ejb.17.2020.06.26.05.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:38:58 -0700 (PDT)
References: <20200625154352.24767-1-qais.yousef@arm.com> <20200625154352.24767-3-qais.yousef@arm.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Qais Yousef <qais.yousef@arm.com>
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
Subject: Re: [PATCH v4 2/2] sched/uclamp: Protect uclamp fast path code with static key
In-reply-to: <20200625154352.24767-3-qais.yousef@arm.com>
Message-ID: <87bll6ngrr.derkling@matbug.net>
Date:   Fri, 26 Jun 2020 14:38:48 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Jun 25, 2020 at 17:43:52 +0200, Qais Yousef <qais.yousef@arm.com> wrote...

[...]

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 235b2cae00a0..e2f1fffa013c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -794,6 +794,25 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
>  /* All clamps are required to be less or equal than these values */
>  static struct uclamp_se uclamp_default[UCLAMP_CNT];
>  
> +/*
> + * This static key is used to reduce the uclamp overhead in the fast path. It
> + * only disables the call to uclamp_rq_{inc, dec}() in enqueue/dequeue_task().
> + *
> + * This allows users to continue to enable uclamp in their kernel config with
> + * minimum uclamp overhead in the fast path.
> + *
> + * As soon as userspace modifies any of the uclamp knobs, the static key is
> + * enabled, since we have an actual users that make use of uclamp
> + * functionality.
> + *
> + * The knobs that would enable this static key are:
> + *
> + *   * A task modifying its uclamp value with sched_setattr().
> + *   * An admin modifying the sysctl_sched_uclamp_{min, max} via procfs.
> + *   * An admin modifying the cgroup cpu.uclamp.{min, max}
> + */
> +static DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);

This is me being choosy, but given that:

---8<---
% grep -e '_used[ )]' fair.c core.c
fair.c:	return static_key_false(&__cfs_bandwidth_used);
fair.c:	static_key_slow_inc_cpuslocked(&__cfs_bandwidth_used);
fair.c:	static_key_slow_dec_cpuslocked(&__cfs_bandwidth_used);

% grep -e '_enabled[ )]' fair.c core.c
fair.c:	if (!cfs_bandwidth_used() || !cfs_rq->runtime_enabled)
fair.c:	if (!cfs_rq->runtime_enabled || cfs_rq->nr_running)
fair.c:	if (!cfs_rq->runtime_enabled || cfs_rq->curr)
fair.c:	if (likely(!cfs_rq->runtime_enabled || cfs_rq->runtime_remaining > 0))
fair.c:	cfs_rq->runtime_enabled = 0;
fair.c:		cfs_rq->runtime_enabled = cfs_b->quota != RUNTIME_INF;
fair.c:		if (!cfs_rq->runtime_enabled)
fair.c:		cfs_rq->runtime_enabled = 0;
core.c:	if (static_key_false((&paravirt_steal_rq_enabled))) {
core.c:	if (unlikely(!p->sched_class->uclamp_enabled))
core.c:	if (unlikely(!p->sched_class->uclamp_enabled))
core.c:	 * Prevent race between setting of cfs_rq->runtime_enabled and
core.c:	runtime_enabled = quota != RUNTIME_INF;
core.c:	runtime_was_enabled = cfs_b->quota != RUNTIME_INF;
core.c:	if (runtime_enabled && !runtime_was_enabled)
core.c:	if (runtime_enabled)
core.c:		cfs_rq->runtime_enabled = runtime_enabled;
core.c:	if (runtime_was_enabled && !runtime_enabled)
---8<---

even just for consistency shake, I would still prefer sched_uclamp_enabled for
the static key name.

> +
>  /* Integer rounded range for each bucket */
>  #define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
>  
> @@ -994,9 +1013,16 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>  	lockdep_assert_held(&rq->lock);
>  
>  	bucket = &uc_rq->bucket[uc_se->bucket_id];
> -	SCHED_WARN_ON(!bucket->tasks);
> -	if (likely(bucket->tasks))
> -		bucket->tasks--;
> +
> +	/*
> +	 * This could happen if sched_uclamp_used was enabled while the
> +	 * current task was running, hence we could end up with unbalanced call
> +	 * to uclamp_rq_dec_id().
> +	 */
> +	if (unlikely(!bucket->tasks))
> +		return;
> +
> +	bucket->tasks--;
>  	uc_se->active = false;

In this chunk you are indeed changing the code.

Are we sure there are not issues with patterns like:

  enqueue(taskA)
  // uclamp gets enabled
  enqueue(taskB)
  dequeue(taskA)
  // bucket->tasks is now 0
  dequeue(taskB)

TaskB has been enqueued with with uclamp enabled, thus it
has got uc_se->active=True and enforced its clamp value at RQ level.

But with your change above we don't reset that anymore.

As per my previous proposal: why not just removing the SCHED_WARN_ON?
That's the only real problem in the code above, since now we are not
more granted to have balanced inc/dec.

[...]

> +bool uclamp_is_enabled(void)
> +{
> +	return static_branch_likely(&sched_uclamp_used);
> +}
> +

The above and the following changes are not necessary if we just
add the guards at the beginning of uclamp_rq_util_with() instead of what
you do in PATCH1.

I think this will give better overheads removal by avoiding not
necessary min/max clamps for both RT and CFS.
  
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 7fbaee24c824..3f4e296ccb67 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -210,7 +210,7 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
>  	unsigned long dl_util, util, irq;
>  	struct rq *rq = cpu_rq(cpu);
>  
> -	if (!IS_BUILTIN(CONFIG_UCLAMP_TASK) &&
> +	if (!uclamp_is_enabled() &&
>  	    type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
>  		return max;
>  	}
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 1d4e94c1e5fe..aff5430331e4 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2371,6 +2371,8 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
>  
>  	return clamp(util, min_util, max_util);
>  }
> +
> +bool uclamp_is_enabled(void);
>  #else /* CONFIG_UCLAMP_TASK */
>  static inline
>  unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> @@ -2378,6 +2380,11 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
>  {
>  	return util;
>  }
> +
> +static inline bool uclamp_is_enabled(void)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_UCLAMP_TASK */
>  
>  #ifdef arch_scale_freq_capacity

