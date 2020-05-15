Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEA2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 193CF207C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589563700;
	bh=3rT3Y1nllLXurlUajpsDUcgeYtZ6W1gs3Ys8kPvelUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dpy9zJYJPt/hbN6HC3V68UTf8XVWa2or+252vfa+hF5pVNXcqD1MZEWg5lX+ovIOG
	 50IKZD9b200umWy8fxpE4eA/KiKjmPmVb3yuI+NJBcWVos4Wl09DYDRJCSVdcBzFRE
	 KMHhaBoNtjpLvCsdBQjdadssCPRQMBi4yDTzRHqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgEOR2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbgEOR2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:28:16 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A08B3207C3;
        Fri, 15 May 2020 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589563695;
        bh=3rT3Y1nllLXurlUajpsDUcgeYtZ6W1gs3Ys8kPvelUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iflLaAfznSBNzehiCR0qdxs9AXdnlMcpDZJeKjJJDdOdOFYot//rRZ+qIoILzuKzm
         gmjibbc5QcONQwYXD8nX/9SH7TkOq2PI4aajQoEFRc0ir4oSjeZdCP8fC/Y1I4QeMN
         UdFJLXmI4zW87VTFTxOfi/3Q66IBl8DdKl++oSgQ=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: [PATCH 4/6] scs: Move scs_overflow_check() out of architecture code
Date:   Fri, 15 May 2020 18:27:54 +0100
Message-Id: <20200515172756.27185-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515172756.27185-1-will@kernel.org>
References: <20200515172756.27185-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing architecture-specific about scs_overflow_check() as
it's just a trivial wrapper around scs_corrupted().

For parity with task_stack_end_corrupted(), rename scs_corrupted() to
task_scs_end_corrupted() and call it from schedule_debug() when
CONFIG_SCHED_STACK_END_CHECK_is enabled. Finally, remove the unused
scs_overflow_check() function entirely.

This has absolutely no impact on architectures that do not support SCS
(currently arm64 only).

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/scs.h | 18 ------------------
 arch/arm64/kernel/process.c  |  2 --
 arch/arm64/kernel/scs.c      |  2 +-
 include/linux/scs.h          |  4 ++--
 kernel/sched/core.c          |  3 +++
 kernel/scs.c                 |  3 ++-
 6 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
index d46efdd2060a..eaa2cd92e4c1 100644
--- a/arch/arm64/include/asm/scs.h
+++ b/arch/arm64/include/asm/scs.h
@@ -24,24 +24,6 @@
 	.endm
 #endif /* CONFIG_SHADOW_CALL_STACK */
 
-#else /* __ASSEMBLY__ */
-
-#include <linux/scs.h>
-
-#ifdef CONFIG_SHADOW_CALL_STACK
-
-static inline void scs_overflow_check(struct task_struct *tsk)
-{
-	if (unlikely(scs_corrupted(tsk)))
-		panic("corrupted shadow stack detected inside scheduler\n");
-}
-
-#else /* CONFIG_SHADOW_CALL_STACK */
-
-static inline void scs_overflow_check(struct task_struct *tsk) {}
-
-#endif /* CONFIG_SHADOW_CALL_STACK */
-
 #endif /* __ASSEMBLY __ */
 
 #endif /* _ASM_SCS_H */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index a35d3318492c..56be4cbf771f 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -52,7 +52,6 @@
 #include <asm/mmu_context.h>
 #include <asm/processor.h>
 #include <asm/pointer_auth.h>
-#include <asm/scs.h>
 #include <asm/stacktrace.h>
 
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
@@ -516,7 +515,6 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 	entry_task_switch(next);
 	uao_thread_switch(next);
 	ssbs_thread_switch(next);
-	scs_overflow_check(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
diff --git a/arch/arm64/kernel/scs.c b/arch/arm64/kernel/scs.c
index adc97f826fab..955875dff9e1 100644
--- a/arch/arm64/kernel/scs.c
+++ b/arch/arm64/kernel/scs.c
@@ -6,7 +6,7 @@
  */
 
 #include <linux/percpu.h>
-#include <asm/scs.h>
+#include <linux/scs.h>
 
 /* Allocate a static per-CPU shadow stack */
 #define DEFINE_SCS(name)						\
diff --git a/include/linux/scs.h b/include/linux/scs.h
index 0eb2485ef832..2fd3df50e93e 100644
--- a/include/linux/scs.h
+++ b/include/linux/scs.h
@@ -47,7 +47,7 @@ static inline unsigned long *__scs_magic(void *s)
 	return (unsigned long *)(s + SCS_SIZE) - 1;
 }
 
-static inline bool scs_corrupted(struct task_struct *tsk)
+static inline bool task_scs_end_corrupted(struct task_struct *tsk)
 {
 	unsigned long *magic = __scs_magic(task_scs(tsk));
 	unsigned long sz = task_scs_sp(tsk) - task_scs(tsk);
@@ -60,8 +60,8 @@ static inline bool scs_corrupted(struct task_struct *tsk)
 static inline void scs_init(void) {}
 static inline void scs_task_reset(struct task_struct *tsk) {}
 static inline int scs_prepare(struct task_struct *tsk, int node) { return 0; }
-static inline bool scs_corrupted(struct task_struct *tsk) { return false; }
 static inline void scs_release(struct task_struct *tsk) {}
+static inline bool task_scs_end_corrupted(struct task_struct *tsk) { return false; }
 
 #endif /* CONFIG_SHADOW_CALL_STACK */
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 934e03cfaec7..a1d815a11b90 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3878,6 +3878,9 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 #ifdef CONFIG_SCHED_STACK_END_CHECK
 	if (task_stack_end_corrupted(prev))
 		panic("corrupted stack end detected inside scheduler\n");
+
+	if (task_scs_end_corrupted(prev))
+		panic("corrupted shadow stack detected inside scheduler\n");
 #endif
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
diff --git a/kernel/scs.c b/kernel/scs.c
index aea841cd7586..faf0ecd7b893 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -98,7 +98,8 @@ void scs_release(struct task_struct *tsk)
 	if (!s)
 		return;
 
-	WARN(scs_corrupted(tsk), "corrupted shadow stack detected when freeing task\n");
+	WARN(task_scs_end_corrupted(tsk),
+	     "corrupted shadow stack detected when freeing task\n");
 	scs_check_usage(tsk);
 	scs_free(s);
 }
-- 
2.26.2.761.g0e0b3e54be-goog

