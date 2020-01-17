Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D59C47409
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272E32469A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgAQKJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:09:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55438 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbgAQKJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:09:16 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYv-0005ay-OB; Fri, 17 Jan 2020 11:09:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6994C1C0330;
        Fri, 17 Jan 2020 11:09:09 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:09:09 -0000
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/osq: Use optimized spinning loop for arm64
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200113150735.21956-1-longman@redhat.com>
References: <20200113150735.21956-1-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <157925574923.396.5221009397252239087.tip-bot2@tip-bot2>
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

Commit-ID:     f5bfdc8e3947a7ae489cf8ae9cfd6b3fb357b952
Gitweb:        https://git.kernel.org/tip/f5bfdc8e3947a7ae489cf8ae9cfd6b3fb357b952
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Mon, 13 Jan 2020 10:07:35 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:30 +01:00

locking/osq: Use optimized spinning loop for arm64

Arm64 has a more optimized spinning loop (atomic_cond_read_acquire)
using wfe for spinlock that can boost performance of sibling threads
by putting the current cpu to a wait state that is broken only when
the monitored variable changes or an external event happens.

OSQ has a more complicated spinning loop. Besides the lock value, it
also checks for need_resched() and vcpu_is_preempted(). The check for
need_resched() is not a problem as it is only set by the tick interrupt
handler. That will be detected by the spinning cpu right after iret.

The vcpu_is_preempted() check, however, is a problem as changes to the
preempt state of of previous node will not affect the wait state. For
ARM64, vcpu_is_preempted is not currently defined and so is a no-op.
Will has indicated that he is planning to para-virtualize wfe instead
of defining vcpu_is_preempted for PV support. So just add a comment in
arch/arm64/include/asm/spinlock.h to indicate that vcpu_is_preempted()
should not be defined as suggested.

On a 2-socket 56-core 224-thread ARM64 system, a kernel mutex locking
microbenchmark was run for 10s with and without the patch. The
performance numbers before patch were:

Running locktest with mutex [runtime = 10s, load = 1]
Threads = 224, Min/Mean/Max = 316/123,143/2,121,269
Threads = 224, Total Rate = 2,757 kop/s; Percpu Rate = 12 kop/s

After patch, the numbers were:

Running locktest with mutex [runtime = 10s, load = 1]
Threads = 224, Min/Mean/Max = 334/147,836/1,304,787
Threads = 224, Total Rate = 3,311 kop/s; Percpu Rate = 15 kop/s

So there was about 20% performance improvement.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20200113150735.21956-1-longman@redhat.com
---
 arch/arm64/include/asm/spinlock.h |  9 +++++++++
 kernel/locking/osq_lock.c         | 23 ++++++++++-------------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index b093b28..102404d 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -11,4 +11,13 @@
 /* See include/linux/spinlock.h */
 #define smp_mb__after_spinlock()	smp_mb()
 
+/*
+ * Changing this will break osq_lock() thanks to the call inside
+ * smp_cond_load_relaxed().
+ *
+ * See:
+ * https://lore.kernel.org/lkml/20200110100612.GC2827@hirez.programming.kicks-ass.net
+ */
+#define vcpu_is_preempted(cpu)	false
+
 #endif /* __ASM_SPINLOCK_H */
diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 6ef600a..1f77349 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -134,20 +134,17 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	 * cmpxchg in an attempt to undo our queueing.
 	 */
 
-	while (!READ_ONCE(node->locked)) {
-		/*
-		 * If we need to reschedule bail... so we can block.
-		 * Use vcpu_is_preempted() to avoid waiting for a preempted
-		 * lock holder:
-		 */
-		if (need_resched() || vcpu_is_preempted(node_cpu(node->prev)))
-			goto unqueue;
-
-		cpu_relax();
-	}
-	return true;
+	/*
+	 * Wait to acquire the lock or cancelation. Note that need_resched()
+	 * will come with an IPI, which will wake smp_cond_load_relaxed() if it
+	 * is implemented with a monitor-wait. vcpu_is_preempted() relies on
+	 * polling, be careful.
+	 */
+	if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
+				  vcpu_is_preempted(node_cpu(node->prev))))
+		return true;
 
-unqueue:
+	/* unqueue */
 	/*
 	 * Step - A  -- stabilize @prev
 	 *
