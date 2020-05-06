Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAD0C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 144BF2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgEFK3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 06:29:15 -0400
Received: from foss.arm.com ([217.140.110.172]:33274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgEFK3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:29:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5F8730E;
        Wed,  6 May 2020 03:29:13 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8658D3F71F;
        Wed,  6 May 2020 03:29:12 -0700 (PDT)
References: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ> <CAKfTPtCNG9Y4xNA-iLd+JRRsUCA1+SkkFFRbbzk5n7q6v401tw@mail.gmail.com> <20200505134056.GA31680@iZj6chx1xj0e0buvshuecpZ> <20200505142711.GA12952@vingu-book>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peng Liu <iwtbavbm@gmail.com>, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix nohz.next_balance update
In-reply-to: <20200505142711.GA12952@vingu-book>
Date:   Wed, 06 May 2020 11:29:10 +0100
Message-ID: <jhjftcd1hmx.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/05/20 15:27, Vincent Guittot wrote:
> So I would be in favor of something as simple as :
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04098d678f3b..e028bc1c4744 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10457,6 +10457,14 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>                 }
>         }
>
> +       /*
> +        * next_balance will be updated only when there is a need.
> +        * When the CPU is attached to null domain for ex, it will not be
> +        * updated.
> +        */
> +       if (likely(update_next_balance))
> +               nohz.next_balance = next_balance;
> +
>         /* Newly idle CPU doesn't need an update */
>         if (idle != CPU_NEWLY_IDLE) {
>                 update_blocked_averages(this_cpu);
> @@ -10477,14 +10485,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>         if (has_blocked_load)
>                 WRITE_ONCE(nohz.has_blocked, 1);
>
> -       /*
> -        * next_balance will be updated only when there is a need.
> -        * When the CPU is attached to null domain for ex, it will not be
> -        * updated.
> -        */
> -       if (likely(update_next_balance))
> -               nohz.next_balance = next_balance;
> -
>         return ret;
>  }
>

But then we may skip an update if we goto abort, no? Imagine we have just
NOHZ_STATS_KICK, so we don't call any rebalance_domains(), and then as we
go through the last NOHZ CPU in the loop we hit need_resched(). We would
end in the abort part without any update to nohz.next_balance, despite
having accumulated relevant data in the local next_balance variable.

Also note that in this case, nohz_idle_balance() will still return true.

If we rip out just the one update we need from rebalance_domains(), then
perhaps we could go with what Peng was initially suggesting? i.e. something
like the below.

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 46b7bd41573f..0a292e0a0731 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9934,22 +9934,8 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
         * When the cpu is attached to null domain for ex, it will not be
         * updated.
         */
-	if (likely(update_next_balance)) {
+	if (likely(update_next_balance))
                rq->next_balance = next_balance;
-
-#ifdef CONFIG_NO_HZ_COMMON
-		/*
-		 * If this CPU has been elected to perform the nohz idle
-		 * balance. Other idle CPUs have already rebalanced with
-		 * nohz_idle_balance() and nohz.next_balance has been
-		 * updated accordingly. This CPU is now running the idle load
-		 * balance for itself and we need to update the
-		 * nohz.next_balance accordingly.
-		 */
-		if ((idle == CPU_IDLE) && time_after(nohz.next_balance, rq->next_balance))
-			nohz.next_balance = rq->next_balance;
-#endif
-	}
 }

 static inline int on_null_domain(struct rq *rq)
@@ -10315,6 +10301,11 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
        if (flags & NOHZ_BALANCE_KICK)
                rebalance_domains(this_rq, CPU_IDLE);

+	if (time_after(next_balance, this_rq->next_balance)) {
+		next_balance = this_rq->next_balance;
+		update_next_balance = 1;
+	}
+
        WRITE_ONCE(nohz.next_blocked,
                now + msecs_to_jiffies(LOAD_AVG_PERIOD));

@@ -10551,6 +10542,17 @@ static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
        /* normal load balance */
        update_blocked_averages(this_rq->cpu);
        rebalance_domains(this_rq, idle);
+
+#ifdef CONFIG_NO_HZ_COMMON
+	/*
+	 * NOHZ idle CPUs will be rebalanced with nohz_idle_balance() and thus
+	 * nohz.next_balance will be updated accordingly. If there was no NOHZ
+	 * kick, then we just need to update nohz.next_balance wrt *this* CPU.
+	 */
+	if ((idle == CPU_IDLE) &&
+	    time_after(nohz.next_balance, this_rq->next_balance))
+		nohz.next_balance = this_rq->next_balance;
+#endif
 }

 /*
---
