Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5A6C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE1620B80
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgCTM6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:58:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35604 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgCTM6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHDx-0003j7-8t; Fri, 20 Mar 2020 13:58:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DD2721C22C0;
        Fri, 20 Mar 2020 13:58:04 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:04 -0000
From:   "tip-bot2 for Yafang Shao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: Move PF_MEMSTALL out of task->flags
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1584408485-1921-1-git-send-email-laoar.shao@gmail.com>
References: <1584408485-1921-1-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Message-ID: <158470908459.28353.7390210153247885071.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1066d1b6974e095d5a6c472ad9180a957b496cd6
Gitweb:        https://git.kernel.org/tip/1066d1b6974e095d5a6c472ad9180a957b496cd6
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Mon, 16 Mar 2020 21:28:05 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:19 +01:00

psi: Move PF_MEMSTALL out of task->flags

The task->flags is a 32-bits flag, in which 31 bits have already been
consumed. So it is hardly to introduce other new per process flag.
Currently there're still enough spaces in the bit-field section of
task_struct, so we can define the memstall state as a single bit in
task_struct instead.
This patch also removes an out-of-date comment pointed by Matthew.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lkml.kernel.org/r/1584408485-1921-1-git-send-email-laoar.shao@gmail.com
---
 include/linux/sched.h |  6 ++++--
 kernel/sched/psi.c    | 12 ++++++------
 kernel/sched/stats.h  | 10 +++++-----
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2e9199b..09bddd9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -785,9 +785,12 @@ struct task_struct {
 	unsigned			frozen:1;
 #endif
 #ifdef CONFIG_BLK_CGROUP
-	/* to be used once the psi infrastructure lands upstream. */
 	unsigned			use_memdelay:1;
 #endif
+#ifdef CONFIG_PSI
+	/* Stalled due to lack of memory */
+	unsigned			in_memstall:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
@@ -1480,7 +1483,6 @@ extern struct pid *cad_pid;
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
-#define PF_MEMSTALL		0x01000000	/* Stalled due to lack of memory */
 #define PF_UMH			0x02000000	/* I'm an Usermodehelper process */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 955a124..8f45cdb 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -865,17 +865,17 @@ void psi_memstall_enter(unsigned long *flags)
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	*flags = current->flags & PF_MEMSTALL;
+	*flags = current->in_memstall;
 	if (*flags)
 		return;
 	/*
-	 * PF_MEMSTALL setting & accounting needs to be atomic wrt
+	 * in_memstall setting & accounting needs to be atomic wrt
 	 * changes to the task's scheduling state, otherwise we can
 	 * race with CPU migration.
 	 */
 	rq = this_rq_lock_irq(&rf);
 
-	current->flags |= PF_MEMSTALL;
+	current->in_memstall = 1;
 	psi_task_change(current, 0, TSK_MEMSTALL);
 
 	rq_unlock_irq(rq, &rf);
@@ -898,13 +898,13 @@ void psi_memstall_leave(unsigned long *flags)
 	if (*flags)
 		return;
 	/*
-	 * PF_MEMSTALL clearing & accounting needs to be atomic wrt
+	 * in_memstall clearing & accounting needs to be atomic wrt
 	 * changes to the task's scheduling state, otherwise we could
 	 * race with CPU migration.
 	 */
 	rq = this_rq_lock_irq(&rf);
 
-	current->flags &= ~PF_MEMSTALL;
+	current->in_memstall = 0;
 	psi_task_change(current, TSK_MEMSTALL, 0);
 
 	rq_unlock_irq(rq, &rf);
@@ -970,7 +970,7 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 	} else if (task->in_iowait)
 		task_flags = TSK_IOWAIT;
 
-	if (task->flags & PF_MEMSTALL)
+	if (task->in_memstall)
 		task_flags |= TSK_MEMSTALL;
 
 	if (task_flags)
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 1339f5b..33d0daf 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -70,7 +70,7 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 		return;
 
 	if (!wakeup || p->sched_psi_wake_requeue) {
-		if (p->flags & PF_MEMSTALL)
+		if (p->in_memstall)
 			set |= TSK_MEMSTALL;
 		if (p->sched_psi_wake_requeue)
 			p->sched_psi_wake_requeue = 0;
@@ -90,7 +90,7 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
 		return;
 
 	if (!sleep) {
-		if (p->flags & PF_MEMSTALL)
+		if (p->in_memstall)
 			clear |= TSK_MEMSTALL;
 	} else {
 		/*
@@ -117,14 +117,14 @@ static inline void psi_ttwu_dequeue(struct task_struct *p)
 	 * deregister its sleep-persistent psi states from the old
 	 * queue, and let psi_enqueue() know it has to requeue.
 	 */
-	if (unlikely(p->in_iowait || (p->flags & PF_MEMSTALL))) {
+	if (unlikely(p->in_iowait || p->in_memstall)) {
 		struct rq_flags rf;
 		struct rq *rq;
 		int clear = 0;
 
 		if (p->in_iowait)
 			clear |= TSK_IOWAIT;
-		if (p->flags & PF_MEMSTALL)
+		if (p->in_memstall)
 			clear |= TSK_MEMSTALL;
 
 		rq = __task_rq_lock(p, &rf);
@@ -149,7 +149,7 @@ static inline void psi_task_tick(struct rq *rq)
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	if (unlikely(rq->curr->flags & PF_MEMSTALL))
+	if (unlikely(rq->curr->in_memstall))
 		psi_memstall_tick(rq->curr, cpu_of(rq));
 }
 #else /* CONFIG_PSI */
