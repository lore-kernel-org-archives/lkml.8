Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28690C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FEC206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbgF3JoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:44:23 -0400
Received: from foss.arm.com ([217.140.110.172]:60764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730613AbgF3JoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:44:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B681530E;
        Tue, 30 Jun 2020 02:44:22 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 162F53F68F;
        Tue, 30 Jun 2020 02:44:20 -0700 (PDT)
References: <20200629162633.8800-1-qais.yousef@arm.com> <20200629162633.8800-3-qais.yousef@arm.com> <87366dnfaq.derkling@matbug.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] sched/uclamp: Protect uclamp fast path code with static key
In-reply-to: <87366dnfaq.derkling@matbug.net>
Date:   Tue, 30 Jun 2020 10:44:15 +0100
Message-ID: <jhj8sg4hor4.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/06/20 09:11, Patrick Bellasi wrote:
> Hi Qais,
> here are some more 2c from me...
>
> On Mon, Jun 29, 2020 at 18:26:33 +0200, Qais Yousef <qais.yousef@arm.com> wrote...
>
> [...]
>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 235b2cae00a0..8d80d6091d86 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -794,6 +794,26 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
>>  /* All clamps are required to be less or equal than these values */
>>  static struct uclamp_se uclamp_default[UCLAMP_CNT];
>>
>> +/*
>> + * This static key is used to reduce the uclamp overhead in the fast path. It
>> + * primarily disables the call to uclamp_rq_{inc, dec}() in
>> + * enqueue/dequeue_task().
>> + *
>> + * This allows users to continue to enable uclamp in their kernel config with
>> + * minimum uclamp overhead in the fast path.
>> + *
>> + * As soon as userspace modifies any of the uclamp knobs, the static key is
>> + * enabled, since we have an actual users that make use of uclamp
>> + * functionality.
>> + *
>> + * The knobs that would enable this static key are:
>> + *
>> + *   * A task modifying its uclamp value with sched_setattr().
>> + *   * An admin modifying the sysctl_sched_uclamp_{min, max} via procfs.
>> + *   * An admin modifying the cgroup cpu.uclamp.{min, max}
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
>

Having some sense of when that key gets flipped is worthwhile IMO; though
it may not have to be exhaustive list.

>> + */
>> +DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
>> +
>>  /* Integer rounded range for each bucket */
>>  #define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
>>
[...]
>> @@ -1032,6 +1073,13 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>>  {
>>      enum uclamp_id clamp_id;
>>
>> +	/*
>> +	 * Avoid any overhead until uclamp is actually used by the userspace.
>> +	 * Including the branch if we use static_branch_likely()
>
> I still find this last sentence hard to parse, but perhaps it's just me
> still missing a breakfast :)
>

AIUI this tries to explain why we use 'unlikely' rather than 'likely' -
it's to prevent !uclamp users from having the branch overhead (see
include/linux/jump_label.h, there's a nice fat comment just above
static_branch_likely()).

IMO that point is already covered by the first sentence, as I blabbered on
some previous version.

>> +	 */
>> +	if (!static_branch_unlikely(&sched_uclamp_used))
>> +		return;
>
> I'm also still wondering if the optimization is still working when we
> have that ! in front.
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

We use it for e.g. the sched_asym_cpucapacity key, and that works (and I've
been down into the asm a few times).

>> +
>>      if (unlikely(!p->sched_class->uclamp_enabled))
>>              return;
>>
>
> [...]
>
>> +/**
>> + * uclamp_rq_util_with - clamp @util with @rq and @p effective uclamp values.
>> + * @rq:		The rq to clamp against. Must not be NULL.
>> + * @util:	The util value to clamp.
>> + * @p:		The task to clamp against. Can be NULL if you want to clamp
>> + *		against @rq only.
>> + *
>> + * Clamps the passed @util to the max(@rq, @p) effective uclamp values.
>> + *
>> + * If sched_uclamp_used static key is disabled, then just return the util
>> + * without any clamping since uclamp aggregation at the rq level in the fast
>> + * path is disabled, rendering this operation a NOP.
>> + *
>> + * Use uclamp_eff_value() if you don't care about uclamp values at rq level. It
>> + * will return the correct effective uclamp value of the task even if the
>> + * static key is disabled.
>
> Well, if you don't care about rq, you don't call a uclamp_rq_* method.
>
> I would say that the above paragraph is redundant, moreover it adds some
> cross-reference to a different method (name) which required maintenance.
>
> What about removing it?
>
>> + */
>>  static __always_inline
>>  unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
>>                                struct task_struct *p)
>>  {
>> -	unsigned long min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
>> -	unsigned long max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
>> +	unsigned long min_util;
>> +	unsigned long max_util;
>> +
>> +	if (!static_branch_likely(&sched_uclamp_used))
>> +		return util;
>> +
>> +	min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
>> +	max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
>
> I think moving the initialization is not required, the compiler should
> be smart enough to place theme where's better.
>

Not so sure with the READ_ONCE() & the volatile underneath; a quick
compiler test with a volatile read before a branch tells me we still do the
read before the branch, even if the value is only used after the branch.

>>      if (p) {
>>              min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
>> @@ -2371,6 +2396,11 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
>>
>>      return clamp(util, min_util, max_util);
>>  }
>> +
>> +static inline bool uclamp_is_enabled(void)
>> +{
>> +	return static_branch_likely(&sched_uclamp_used);
>> +}
>
> Looks like here we mix up terms, which can be confusing.
> AFAIKS, we use:
> - *_enabled for the sched class flags (compile time)
> - *_used    for the user-space opting in (run time)
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
>>  #else /* CONFIG_UCLAMP_TASK */
>>  static inline
>>  unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
>> @@ -2378,6 +2408,11 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
>>  {
>>      return util;
>>  }
>> +
>> +static inline bool uclamp_is_enabled(void)
>> +{
>> +	return false;
>> +}
>>  #endif /* CONFIG_UCLAMP_TASK */
>>
>>  #ifdef arch_scale_freq_capacity
>
> Best,
> Patrick
