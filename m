Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B1BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820132146E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgCDSbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:31:20 -0500
Received: from foss.arm.com ([217.140.110.172]:38340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729600AbgCDSbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:31:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BE5031B;
        Wed,  4 Mar 2020 10:31:19 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B45A3F6C4;
        Wed,  4 Mar 2020 10:31:17 -0800 (PST)
References: <20200304114844.17700-1-daniel.lezcano@linaro.org> <jhjimjk16xi.mognet@arm.com> <a3ab2f17-92b8-20f7-50cd-060385ff655e@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list\:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: fair: Use the earliest break even
In-reply-to: <a3ab2f17-92b8-20f7-50cd-060385ff655e@linaro.org>
Date:   Wed, 04 Mar 2020 18:31:10 +0000
Message-ID: <jhjh7z40y6p.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Mar 04 2020, Daniel Lezcano wrote:
>> With that said, that comment actually raises a valid point: picking
>> recently idled CPUs might give us warmer cache. So by using the break
>> even stat, we can end up picking CPUs with colder caches (have been
>> idling for longer) than the current logic would. I suppose more testing
>> will tell us where we stand.
>
> Actually I'm not sure this comment still applies. If the CPU is powered
> down, the cache is flushed or we can be picking up CPU with their cache
> totally trashed by interrupt processing.
>
>>> +++ b/kernel/sched/sched.h
>>> @@ -1015,6 +1015,7 @@ struct rq {
>>>  #ifdef CONFIG_CPU_IDLE
>>>       /* Must be inspected within a rcu lock section */
>>>       struct cpuidle_state	*idle_state;
>>> +	s64			break_even;
>>
>> Why signed? This should be purely positive, right?
>
> It should be, but s64 complies with the functions ktime_to_ns signature.
>
> static inline s64 ktime_to_ns(const ktime_t kt)
>

Would there be harm then in simply storing:

  ktime_get_ns() + idle_state->exit_latency_ns

(which is u64)?

>>>  #endif
>>>  };
>>>
>>> @@ -1850,6 +1851,16 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
>>>
>>>       return rq->idle_state;
>>>  }
>>> +
>>> +static inline void idle_set_break_even(struct rq *rq, s64 break_even)
>>> +{
>>> +	rq->break_even = break_even;
>>> +}
>>> +
>>> +static inline s64 idle_get_break_even(struct rq *rq)
>>> +{
>>> +	return rq->break_even;
>>> +}
>>
>> I'm not super familiar with the callsites for setting idle states,
>> what's the locking situation there? Do we have any rq lock?
>
> It is safe, we are under rcu, this section was discussed several years
> ago when introducing the idle_set_state():
>
>  https://lkml.org/lkml/2014/9/19/332
>

Thanks for the link!

So while we (should) have the relevant barriers, there can still be
concurrent writing (from the CPU entering/leaving idle) and reading
(from the CPU gathering stats).

rcu_dereference() gives you READ_ONCE(), and the rcu_assign_pointer()
should give you an smp_store_release(). What I'm thinking here is, if we
have reasons not to use the RCU primitives, we should at least slap some
READ/WRITE_ONCE() to the accesses. Also, can RCU even do anything about
scalar values like the break even you're storing?

>> In find_idlest_group_cpu() we're in a read-side RCU section, so the
>> idle_state is protected (speaking of which, why isn't idle_get_state()
>> using rcu_dereference()?), but that's doesn't cover the break even.
>>
>> IIUC at the very least we may want to give them the READ/WRITE_ONCE()
>> treatment.
>>
