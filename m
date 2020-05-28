Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B16C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1AA21532
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgE1DHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 23:07:05 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37862 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbgE1DHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 23:07:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TzrLi3f_1590635222;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TzrLi3f_1590635222)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 May 2020 11:07:03 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 1/2] workqueue: pin the pool while it is managing
Date:   Thu, 28 May 2020 03:06:55 +0000
Message-Id: <20200528030657.1690-1-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527194633.1660952-2-bigeasy@linutronix.de>
References: <20200527194633.1660952-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that put_unbound_pool() can ensure all workers in idle,
no unfinished manager. And it doens't need to wait any manager
and can go to delete all the idle workers straight away.

Also removes manager waitqueue, because it is unneeded and as
Sebastian Andrzej Siewior said:

  The workqueue code has it's internal spinlock (pool::lock) and also
  implicit spinlock usage in the wq_manager waitqueue. These spinlocks
  are converted to 'sleeping' spinlocks on a RT-kernel.

  Workqueue functions can be invoked from contexts which are truly atomic
  even on a PREEMPT_RT enabled kernel. Taking sleeping locks from such
  contexts is forbidden.

  pool::lock can be converted to a raw spinlock as the lock held times
  are short. But the workqueue manager waitqueue is handled inside of
  pool::lock held regions which again violates the lock nesting rules
  of raw and regular spinlocks.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/lkml/20200527194633.1660952-2-bigeasy@linutronix.de
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 891ccad5f271..fde10a5dba82 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -301,7 +301,6 @@ static struct workqueue_attrs *wq_update_unbound_numa_attrs_buf;
 static DEFINE_MUTEX(wq_pool_mutex);	/* protects pools and workqueues list */
 static DEFINE_MUTEX(wq_pool_attach_mutex); /* protects worker attach/detach */
 static DEFINE_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
-static DECLARE_WAIT_QUEUE_HEAD(wq_manager_wait); /* wait for manager to go away */
 
 static LIST_HEAD(workqueues);		/* PR: list of all workqueues */
 static bool workqueue_freezing;		/* PL: have wqs started freezing? */
@@ -2129,10 +2128,21 @@ __acquires(&pool->lock)
 static bool manage_workers(struct worker *worker)
 {
 	struct worker_pool *pool = worker->pool;
+	struct work_struct *work = list_first_entry(&pool->worklist,
+					struct work_struct, entry);
+	struct pool_workqueue *pwq = get_work_pwq(work);
 
 	if (pool->flags & POOL_MANAGER_ACTIVE)
 		return false;
 
+	/*
+	 * If @pwq is for an unbound wq, its base ref and the @pool's
+	 * ref may be put at any time due to an attribute change.
+	 * Pin @pwq to also pin the @pool until the manager is done
+	 * with it.
+	 */
+	get_pwq(pwq);
+
 	pool->flags |= POOL_MANAGER_ACTIVE;
 	pool->manager = worker;
 
@@ -2140,7 +2150,7 @@ static bool manage_workers(struct worker *worker)
 
 	pool->manager = NULL;
 	pool->flags &= ~POOL_MANAGER_ACTIVE;
-	wake_up(&wq_manager_wait);
+	put_pwq(pwq);
 	return true;
 }
 
@@ -3535,16 +3545,7 @@ static void put_unbound_pool(struct worker_pool *pool)
 		idr_remove(&worker_pool_idr, pool->id);
 	hash_del(&pool->hash_node);
 
-	/*
-	 * Become the manager and destroy all workers.  This prevents
-	 * @pool's workers from blocking on attach_mutex.  We're the last
-	 * manager and @pool gets freed with the flag set.
-	 */
 	spin_lock_irq(&pool->lock);
-	wait_event_lock_irq(wq_manager_wait,
-			    !(pool->flags & POOL_MANAGER_ACTIVE), pool->lock);
-	pool->flags |= POOL_MANAGER_ACTIVE;
-
 	while ((worker = first_idle_worker(pool)))
 		destroy_worker(worker);
 	WARN_ON(pool->nr_workers || pool->nr_idle);
-- 
2.20.1

