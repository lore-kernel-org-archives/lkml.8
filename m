Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2C9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4220B2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389662AbgEMQ2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbgEMQ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:28:19 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83780C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:28:19 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jYuEz-0000ME-LU; Wed, 13 May 2020 18:28:17 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/3] sched/swait: Add swait_event_lock_irq()
Date:   Wed, 13 May 2020 18:27:30 +0200
Message-Id: <20200513162732.977489-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513162732.977489-1-bigeasy@linutronix.de>
References: <20200513162732.977489-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue code is currently not RT compatible due to nesting of
regular spinlocks inside of raw spinlocks and locking of spinlocks
inside of regions which are truly atomic even on a RT kernel.

One part of this problem are the wait queues as they use regular
spinlocks internally.

The semantical requirements of the workqueue code are also met by simple
waitqueues. This allows to solve the lock nesting problem because they
use a raw spinlock to protect the waiter list.

But workqueues use wait_event_lock_irq() which is not yet provided by the
simple waitqueue code.

Provide the straight forward counterpart to prepare for the conversion.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/swait.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 73e06e9986d4b..d86bc68a39d3d 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -297,4 +297,30 @@ do {									\
 	__ret;								\
 })
=20
+#define __swait_event_lock_irq(wq, condition, lock, cmd)		\
+	___swait_event(wq, condition, TASK_UNINTERRUPTIBLE, 0,		\
+		       raw_spin_unlock_irq(&lock);			\
+		       cmd;						\
+		       schedule();					\
+		       raw_spin_lock_irq(&lock))
+
+/**
+ * swait_event_lock_irq - Sleep until a condition gets true.
+ * @wq: The waitqueue to wait on.
+ * @condition: A C expression for the event to wait for.
+ * @lock: A locked raw_spinlock_t which will be released during schedule().
+ *
+ * The process is put to sleep (TASK_UNINTERRUPTIBLE) until the @condition
+ * evaluates to true. The @condition is checked each time the waitqueue @w=
q is
+ * woken up with @lock acquired. The @lock is released during schedule(). =
The
+ * function must be invoked with the lock acquired and it exits with the l=
ock
+ * acquired.
+ */
+#define swait_event_lock_irq(wq, condition, lock)			\
+	do {								\
+		if (condition)						\
+			break;						\
+		__swait_event_lock_irq(wq, condition, lock, );		\
+	} while (0)
+
 #endif /* _LINUX_SWAIT_H */
--=20
2.26.2

