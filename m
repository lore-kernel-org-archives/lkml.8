Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62398C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42EA720EDD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbgFSKgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:36:54 -0400
Received: from foss.arm.com ([217.140.110.172]:51208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729195AbgFSKgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:36:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3160D6E;
        Fri, 19 Jun 2020 03:36:50 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 338343F71F;
        Fri, 19 Jun 2020 03:36:49 -0700 (PDT)
References: <20200618195525.7889-1-qais.yousef@arm.com> <20200618195525.7889-3-qais.yousef@arm.com>
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
        Chris Redpath <chrid.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/uclamp: Protect uclamp fast path code with static key
In-reply-to: <20200618195525.7889-3-qais.yousef@arm.com>
Date:   Fri, 19 Jun 2020 11:36:46 +0100
Message-ID: <jhjwo43cpfl.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/06/20 20:55, Qais Yousef wrote:
> There is a report that when uclamp is enabled, a netperf UDP test
> regresses compared to a kernel compiled without uclamp.
>
> https://lore.kernel.org/lkml/20200529100806.GA3070@suse.de/
>

ISTR the perennial form for those is: https://lkml.kernel.org/r/<message-id>

> While investigating the root cause, there were no sign that the uclamp
> code is doing anything particularly expensive but could suffer from bad
> cache behavior under certain circumstances that are yet to be
> understood.
>
> https://lore.kernel.org/lkml/20200616110824.dgkkbyapn3io6wik@e107158-lin/

Ditto on the URL

>
> To reduce the pressure on the fast path anyway, add a static key that is
                                                                        ^^
                                                                     s/is//

> by default will skip executing uclamp logic in the
> enqueue/dequeue_task() fast path in the until it's needed.
                                   ^^^^^^
                                 s/in the//

> As soon as the user start using util clamp by:
>
>       1. Changing uclamp value of a task with sched_setattr()
>       2. Modifying the default sysctl_sched_util_clamp_{min, max}
>       3. Modifying the default cpu.uclamp.{min, max} value in cgroup
>
> We flip the static key now that the user has opted to use util clamp.
> Effectively re-introducing uclamp logic in the enqueue/dequeue_task()
> fast path. It stays on from that point forward until the next reboot.
>
> This should help minimize the effect of util clamp on workloads that
> don't need it but still allow distros to ship their kernels with uclamp
> compiled in by default.
>
> SCHED_WARN_ON() in uclamp_rq_dec_id() was removed since now we can end
> up with unbalanced call to uclamp_rq_dec_id() if we flip the key while
> a task is running in the rq. Since we know it is harmless we just
> quietly return if we attempt a uclamp_rq_dec_id() when
> rq->uclamp[].bucket[].tasks is 0.
>

I have an extra comment about that down in the diff.

Also, I think it would be worth mentioning in the changelog why we use the
same static key with different likelihoods - unlikely in unfrequent paths,
and likely in the eq/dq hotpath.

> The following results demonstrates how this helps on 2 Sockets Xeon E5
> 2x10-Cores system.
>
>                                    nouclamp                 uclamp      uclamp-static-key
> Hmean     send-64         162.43 (   0.00%)      157.84 *  -2.82%*      163.39 *   0.59%*
> Hmean     send-128        324.71 (   0.00%)      314.78 *  -3.06%*      326.18 *   0.45%*
> Hmean     send-256        641.55 (   0.00%)      628.67 *  -2.01%*      648.12 *   1.02%*
> Hmean     send-1024      2525.28 (   0.00%)     2448.26 *  -3.05%*     2543.73 *   0.73%*
> Hmean     send-2048      4836.14 (   0.00%)     4712.08 *  -2.57%*     4867.69 *   0.65%*
> Hmean     send-3312      7540.83 (   0.00%)     7425.45 *  -1.53%*     7621.06 *   1.06%*
> Hmean     send-4096      9124.53 (   0.00%)     8948.82 *  -1.93%*     9276.25 *   1.66%*
> Hmean     send-8192     15589.67 (   0.00%)    15486.35 *  -0.66%*    15819.98 *   1.48%*
> Hmean     send-16384    26386.47 (   0.00%)    25752.25 *  -2.40%*    26773.74 *   1.47%*
>

Am I reading this correctly in that compiling in uclamp but having the
static key enabled gives a slight improvement compared to not compiling in
uclamp? I suppose the important bit is that we're not seeing regressions
anymore, but still.

> Reported-by: Mel Gorman <mgorman@suse.de>
> Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> CC: Patrick Bellasi <patrick.bellasi@matbug.net>
> Cc: Chris Redpath <chrid.redpath@arm.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: linux-kernel@vger.kernel.org
>
>  kernel/sched/core.c | 56 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e19d2b915406..0824e1bfb484 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -993,9 +1012,16 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>       lockdep_assert_held(&rq->lock);
>
>       bucket = &uc_rq->bucket[uc_se->bucket_id];
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

I'm slightly worried about silent returns for cases like these, can we try
to cook something up to preserve the previous SCHED_WARN_ON()? Say,
something like the horrendous below - alternatively might be feasible with
with some clever p->on_rq flag.

---
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b62e6aaf28f0..09a7891eb481 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -695,6 +695,9 @@ struct task_struct {
        struct uclamp_se		uclamp_req[UCLAMP_CNT];
        /* Effective clamp values used for a scheduling entity */
        struct uclamp_se		uclamp[UCLAMP_CNT];
+#ifdef CONFIG_SCHED_DEBUG
+	int                             uclamp_unused_enqueue;
+#endif
 #endif

 #ifdef CONFIG_PREEMPT_NOTIFIERS
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2a712dcb682b..2a723e9d5219 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1018,8 +1018,10 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
         * current task was running, hence we could end up with unbalanced call
         * to uclamp_rq_dec_id().
         */
-	if (unlikely(!bucket->tasks))
+	if (unlikely(!bucket->tasks)) {
+		SCHED_WARN_ON(!p->uclamp_unused_enqueue);
                return;
+	}

        bucket->tasks--;
        uc_se->active = false;
@@ -1049,8 +1051,16 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 {
        enum uclamp_id clamp_id;

-	if (static_branch_likely(&sched_uclamp_unused))
+#ifdef CONFIG_SCHED_DEBUG
+	p->uclamp_unused_enqueue = 0;
+#endif
+
+	if (static_branch_likely(&sched_uclamp_unused)) {
+#ifdef CONFIG_SCHED_DEBUG
+		p->uclamp_unused_enqueue = 1;
+#endif
                return;
+	}

        if (unlikely(!p->sched_class->uclamp_enabled))
                return;
@@ -1075,6 +1085,10 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)

        for_each_clamp_id(clamp_id)
                uclamp_rq_dec_id(rq, p, clamp_id);
+
+#ifdef CONFIG_SCHED_DEBUG
+	p->uclamp_unused_enqueue = 0;
+#endif
 }

 static inline void
---
