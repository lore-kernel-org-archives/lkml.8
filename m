Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BC6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5082078D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388543AbgFYAQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:16:56 -0400
Received: from foss.arm.com ([217.140.110.172]:58330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387843AbgFYAQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:16:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9630E1FB;
        Wed, 24 Jun 2020 17:16:54 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E77403F6CF;
        Wed, 24 Jun 2020 17:16:52 -0700 (PDT)
References: <20200624172605.26715-1-qais.yousef@arm.com> <20200624172605.26715-3-qais.yousef@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] sched/uclamp: Protect uclamp fast path code with static key
In-reply-to: <20200624172605.26715-3-qais.yousef@arm.com>
Date:   Thu, 25 Jun 2020 01:16:50 +0100
Message-ID: <jhj5zbgroct.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Qais,

On 24/06/20 18:26, Qais Yousef wrote:
[...]
> ---
>
> This takes a different approach to PSI which introduces a config option
>
> ```
>       CONFIG_PSI_DEFAULT_DISABLED
>
>         Require boot parameter to enable pressure stall information
>         tracking (NEW)
>
>       boot param psi
> ```
>
> via commit e0c274472d5d "psi: make disabling/enabling easier for vendor kernels"
>
> uclamp has a clearer points of entry when userspace would like to use it so we
> can automatically flip the switch if the kernel is running on a userspace that
> wants to user utilclamp without any extra userspace visible switches.
>
> I wanted to make this dependent on schedutil being the governor too, but beside
> the complexity, uclamp is used for capacity awareness. We could certainly
> construct a more complex condition, but I'm not sure it's worth it. Open to
> hear more opinions and points of views on this :)
>

I think the toggling conditions are good as they are. However, speaking of
schedutil, doesn't this patch break the RT frequency boost? Mind you it
might be too late for me to be thinking about this stuff.

In schedutil_cpu_util(), when uclamp isn't compiled it, we have an explicit
'goto max'. When uclamp *is* compiled in, that's taken care of by the
"natural" RT uclamp aggregation... Which doesn't happen until we flip the
static key. 

It's yucky, but if you declare the key in the internal sched header, you
could reuse it in the existing 'goto max' (or sysctl value, when we make
that tweakable) path. 

>
>  kernel/sched/core.c | 54 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 50 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 235b2cae00a0..44e03d4fd19d 100644
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

That one makes it not just userspace, right? While the sched_setattr()
stuff is expected to be unexported, it isn't ATM and we may expect some
modules to ask for a uclamp API eventually.

> + *   * An admin modifying the sysctl_sched_uclamp_{min, max} via procfs.
> + *   * An admin modifying the cgroup cpu.uclamp.{min, max}
> + */
> +static DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
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
>  
>  	/*
> @@ -1032,6 +1058,13 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>  {
>  	enum uclamp_id clamp_id;
>  
> +	/*
> +	 * Avoid any overhead until uclamp is actually used by the userspace.
> +	 * Including the branch if we use static_branch_likely()

I think that second point is made clear by the first one, but YMMV.

> +	 */
> +	if (!static_branch_unlikely(&sched_uclamp_used))
> +		return;
> +
>  	if (unlikely(!p->sched_class->uclamp_enabled))
>  		return;
>  
> @@ -1047,6 +1080,13 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
>  {
>  	enum uclamp_id clamp_id;
>  
> +	/*
> +	 * Avoid any overhead until uclamp is actually used by the userspace.
> +	 * Including the branch if we use static_branch_likely()
> +	 */
> +	if (!static_branch_unlikely(&sched_uclamp_used))
> +		return;
> +
>  	if (unlikely(!p->sched_class->uclamp_enabled))
>  		return;
>  
> @@ -1155,8 +1195,10 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
>  		update_root_tg = true;
>  	}
>  
> -	if (update_root_tg)
> +	if (update_root_tg) {
>  		uclamp_update_root_tg();
> +		static_branch_enable(&sched_uclamp_used);

I don't think it matters ATM, but shouldn't we flip that *before* updating
the TG's to avoid any future surprises? 

> +	}
>  
>  	/*
>  	 * We update all RUNNABLE tasks only when task groups are in use.
> @@ -1221,6 +1263,8 @@ static void __setscheduler_uclamp(struct task_struct *p,
>  	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
>  		return;
>  
> +	static_branch_enable(&sched_uclamp_used);
> +
>  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
>  			      attr->sched_util_min, true);
> @@ -7387,6 +7431,8 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
>  	if (req.ret)
>  		return req.ret;
>  
> +	static_branch_enable(&sched_uclamp_used);
> +
>  	mutex_lock(&uclamp_mutex);
>  	rcu_read_lock();

