Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0516C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C3821924
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgEASXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730611AbgEASWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EF8C061A0E;
        Fri,  1 May 2020 11:22:21 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIh-0003bM-9g; Fri, 01 May 2020 20:22:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 73AC11C04CD;
        Fri,  1 May 2020 20:22:12 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:12 -0000
From:   "tip-bot2 for Paul Turner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Eliminate bandwidth race between
 throttling and distribution
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200410225208.109717-2-joshdon@google.com>
References: <20200410225208.109717-2-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <158835733243.8414.17537878158175326698.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e98fa02c4f2ea4991dae422ac7e34d102d2f0599
Gitweb:        https://git.kernel.org/tip/e98fa02c4f2ea4991dae422ac7e34d102d2f0599
Author:        Paul Turner <pjt@google.com>
AuthorDate:    Fri, 10 Apr 2020 15:52:07 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:38 +02:00

sched/fair: Eliminate bandwidth race between throttling and distribution

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
Signed-off-by: Ben Segall <bsegall@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://lkml.kernel.org/r/20200410225208.109717-2-joshdon@google.com
---
 kernel/sched/fair.c | 79 ++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b..0c13a41 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4588,16 +4588,16 @@ static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
 }
 
 /* returns 0 on failure to allocate runtime */
-static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
+static int __assign_cfs_rq_runtime(struct cfs_bandwidth *cfs_b,
+				   struct cfs_rq *cfs_rq, u64 target_runtime)
 {
-	struct task_group *tg = cfs_rq->tg;
-	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(tg);
-	u64 amount = 0, min_amount;
+	u64 min_amount, amount = 0;
+
+	lockdep_assert_held(&cfs_b->lock);
 
 	/* note: this is a positive sum as runtime_remaining <= 0 */
-	min_amount = sched_cfs_bandwidth_slice() - cfs_rq->runtime_remaining;
+	min_amount = target_runtime - cfs_rq->runtime_remaining;
 
-	raw_spin_lock(&cfs_b->lock);
 	if (cfs_b->quota == RUNTIME_INF)
 		amount = min_amount;
 	else {
@@ -4609,13 +4609,25 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
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
+	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
+	int ret;
+
+	raw_spin_lock(&cfs_b->lock);
+	ret = __assign_cfs_rq_runtime(cfs_b, cfs_rq, sched_cfs_bandwidth_slice());
+	raw_spin_unlock(&cfs_b->lock);
+
+	return ret;
+}
+
 static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 {
 	/* dock delta_exec before expiring quota (as it could span periods) */
@@ -4704,13 +4716,33 @@ static int tg_throttle_down(struct task_group *tg, void *data)
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
 
@@ -4744,29 +4776,13 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	if (!se)
 		sub_nr_running(rq, task_delta);
 
-	cfs_rq->throttled = 1;
-	cfs_rq->throttled_clock = rq_clock(rq);
-	raw_spin_lock(&cfs_b->lock);
-	empty = list_empty(&cfs_b->throttled_cfs_rq);
-
-	/*
-	 * Add to the _head_ of the list, so that an already-started
-	 * distribute_cfs_runtime will not see us. If disribute_cfs_runtime is
-	 * not running add to the tail so that later runqueues don't get starved.
-	 */
-	if (cfs_b->distribute_running)
-		list_add_rcu(&cfs_rq->throttled_list, &cfs_b->throttled_cfs_rq);
-	else
-		list_add_tail_rcu(&cfs_rq->throttled_list, &cfs_b->throttled_cfs_rq);
-
 	/*
-	 * If we're the first throttled task, make sure the bandwidth
-	 * timer is running.
+	 * Note: distribution will already see us throttled via the
+	 * throttled-list.  rq->lock protects completion.
 	 */
-	if (empty)
-		start_cfs_bandwidth(cfs_b);
-
-	raw_spin_unlock(&cfs_b->lock);
+	cfs_rq->throttled = 1;
+	cfs_rq->throttled_clock = rq_clock(rq);
+	return true;
 }
 
 void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
@@ -5121,8 +5137,7 @@ static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	if (cfs_rq_throttled(cfs_rq))
 		return true;
 
-	throttle_cfs_rq(cfs_rq);
-	return true;
+	return throttle_cfs_rq(cfs_rq);
 }
 
 static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
