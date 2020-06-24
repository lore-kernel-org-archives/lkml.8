Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9902FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F2C2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389831AbgFXHeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:34:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39151 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389739AbgFXHeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:34:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id t194so1495701wmt.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 00:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=TX46+tOYw695eoUWnWY6nEE97aD+zCO7F3ulbGdoE74=;
        b=eogAb0jdDTupHsscvGfuvfSCCC2AgcOE6XoymMx9gm8tBf86caTajNvz5HtTQFsitZ
         WCe04Bflw4DFGos5zN1fJuU0mwtsh/Qj61Rds2Bw1fW2qhf6CcFS4H2+eS9HjRn3j7dj
         JSS5uCHGA226nZwdlScxtNVZZGsqiOUsCfgMlxzNglrGCh1BN9ble36mjRKVRAvdWbcp
         nIUCbcKWRfEnhEwQ2NwZADsCqyJiSKJIFlKkPx2E1ZgM8sR3FulMT4qqVeyJ0iDnELvI
         qUWJvXw39KehaHnqJV/tzePugPDjBMG6SEVdXy5xFvthFGnoOWIr4g6ckl++0x3SKtSL
         zPQA==
X-Gm-Message-State: AOAM533Cc8khXC2MIxxSdui3Zme3Sf5DqGqB98RqM0Zlaz49Fxf09jaB
        1Gr+nJdiJKvWsuwDWhOl9Z75/Aw2a96nlw==
X-Google-Smtp-Source: ABdhPJzttRmmUsL1CobmbB3fHgdt2fNw0uYMG/g38pQafL0EfjL0Pjr5X/PGEeEVY//tZQfETH+ZIg==
X-Received: by 2002:a1c:29c3:: with SMTP id p186mr20850956wmp.122.1592984052051;
        Wed, 24 Jun 2020 00:34:12 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id y196sm7588426wmd.11.2020.06.24.00.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 00:34:11 -0700 (PDT)
References: <20200619172011.5810-1-qais.yousef@arm.com> <20200619172011.5810-3-qais.yousef@arm.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sched/uclamp: Protect uclamp fast path code with static key
In-reply-to: <20200619172011.5810-3-qais.yousef@arm.com>
Message-ID: <87pn9oor2t.derkling@matbug.net>
Date:   Wed, 24 Jun 2020 09:34:02 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Jun 19, 2020 at 19:20:11 +0200, Qais Yousef <qais.yousef@arm.com> wrote...

[...]

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 4265861e13e9..9ab22f699613 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -793,6 +793,25 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
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
> + * disabled, since we have an actual users that make use of uclamp
> + * functionality.
> + *
> + * The knobs that would disable this static key are:
> + *
> + *   * A task modifying its uclamp value with sched_setattr().
> + *   * An admin modifying the sysctl_sched_uclamp_{min, max} via procfs.
> + *   * An admin modifying the cgroup cpu.uclamp.{min, max}
> + */
> +static DEFINE_STATIC_KEY_TRUE(sched_uclamp_unused);

I would personally prefer a non negated semantic.

Why not using 'sched_uclamp_enabled'?

> +
>  /* Integer rounded range for each bucket */
>  #define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
>  
> @@ -993,9 +1012,16 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>  	lockdep_assert_held(&rq->lock);
>  
>  	bucket = &uc_rq->bucket[uc_se->bucket_id];
> -	SCHED_WARN_ON(!bucket->tasks);
> -	if (likely(bucket->tasks))
> -		bucket->tasks--;
> +
> +	/*
> +	 * This could happen if sched_uclamp_unused was disabled while the
> +	 * current task was running, hence we could end up with unbalanced call
> +	 * to uclamp_rq_dec_id().
> +	 */
> +	if (unlikely(!bucket->tasks))
> +		return;
> +
> +	bucket->tasks--;

Since above you are not really changing the logic, why changing the
code?

The SCHED_WARN_ON/if(likely) is a defensive programming thing.
I understand that SCHED_WARN_ON() can now be misleading because of the
unbalanced calls but... why not just removing it?

Maybe also adding in the comment, but I don't see valid reasons to
change the code if the functionality is not changing.


>  	uc_se->active = false;
>  
>  	/*
> @@ -1031,6 +1057,13 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>  {
>  	enum uclamp_id clamp_id;
>  
> +	/*
> +	 * Avoid any overhead until uclamp is actually used by the userspace.
> +	 * Including the potential JMP if we use static_branch_unlikely()

The comment above (about unlikely) seems not to match the code?

> +	 */
> +	if (static_branch_likely(&sched_uclamp_unused))
> +		return;

Moreover, something like:

       if (static_key_false(&sched_uclamp_enabled))
                return;

is not just good enough?

> +
>  	if (unlikely(!p->sched_class->uclamp_enabled))
>  		return;

Since we already have these per sched_class gates, I'm wondering if it
could make sense to just re-purpose them.

Problem with the static key is that if just one RT task opts in, CFS
will still pay the overheads, and vice versa too.

So, an alternative approach could be to opt in sched classes on-demand.

The above if(unlikely) is not exactly has a static key true, but I
assume we agree the overheads we are tacking are nothing compared to
that check, aren't they?


> @@ -1046,6 +1079,13 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
>  {
>  	enum uclamp_id clamp_id;
>  
> +	/*
> +	 * Avoid any overhead until uclamp is actually used by the userspace.
> +	 * Including the potential JMP if we use static_branch_unlikely()
> +	 */
> +	if (static_branch_likely(&sched_uclamp_unused))
> +		return;
> +
>  	if (unlikely(!p->sched_class->uclamp_enabled))
>  		return;
>  
> @@ -1155,9 +1195,13 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
>  		update_root_tg = true;
>  	}
>  
> -	if (update_root_tg)
> +	if (update_root_tg) {
>  		uclamp_update_root_tg();
>  
> +		if (static_branch_unlikely(&sched_uclamp_unused))
> +			static_branch_disable(&sched_uclamp_unused);
> +	}
> +

Can we move the above into a function?

Something similar to set_schedstats(bool), what about uclamp_enable(bool)?

>  	/*
>  	 * We update all RUNNABLE tasks only when task groups are in use.
>  	 * Otherwise, keep it simple and do just a lazy update at each next
> @@ -1221,6 +1265,9 @@ static void __setscheduler_uclamp(struct task_struct *p,
>  	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
>  		return;
>  
> +	if (static_branch_unlikely(&sched_uclamp_unused))
> +		static_branch_disable(&sched_uclamp_unused);
> +
>  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
>  			      attr->sched_util_min, true);
> @@ -7315,6 +7362,9 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
>  	if (req.ret)
>  		return req.ret;
>  
> +	if (static_branch_unlikely(&sched_uclamp_unused))
> +		static_branch_disable(&sched_uclamp_unused);
> +
>  	mutex_lock(&uclamp_mutex);
>  	rcu_read_lock();

Best,
Patrick
