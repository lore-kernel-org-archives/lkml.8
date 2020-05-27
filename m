Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB629C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8CE920890
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgE0TrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgE0TrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:47:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F66C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:47:02 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1je20y-0005H4-8n; Wed, 27 May 2020 21:47:00 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 1/2] workqueue: Use rcuwait for wq_manager_wait
Date:   Wed, 27 May 2020 21:46:32 +0200
Message-Id: <20200527194633.1660952-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200527194633.1660952-1-bigeasy@linutronix.de>
References: <20200527194633.1660952-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

The manager waitqueue has no special requirements like custom wakeup
callbacks or mass wakeups. While it does not use exclusive wait mode
explicitly there is no strict requirement to queue the waiters in a
particular order as there is only one waiter at a time.

This allows to replace the waitqueue with rcuwait which solves the
locking problem because rcuwait relies on existing locking.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 891ccad5f2716..e1d9af713df4a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -301,7 +301,8 @@ static struct workqueue_attrs *wq_update_unbound_numa_a=
ttrs_buf;
 static DEFINE_MUTEX(wq_pool_mutex);	/* protects pools and workqueues list =
*/
 static DEFINE_MUTEX(wq_pool_attach_mutex); /* protects worker attach/detac=
h */
 static DEFINE_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
-static DECLARE_WAIT_QUEUE_HEAD(wq_manager_wait); /* wait for manager to go=
 away */
+/* wait for manager to go away */
+static struct rcuwait manager_wait =3D __RCUWAIT_INITIALIZER(manager_wait);
=20
 static LIST_HEAD(workqueues);		/* PR: list of all workqueues */
 static bool workqueue_freezing;		/* PL: have wqs started freezing? */
@@ -2140,7 +2141,7 @@ static bool manage_workers(struct worker *worker)
=20
 	pool->manager =3D NULL;
 	pool->flags &=3D ~POOL_MANAGER_ACTIVE;
-	wake_up(&wq_manager_wait);
+	rcuwait_wake_up(&manager_wait);
 	return true;
 }
=20
@@ -3504,6 +3505,18 @@ static void rcu_free_pool(struct rcu_head *rcu)
 	kfree(pool);
 }
=20
+/* This returns with the lock held on success (pool manager is inactive). =
*/
+static bool wq_manager_inactive(struct worker_pool *pool)
+{
+	spin_lock_irq(&pool->lock);
+
+	if (pool->flags & POOL_MANAGER_ACTIVE) {
+		spin_unlock_irq(&pool->lock);
+		return false;
+	}
+	return true;
+}
+
 /**
  * put_unbound_pool - put a worker_pool
  * @pool: worker_pool to put
@@ -3539,10 +3552,11 @@ static void put_unbound_pool(struct worker_pool *po=
ol)
 	 * Become the manager and destroy all workers.  This prevents
 	 * @pool's workers from blocking on attach_mutex.  We're the last
 	 * manager and @pool gets freed with the flag set.
+	 * Because of how wq_manager_inactive() works, we will hold the
+	 * spinlock after a successful wait.
 	 */
-	spin_lock_irq(&pool->lock);
-	wait_event_lock_irq(wq_manager_wait,
-			    !(pool->flags & POOL_MANAGER_ACTIVE), pool->lock);
+	rcuwait_wait_event(&manager_wait, wq_manager_inactive(pool),
+			   TASK_UNINTERRUPTIBLE);
 	pool->flags |=3D POOL_MANAGER_ACTIVE;
=20
 	while ((worker =3D first_idle_worker(pool)))
--=20
2.27.0.rc0

