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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5059C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1753420786
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaHQhlbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgHFRIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbgHFRGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:06:40 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323BBC061575
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 10:05:50 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 3so33988648qkv.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ClCRhz5VpiOzswZeEfz32cI4Ba2QyTHClpP/KXN77n8=;
        b=IaHQhlbRWGXN2/ao+LoJlBFGdbqt+zL5VeTLHAkovnP6l+enfuSJzm52DuFZPXbvWI
         FSspI20sJny2yb3byTqFpczlG9HADujqraCWnUSwzqwLTvYaiYL1PRHk/2dxxj2Is2u+
         a3LV++mKN5yFhfQcaUcpwu3eL6bIA6zT7Lgm6eSZZJoeLsXc/A0typPneJKHKREIvNqZ
         wn9gQtrl27vn5k4unsqOvnPBsjcKswcsFY6ReFOGmVfxVQeSUo3tWx+9AeFIvQ9gHNVe
         PBB3s/5lq4nEuZQh9mZSEEzLLvlhpsJlKQTuzyPJPlykKmDL+wMe3h13i09TDxg+13yC
         nUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ClCRhz5VpiOzswZeEfz32cI4Ba2QyTHClpP/KXN77n8=;
        b=qISYHphlFOLnDUy0f1ahor2brTSXzft9UcE8jAUTPkreOijZ9b29jKaclog+17Zi46
         XOlhuFeTiEQgqUyqA3XLCWAsk7g8Le2xE7YCp/qNeQ8vraelEznZe2bACpAkn/PcGsPd
         /gXqNzjcxIW1Df7xhqf4YWOQYpYfUrIo6j9HulyR6VLzBMoY/yJufYPXxLwKtttYE5YY
         BU6EGeIfNiAcxWmzTcJLI+2MH5MeNTMW03oUcKkYd+TFOSFptpsH4NYlgU7uEvlKfO/O
         vStYM1wR0BEwQNW/dR5c9xy5vWPzK6l/EdFPQIkrzILJjcHUEQg6iSA36TEif1f+B9fZ
         AGIQ==
X-Gm-Message-State: AOAM530JcyUA2yRbpOt6e7l/GQSaXaJTQKr6JeHIr3ja9jUJQsNE+gB/
        BWDrtCNp35St8xwV6FRoG0synRXb
X-Google-Smtp-Source: ABdhPJyPrrFgf+jmR3AS5090OYP3uL6N4D/xOD+aUyRRQ84OAADWwld7vDWjMWEJ5+hHxAx/fLoVPu0b
X-Received: by 2002:ad4:46e1:: with SMTP id h1mr10195779qvw.129.1596733548153;
 Thu, 06 Aug 2020 10:05:48 -0700 (PDT)
Date:   Thu,  6 Aug 2020 10:05:43 -0700
Message-Id: <20200806170544.382140-1-posk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 1/2 v2] rseq/membarrier: add MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
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

The second patch in the patchset adds a selftest
of this feature.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 include/uapi/linux/membarrier.h |  5 ++++
 kernel/sched/membarrier.c       | 43 +++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/membarrier.h b/include/uapi/linux/membarrier.h
index 5891d7614c8c..ce4628ea17fa 100644
--- a/include/uapi/linux/membarrier.h
+++ b/include/uapi/linux/membarrier.h
@@ -114,6 +114,10 @@
  *                          If this command is not implemented by an
  *                          architecture, -EINVAL is returned.
  *                          Returns 0 on success.
+ * @MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU:
+ *                          If a thread belonging to the current process
+ *                          is currently in an RSEQ critical section on the
+ *                          CPU identified by flags parameter, restart it.
  * @MEMBARRIER_CMD_SHARED:
  *                          Alias to MEMBARRIER_CMD_GLOBAL. Provided for
  *                          header backward compatibility.
@@ -131,6 +135,7 @@ enum membarrier_cmd {
 	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED		= (1 << 4),
 	MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE		= (1 << 5),
 	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE	= (1 << 6),
+	MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU		= (1 << 7),
 
 	/* Alias for header backward compatibility. */
 	MEMBARRIER_CMD_SHARED			= MEMBARRIER_CMD_GLOBAL,
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 168479a7d61b..1cdfde23696c 100644
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
@@ -308,10 +316,39 @@ static int membarrier_register_private_expedited(int flags)
 	return 0;
 }
 
+#ifdef CONFIG_RSEQ
+static void membarrier_rseq_ipi(void *arg)
+{
+	if (current->mm != arg)  /* Not our process. */
+		return;
+	if (!current->rseq)  /* RSEQ not set up for the current task/thread. */
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
+	return smp_call_function_single(cpu_id, membarrier_rseq_ipi,
+					current->mm, true);
+#else
+	return 0;
+#endif
+}
+
 /**
  * sys_membarrier - issue memory barriers on a set of threads
  * @cmd:   Takes command values defined in enum membarrier_cmd.
- * @flags: Currently needs to be 0. For future extensions.
+ * @flags: Currently needs to be 0 for all commands other than
+ *         MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU: in the latter
+ *         case it indicates the CPU on which to interrupt (= restart)
+ *         the RSEQ critical section.
  *
  * If this system call is not implemented, -ENOSYS is returned. If the
  * command specified does not exist, not available on the running
@@ -339,7 +376,7 @@ static int membarrier_register_private_expedited(int flags)
  */
 SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
 {
-	if (unlikely(flags))
+	if (unlikely(flags && cmd != MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU))
 		return -EINVAL;
 	switch (cmd) {
 	case MEMBARRIER_CMD_QUERY:
@@ -369,6 +406,8 @@ SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
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

