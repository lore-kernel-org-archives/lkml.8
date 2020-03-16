Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A89BC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2512073C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHohRyYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbgCPKqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:46:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39190 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730478AbgCPKqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:46:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id b22so3534319pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 03:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4Jcxpb/lSA+RpVfW2OIW26iHAGRBXnhNEQ0GjrjO6gQ=;
        b=aHohRyYzN/5wSK+rMqjtj+XtpawAxu3b1TX/aZmD8It/Xzd/n/NlEd2QKNmJgvHT5o
         zRXiOdTbOCwoeNUthMhgYRRowUvqE66DIbEwc+d2WHHSs17EjoQjpsqqPIB8yPc3Nu7T
         TkFq32LsZ9sAok+T3zIr2v0ggwwegSeyQaNva/WbImfeC2rQiSdjv/YV8qdIr+s1NyqZ
         wGR8uX8zPquKe8KPhL69cUd8GZoDdv/LHlyfJF7wA9AWKV9B5RRDPFvBQdTZt18QfAPk
         zxP094j2oao4sOf2VkcOCRcfJUePdNXXEPDslHIdrF6jnn3K3ZcCn/LLOP/+OfdMr2dt
         KVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4Jcxpb/lSA+RpVfW2OIW26iHAGRBXnhNEQ0GjrjO6gQ=;
        b=qa267z511FBWDEKpt3XDvc90nCegCjMm2I4BcHon+ZCpSlXcC0l0c8Tvln3XGWuh/C
         DePff0oBRCNSitLKQM06qY9nzcpWiR+IqrMtUuCcuCPzlZe/x2bykp4/ZXMxZC/l+c2F
         7iohsEv6xgXWYotZIviwHHx3gf9oxDnyOmo5tlpRRtZohPs5mx/j5rauENZ/I4Dwbbgh
         cb3+YlbPjeQ773Je02zMAJJOKds18wWW/8tGIz3mg00YQffiIfaEUBJ7d9+CwlYSA9Ae
         VBAmjuANLhbr+aM7Hm4izGPtXcB3ViDFw3r5iXD6TlRxMicoocbhqHIm4eu1H2sQMK4a
         ViEg==
X-Gm-Message-State: ANhLgQ1jmz/mqOz0MSxYrAAMkq1qA4tUlq6SCZni94fw2RpQyX2G/gj5
        d4X5zDfxNx0eAARrAF2Mvzc=
X-Google-Smtp-Source: ADFU+vtRqpYP4fTFBx4/XoW7SlCQvgz/Qc0pOI7iyYqbXLE1WuUc3IrMufowyUYf9BxxOJGVyb0tJw==
X-Received: by 2002:a63:c507:: with SMTP id f7mr25643454pgd.278.1584355607250;
        Mon, 16 Mar 2020 03:46:47 -0700 (PDT)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id w124sm16424233pfd.71.2020.03.16.03.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2020 03:46:46 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, akpm@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 1/1] psi: move PF_MEMSTALL out of task->flags
Date:   Mon, 16 Mar 2020 06:46:25 -0400
Message-Id: <1584355585-10210-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The task->flags is a 32-bits flag, in which 31 bits have already been
consumed. So it is hardly to introduce other new per process flag.
Currently there're still enough spaces in the bit-field section of
task_struct, so we can define the memstall state as a single bit in
task_struct instead.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/sched.h |  5 ++++-
 kernel/sched/psi.c    | 12 ++++++------
 kernel/sched/stats.h  | 10 +++++-----
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0d84f8f..fe8cba2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -786,6 +786,10 @@ struct task_struct {
 	/* to be used once the psi infrastructure lands upstream. */
 	unsigned			use_memdelay:1;
 #endif
+#ifdef CONFIG_PSI
+	/* Stalled due to lack of memory */
+	unsigned			in_memstall:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
@@ -1490,7 +1494,6 @@ static inline int is_global_init(struct task_struct *tsk)
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
-#define PF_MEMSTALL		0x01000000	/* Stalled due to lack of memory */
 #define PF_UMH			0x02000000	/* I'm an Usermodehelper process */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 517e371..d068e83 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -817,17 +817,17 @@ void psi_memstall_enter(unsigned long *flags)
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
@@ -850,13 +850,13 @@ void psi_memstall_leave(unsigned long *flags)
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
@@ -920,7 +920,7 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 	else if (task->in_iowait)
 		task_flags = TSK_IOWAIT;
 
-	if (task->flags & PF_MEMSTALL)
+	if (task->in_memstall)
 		task_flags |= TSK_MEMSTALL;
 
 	if (task_flags)
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index ba683fe..199e304 100644
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
 		if (p->in_iowait)
@@ -109,14 +109,14 @@ static inline void psi_ttwu_dequeue(struct task_struct *p)
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
@@ -131,7 +131,7 @@ static inline void psi_task_tick(struct rq *rq)
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	if (unlikely(rq->curr->flags & PF_MEMSTALL))
+	if (unlikely(rq->curr->in_memstall))
 		psi_memstall_tick(rq->curr, cpu_of(rq));
 }
 #else /* CONFIG_PSI */
-- 
1.8.3.1

