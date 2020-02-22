Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E41C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 14:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D8A20684
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 14:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbpoZYf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgBVOq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 09:46:59 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55015 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbgBVOq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 09:46:58 -0500
Received: by mail-pj1-f65.google.com with SMTP id dw13so2063521pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 06:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZUN0QoqtAwCcbcCvyhddxIhhjY3uc6WZiHY0zOqSM+Y=;
        b=TbpoZYf/2g3eTjRTPvtLsW2nyH712Iejhztj4Jz2/6ahmfmRoDAoj+yc4EFMx122qv
         IZ3usqbgQbsmq6BQPOkTJuYe5KjlVZJ1/S36Gq+VEMrxwnGWWCeVZxI4h43E0HsM/iER
         iDQV/ZmGKe7rADWAZPydKkU1J1z9d3eqyEMMyub8GWYyTv2S7JS2mm6nGaJZcJ9x2SJY
         /tnlKe41FS6RDBW93MpyeyDqSHttRsPrlHeCFaYhBZUQcx4jVZpGRWDlVA1Vh2Lk/acd
         r3mpsVfF9FMFU6YmJl6UH0HadYA6aSSo8I7Tll7CpZ+7E+JjKTU6IyQr7LgHEJmmEWDM
         VLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZUN0QoqtAwCcbcCvyhddxIhhjY3uc6WZiHY0zOqSM+Y=;
        b=N2uuysqxM+Xu6DYOvoFAXqRndoRTZnKT483qrUOWfTcTBSFpZu2vhD7MyLdc6y1H99
         OgGt/MYeD1epqmTa6O2QAINPVZjc57s+cQ5e+zM3Dag0+Qjyl/Cr2ft7w4b9Z0VzEMv5
         E1gu1HyXRPLLYnGTGGVF0q/eVcnoVPPVPg7P4qVeTlEmNFN3txdXgatT41hUBrne5Drb
         6ZAFTpfFO0cuELfYEPtjnyaT4E47zlLGIotr7rh+6vDCiq+qYzQzyjlM3R1VKebeJVQA
         a5fuaomeKmZcoS8LvFGXufsMLI/o+U3+JU0YrY00+5wtQZvhW42Pk560y+2OQwVIvjvZ
         iyLA==
X-Gm-Message-State: APjAAAX6mWKY9Nz5hf6X6pcJBHnzhWuRIl33/RSF41M1cN7zrWOwU1pp
        5kPoL4AokauparId946Wq1g=
X-Google-Smtp-Source: APXvYqx8tLUlcYFBP6kg8jKYvnw0BkcEB7L1Tz8BmC/Jxy/DM520ZLaRX8cRjHeQ/A6cskS/LYWXeQ==
X-Received: by 2002:a17:90b:3011:: with SMTP id hg17mr9397539pjb.90.1582382818060;
        Sat, 22 Feb 2020 06:46:58 -0800 (PST)
Received: from snappy-silo-1.localdomain ([107.182.183.158])
        by smtp.gmail.com with ESMTPSA id hg11sm6179226pjb.14.2020.02.22.06.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 06:46:57 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] psi: move PF_MEMSTALL into psi specific psi_flags
Date:   Sat, 22 Feb 2020 09:46:47 -0500
Message-Id: <20200222144647.10120-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.18.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The task->flags is a 32-bits flag, in which 31 bits have already been
consumed. So it is hardly to introduce other new per process flag.
As there's a psi specific flag psi_flags, we'd better move the psi specific
per process flag PF_MEMSTALL into it.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/psi_types.h | 12 +++++++++++-
 include/linux/sched.h     |  7 +++++--
 kernel/sched/psi.c        | 15 ++++++++-------
 kernel/sched/stats.h      | 10 +++++-----
 4 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 07aaf9b82241..411dbbf57d51 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -17,11 +17,21 @@ enum psi_task_count {
 	NR_PSI_TASK_COUNTS = 3,
 };
 
-/* Task state bitmasks */
+/*
+ * Task state bitmasks:
+ * These flags are stored in the lower PSI_TSK_BITS bits of
+ * task->psi_flags, and the higher bits are set with per process flag which
+ * persists across sleeps.
+ */
+#define PSI_TSK_STATE_BITS 16
+#define PSI_TSK_STATE_MASK ((1 << PSI_TSK_STATE_BITS) - 1)
 #define TSK_IOWAIT	(1 << NR_IOWAIT)
 #define TSK_MEMSTALL	(1 << NR_MEMSTALL)
 #define TSK_RUNNING	(1 << NR_RUNNING)
 
+/* Stalled due to lack of memory, that's per process flag. */
+#define PSI_PF_MEMSTALL (1 << PSI_TSK_STATE_BITS)
+
 /* Resources that workloads could be stalled on */
 enum psi_res {
 	PSI_IO,
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f314790cb527..2d4c04d35d9b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1025,7 +1025,11 @@ struct task_struct {
 
 	struct task_io_accounting	ioac;
 #ifdef CONFIG_PSI
-	/* Pressure stall state */
+	/*
+	 * Pressure stall state:
+	 * Bits 0 ~ PSI_TSK_STATE_BITS-1: PSI task states
+	 * Bits PSI_TSK_STATE_BITS ~ 31: Per process flags
+	 */
 	unsigned int			psi_flags;
 #endif
 #ifdef CONFIG_TASK_XACCT
@@ -1490,7 +1494,6 @@ extern struct pid *cad_pid;
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
-#define PF_MEMSTALL		0x01000000	/* Stalled due to lack of memory */
 #define PF_UMH			0x02000000	/* I'm an Usermodehelper process */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 028520702717..34363fc77ecc 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -759,7 +759,8 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 	    !psi_bug) {
 		printk_deferred(KERN_ERR "psi: inconsistent task state! task=%d:%s cpu=%d psi_flags=%x clear=%x set=%x\n",
 				task->pid, task->comm, cpu,
-				task->psi_flags, clear, set);
+				task->psi_flags & PSI_TSK_STATE_MASK,
+				clear, set);
 		psi_bug = 1;
 	}
 
@@ -818,17 +819,17 @@ void psi_memstall_enter(unsigned long *flags)
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	*flags = current->flags & PF_MEMSTALL;
+	*flags = current->psi_flags & PSI_PF_MEMSTALL;
 	if (*flags)
 		return;
 	/*
-	 * PF_MEMSTALL setting & accounting needs to be atomic wrt
+	 * PSI_PF_MEMSTALL setting & accounting needs to be atomic wrt
 	 * changes to the task's scheduling state, otherwise we can
 	 * race with CPU migration.
 	 */
 	rq = this_rq_lock_irq(&rf);
 
-	current->flags |= PF_MEMSTALL;
+	current->psi_flags |= PSI_PF_MEMSTALL;
 	psi_task_change(current, 0, TSK_MEMSTALL);
 
 	rq_unlock_irq(rq, &rf);
@@ -851,13 +852,13 @@ void psi_memstall_leave(unsigned long *flags)
 	if (*flags)
 		return;
 	/*
-	 * PF_MEMSTALL clearing & accounting needs to be atomic wrt
+	 * PSI_PF_MEMSTALL clearing & accounting needs to be atomic wrt
 	 * changes to the task's scheduling state, otherwise we could
 	 * race with CPU migration.
 	 */
 	rq = this_rq_lock_irq(&rf);
 
-	current->flags &= ~PF_MEMSTALL;
+	current->psi_flags &= ~PSI_PF_MEMSTALL;
 	psi_task_change(current, TSK_MEMSTALL, 0);
 
 	rq_unlock_irq(rq, &rf);
@@ -921,7 +922,7 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 	else if (task->in_iowait)
 		task_flags = TSK_IOWAIT;
 
-	if (task->flags & PF_MEMSTALL)
+	if (task->psi_flags & PSI_PF_MEMSTALL)
 		task_flags |= TSK_MEMSTALL;
 
 	if (task_flags)
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index ba683fe81a6e..164f97b1ce7f 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -70,7 +70,7 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 		return;
 
 	if (!wakeup || p->sched_psi_wake_requeue) {
-		if (p->flags & PF_MEMSTALL)
+		if (p->psi_flags & PSI_PF_MEMSTALL)
 			set |= TSK_MEMSTALL;
 		if (p->sched_psi_wake_requeue)
 			p->sched_psi_wake_requeue = 0;
@@ -90,7 +90,7 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
 		return;
 
 	if (!sleep) {
-		if (p->flags & PF_MEMSTALL)
+		if (p->psi_flags & PSI_PF_MEMSTALL)
 			clear |= TSK_MEMSTALL;
 	} else {
 		if (p->in_iowait)
@@ -109,14 +109,14 @@ static inline void psi_ttwu_dequeue(struct task_struct *p)
 	 * deregister its sleep-persistent psi states from the old
 	 * queue, and let psi_enqueue() know it has to requeue.
 	 */
-	if (unlikely(p->in_iowait || (p->flags & PF_MEMSTALL))) {
+	if (unlikely(p->in_iowait || (p->psi_flags & PSI_PF_MEMSTALL))) {
 		struct rq_flags rf;
 		struct rq *rq;
 		int clear = 0;
 
 		if (p->in_iowait)
 			clear |= TSK_IOWAIT;
-		if (p->flags & PF_MEMSTALL)
+		if (p->psi_flags & PSI_PF_MEMSTALL)
 			clear |= TSK_MEMSTALL;
 
 		rq = __task_rq_lock(p, &rf);
@@ -131,7 +131,7 @@ static inline void psi_task_tick(struct rq *rq)
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	if (unlikely(rq->curr->flags & PF_MEMSTALL))
+	if (unlikely(rq->curr->psi_flags & PSI_PF_MEMSTALL))
 		psi_memstall_tick(rq->curr, cpu_of(rq));
 }
 #else /* CONFIG_PSI */
-- 
Yafang Shao
DiDi

