Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E765C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28822064E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389672AbgEMQ2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbgEMQ2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:28:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067B8C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:28:20 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jYuEz-0000ME-Uv; Wed, 13 May 2020 18:28:18 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/3] workqueue: Use swait for wq_manager_wait
Date:   Wed, 13 May 2020 18:27:31 +0200
Message-Id: <20200513162732.977489-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513162732.977489-1-bigeasy@linutronix.de>
References: <20200513162732.977489-1-bigeasy@linutronix.de>
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
particular order as there should be only one waiter at a time anyway.

This allows to replace the waitqueue with a simple waitqueue which
solves the locking problem because simple waitqueues use raw spinlocks
to protect their waiter list.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 891ccad5f2716..c2ead0577f02b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -50,6 +50,7 @@
 #include <linux/uaccess.h>
 #include <linux/sched/isolation.h>
 #include <linux/nmi.h>
+#include <linux/swait.h>
=20
 #include "workqueue_internal.h"
=20
@@ -301,7 +302,7 @@ static struct workqueue_attrs *wq_update_unbound_numa_a=
ttrs_buf;
 static DEFINE_MUTEX(wq_pool_mutex);	/* protects pools and workqueues list =
*/
 static DEFINE_MUTEX(wq_pool_attach_mutex); /* protects worker attach/detac=
h */
 static DEFINE_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
-static DECLARE_WAIT_QUEUE_HEAD(wq_manager_wait); /* wait for manager to go=
 away */
+static DECLARE_SWAIT_QUEUE_HEAD(wq_manager_wait); /* wait for manager to g=
o away */
=20
 static LIST_HEAD(workqueues);		/* PR: list of all workqueues */
 static bool workqueue_freezing;		/* PL: have wqs started freezing? */
@@ -2140,7 +2141,7 @@ static bool manage_workers(struct worker *worker)
=20
 	pool->manager =3D NULL;
 	pool->flags &=3D ~POOL_MANAGER_ACTIVE;
-	wake_up(&wq_manager_wait);
+	swake_up_one(&wq_manager_wait);
 	return true;
 }
=20
@@ -3541,7 +3542,7 @@ static void put_unbound_pool(struct worker_pool *pool)
 	 * manager and @pool gets freed with the flag set.
 	 */
 	spin_lock_irq(&pool->lock);
-	wait_event_lock_irq(wq_manager_wait,
+	swait_event_lock_irq(wq_manager_wait,
 			    !(pool->flags & POOL_MANAGER_ACTIVE), pool->lock);
 	pool->flags |=3D POOL_MANAGER_ACTIVE;
=20
--=20
2.26.2

