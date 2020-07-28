Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7351AC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA2A2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ssLyZp/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbgG1QAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:00:17 -0400
Received: from mail.efficios.com ([167.114.26.124]:44370 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730994AbgG1QAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:00:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D2CF129A886;
        Tue, 28 Jul 2020 12:00:14 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qn_CIEv5heer; Tue, 28 Jul 2020 12:00:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 936D829A618;
        Tue, 28 Jul 2020 12:00:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 936D829A618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1595952014;
        bh=2xoJecq6SiKChi0NlXRlWBK3yJHwYnLJVWhwBhqc12g=;
        h=From:To:Date:Message-Id;
        b=ssLyZp/vmIqNOapsb0P3FDyt/rFEI83M16WIMxDldCWZ8zgkrASLmG6qjz2JZLEPQ
         XaXx2KF1UnI54yKqapwgNQWUyiRS7Z0SDI2kDsQTSUrS+1Igk9iAPRWq4tnAAXP7SW
         JTmbJD1NlpLih6qZJQqYtFti5TzmchgXPc/Inhp+qajfGyYmeL3UJySlO3fqGF0HV1
         dplwaPrRV11zR1AiDRQs8e8S72m/jcU+HPdISAHLUug4uOq+ePEcLip9tcUgoaMjc1
         kXnv3h6crcvgbjUA70jqzvfJ6MEEB+kYx8NwPISPJ70o3RBdKZh4wStZH55hL1mJPR
         GklCkXhuWN35g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LNYLVUcXcOdE; Tue, 28 Jul 2020 12:00:14 -0400 (EDT)
Received: from thinkos.etherlink (unknown [192.222.236.144])
        by mail.efficios.com (Postfix) with ESMTPSA id 67F2729A728;
        Tue, 28 Jul 2020 12:00:14 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH 2/2] sched: membarrier: cover kthread_use_mm
Date:   Tue, 28 Jul 2020 12:00:10 -0400
Message-Id: <20200728160010.3314-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200728160010.3314-1-mathieu.desnoyers@efficios.com>
References: <20200728160010.3314-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add comments and memory barrier to kthread_use_mm and kthread_unuse_mm
to allow the effect of membarrier(2) to apply to kthreads accessing
user-space memory as well.

Given that no prior kthread use this guarantee and that it only affects
kthreads, adding this guarantee does not affect user-space ABI.

Refine the check in membarrier_global_expedited to exclude runqueues
running the idle thread rather than all kthreads from the IPI cpumask.

This patch applies on top of this patch from Peter Zijlstra:
"mm: fix kthread_use_mm() vs TLB invalidate" currently in Andrew
Morton's tree.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/kthread.c          | 19 +++++++++++++++++++
 kernel/sched/membarrier.c |  8 ++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 48925b17920e..ef2435517f14 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1258,8 +1258,19 @@ void kthread_use_mm(struct mm_struct *mm)
 	finish_arch_post_lock_switch();
 #endif
 
+	/*
+	 * When a kthread starts operating on an address space, the loop
+	 * in membarrier_{private,global}_expedited() may not observe
+	 * that tsk->mm, and not issue an IPI. Membarrier requires a
+	 * memory barrier after storing to tsk->mm, before accessing
+	 * user-space memory. A full memory barrier for membarrier
+	 * {PRIVATE,GLOBAL}_EXPEDITED is implicitly provided by
+	 * mmdrop().
+	 */
 	if (active_mm != mm)
 		mmdrop(active_mm);
+	else
+		smp_mb();
 
 	to_kthread(tsk)->oldfs = get_fs();
 	set_fs(USER_DS);
@@ -1280,6 +1291,14 @@ void kthread_unuse_mm(struct mm_struct *mm)
 	set_fs(to_kthread(tsk)->oldfs);
 
 	task_lock(tsk);
+	/*
+	 * When a kthread stops operating on an address space, the loop
+	 * in membarrier_{private,global}_expedited() may not observe
+	 * that tsk->mm, and not issue an IPI. Membarrier requires a
+	 * memory barrier after accessing user-space memory, before
+	 * clearing tsk->mm.
+	 */
+	smp_mb();
 	sync_mm_rss(mm);
 	local_irq_disable();
 	tsk->mm = NULL;
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 168479a7d61b..8a294483074d 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -100,13 +100,9 @@ static int membarrier_global_expedited(void)
 		    MEMBARRIER_STATE_GLOBAL_EXPEDITED))
 			continue;
 
-		/*
-		 * Skip the CPU if it runs a kernel thread. The scheduler
-		 * leaves the prior task mm in place as an optimization when
-		 * scheduling a kthread.
-		 */
+		/* Skip the CPU if it runs the idle thread. */
 		p = rcu_dereference(cpu_rq(cpu)->curr);
-		if (p->flags & PF_KTHREAD)
+		if (is_idle_task(p))
 			continue;
 
 		__cpumask_set_cpu(cpu, tmpmask);
-- 
2.11.0

