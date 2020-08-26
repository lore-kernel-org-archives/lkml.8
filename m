Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC212C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A83D2078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fIlVnwAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgHZSsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgHZSr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:47:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26DBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 11:47:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g127so3976466ybf.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 11:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=01eVWF2fj1sRoqYf2KTZ5Ary3GQdqMTjG4D8J0rI9NU=;
        b=fIlVnwAZkl6j9fjtEXMbbmQh4nbprbP/LxPTIJv2BXSaqgZMpPiMgqgJbsSnyCNvoC
         C58QV3HukJcwQ/pNugtckcvLXL/zrdTnKVkXrQIxR+s+mSDNRsS01kzgFgpqJUdritI7
         YMUPDGYN4VCQ0BmRlVATVQtWoNnVl7hrwgSKic3WrTSXe0I0au5Uom57U4Zk7eVg5H6d
         e/nwe2OqU6FO4exNihCIbBZ3MXfW8E4kYSKX+oBSLeyFJAGRFA2/aZr2TmE+KKilHWAg
         zhtYRa7w++D0wtuZB6HY9ahGXSGGe2Uq2TXwzHFs8fkB6LN5VF6t5nu5w9YjI08nij7x
         /+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=01eVWF2fj1sRoqYf2KTZ5Ary3GQdqMTjG4D8J0rI9NU=;
        b=iynHLw84zfb0BfcqQTDHnvKk2Rtw8fUEWMRQQvxauZ7e5HwwGuIHODAEZe+DMa9DFu
         Rb+DYG6Prq7do5gGJ+ecHC774DEIjozp0d4czRbPs+/kQ+4b8D7604TK9MUSMCfS4L1p
         +kvQWnjAVmiV2PPa+FEwDGolFwc/eObnoBdRcRL8l6YpCreRmCxiFfnoRw+HV7HXZCl0
         n9V4IPDfhk5kiiKpeLPek+13xzdJWimCi7zLp7POhyMM6xxTAbRo/dKG/Os1ASjXgvXf
         PMiILGFvWSzaLlZVb+NUocy4Ne8aGGnOBZ+GomkwLR1kyuTsAS73Uzu9DQhr++lY+k6o
         198Q==
X-Gm-Message-State: AOAM530wvqoAn+BKwUkAOWTEXV8ttGqCDaIj8c5pG61uFxgIVkMR/d7p
        gb3L6NKSsC2ktbO+yd3Xg3RdXICz
X-Google-Smtp-Source: ABdhPJzmKJXj8xBQQ7xEF2+LOkKMdhl56kNMnjzy+WZixC+YxR4KIcK7YfxFugI8b7tfeL6AajX9znB5
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:7220:84ff:fe09:7598])
 (user=posk job=sendgmr) by 2002:a5b:947:: with SMTP id x7mr25853229ybq.106.1598467675085;
 Wed, 26 Aug 2020 11:47:55 -0700 (PDT)
Date:   Wed, 26 Aug 2020 11:47:49 -0700
Message-Id: <20200826184750.3671821-1-posk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 1/2 v4] rseq/membarrier: add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
From:   Peter Oskolkov <posk@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>, Peter Oskolkov <posk@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on Google-internal RSEQ
work done by Paul Turner and Andrew Hunter.

When working with per-CPU RSEQ-based memory allocations,
it is sometimes important to make sure that a global
memory location is no longer accessed from RSEQ critical
sections. For example, there can be two per-CPU lists,
one is "active" and accessed per-CPU, while another one
is inactive and worked on asynchronously "off CPU" (e.g.
garbage collection is performed). Then at some point
the two lists are swapped, and a fast RCU-like mechanism
is required to make sure that the previously active
list is no longer accessed.

This patch introduces such a mechanism: in short,
membarrier() syscall issues an IPI to a CPU, restarting
a potentially active RSEQ critical section on the CPU.

v1->v2:
  - removed the ability to IPI all CPUs in a single sycall;
  - use task->mm rather than task->group_leader to identify
    tasks belonging to the same process.
v2->v3:
  - re-added the ability to IPI all CPUs in a single syscall;
  - integrated with membarrier_private_expedited() to
    make sure only CPUs running tasks with the same mm as
    the current task are interrupted;
  - also added MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ;
  - flags in membarrier_private_expedited are never actually
    bit flags but always distinct values (i.e. never two flags
    are combined), so I modified bit testing to full equation
    comparison for simplicity (otherwise the code needs to
    work when several bits are set, for example).
v3->v4:
  - added the third parameter to membarrier syscall: @cpu_id:
    if @flags == MEMBARRIER_CMD_FLAG_CPU, then @cpu_id indicates
    the cpu on which RSEQ CS should be restarted.

The second patch in the patchset adds a selftest
of this feature.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 include/linux/sched/mm.h        |  3 ++
 include/uapi/linux/membarrier.h | 29 ++++++++++++++
 kernel/sched/membarrier.c       | 67 ++++++++++++++++++++++++++++-----
 3 files changed, 89 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index f889e332912f..15bfb06f2884 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -348,10 +348,13 @@ enum {
 	MEMBARRIER_STATE_GLOBAL_EXPEDITED			= (1U << 3),
 	MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY	= (1U << 4),
 	MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE		= (1U << 5),
+	MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY		= (1U << 6),
+	MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ			= (1U << 7),
 };
 
 enum {
 	MEMBARRIER_FLAG_SYNC_CORE	= (1U << 0),
+	MEMBARRIER_FLAG_RSEQ		= (1U << 1),
 };
 
 #ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
diff --git a/include/uapi/linux/membarrier.h b/include/uapi/linux/membarrier.h
index 5891d7614c8c..98c2b0e7c0d8 100644
--- a/include/uapi/linux/membarrier.h
+++ b/include/uapi/linux/membarrier.h
@@ -114,6 +114,29 @@
  *                          If this command is not implemented by an
  *                          architecture, -EINVAL is returned.
  *                          Returns 0 on success.
+ * @MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
+ *                          In addition to provide memory ordering
+ *                          guarantees described in
+ *                          MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE,
+ *                          ensure the caller thread, upon return from
+ *                          system call, that all its running thread
+ *                          siblings have any currently running rseq
+ *                          critical sections restarted if @flags
+ *                          parameter is 0; if @flags parameter is
+ *                          MEMBARRIER_CMD_FLAG_CPU,
+ *                          then this operation is performed only
+ *                          on CPU indicated by @cpu_id. If this command is
+ *                          not implemented by an architecture, -EINVAL
+ *                          is returned. A process needs to register its
+ *                          intent to use the private expedited rseq
+ *                          command prior to using it, otherwise
+ *                          this command returns -EPERM.
+ * @MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
+ *                          Register the process intent to use
+ *                          MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.
+ *                          If this command is not implemented by an
+ *                          architecture, -EINVAL is returned.
+ *                          Returns 0 on success.
  * @MEMBARRIER_CMD_SHARED:
  *                          Alias to MEMBARRIER_CMD_GLOBAL. Provided for
  *                          header backward compatibility.
@@ -131,9 +154,15 @@ enum membarrier_cmd {
 	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED		= (1 << 4),
 	MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE		= (1 << 5),
 	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE	= (1 << 6),
+	MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ			= (1 << 7),
+	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ		= (1 << 8),
 
 	/* Alias for header backward compatibility. */
 	MEMBARRIER_CMD_SHARED			= MEMBARRIER_CMD_GLOBAL,
 };
 
+enum membarrier_cmd_flag {
+	MEMBARRIER_CMD_FLAG_CPU		= (1 << 0),
+};
+
 #endif /* _UAPI_LINUX_MEMBARRIER_H */
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 168479a7d61b..ac9f4895491d 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -18,6 +18,14 @@
 #define MEMBARRIER_PRIVATE_EXPEDITED_SYNC_CORE_BITMASK	0
 #endif
 
+#ifdef CONFIG_RSEQ
+#define MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ_BITMASK		\
+	(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ			\
+	| MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ_BITMASK)
+#else
+#define MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ_BITMASK	0
+#endif
+
 #define MEMBARRIER_CMD_BITMASK						\
 	(MEMBARRIER_CMD_GLOBAL | MEMBARRIER_CMD_GLOBAL_EXPEDITED	\
 	| MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED			\
@@ -27,6 +35,12 @@
 
 static void ipi_mb(void *info)
 {
+#ifdef CONFIG_RSEQ
+	int *flags = info;
+
+	if (flags && (*flags == MEMBARRIER_FLAG_RSEQ))
+		rseq_preempt(current);
+#endif
 	smp_mb();	/* IPIs should be serializing but paranoid. */
 }
 
@@ -129,19 +143,26 @@ static int membarrier_global_expedited(void)
 	return 0;
 }
 
-static int membarrier_private_expedited(int flags)
+static int membarrier_private_expedited(int flags, int cpu_id)
 {
 	int cpu;
 	cpumask_var_t tmpmask;
 	struct mm_struct *mm = current->mm;
 
-	if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
+	if (flags == MEMBARRIER_FLAG_SYNC_CORE) {
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
 			return -EINVAL;
 		if (!(atomic_read(&mm->membarrier_state) &
 		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY))
 			return -EPERM;
+	} else if (flags == MEMBARRIER_FLAG_RSEQ) {
+		if (!IS_ENABLED(CONFIG_RSEQ))
+			return -EINVAL;
+		if (!(atomic_read(&mm->membarrier_state) &
+		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY))
+			return -EPERM;
 	} else {
+		BUG_ON(flags != 0);
 		if (!(atomic_read(&mm->membarrier_state) &
 		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY))
 			return -EPERM;
@@ -174,6 +195,8 @@ static int membarrier_private_expedited(int flags)
 		 */
 		if (cpu == raw_smp_processor_id())
 			continue;
+		if (cpu_id >= 0 && cpu != cpu_id)
+			continue;
 		p = rcu_dereference(cpu_rq(cpu)->curr);
 		if (p && p->mm == mm)
 			__cpumask_set_cpu(cpu, tmpmask);
@@ -181,7 +204,7 @@ static int membarrier_private_expedited(int flags)
 	rcu_read_unlock();
 
 	preempt_disable();
-	smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
+	smp_call_function_many(tmpmask, ipi_mb, &flags, 1);
 	preempt_enable();
 
 	free_cpumask_var(tmpmask);
@@ -283,11 +306,18 @@ static int membarrier_register_private_expedited(int flags)
 	    set_state = MEMBARRIER_STATE_PRIVATE_EXPEDITED,
 	    ret;
 
-	if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
+	if (flags == MEMBARRIER_FLAG_SYNC_CORE) {
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
 			return -EINVAL;
 		ready_state =
 			MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY;
+	} else if (flags == MEMBARRIER_FLAG_RSEQ) {
+		if (!IS_ENABLED(CONFIG_RSEQ))
+			return -EINVAL;
+		ready_state =
+			MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY;
+	} else {
+		BUG_ON(flags != 0);
 	}
 
 	/*
@@ -299,6 +329,8 @@ static int membarrier_register_private_expedited(int flags)
 		return 0;
 	if (flags & MEMBARRIER_FLAG_SYNC_CORE)
 		set_state |= MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE;
+	if (flags & MEMBARRIER_FLAG_RSEQ)
+		set_state |= MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ;
 	atomic_or(set_state, &mm->membarrier_state);
 	ret = sync_runqueues_membarrier_state(mm);
 	if (ret)
@@ -310,8 +342,15 @@ static int membarrier_register_private_expedited(int flags)
 
 /**
  * sys_membarrier - issue memory barriers on a set of threads
- * @cmd:   Takes command values defined in enum membarrier_cmd.
- * @flags: Currently needs to be 0. For future extensions.
+ * @cmd:    Takes command values defined in enum membarrier_cmd.
+ * @flags:  Currently needs to be 0 for all commands other than
+ *          MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ: in the latter
+ *          case it can be MEMBARRIER_CMD_FLAG_CPU, indicating that @cpu_id
+ *          contains the CPU on which to interrupt (= restart)
+ *          the RSEQ critical section.
+ * @cpu_id: if @flags == MEMBARRIER_CMD_FLAG_CPU, indicates the cpu on which
+ *          RSEQ CS should be interrupted (@cmd must be
+ *          MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ).
  *
  * If this system call is not implemented, -ENOSYS is returned. If the
  * command specified does not exist, not available on the running
@@ -337,9 +376,9 @@ static int membarrier_register_private_expedited(int flags)
  *        smp_mb()           X           O            O
  *        sys_membarrier()   O           O            O
  */
-SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
+SYSCALL_DEFINE3(membarrier, int, cmd, int, flags, int, cpu_id)
 {
-	if (unlikely(flags))
+	if (unlikely(flags) && cmd != MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)
 		return -EINVAL;
 	switch (cmd) {
 	case MEMBARRIER_CMD_QUERY:
@@ -362,13 +401,21 @@ SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
 	case MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED:
 		return membarrier_register_global_expedited();
 	case MEMBARRIER_CMD_PRIVATE_EXPEDITED:
-		return membarrier_private_expedited(0);
+		return membarrier_private_expedited(0, -1);
 	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED:
 		return membarrier_register_private_expedited(0);
 	case MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE:
-		return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
+		return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE, -1);
 	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE:
 		return membarrier_register_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
+	case MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
+		if (flags == 0)
+			return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ, -1);
+		if (flags == MEMBARRIER_CMD_FLAG_CPU)
+			return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ, cpu_id);
+		return -EINVAL;
+	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
+		return membarrier_register_private_expedited(MEMBARRIER_FLAG_RSEQ);
 	default:
 		return -EINVAL;
 	}
-- 
2.28.0.297.g1956fa8f8d-goog

