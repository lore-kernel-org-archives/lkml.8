Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38DEC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C810A206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgCMRrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:47:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47720 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgCMRrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:47:22 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jCoP1-00017r-Rk; Fri, 13 Mar 2020 18:47:19 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 5/9] completion: Use simple wait queues
Date:   Fri, 13 Mar 2020 18:46:57 +0100
Message-Id: <20200313174701.148376-6-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313174701.148376-1-bigeasy@linutronix.de>
References: <20200313174701.148376-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

completion uses a wait_queue_head_t to enqueue waiters.

wait_queue_head_t contains a spinlock_t to protect the list of waiters
which excludes it from being used in truly atomic context on a PREEMPT_RT
enabled kernel.

The spinlock in the wait queue head cannot be replaced by a raw_spinlock
because:

  - wait queues can have custom wakeup callbacks, which acquire other
    spinlock_t locks and have potentially long execution times

  - wake_up() walks an unbounded number of list entries during the wake up
    and may wake an unbounded number of waiters.

For simplicity and performance reasons complete() should be usable on
PREEMPT_RT enabled kernels.

completions do not use custom wakeup callbacks and are usually single
waiter, except for a few corner cases.

Replace the wait queue in the completion with a simple wait queue (swait),
which uses a raw_spinlock_t for protecting the waiter list and therefore is
safe to use inside truly atomic regions on PREEMPT_RT.

complete_all() might cause unbound latencies with a large number of waiters
being woken at once, but most complete_all() usage sites are either in
testing or initialization code or have only a really small number of
concurrent waiters which for now does not cause a latency problem. Keep it
simple for now.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/platforms/ps3/device-init.c      |  4 +--
 .../wireless/intersil/orinoco/orinoco_usb.c   |  4 +--
 drivers/usb/gadget/function/f_fs.c            |  2 +-
 drivers/usb/gadget/legacy/inode.c             |  4 +--
 include/linux/completion.h                    |  8 ++---
 kernel/sched/completion.c                     | 36 ++++++++++---------
 6 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platfo=
rms/ps3/device-init.c
index 2735ec90414dc..359231cea8cd7 100644
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -738,8 +738,8 @@ static int ps3_notification_read_write(struct ps3_notif=
ication_device *dev,
 	}
 	pr_debug("%s:%u: notification %s issued\n", __func__, __LINE__, op);
=20
-	res =3D wait_event_interruptible(dev->done.wait,
-				       dev->done.done || kthread_should_stop());
+	res =3D swait_event_interruptible_exclusive(dev->done.wait,
+						  dev->done.done || kthread_should_stop());
 	if (kthread_should_stop())
 		res =3D -EINTR;
 	if (res) {
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c b/drivers/=
net/wireless/intersil/orinoco/orinoco_usb.c
index e753f43e0162f..7e53a0ba57762 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
@@ -693,8 +693,8 @@ static void ezusb_req_ctx_wait(struct ezusb_priv *upriv,
 			while (!ctx->done.done && msecs--)
 				udelay(1000);
 		} else {
-			wait_event_interruptible(ctx->done.wait,
-						 ctx->done.done);
+			swait_event_interruptible_exclusive(ctx->done.wait,
+							    ctx->done.done);
 		}
 		break;
 	default:
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/functi=
on/f_fs.c
index 571917677d358..234177dd1ed57 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1703,7 +1703,7 @@ static void ffs_data_put(struct ffs_data *ffs)
 		pr_info("%s(): freeing\n", __func__);
 		ffs_data_clear(ffs);
 		BUG_ON(waitqueue_active(&ffs->ev.waitq) ||
-		       waitqueue_active(&ffs->ep0req_completion.wait) ||
+		       swait_active(&ffs->ep0req_completion.wait) ||
 		       waitqueue_active(&ffs->wait));
 		destroy_workqueue(ffs->io_completion_wq);
 		kfree(ffs->dev_name);
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/=
inode.c
index b47938dff1a22..e5141c1136e47 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -344,7 +344,7 @@ ep_io (struct ep_data *epdata, void *buf, unsigned len)
 	spin_unlock_irq (&epdata->dev->lock);
=20
 	if (likely (value =3D=3D 0)) {
-		value =3D wait_event_interruptible (done.wait, done.done);
+		value =3D swait_event_interruptible_exclusive(done.wait, done.done);
 		if (value !=3D 0) {
 			spin_lock_irq (&epdata->dev->lock);
 			if (likely (epdata->ep !=3D NULL)) {
@@ -353,7 +353,7 @@ ep_io (struct ep_data *epdata, void *buf, unsigned len)
 				usb_ep_dequeue (epdata->ep, epdata->req);
 				spin_unlock_irq (&epdata->dev->lock);
=20
-				wait_event (done.wait, done.done);
+				swait_event_exclusive(done.wait, done.done);
 				if (epdata->status =3D=3D -ECONNRESET)
 					epdata->status =3D -EINTR;
 			} else {
diff --git a/include/linux/completion.h b/include/linux/completion.h
index 519e94915d185..bf8e77001f18f 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -9,7 +9,7 @@
  * See kernel/sched/completion.c for details.
  */
=20
-#include <linux/wait.h>
+#include <linux/swait.h>
=20
 /*
  * struct completion - structure used to maintain state for a "completion"
@@ -25,7 +25,7 @@
  */
 struct completion {
 	unsigned int done;
-	wait_queue_head_t wait;
+	struct swait_queue_head wait;
 };
=20
 #define init_completion_map(x, m) __init_completion(x)
@@ -34,7 +34,7 @@ static inline void complete_acquire(struct completion *x)=
 {}
 static inline void complete_release(struct completion *x) {}
=20
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __WAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
+	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
=20
 #define COMPLETION_INITIALIZER_ONSTACK_MAP(work, map) \
 	(*({ init_completion_map(&(work), &(map)); &(work); }))
@@ -85,7 +85,7 @@ static inline void complete_release(struct completion *x)=
 {}
 static inline void __init_completion(struct completion *x)
 {
 	x->done =3D 0;
-	init_waitqueue_head(&x->wait);
+	init_swait_queue_head(&x->wait);
 }
=20
 /**
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index a1ad5b7d5521b..f15e96164ff1e 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -29,12 +29,12 @@ void complete(struct completion *x)
 {
 	unsigned long flags;
=20
-	spin_lock_irqsave(&x->wait.lock, flags);
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
=20
 	if (x->done !=3D UINT_MAX)
 		x->done++;
-	__wake_up_locked(&x->wait, TASK_NORMAL, 1);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	swake_up_locked(&x->wait);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 EXPORT_SYMBOL(complete);
=20
@@ -58,10 +58,12 @@ void complete_all(struct completion *x)
 {
 	unsigned long flags;
=20
-	spin_lock_irqsave(&x->wait.lock, flags);
+	WARN_ON(irqs_disabled());
+
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
 	x->done =3D UINT_MAX;
-	__wake_up_locked(&x->wait, TASK_NORMAL, 0);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	swake_up_all_locked(&x->wait);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 EXPORT_SYMBOL(complete_all);
=20
@@ -70,20 +72,20 @@ do_wait_for_common(struct completion *x,
 		   long (*action)(long), long timeout, int state)
 {
 	if (!x->done) {
-		DECLARE_WAITQUEUE(wait, current);
+		DECLARE_SWAITQUEUE(wait);
=20
-		__add_wait_queue_entry_tail_exclusive(&x->wait, &wait);
 		do {
 			if (signal_pending_state(state, current)) {
 				timeout =3D -ERESTARTSYS;
 				break;
 			}
+			__prepare_to_swait(&x->wait, &wait);
 			__set_current_state(state);
-			spin_unlock_irq(&x->wait.lock);
+			raw_spin_unlock_irq(&x->wait.lock);
 			timeout =3D action(timeout);
-			spin_lock_irq(&x->wait.lock);
+			raw_spin_lock_irq(&x->wait.lock);
 		} while (!x->done && timeout);
-		__remove_wait_queue(&x->wait, &wait);
+		__finish_swait(&x->wait, &wait);
 		if (!x->done)
 			return timeout;
 	}
@@ -100,9 +102,9 @@ __wait_for_common(struct completion *x,
=20
 	complete_acquire(x);
=20
-	spin_lock_irq(&x->wait.lock);
+	raw_spin_lock_irq(&x->wait.lock);
 	timeout =3D do_wait_for_common(x, action, timeout, state);
-	spin_unlock_irq(&x->wait.lock);
+	raw_spin_unlock_irq(&x->wait.lock);
=20
 	complete_release(x);
=20
@@ -291,12 +293,12 @@ bool try_wait_for_completion(struct completion *x)
 	if (!READ_ONCE(x->done))
 		return false;
=20
-	spin_lock_irqsave(&x->wait.lock, flags);
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
 	if (!x->done)
 		ret =3D false;
 	else if (x->done !=3D UINT_MAX)
 		x->done--;
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(try_wait_for_completion);
@@ -322,8 +324,8 @@ bool completion_done(struct completion *x)
 	 * otherwise we can end up freeing the completion before complete()
 	 * is done referencing it.
 	 */
-	spin_lock_irqsave(&x->wait.lock, flags);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 	return true;
 }
 EXPORT_SYMBOL(completion_done);
--=20
2.25.1

