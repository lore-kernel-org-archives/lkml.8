Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C93C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6F321D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgBROyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:54:43 -0500
Received: from foss.arm.com ([217.140.110.172]:53798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgBROyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:54:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89D96328;
        Tue, 18 Feb 2020 06:54:42 -0800 (PST)
Received: from [10.1.195.59] (ifrit.cambridge.arm.com [10.1.195.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AF873F703;
        Tue, 18 Feb 2020 06:54:40 -0800 (PST)
Subject: Re: [PATCH v2 4/5] sched/pelt: Add a new runnable average signal
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, hdanton@sina.com
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-5-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <5ea96f6e-433e-1520-56dc-a10e9a8e63c7@arm.com>
Date:   Tue, 18 Feb 2020 14:54:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214152729.6059-5-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/20 3:27 PM, Vincent Guittot wrote:
> @@ -532,8 +535,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
>  			cfs_rq->removed.load_avg);
>  	SEQ_printf(m, "  .%-30s: %ld\n", "removed.util_avg",
>  			cfs_rq->removed.util_avg);
> -	SEQ_printf(m, "  .%-30s: %ld\n", "removed.runnable_sum",
> -			cfs_rq->removed.runnable_sum);

Shouldn't that have been part of patch 3?

> +	SEQ_printf(m, "  .%-30s: %ld\n", "removed.runnable_avg",
> +			cfs_rq->removed.runnable_avg);
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  	SEQ_printf(m, "  .%-30s: %lu\n", "tg_load_avg_contrib",
>  			cfs_rq->tg_load_avg_contrib);
> @@ -3278,6 +3280,32 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
>  	cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * LOAD_AVG_MAX;
>  }
>  
> +static inline void
> +update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
> +{
> +	long delta = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
> +
> +	/* Nothing to update */
> +	if (!delta)
> +		return;
> +
> +	/*
> +	 * The relation between sum and avg is:
> +	 *
> +	 *   LOAD_AVG_MAX - 1024 + sa->period_contrib
> +	 *
> +	 * however, the PELT windows are not aligned between grq and gse.
> +	 */
> +
> +	/* Set new sched_entity's runnable */
> +	se->avg.runnable_avg = gcfs_rq->avg.runnable_avg;
> +	se->avg.runnable_sum = se->avg.runnable_avg * LOAD_AVG_MAX;
> +
> +	/* Update parent cfs_rq runnable */
> +	add_positive(&cfs_rq->avg.runnable_avg, delta);
> +	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * LOAD_AVG_MAX;
> +}
> +

Humph, that's an exact copy of update_tg_cfs_util(). FWIW the following
eldritch horror compiles...

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 99249a2484b4..be796532a2d3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3254,57 +3254,34 @@ void set_task_rq_fair(struct sched_entity *se,
  *
  */
 
-static inline void
-update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
-{
-	long delta = gcfs_rq->avg.util_avg - se->avg.util_avg;
-
-	/* Nothing to update */
-	if (!delta)
-		return;
-
-	/*
-	 * The relation between sum and avg is:
-	 *
-	 *   LOAD_AVG_MAX - 1024 + sa->period_contrib
-	 *
-	 * however, the PELT windows are not aligned between grq and gse.
-	 */
-
-	/* Set new sched_entity's utilization */
-	se->avg.util_avg = gcfs_rq->avg.util_avg;
-	se->avg.util_sum = se->avg.util_avg * LOAD_AVG_MAX;
-
-	/* Update parent cfs_rq utilization */
-	add_positive(&cfs_rq->avg.util_avg, delta);
-	cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * LOAD_AVG_MAX;
-}
-
-static inline void
-update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
-{
-	long delta = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
-
-	/* Nothing to update */
-	if (!delta)
-		return;
-
-	/*
-	 * The relation between sum and avg is:
-	 *
-	 *   LOAD_AVG_MAX - 1024 + sa->period_contrib
-	 *
-	 * however, the PELT windows are not aligned between grq and gse.
-	 */
-
-	/* Set new sched_entity's runnable */
-	se->avg.runnable_avg = gcfs_rq->avg.runnable_avg;
-	se->avg.runnable_sum = se->avg.runnable_avg * LOAD_AVG_MAX;
+#define DECLARE_UPDATE_TG_CFS_SIGNAL(signal)				\
+static inline void						\
+update_tg_cfs_##signal(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq) \
+{								\
+	long delta = gcfs_rq->avg.signal##_avg - se->avg.signal##_avg; \
+								\
+	/* Nothing to update */					\
+	if (!delta)						\
+		return;						\
+								\
+	/*									\
+	 * The relation between sum and avg is:					\
+	 *									\
+	 *   LOAD_AVG_MAX - 1024 + sa->period_contrib				\
+	 *									\
+		* however, the PELT windows are not aligned between grq and gse.	\
+	*/									\
+	/* Set new sched_entity's runnable */			\
+	se->avg.signal##_avg = gcfs_rq->avg.signal##_avg;	\
+	se->avg.signal##_sum = se->avg.signal##_avg * LOAD_AVG_MAX; \
+								\
+	/* Update parent cfs_rq signal## */			\
+	add_positive(&cfs_rq->avg.signal##_avg, delta);		\
+	cfs_rq->avg.signal##_sum = cfs_rq->avg.signal##_avg * LOAD_AVG_MAX; \
+}								\
 
-	/* Update parent cfs_rq runnable */
-	add_positive(&cfs_rq->avg.runnable_avg, delta);
-	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * LOAD_AVG_MAX;
-}
+DECLARE_UPDATE_TG_CFS_SIGNAL(util);
+DECLARE_UPDATE_TG_CFS_SIGNAL(runnable);
 
 static inline void
 update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
---

>  static inline void
>  update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
>  {
> @@ -3358,6 +3386,7 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
>  	add_tg_cfs_propagate(cfs_rq, gcfs_rq->prop_runnable_sum);
>  
>  	update_tg_cfs_util(cfs_rq, se, gcfs_rq);
> +	update_tg_cfs_runnable(cfs_rq, se, gcfs_rq);
>  	update_tg_cfs_load(cfs_rq, se, gcfs_rq);
>  
>  	trace_pelt_cfs_tp(cfs_rq);
> @@ -3439,7 +3468,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  		raw_spin_lock(&cfs_rq->removed.lock);
>  		swap(cfs_rq->removed.util_avg, removed_util);
>  		swap(cfs_rq->removed.load_avg, removed_load);
> -		swap(cfs_rq->removed.runnable_sum, removed_runnable_sum);

Ditto on the stray from patch 3?

> +		swap(cfs_rq->removed.runnable_avg, removed_runnable);
>  		cfs_rq->removed.nr = 0;
>  		raw_spin_unlock(&cfs_rq->removed.lock);
>  
> @@ -3451,7 +3480,16 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)

