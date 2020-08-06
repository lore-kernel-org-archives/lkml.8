Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5167C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AEC422CAE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhhx2fAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgHFAJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgHFAJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 20:09:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075C9C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 17:09:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v11so51378837ybm.22
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 17:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KPwQaPC5rlEgRvrcmoBlVpZT38eeluDqoMRajQA10S4=;
        b=qhhx2fAtSuQMbAlthsz86qneY+UexRTYr8f7upe8nl1fEwivtrK/hacFGf+FtW7+Mh
         yVHFt2872Qzg20bLldT8gIlxviU0uUWOmKYQlMgLnrdJMYzFfMfVHKzAAhJWjPthwuoM
         3EKZXSMg01/PVKuhrB+XCuT5CqGcoIbBu1icIMdghImKcHSxi2GAoCc3HfhHIBOkHr6K
         InfWgYFkcoaX46ktGmofSr6J7kKJjP/dp5jnJQvAxhejUVJ61Pmie2F46ZgRJ+P53S2+
         Uwq4Inwo2R4JXBWSG60TIQtFw+ZudQym3bHNUYHv4GzJGnMiyTO6TlEagvqasfVFPOr9
         Av+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KPwQaPC5rlEgRvrcmoBlVpZT38eeluDqoMRajQA10S4=;
        b=oJJbEhj56/PorWl5NEAOKdQnwWjc6yEkHhtjR/DCcUi99Akk4XHrJ5/n6zfDBP8KwD
         coZxRQhBXCXH36nis8dctH0aL8nyBOLieCgLhi6HyEKN7xb3+MFuENIu8B62akEjlibq
         qLx8RW8azblAARgDw83TdtooiWmiYedm5xlDVjN+wy1ep8Bo2ozzRQ3pYlfM23Evjggc
         QfIAVCJFvOzi6tsdpXpP3tEALvYmF8HbUfA15Hjh+Xvw3l1tI6kocpufRoSGgz7EKCOd
         PM5+4xrYBClMVG34IPyjRczno/VA/op5YobQGnlY1p6vpTXJ2nksyptwgnr0OVHPzhgR
         206Q==
X-Gm-Message-State: AOAM530FFtoGdJzrkBVIfsTKTIWEHj/ihZNT2ppPfWxwXM4kZZ33oPGt
        wvYVciNKy6BumKo682mVw9NMua2w
X-Google-Smtp-Source: ABdhPJyOzcoq836Rgdoac/2iNrqmHqqin6yoeU0x4KQGpPc/L1RZcl4Jzyso81ab94G8Sm1JKobTzQ5C
X-Received: by 2002:a25:44d4:: with SMTP id r203mr8462924yba.500.1596672542788;
 Wed, 05 Aug 2020 17:09:02 -0700 (PDT)
Date:   Wed,  5 Aug 2020 17:08:58 -0700
Message-Id: <20200806000859.160882-1-posk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 1/2] membarrier: add MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
From:   Peter Oskolkov <posk@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
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
any potentially active RSEQ critical sections on the CPU,
with an option to restart RSEQ CSs on all CPUs.

The second patch in the patchset adds a selftest
of this feature.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 include/uapi/linux/membarrier.h |  8 ++++++
 kernel/sched/membarrier.c       | 51 +++++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/membarrier.h b/include/uapi/linux/membarrier.h
index 5891d7614c8c..169ffb613397 100644
--- a/include/uapi/linux/membarrier.h
+++ b/include/uapi/linux/membarrier.h
@@ -114,6 +114,13 @@
  *                          If this command is not implemented by an
  *                          architecture, -EINVAL is returned.
  *                          Returns 0 on success.
+ * @MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU:
+ *                          If a thread belonging to the current process
+ *                          is currently in an RSEQ critical section on the
+ *                          CPU identified by flags parameter, restart it.
+ *                          @flags: if @flags >= 0, identifies the CPU to
+ *                                  restart RSEQ CS on; if == -1, restarts
+ *                                  RSEQ CSs on all CPUs.
  * @MEMBARRIER_CMD_SHARED:
  *                          Alias to MEMBARRIER_CMD_GLOBAL. Provided for
  *                          header backward compatibility.
@@ -131,6 +138,7 @@ enum membarrier_cmd {
 	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED		= (1 << 4),
 	MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE		= (1 << 5),
 	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE	= (1 << 6),
+	MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU		= (1 << 7),
 
 	/* Alias for header backward compatibility. */
 	MEMBARRIER_CMD_SHARED			= MEMBARRIER_CMD_GLOBAL,
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 168479a7d61b..edcc1386daf5 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -18,11 +18,19 @@
 #define MEMBARRIER_PRIVATE_EXPEDITED_SYNC_CORE_BITMASK	0
 #endif
 
+#ifdef CONFIG_RSEQ
+#define MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU_BITMASK		\
+	MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
+#else
+#define MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU_BITMASK	0
+#endif
+
 #define MEMBARRIER_CMD_BITMASK						\
 	(MEMBARRIER_CMD_GLOBAL | MEMBARRIER_CMD_GLOBAL_EXPEDITED	\
 	| MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED			\
 	| MEMBARRIER_CMD_PRIVATE_EXPEDITED				\
 	| MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED			\
+	| MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU_BITMASK		\
 	| MEMBARRIER_PRIVATE_EXPEDITED_SYNC_CORE_BITMASK)
 
 static void ipi_mb(void *info)
@@ -308,10 +316,47 @@ static int membarrier_register_private_expedited(int flags)
 	return 0;
 }
 
+#ifdef CONFIG_RSEQ
+static void membarrier_rseq_ipi(void *arg)
+{
+	struct task_struct *leader = (struct task_struct *)arg;
+
+	if (current->group_leader != leader)  /* Not our process. */
+		return;
+	if (!current->rseq)  /* RSEQ not set up for current task/thread. */
+		return;
+
+	rseq_preempt(current);
+}
+#endif
+
+static int membarrier_private_restart_rseq_on_cpu(int cpu_id)
+{
+#ifdef CONFIG_RSEQ
+	/* syscalls are not allowed inside rseq critical sections. */
+	if (cpu_id == raw_smp_processor_id())
+		return 0;
+
+	if (cpu_id >= 0) {
+		return smp_call_function_single(cpu_id, membarrier_rseq_ipi,
+						current->group_leader, true);
+	} else if (cpu_id == -1) {
+		on_each_cpu(membarrier_rseq_ipi,
+			    current->group_leader, true);
+	} else {
+		return -EINVAL;
+	}
+#endif
+	return 0;
+}
+
 /**
  * sys_membarrier - issue memory barriers on a set of threads
  * @cmd:   Takes command values defined in enum membarrier_cmd.
- * @flags: Currently needs to be 0. For future extensions.
+ * @flags: Currently needs to be 0 for all commands other than
+ *         MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU: in the latter
+ *         case it indicates the CPU on which to interrupt (= restart)
+ *         the RSEQ critical section, or -1 to restart RSEQ CSs on all CPUs.
  *
  * If this system call is not implemented, -ENOSYS is returned. If the
  * command specified does not exist, not available on the running
@@ -339,7 +384,7 @@ static int membarrier_register_private_expedited(int flags)
  */
 SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
 {
-	if (unlikely(flags))
+	if (unlikely(flags && cmd != MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU))
 		return -EINVAL;
 	switch (cmd) {
 	case MEMBARRIER_CMD_QUERY:
@@ -369,6 +414,8 @@ SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
 		return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
 	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE:
 		return membarrier_register_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
+	case MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU:
+		return membarrier_private_restart_rseq_on_cpu(flags);
 	default:
 		return -EINVAL;
 	}
-- 
2.28.0.163.g6104cc2f0b6-goog

