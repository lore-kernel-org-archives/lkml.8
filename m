Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E34C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA964206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgFAGIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:08:21 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:41280 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725831AbgFAGIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:08:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U-Ax10g_1590991685;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0U-Ax10g_1590991685)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Jun 2020 14:08:06 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: ensure all flush_work() completed when being destoryed
Date:   Mon,  1 Jun 2020 06:08:02 +0000
Message-Id: <20200601060802.3260-1-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In old days, worker threads are not shared among different
workqueues and destroy_workqueue() used kthread_stop() to destroy
all workers before going to destroy workqueue structures.
And kthread_stop() can ensure the scheduled (worker->scheduled)
work items and the linked work items queued by flush_work()
to be completed.

For a workqueue to be completed/unused for wq users means that all
queued works have completed and all flush_work() have return,
and the workqueue is legitimate to passed to destroy_workqueue().

But
e22bee782b3b("workqueue: implement concurrency managed dynamic worker pool")
made worker pools and workers shared among different
workqueues and kthread_stop() is not used to sync the completion
of the work items. destroy_workqueue() uses drain_workqueue()
to drain user work items, but internal work items queued by
flush_work() is not drained due to they don't have colors.

So problems may occur when wq_barrier_func() does complete(&barr->done)
and the wokenup wq-user code does destroy_workqueue(). destroy_workqueue()
can be scheduled eariler than the proccess_one_work() to do
the put_pwq(), so that the sanity check in destroy_workqueue()
can see the no yet put pwq->refcnt and blame false positively.

The problem can be easily fixed by removing the WORK_NO_COLOR
and making the internal work item queued by flush_work() inherit
the color of the work items to be flushed. It would definitely
revert the design and the benefits of the WORK_NO_COLOR.

The color-based flush_workqueue() was designed so well that
we can also easily to adapt it to flush WORK_NO_COLOR. This
is the approach taken by this patch which introduces a
flush_no_color() to flush all the WORK_NO_COLOR works.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 include/linux/workqueue.h |  5 +--
 kernel/workqueue.c        | 72 +++++++++++++++++++++++++++++++++------
 2 files changed, 64 insertions(+), 13 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 8b505d22fc0e..85aea89fb6fc 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -55,8 +55,9 @@ enum {
 	 * The last color is no color used for works which don't
 	 * participate in workqueue flushing.
 	 */
-	WORK_NR_COLORS		= (1 << WORK_STRUCT_COLOR_BITS) - 1,
-	WORK_NO_COLOR		= WORK_NR_COLORS,
+	WORK_NR_COLORS		= (1 << WORK_STRUCT_COLOR_BITS),
+	WORK_NR_FLUSH_COLORS	= (WORK_NR_COLORS - 1),
+	WORK_NO_COLOR		= WORK_NR_FLUSH_COLORS,
 
 	/* not bound to any CPU, prefer the local CPU */
 	WORK_CPU_UNBOUND	= NR_CPUS,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7a1fc9fe6314..cf281e273b28 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -585,7 +585,7 @@ static int get_work_color(struct work_struct *work)
 
 static int work_next_color(int color)
 {
-	return (color + 1) % WORK_NR_COLORS;
+	return (color + 1) % WORK_NR_FLUSH_COLORS;
 }
 
 /*
@@ -1167,19 +1167,18 @@ static void pwq_activate_first_delayed(struct pool_workqueue *pwq)
  */
 static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, int color)
 {
-	/* uncolored work items don't participate in flushing or nr_active */
-	if (color == WORK_NO_COLOR)
-		goto out_put;
+	/* uncolored work items don't participate in nr_active */
+	if (color != WORK_NO_COLOR) {
+		pwq->nr_active--;
+		if (!list_empty(&pwq->delayed_works)) {
+			/* one down, submit a delayed one */
+			if (pwq->nr_active < pwq->max_active)
+				pwq_activate_first_delayed(pwq);
+		}
+	}
 
 	pwq->nr_in_flight[color]--;
 
-	pwq->nr_active--;
-	if (!list_empty(&pwq->delayed_works)) {
-		/* one down, submit a delayed one */
-		if (pwq->nr_active < pwq->max_active)
-			pwq_activate_first_delayed(pwq);
-	}
-
 	/* is flush in progress and are we at the flushing tip? */
 	if (likely(pwq->flush_color != color))
 		goto out_put;
@@ -2682,6 +2681,7 @@ static void insert_wq_barrier(struct pool_workqueue *pwq,
 	}
 
 	debug_work_activate(&barr->work);
+	pwq->nr_in_flight[WORK_NO_COLOR]++;
 	insert_work(pwq, &barr->work, head,
 		    work_color_to_flags(WORK_NO_COLOR) | linked);
 }
@@ -2915,6 +2915,55 @@ void flush_workqueue(struct workqueue_struct *wq)
 }
 EXPORT_SYMBOL(flush_workqueue);
 
+/*
+ * Called form destroy_workqueue() to flush all uncompleted internal
+ * work items queued by flush_work().
+ */
+static void flush_no_color(struct workqueue_struct *wq)
+{
+	struct wq_flusher this_flusher = {
+		.list = LIST_HEAD_INIT(this_flusher.list),
+		.flush_color = -1,
+		.done = COMPLETION_INITIALIZER_ONSTACK_MAP(this_flusher.done, wq->lockdep_map),
+	};
+
+	lock_map_acquire(&wq->lockdep_map);
+	lock_map_release(&wq->lockdep_map);
+
+	mutex_lock(&wq->mutex);
+	if (WARN_ON_ONCE(wq->first_flusher))
+		goto out_unlock;
+
+	wq->first_flusher = &this_flusher;
+	this_flusher.flush_color = wq->work_color;
+	WARN_ON_ONCE(wq->flush_color != this_flusher.flush_color);
+	WARN_ON_ONCE(!list_empty(&wq->flusher_overflow));
+	WARN_ON_ONCE(!list_empty(&wq->flusher_queue));
+
+	if (!flush_workqueue_prep_pwqs(wq, WORK_NO_COLOR, -1)) {
+		/* nothing to flush, done */
+		WRITE_ONCE(wq->first_flusher, NULL);
+		goto out_unlock;
+	}
+
+	check_flush_dependency(wq, NULL);
+
+	mutex_unlock(&wq->mutex);
+
+	wait_for_completion(&this_flusher.done);
+
+	mutex_lock(&wq->mutex);
+	WARN_ON_ONCE(wq->first_flusher != &this_flusher);
+	WARN_ON_ONCE(!list_empty(&wq->flusher_overflow));
+	WARN_ON_ONCE(!list_empty(&wq->flusher_queue));
+	WARN_ON_ONCE(!list_empty(&this_flusher.list));
+	WARN_ON_ONCE(wq->flush_color != this_flusher.flush_color);
+	WRITE_ONCE(wq->first_flusher, NULL);
+
+out_unlock:
+	mutex_unlock(&wq->mutex);
+}
+
 /**
  * drain_workqueue - drain a workqueue
  * @wq: workqueue to drain
@@ -4353,6 +4402,7 @@ void destroy_workqueue(struct workqueue_struct *wq)
 
 	/* drain it before proceeding with destruction */
 	drain_workqueue(wq);
+	flush_no_color(wq);
 
 	/* kill rescuer, if sanity checks fail, leave it w/o rescuer */
 	if (wq->rescuer) {
-- 
2.20.1

