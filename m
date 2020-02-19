Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F984C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478732064C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgBSUKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:10:42 -0500
Received: from foss.arm.com ([217.140.110.172]:56006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgBSUKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:10:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A741F31B;
        Wed, 19 Feb 2020 12:10:41 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E475F3F68F;
        Wed, 19 Feb 2020 12:10:39 -0800 (PST)
Subject: Re: [PATCH v3 4/5] sched/pelt: Add a new runnable average signal
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, hdanton@sina.com
References: <20200214152729.6059-5-vincent.guittot@linaro.org>
 <20200219125513.8953-1-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <9fe822fc-c311-2b97-ae14-b9269dd99f1e@arm.com>
Date:   Wed, 19 Feb 2020 20:10:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219125513.8953-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2020 12:55, Vincent Guittot wrote:
> @@ -740,8 +740,10 @@ void init_entity_runnable_average(struct sched_entity *se)
>  	 * Group entities are initialized with zero load to reflect the fact that
>  	 * nothing has been attached to the task group yet.
>  	 */
> -	if (entity_is_task(se))
> +	if (entity_is_task(se)) {
> +		sa->runnable_avg = SCHED_CAPACITY_SCALE;

So this is a comment that's more related to patch 5, but the relevant bit is
here. I'm thinking this initialization might be too aggressive wrt load
balance. This will also give different results between symmetric vs
asymmetric topologies - a single fork() will make a LITTLE CPU group (at the
base domain level) overloaded straight away. That won't happen for bigs or on
symmetric topologies because

  // group_is_overloaded()
  sgs->group_capacity * imbalance_pct) < (sgs->group_runnable * 100)

will be false - it would take more than one task for that to happen (due to
the imbalance_pct).

So maybe what we want here instead is to mimic what he have for utilization,
i.e. initialize to half the spare capacity of the local CPU. IOW, 
conceptually something like this:

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 99249a2484b4..762717092235 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -740,10 +740,8 @@ void init_entity_runnable_average(struct sched_entity *se)
 	 * Group entities are initialized with zero load to reflect the fact that
 	 * nothing has been attached to the task group yet.
 	 */
-	if (entity_is_task(se)) {
-		sa->runnable_avg = SCHED_CAPACITY_SCALE;
+	if (entity_is_task(se))
 		sa->load_avg = scale_load_down(se->load.weight);
-	}
 
 	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
 }
@@ -796,6 +794,8 @@ void post_init_entity_util_avg(struct task_struct *p)
 		}
 	}
 
+	sa->runnable_avg = sa->util_avg;
+
 	if (p->sched_class != &fair_sched_class) {
 		/*
 		 * For !fair tasks do:
---

The current approach has the merit of giving some sort of hint to the LB
that there is a bunch of new tasks that it could spread out, but I fear it
is too aggressive.

>  		sa->load_avg = scale_load_down(se->load.weight);
> +	}
>  
>  	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
>  }
