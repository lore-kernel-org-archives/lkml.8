Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9495BC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 22:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0582083E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 22:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XMwmJJcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgDJWwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:52:42 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:46096 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgDJWwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 18:52:42 -0400
Received: by mail-pg1-f201.google.com with SMTP id q8so2758066pgv.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 15:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uSNGUFb7mp7G5fKDIDq1t6EYFHHo2JDseFHb/Cjwrgs=;
        b=XMwmJJcWq+WuXEsl0kZpCSNqa+BXkCe4oSZ4pLOkNkAiDZKQP24avRiZQGZHy3rOsg
         OJyukeDkwIiDp9vS+oMmNbXlgdcRqSZzE22XOArgpt6uphG4MVawA7XcMYpgZZPd3x7L
         Ufk0ZN7iNcEt7YQbKEZWsFdExPEx+c8sfNb1FdPpph+IWl8LU6ceC+rzA2YwN64d2lsy
         mO9fbIvMwO2VDvlc0R4+snG/RiklOrfJVPJPl5KyjURHOASt0HEJm/y0c1KO/JmxHoQe
         v6/XWh4SggUww1TnemHcjWXtBctz0vCKzXDBqnat3HMKybdH6JRzF6q9ntwEXV1e4onZ
         V+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uSNGUFb7mp7G5fKDIDq1t6EYFHHo2JDseFHb/Cjwrgs=;
        b=mIN5PYClsmxuc9tkq8hGVNQBxl5HTPul56abvP2jQDuF9RfIfP4Zv4LnJAdiFzGCYW
         plWUe2FpNnDSJ70XoeiP+GCqpRoECx/02w1ZEKwGu8zcrIsPTBCWgzn6bq1tDN8atigB
         pHXfp00Y9Y6sz6enSTojSrn6UrNPsCEXFXOYdTjK9v3aCMjjHvaza3FNp9IUt6cdbl9N
         ldvwfTS6rbllj0M/CBhQI+RXP3/Lihy3ZjIk5RpA505SKsLr6Xst/mTCTyTHAw7ZVJKg
         /8VINvZl1swQ3ekndBgE5/UbDnTCprPFwwVspZL1H3wYw8emV4q2YxkcRHZAU9D+mku2
         9a/Q==
X-Gm-Message-State: AGi0PubW/+Gq8dQVdlJRdrVp2vsZTy5o+vUHo0i0xg1QOqWMh7RixdCH
        STtYHHt/9Nb9GzjM6BBeUhdCizEt22fE
X-Google-Smtp-Source: APiQypIwezuUMvBIcKWw/vXD4vi420iXS7LltpTcruA9Ns5LwVF20J3FApXwnYKMA4p8JUFjBsee5uYWmqZC
X-Received: by 2002:a17:90a:de0e:: with SMTP id m14mr7980344pjv.54.1586559159851;
 Fri, 10 Apr 2020 15:52:39 -0700 (PDT)
Date:   Fri, 10 Apr 2020 15:52:07 -0700
In-Reply-To: <20200410225208.109717-1-joshdon@google.com>
Message-Id: <20200410225208.109717-2-joshdon@google.com>
Mime-Version: 1.0
References: <20200410225208.109717-1-joshdon@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH 1/2] sched: eliminate bandwidth race between throttling and distribution
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Paul Turner <pjt@google.com>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Phil Auld <pauld@redhead.com>, linux-kernel@vger.kernel.org,
        Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Turner <pjt@google.com>

There is a race window in which an entity begins throttling before quota
is added to the pool, but does not finish throttling until after we have
finished with distribute_cfs_runtime(). This entity is not observed by
distribute_cfs_runtime() because it was not on the throttled list at the
time that distribution was running. This race manifests as rare
period-length statlls for such entities.

Rather than heavy-weight the synchronization with the progress of
distribution, we can fix this by aborting throttling if bandwidth has
become available. Otherwise, we immediately add the entity to the
throttled list so that it can be observed by a subsequent distribution.

Additionally, we can remove the case of adding the throttled entity to
the head of the throttled list, and simply always add to the tail.
Thanks to 26a8b12747c97, distribute_cfs_runtime() no longer holds onto
its own pool of runtime. This means that if we do hit the !assign and
distribute_running case, we know that distribution is about to end.

Signed-off-by: Paul Turner <pjt@google.com>
Co-developed-by: Ben Segall <bsegall@google.com>
Signed-off-by: Ben Segall <bsegall@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/fair.c | 78 ++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..3fb986c52825 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4587,17 +4587,15 @@ static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
 	return &tg->cfs_bandwidth;
 }
 
-/* returns 0 on failure to allocate runtime */
-static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
+/* returns 0 on failure to allocate runtime, called with cfs_b->lock held */
+static int __assign_cfs_rq_runtime(struct cfs_bandwidth *cfs_b,
+				   struct cfs_rq *cfs_rq, u64 target_runtime)
 {
-	struct task_group *tg = cfs_rq->tg;
-	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(tg);
 	u64 amount = 0, min_amount;
 
 	/* note: this is a positive sum as runtime_remaining <= 0 */
-	min_amount = sched_cfs_bandwidth_slice() - cfs_rq->runtime_remaining;
+	min_amount = target_runtime - cfs_rq->runtime_remaining;
 
-	raw_spin_lock(&cfs_b->lock);
 	if (cfs_b->quota == RUNTIME_INF)
 		amount = min_amount;
 	else {
@@ -4609,13 +4607,26 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 			cfs_b->idle = 0;
 		}
 	}
-	raw_spin_unlock(&cfs_b->lock);
 
 	cfs_rq->runtime_remaining += amount;
 
 	return cfs_rq->runtime_remaining > 0;
 }
 
+/* returns 0 on failure to allocate runtime */
+static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
+{
+	int ret;
+	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
+
+	raw_spin_lock(&cfs_b->lock);
+	ret = __assign_cfs_rq_runtime(cfs_b, cfs_rq,
+				      sched_cfs_bandwidth_slice());
+	raw_spin_unlock(&cfs_b->lock);
+
+	return ret;
+}
+
 static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 {
 	/* dock delta_exec before expiring quota (as it could span periods) */
@@ -4704,13 +4715,33 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 	return 0;
 }
 
-static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
+static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	long task_delta, idle_task_delta, dequeue = 1;
-	bool empty;
+
+	raw_spin_lock(&cfs_b->lock);
+	/* This will start the period timer if necessary */
+	if (__assign_cfs_rq_runtime(cfs_b, cfs_rq, 1)) {
+		/*
+		 * We have raced with bandwidth becoming available, and if we
+		 * actually throttled the timer might not unthrottle us for an
+		 * entire period. We additionally needed to make sure that any
+		 * subsequent check_cfs_rq_runtime calls agree not to throttle
+		 * us, as we may commit to do cfs put_prev+pick_next, so we ask
+		 * for 1ns of runtime rather than just check cfs_b.
+		 */
+		dequeue = 0;
+	} else {
+		list_add_tail_rcu(&cfs_rq->throttled_list,
+				  &cfs_b->throttled_cfs_rq);
+	}
+	raw_spin_unlock(&cfs_b->lock);
+
+	if (!dequeue)
+		return false;  /* Throttle no longer required. */
 
 	se = cfs_rq->tg->se[cpu_of(rq_of(cfs_rq))];
 
@@ -4744,29 +4775,13 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	if (!se)
 		sub_nr_running(rq, task_delta);
 
-	cfs_rq->throttled = 1;
-	cfs_rq->throttled_clock = rq_clock(rq);
-	raw_spin_lock(&cfs_b->lock);
-	empty = list_empty(&cfs_b->throttled_cfs_rq);
-
 	/*
-	 * Add to the _head_ of the list, so that an already-started
-	 * distribute_cfs_runtime will not see us. If disribute_cfs_runtime is
-	 * not running add to the tail so that later runqueues don't get starved.
+	 * Note: distribution will already see us throttled via the
+	 * throttled-list.  rq->lock protects completion.
 	 */
-	if (cfs_b->distribute_running)
-		list_add_rcu(&cfs_rq->throttled_list, &cfs_b->throttled_cfs_rq);
-	else
-		list_add_tail_rcu(&cfs_rq->throttled_list, &cfs_b->throttled_cfs_rq);
-
-	/*
-	 * If we're the first throttled task, make sure the bandwidth
-	 * timer is running.
-	 */
-	if (empty)
-		start_cfs_bandwidth(cfs_b);
-
-	raw_spin_unlock(&cfs_b->lock);
+	cfs_rq->throttled = 1;
+	cfs_rq->throttled_clock = rq_clock(rq);
+	return true;
 }
 
 void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
@@ -5121,8 +5136,7 @@ static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	if (cfs_rq_throttled(cfs_rq))
 		return true;
 
-	throttle_cfs_rq(cfs_rq);
-	return true;
+	return throttle_cfs_rq(cfs_rq);
 }
 
 static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
-- 
2.26.0.110.g2183baf09c-goog

