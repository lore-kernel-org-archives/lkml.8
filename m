Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112EBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2C8120759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgF3IMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:12:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33012 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgF3IMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:12:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id h28so15327382edz.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 01:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=J9MxgcqbqpLXLDMoRI08abhZKfTDkvAje8aDh5X0sC4=;
        b=hhNGKJvbFR9yuFRjiaxJsK2ydz4H2+7TeWllVLJzvwP6pZmVisstIK16iy0RniMOHF
         fy55HsIUwTYLdWSrNvrxdI1JCrHLpKcjuW+ZFuUjUDqM8X5g/J4+34MpAo0iB3Uchcla
         EeGKKuQIijem3TAq2vij0oQr+0Zxi+qI/e7QJn+M2pnybuv4hcq4Mp96NxeZmk6IUCGc
         Hq8YRRU3BU63delgIUK31i+3YOmRBFQ6aZbXRUD9PfG2qp7sux2jx9AHHRCKhATJohZ9
         Z1wHSPuqaubbr+1w/1tgy5LgzsIfrVa5HWlYJvsW24/Ssj1Qll3mNfxRGMEByrp6nJSA
         YJ7w==
X-Gm-Message-State: AOAM532i5k0/688A/rhDVehEE+4KdMlcnD0R8txGOw9DSA1RJw5lR6nT
        pKlIJENeeP4etuEcKCh8BKWVzwBpZ5I=
X-Google-Smtp-Source: ABdhPJyrA5os0afG5E78JifN6dc5ne4R5tgSA6mHjCtOGfq5/9Y5XWU2Qcqoz1WAcmNKPY6dy6pgOQ==
X-Received: by 2002:a05:6402:94f:: with SMTP id h15mr22030687edz.313.1593504730113;
        Tue, 30 Jun 2020 01:12:10 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id m26sm1498371ejn.122.2020.06.30.01.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 01:12:09 -0700 (PDT)
References: <20200629162633.8800-1-qais.yousef@arm.com> <20200629162633.8800-3-qais.yousef@arm.com>
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
Subject: Re: [PATCH v5 2/2] sched/uclamp: Protect uclamp fast path code with static key
In-reply-to: <20200629162633.8800-3-qais.yousef@arm.com>
Message-ID: <87366dnfaq.derkling@matbug.net>
Date:   Tue, 30 Jun 2020 10:11:57 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Qais,
here are some more 2c from me...

On Mon, Jun 29, 2020 at 18:26:33 +0200, Qais Yousef <qais.yousef@arm.com> wrote...

[...]

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 235b2cae00a0..8d80d6091d86 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -794,6 +794,26 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
>  /* All clamps are required to be less or equal than these values */
>  static struct uclamp_se uclamp_default[UCLAMP_CNT];
>  
> +/*
> + * This static key is used to reduce the uclamp overhead in the fast path. It
> + * primarily disables the call to uclamp_rq_{inc, dec}() in
> + * enqueue/dequeue_task().
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

I guess this list can be obtained with a grep or git changelog, moreover
this text will require maintenance.

What about replacing this full comment with something shorted like:

---8<---
      Static key to reduce uclamp overhead in the fast path by disabling
      calls to uclamp_rq_{inc, dec}().
---8<---

> + */
> +DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
> +
>  /* Integer rounded range for each bucket */
>  #define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
>  
> @@ -994,9 +1014,30 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>  	lockdep_assert_held(&rq->lock);
>  
>  	bucket = &uc_rq->bucket[uc_se->bucket_id];
> -	SCHED_WARN_ON(!bucket->tasks);
> +
> +	/*
> +	 * bucket->tasks could be zero if sched_uclamp_used was enabled while
> +	 * the current task was running, hence we could end up with unbalanced
> +	 * call to uclamp_rq_dec_id().
> +	 *
> +	 * Need to be careful of the following enqeueue/dequeue order
> +	 * problem too
> +	 *
> +	 *	enqueue(taskA)
> +	 *	// sched_uclamp_used gets enabled
> +	 *	enqueue(taskB)
> +	 *	dequeue(taskA)
> +	 *	// bucket->tasks is now 0
> +	 *	dequeue(taskB)
> +	 *
> +	 * where we could end up with uc_se->active of the task set to true and
> +	 * the wrong bucket[uc_se->bucket_id].value.
> +	 *
> +	 * Hence always make sure we reset things properly.
> +	 */
>  	if (likely(bucket->tasks))
>  		bucket->tasks--;
> +
>  	uc_se->active = false;

Better than v4, what about just using this active flag?

---8<---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8f360326861e..465a7645713b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -990,6 +990,13 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 
        lockdep_assert_held(&rq->lock);
 
+       /*
+        * If a task was already enqueue at uclamp enable time
+        * nothing has been accounted for it.
+        */
+       if (unlikely(!uc_se->active))
+               return;
+
        bucket = &uc_rq->bucket[uc_se->bucket_id];
        SCHED_WARN_ON(!bucket->tasks);
        if (likely(bucket->tasks))
---8<---

This will allow also to keep in all the ref count checks we have,
e.g. the SChed_WARN_ON().


>  	/*
> @@ -1032,6 +1073,13 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>  {
>  	enum uclamp_id clamp_id;
>  
> +	/*
> +	 * Avoid any overhead until uclamp is actually used by the userspace.
> +	 * Including the branch if we use static_branch_likely()

I still find this last sentence hard to parse, but perhaps it's just me
still missing a breakfast :)

> +	 */
> +	if (!static_branch_unlikely(&sched_uclamp_used))
> +		return;

I'm also still wondering if the optimization is still working when we
have that ! in front.

Had a check at:

   https://elixir.bootlin.com/linux/latest/source/include/linux/jump_label.h#L399

and AFAIU, it all boils down to cook a __branch_check()'s compiler hint,
and ISTR that those are "anti-patterns"?

That said we do have some usages for this pattern too:

$ git grep '!static_branch_unlikely' | wc -l       36
$ git grep 'static_branch_unlikely' | wc -l       220

?

> +
>  	if (unlikely(!p->sched_class->uclamp_enabled))
>  		return;
>  

[...]

> +/**
> + * uclamp_rq_util_with - clamp @util with @rq and @p effective uclamp values.
> + * @rq:		The rq to clamp against. Must not be NULL.
> + * @util:	The util value to clamp.
> + * @p:		The task to clamp against. Can be NULL if you want to clamp
> + *		against @rq only.
> + *
> + * Clamps the passed @util to the max(@rq, @p) effective uclamp values.
> + *
> + * If sched_uclamp_used static key is disabled, then just return the util
> + * without any clamping since uclamp aggregation at the rq level in the fast
> + * path is disabled, rendering this operation a NOP.
> + *
> + * Use uclamp_eff_value() if you don't care about uclamp values at rq level. It
> + * will return the correct effective uclamp value of the task even if the
> + * static key is disabled.

Well, if you don't care about rq, you don't call a uclamp_rq_* method.

I would say that the above paragraph is redundant, moreover it adds some
cross-reference to a different method (name) which required maintenance.

What about removing it?

> + */
>  static __always_inline
>  unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
>  				  struct task_struct *p)
>  {
> -	unsigned long min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
> -	unsigned long max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
> +	unsigned long min_util;
> +	unsigned long max_util;
> +
> +	if (!static_branch_likely(&sched_uclamp_used))
> +		return util;
> +
> +	min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
> +	max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);

I think moving the initialization is not required, the compiler should
be smart enough to place theme where's better.

>  	if (p) {
>  		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
> @@ -2371,6 +2396,11 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
>  
>  	return clamp(util, min_util, max_util);
>  }
> +
> +static inline bool uclamp_is_enabled(void)
> +{
> +	return static_branch_likely(&sched_uclamp_used);
> +}

Looks like here we mix up terms, which can be confusing.
AFAIKS, we use:
- *_enabled for the sched class flags (compile time)
- *_used    for the user-space opting in (run time)

Thus, perhaps we can just use the same pattern used by the
sched_numa_balancing static key:

  $ git grep sched_numa_balancing
  kernel/sched/core.c:DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
  kernel/sched/core.c:            static_branch_enable(&sched_numa_balancing);
  kernel/sched/core.c:            static_branch_disable(&sched_numa_balancing);
  kernel/sched/core.c:    int state = static_branch_likely(&sched_numa_balancing);
  kernel/sched/fair.c:    if (!static_branch_likely(&sched_numa_balancing))
  kernel/sched/fair.c:    if (!static_branch_likely(&sched_numa_balancing))
  kernel/sched/fair.c:    if (!static_branch_likely(&sched_numa_balancing))
  kernel/sched/fair.c:    if (static_branch_unlikely(&sched_numa_balancing))
  kernel/sched/sched.h:extern struct static_key_false sched_numa_balancing;

IOW: unconditionally define sched_uclamp_used as non static in core.c,
and use it directly on schedutil too.

>  #else /* CONFIG_UCLAMP_TASK */
>  static inline
>  unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> @@ -2378,6 +2408,11 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
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

Best,
Patrick
