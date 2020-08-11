Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A6BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9ED206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hH2+OHUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgHKAKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 20:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgHKAKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:10:05 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DA7C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 17:10:05 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 129so9109282pfv.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 17:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EX67DgdPRMTYsAQtHZsF+azPW4jxLdEYZ/VSwZaSl7I=;
        b=hH2+OHUX4gFGMcvGv2yd4ieu9Wg0U+2P5ZzA7TVT2PpW6XUurjGhOCRaYmym1TWZHV
         8H2b+UGnduhkbeqgJk/+SySxhEeiSF6izFpK0wzClla8bk3eMLZSY5ceBhFVNQ0n6CnK
         +4W0GPQnDoSqFLKD79BhOuI5tCret+YZiAEPXdhCyQU28Rv3IEZLJNjnW2//C54TQpzw
         8XiRKe3AXlXvqQkVPwJkODcIidd6Wxdsn+rcCXljrGDD6eCPOiHr8p8xz7pqIPX/4PvG
         Ye19X69ufitbb6iw60eNAhxlZcvF1tPj3Wj7O54kUv/Udhj6+Rk4UgBdpb4eXWzsjUQf
         3A8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EX67DgdPRMTYsAQtHZsF+azPW4jxLdEYZ/VSwZaSl7I=;
        b=sSFOTMxBqSCQhAqXevmJehTDdxTFU15o3H8C/4fDCCzjfMfTzhjqj2prs/CC58VkvO
         o5B3Jp45QKLbql/EGdG0H+cHpY7pQiF6LjKyxamzCsr06LAfKj2/wrGLyorQHI+X2NU3
         cUgkOZENK7Ikq4AfbFwQKz/36vGvmlSrf3DfYs1BWjPpGtcD67/FquM2fNAZFrmhnxAW
         3QTjj4Cknft9dTQ/dFCUbkg6wNSuGr8EX96lqeI7NTIKxz4rPBhKUSyYZbN+V3byDS24
         wlbwhOdai2fpDftvIf2iIg9mAYYAp4omcXfdw1ehnakixmhPkFesb1Mm2oZ4psfsXRHz
         DlBQ==
X-Gm-Message-State: AOAM532jwGF6uynVkx6IGf+4q9QByYB0YHr9L2xAz4zxuZFOdUpJY9Va
        jUqpKQIBvD6uPDwICkVHbkLREdeH
X-Google-Smtp-Source: ABdhPJxoY8l0Zu4281GYn/qE2cjFl5SJRu/B+oMK0Zrl1PglBzQUPs2TKLDVDEMxfMN4+qf+S9CAd9zx
X-Received: by 2002:a17:90a:3488:: with SMTP id p8mr270498pjb.1.1597104604455;
 Mon, 10 Aug 2020 17:10:04 -0700 (PDT)
Date:   Mon, 10 Aug 2020 17:09:58 -0700
Message-Id: <20200811000959.2486636-1-posk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH 1/2 v3] rseq/membarrier: add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
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

The second patch in the patchset adds a selftest
of this feature.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 include/linux/sched/mm.h        |  3 ++
 include/uapi/linux/membarrier.h | 24 ++++++++++++++
 kernel/sched/membarrier.c       | 55 ++++++++++++++++++++++++++++-----
 3 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 6be66f52a2ad..477d5526e053 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -352,10 +352,13 @@ enum {
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
index 5891d7614c8c..f6bafe0676ba 100644
--- a/include/uapi/linux/membarrier.h
+++ b/include/uapi/linux/membarrier.h
@@ -114,6 +114,28 @@
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
+ *                          parameter is -1; if @flags parameter is >= 0,
+ *                          then this operation is performed only
+ *                          on CPU indicated by @flags. If this command is
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
@@ -131,6 +153,8 @@ enum membarrier_cmd {
 	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED		= (1 << 4),
 	MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE		= (1 << 5),
 	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE	= (1 << 6),
+	MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ			= (1 << 7),
+	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ		= (1 << 8),
 
 	/* Alias for header backward compatibility. */
 	MEMBARRIER_CMD_SHARED			= MEMBARRIER_CMD_GLOBAL,
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 168479a7d61b..54c1093ebc87 100644
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
+	int *flags = info;
+
+#ifdef CONFIG_RSEQ
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
@@ -311,7 +343,10 @@ static int membarrier_register_private_expedited(int flags)
 /**
  * sys_membarrier - issue memory barriers on a set of threads
  * @cmd:   Takes command values defined in enum membarrier_cmd.
- * @flags: Currently needs to be 0. For future extensions.
+ * @flags: Currently needs to be 0 for all commands other than
+ *         MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ: in the latter
+ *         case it indicates the CPU on which to interrupt (= restart)
+ *         the RSEQ critical section, or -1 to restart on all CPUs.
  *
  * If this system call is not implemented, -ENOSYS is returned. If the
  * command specified does not exist, not available on the running
@@ -339,7 +374,7 @@ static int membarrier_register_private_expedited(int flags)
  */
 SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
 {
-	if (unlikely(flags))
+	if (unlikely(flags) && cmd != MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)
 		return -EINVAL;
 	switch (cmd) {
 	case MEMBARRIER_CMD_QUERY:
@@ -362,13 +397,17 @@ SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
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
+		return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ, flags);
+	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
+		return membarrier_register_private_expedited(MEMBARRIER_FLAG_RSEQ);
 	default:
 		return -EINVAL;
 	}
-- 
2.28.0.236.gb10cc79966-goog

