Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D548C0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682DC2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIRr+yri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgCQB2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 21:28:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38218 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733017AbgCQB2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 21:28:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id x7so10783578pgh.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 18:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Va5UX5LTG/PbDYFMWXp7ney7E1y0v7mEaerBejG/K4E=;
        b=LIRr+yriG6pj/VMT+1Pr//O7xrgS8MHGcxzp9wJOkKNBLJ5jmwhfxjtZvJcJzjrt7x
         sHKxBEZGEST4LY6FPAH/7JM0QjxPsDf/NbMTp6RJZPBHxL2MgcY8CUavdovsCw6aDCR4
         YapO6UGg00zAy1zsDmEhtu6dMETR11zmqPfFhGbM6SHlda+SkjrENUR9eEwvNqKmPxYl
         CJEDUIFNYpa6SF+JTuIYV1fjuSchFv3Y11P/7DAz4mluZbH9cTPV70BXWNMynikt4hYj
         XZJi+ZFWVe4XQbm0+2rpTNIp97NPJW45YMWIIk+7u/tglVbouPnvue4OlvDA+Xhhay0m
         v+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Va5UX5LTG/PbDYFMWXp7ney7E1y0v7mEaerBejG/K4E=;
        b=UrzgFufP/A6ckjdV73/G0lBmhXN3P6aIwxFmiLpraS23NFYizeFk1AYu0DoXuSGZrp
         2WTinJ5snq5axxu6Ct+ypRvA0Rsj8P85VNykloHzCLMyYjNqCH36lgeZPNt9MBe/eXvW
         fMxMziWHB+SaPxeFafIz/LsW48pYPe/ZR81TONGD4GAUhXCSE7n+IxAmol9McSd3F+1+
         qKM3BqwnnCIrnZD6aj0Fq2Kng2LScSRNBG9r5iNOQre6sv+5EcY9tYCeiIE5b3A1M/Xb
         kzm5VrExfGkC9RTsd/XHJNsxiFqqGocPpx6ZtO5yxX0UfKS48f3QW/I1+6nzlW1lWEtK
         HPpQ==
X-Gm-Message-State: ANhLgQ02F0ili7mZeGlNBAiHR+sgXPknc9tupbIAwgYItCDKGD0kgNLl
        GTjdjMuIQH06CdTaIJBIyMQ=
X-Google-Smtp-Source: ADFU+vsPf8UE++tkaMdzY8hRCKV9M94sAGnlJksmoCNjQGnxI5MTQofGsQO60+VW3X7RnDrk/pBqBw==
X-Received: by 2002:a63:1459:: with SMTP id 25mr2641053pgu.427.1584408515489;
        Mon, 16 Mar 2020 18:28:35 -0700 (PDT)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p8sm1062687pff.26.2020.03.16.18.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2020 18:28:34 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, willy@infradead.org, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2] psi: move PF_MEMSTALL out of task->flags
Date:   Mon, 16 Mar 2020 21:28:05 -0400
Message-Id: <1584408485-1921-1-git-send-email-laoar.shao@gmail.com>
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
This patch also removes an out-of-date comment pointed by Matthew.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/sched.h |  6 ++++--
 kernel/sched/psi.c    | 12 ++++++------
 kernel/sched/stats.h  | 10 +++++-----
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0d84f8f..c429e97 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -783,9 +783,12 @@ struct task_struct {
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
 
@@ -1490,7 +1493,6 @@ static inline int is_global_init(struct task_struct *tsk)
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

