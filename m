Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A87C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DD020706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404221AbgFYL0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:26:12 -0400
Received: from foss.arm.com ([217.140.110.172]:35202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404042AbgFYL0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:26:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A17521FB;
        Thu, 25 Jun 2020 04:26:10 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01D683F73C;
        Thu, 25 Jun 2020 04:26:08 -0700 (PDT)
References: <20200624172605.26715-1-qais.yousef@arm.com> <20200624172605.26715-3-qais.yousef@arm.com> <jhj5zbgroct.mognet@arm.com> <20200625110006.q3iepcrh2uh4oizv@e107158-lin.cambridge.arm.com>
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
Message-ID: <jhjpn9ngzlx.mognet@arm.com>
In-reply-to: <20200625110006.q3iepcrh2uh4oizv@e107158-lin.cambridge.arm.com>
Date:   Thu, 25 Jun 2020 12:26:04 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/06/20 12:00, Qais Yousef wrote:
> Hi Valentin
>
> On 06/25/20 01:16, Valentin Schneider wrote:
>> In schedutil_cpu_util(), when uclamp isn't compiled it, we have an explicit
>> 'goto max'. When uclamp *is* compiled in, that's taken care of by the
>> "natural" RT uclamp aggregation... Which doesn't happen until we flip the
>> static key.
>>
>> It's yucky, but if you declare the key in the internal sched header, you
>> could reuse it in the existing 'goto max' (or sysctl value, when we make
>> that tweakable) path.
>
> Not sure if this is the best way forward. I need to think about it.
> While I am not keen on enabling in kernel users of util clamp, but there was
> already an attempt to do so. This approach will not allow us to implement
> something in the future for that. Which maybe is what we want..
>

Just to be clear, I'm not suggesting to add any in-kernel toggling of
uclamp outside of the scheduler: by keeping that to the internal sched
header & schedutil, we're keeping it contained to internal scheduler land.

Since a diff is worth a thousand words, here's what I was thinking of (not
even compiled):
---
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 7fbaee24c824..68731c3316ef 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -210,7 +210,7 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
        unsigned long dl_util, util, irq;
        struct rq *rq = cpu_rq(cpu);

-	if (!IS_BUILTIN(CONFIG_UCLAMP_TASK) &&
+	if ((!IS_BUILTIN(CONFIG_UCLAMP_TASK) || !static_branch_likely(&sched_uclamp_used)) &&
            type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
                return max;
        }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1d4e94c1e5fe..3fd5c792f247 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1638,6 +1638,7 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =

 extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false sched_schedstats;
+extern struct static_key_false sched_uclamp_used;

 static inline u64 global_rt_period(void)
 {
---

>> > + * As soon as userspace modifies any of the uclamp knobs, the static key is
>> > + * enabled, since we have an actual users that make use of uclamp
>> > + * functionality.
>> > + *
>> > + * The knobs that would enable this static key are:
>> > + *
>> > + *   * A task modifying its uclamp value with sched_setattr().
>>
>> That one makes it not just userspace, right? While the sched_setattr()
>> stuff is expected to be unexported, it isn't ATM and we may expect some
>> modules to ask for a uclamp API eventually.
>
> This has already come up with another thread [1]. I think in-kernel users
> shouldn't go through this path. I will propose something to give stronger
> guarantees in this regard.
>

True; and they'll have to go through another path anyway once the unexport
thing happens.

>> > -	if (update_root_tg)
>> > +	if (update_root_tg) {
>> >            uclamp_update_root_tg();
>> > +		static_branch_enable(&sched_uclamp_used);
>>
>> I don't think it matters ATM, but shouldn't we flip that *before* updating
>> the TG's to avoid any future surprises?
>
> What sort of surprises are you thinking of?
>

Say if we end up adding static key checks in some other uclamp functions
(which are called in the TG update) and don't change this here, someone
will have to scratch their heads to figure out the key enablement needs to
be moved one line higher. It's harmless future-proofing, I think.

> Thanks
