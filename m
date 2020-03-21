Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5420C4332E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8407920781
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgCUPyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:54:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39055 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgCUPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:53:59 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFgRe-0005TF-Ck; Sat, 21 Mar 2020 16:53:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DFEEE1C22EE;
        Sat, 21 Mar 2020 16:53:48 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:53:48 -0000
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rcuwait: Add @state argument to rcuwait_wait_event()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200321113241.824030968@linutronix.de>
References: <20200321113241.824030968@linutronix.de>
MIME-Version: 1.0
Message-ID: <158480602856.28353.10692996135466470181.tip-bot2@tip-bot2>
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

Commit-ID:     80fbaf1c3f2926c834f8ca915441dfe27ce5487e
Gitweb:        https://git.kernel.org/tip/80fbaf1c3f2926c834f8ca915441dfe27ce5487e
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Sat, 21 Mar 2020 12:25:55 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Mar 2020 16:00:22 +01:00

rcuwait: Add @state argument to rcuwait_wait_event()

Extend rcuwait_wait_event() with a state variable so that it is not
restricted to UNINTERRUPTIBLE waits.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200321113241.824030968@linutronix.de
---
 include/linux/rcuwait.h       | 12 ++++++++++--
 kernel/locking/percpu-rwsem.c |  2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 75c97e4..2ffe1ee 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -3,6 +3,7 @@
 #define _LINUX_RCUWAIT_H_
 
 #include <linux/rcupdate.h>
+#include <linux/sched/signal.h>
 
 /*
  * rcuwait provides a way of blocking and waking up a single
@@ -30,23 +31,30 @@ extern void rcuwait_wake_up(struct rcuwait *w);
  * The caller is responsible for locking around rcuwait_wait_event(),
  * such that writes to @task are properly serialized.
  */
-#define rcuwait_wait_event(w, condition)				\
+#define rcuwait_wait_event(w, condition, state)				\
 ({									\
+	int __ret = 0;							\
 	rcu_assign_pointer((w)->task, current);				\
 	for (;;) {							\
 		/*							\
 		 * Implicit barrier (A) pairs with (B) in		\
 		 * rcuwait_wake_up().					\
 		 */							\
-		set_current_state(TASK_UNINTERRUPTIBLE);		\
+		set_current_state(state);				\
 		if (condition)						\
 			break;						\
 									\
+		if (signal_pending_state(state, current)) {		\
+			__ret = -EINTR;					\
+			break;						\
+		}							\
+									\
 		schedule();						\
 	}								\
 									\
 	WRITE_ONCE((w)->task, NULL);					\
 	__set_current_state(TASK_RUNNING);				\
+	__ret;								\
 })
 
 #endif /* _LINUX_RCUWAIT_H_ */
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 183a3aa..a008a1b 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -234,7 +234,7 @@ void percpu_down_write(struct percpu_rw_semaphore *sem)
 	 */
 
 	/* Wait for all active readers to complete. */
-	rcuwait_wait_event(&sem->writer, readers_active_check(sem));
+	rcuwait_wait_event(&sem->writer, readers_active_check(sem), TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL_GPL(percpu_down_write);
 
