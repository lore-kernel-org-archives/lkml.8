Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26598C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E652920781
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgCUPyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:54:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39093 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbgCUPyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:54:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFgRX-0005RC-8c; Sat, 21 Mar 2020 16:53:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C7E711C22EE;
        Sat, 21 Mar 2020 16:53:46 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:53:46 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] completion: Use simple wait queues
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200321113242.317954042@linutronix.de>
References: <20200321113242.317954042@linutronix.de>
MIME-Version: 1.0
Message-ID: <158480602650.28353.1316878799107869601.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a5c6234e10280b3ec65e2410ce34904a2580e5f8
Gitweb:        https://git.kernel.org/tip/a5c6234e10280b3ec65e2410ce34904a2580e5f8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 21 Mar 2020 12:26:00 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Mar 2020 16:00:24 +01:00

completion: Use simple wait queues

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

There is no semantical or functional change:

  - completions use the exclusive wait mode which is what swait provides

  - complete() wakes one exclusive waiter

  - complete_all() wakes all waiters while holding the lock which protects
    the wait queue against newly incoming waiters. The conversion to swait
    preserves this behaviour.

complete_all() might cause unbound latencies with a large number of waiters
being woken at once, but most complete_all() usage sites are either in
testing or initialization code or have only a really small number of
concurrent waiters which for now does not cause a latency problem. Keep it
simple for now.

The fixup of the warning check in the USB gadget driver is just a straight
forward conversion of the lockless waiter check from one waitqueue type to
the other.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lkml.kernel.org/r/20200321113242.317954042@linutronix.de
---
 drivers/usb/gadget/function/f_fs.c |  2 +-
 include/linux/completion.h         |  8 +++---
 kernel/sched/completion.c          | 36 +++++++++++++++--------------
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 5719176..234177d 100644
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
diff --git a/include/linux/completion.h b/include/linux/completion.h
index 519e949..bf8e770 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -9,7 +9,7 @@
  * See kernel/sched/completion.c for details.
  */
 
-#include <linux/wait.h>
+#include <linux/swait.h>
 
 /*
  * struct completion - structure used to maintain state for a "completion"
@@ -25,7 +25,7 @@
  */
 struct completion {
 	unsigned int done;
-	wait_queue_head_t wait;
+	struct swait_queue_head wait;
 };
 
 #define init_completion_map(x, m) __init_completion(x)
@@ -34,7 +34,7 @@ static inline void complete_acquire(struct completion *x) {}
 static inline void complete_release(struct completion *x) {}
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __WAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
+	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
 
 #define COMPLETION_INITIALIZER_ONSTACK_MAP(work, map) \
 	(*({ init_completion_map(&(work), &(map)); &(work); }))
@@ -85,7 +85,7 @@ static inline void complete_release(struct completion *x) {}
 static inline void __init_completion(struct completion *x)
 {
 	x->done = 0;
-	init_waitqueue_head(&x->wait);
+	init_swait_queue_head(&x->wait);
 }
 
 /**
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index a1ad5b7..f15e961 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -29,12 +29,12 @@ void complete(struct completion *x)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
 
 	if (x->done != UINT_MAX)
 		x->done++;
-	__wake_up_locked(&x->wait, TASK_NORMAL, 1);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	swake_up_locked(&x->wait);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 EXPORT_SYMBOL(complete);
 
@@ -58,10 +58,12 @@ void complete_all(struct completion *x)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
+	WARN_ON(irqs_disabled());
+
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
 	x->done = UINT_MAX;
-	__wake_up_locked(&x->wait, TASK_NORMAL, 0);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	swake_up_all_locked(&x->wait);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 EXPORT_SYMBOL(complete_all);
 
@@ -70,20 +72,20 @@ do_wait_for_common(struct completion *x,
 		   long (*action)(long), long timeout, int state)
 {
 	if (!x->done) {
-		DECLARE_WAITQUEUE(wait, current);
+		DECLARE_SWAITQUEUE(wait);
 
-		__add_wait_queue_entry_tail_exclusive(&x->wait, &wait);
 		do {
 			if (signal_pending_state(state, current)) {
 				timeout = -ERESTARTSYS;
 				break;
 			}
+			__prepare_to_swait(&x->wait, &wait);
 			__set_current_state(state);
-			spin_unlock_irq(&x->wait.lock);
+			raw_spin_unlock_irq(&x->wait.lock);
 			timeout = action(timeout);
-			spin_lock_irq(&x->wait.lock);
+			raw_spin_lock_irq(&x->wait.lock);
 		} while (!x->done && timeout);
-		__remove_wait_queue(&x->wait, &wait);
+		__finish_swait(&x->wait, &wait);
 		if (!x->done)
 			return timeout;
 	}
@@ -100,9 +102,9 @@ __wait_for_common(struct completion *x,
 
 	complete_acquire(x);
 
-	spin_lock_irq(&x->wait.lock);
+	raw_spin_lock_irq(&x->wait.lock);
 	timeout = do_wait_for_common(x, action, timeout, state);
-	spin_unlock_irq(&x->wait.lock);
+	raw_spin_unlock_irq(&x->wait.lock);
 
 	complete_release(x);
 
@@ -291,12 +293,12 @@ bool try_wait_for_completion(struct completion *x)
 	if (!READ_ONCE(x->done))
 		return false;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
 	if (!x->done)
 		ret = false;
 	else if (x->done != UINT_MAX)
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
