Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6196CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4282620870
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgFBNtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:49:25 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:35801 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbgFBNtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:49:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U-O.QTj_1591105757;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0U-O.QTj_1591105757)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Jun 2020 21:49:17 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: ensure all flush_work() completed when being destoryed
Date:   Tue,  2 Jun 2020 13:49:14 +0000
Message-Id: <20200602134915.2644-1-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200601060802.3260-1-laijs@linux.alibaba.com>
References: <20200601060802.3260-1-laijs@linux.alibaba.com>
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

The patch simply adds an atomic counter for in-flight flush_work()
and a completion for destroy_workqueue() waiting for them.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
Changed from V1:
	Change from flush_no_color based mechanism to atomic+completion
	based as TJ suggested.

 kernel/workqueue.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1921c982f920..71272beb8e01 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -253,6 +253,9 @@ struct workqueue_struct {
 	int			nr_drainers;	/* WQ: drain in progress */
 	int			saved_max_active; /* WQ: saved pwq max_active */
 
+	atomic_t		nr_flush_work;	/* flush work in progress */
+	struct completion	flush_work_done; /* sync flush_work() */
+
 	struct workqueue_attrs	*unbound_attrs;	/* PW: only for unbound wqs */
 	struct pool_workqueue	*dfl_pwq;	/* PW: only for unbound wqs */
 
@@ -1154,6 +1157,12 @@ static void pwq_activate_first_delayed(struct pool_workqueue *pwq)
 	pwq_activate_delayed_work(work);
 }
 
+static void dec_nr_in_flight_flush_work(struct workqueue_struct *wq)
+{
+	if (atomic_dec_and_test(&wq->nr_flush_work))
+		complete(&wq->flush_work_done);
+}
+
 /**
  * pwq_dec_nr_in_flight - decrement pwq's nr_in_flight
  * @pwq: pwq of interest
@@ -1168,8 +1177,10 @@ static void pwq_activate_first_delayed(struct pool_workqueue *pwq)
 static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, int color)
 {
 	/* uncolored work items don't participate in flushing or nr_active */
-	if (color == WORK_NO_COLOR)
+	if (color == WORK_NO_COLOR) {
+		dec_nr_in_flight_flush_work(pwq->wq);
 		goto out_put;
+	}
 
 	pwq->nr_in_flight[color]--;
 
@@ -2682,6 +2693,7 @@ static void insert_wq_barrier(struct pool_workqueue *pwq,
 	}
 
 	debug_work_activate(&barr->work);
+	atomic_inc(&pwq->wq->nr_flush_work);
 	insert_work(pwq, &barr->work, head,
 		    work_color_to_flags(WORK_NO_COLOR) | linked);
 }
@@ -4278,6 +4290,9 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	wq_init_lockdep(wq);
 	INIT_LIST_HEAD(&wq->list);
 
+	atomic_set(&wq->nr_flush_work, 1);
+	init_completion(&wq->flush_work_done);
+
 	if (alloc_and_link_pwqs(wq) < 0)
 		goto err_unreg_lockdep;
 
@@ -4354,6 +4369,10 @@ void destroy_workqueue(struct workqueue_struct *wq)
 	/* drain it before proceeding with destruction */
 	drain_workqueue(wq);
 
+	/* flush all uncompleted internal work items queued by flush_work() */
+	dec_nr_in_flight_flush_work(wq);
+	wait_for_completion(&wq->flush_work_done);
+
 	/* kill rescuer, if sanity checks fail, leave it w/o rescuer */
 	if (wq->rescuer) {
 		struct worker *rescuer = wq->rescuer;
-- 
2.20.1

