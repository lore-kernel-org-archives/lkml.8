Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E056C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C1B2065E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgG1UXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:23:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56868 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbgG1UXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:23:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D72C228EA02
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     keescook@chromium.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 6/6] arch: x86: Reclaim TIF_X32 flag
Date:   Tue, 28 Jul 2020 16:22:29 -0400
Message-Id: <20200728202229.1195682-7-krisman@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728202229.1195682-1-krisman@collabora.com>
References: <20200728202229.1195682-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dropping this as a TIF flag is interesting given the pressure over x86
remaining x86 flags, plus considering the current common entry code,
reducing arch-specific flags is a good thing.

Notice that no path really relies on TIF_X32 as part of a critical path,
therefore the cost of checking another field in thread_info shouldn't be
a problem.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/events/core.c             | 2 +-
 arch/x86/include/asm/thread_info.h | 4 +---
 arch/x86/kernel/process_64.c       | 3 ---
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 42dff74c6197..389a840e2211 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2574,7 +2574,7 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
  *   IA32 - Where we need to look at GDT/LDT segment descriptor tables
  *          to figure out what the 32bit base address is.
  *
- *    X32 - has TIF_X32 set, but is running in x86_64
+ *    X32 - has PSABI_X32 set, but is running in x86_64
  *
  * X86_64 - CS,DS,SS,ES are all zero based.
  */
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index aa7d27054a8a..3059af355cdb 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -108,7 +108,6 @@ struct thread_info {
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_SYSCALL_TRACEPOINT	28	/* syscall tracepoint instrumentation */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
-#define TIF_X32			30	/* 32-bit native x86-64 binary */
 #define TIF_FSCHECK		31	/* Check FS is USER_DS on return */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
@@ -136,7 +135,6 @@ struct thread_info {
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
-#define _TIF_X32		(1 << TIF_X32)
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
 
 /* flags to check in __switch_to() */
@@ -244,6 +242,6 @@ extern void arch_setup_new_exec(void);
 #endif	/* !__ASSEMBLY__ */
 
 #define TASK_IA32(tsk) (task_thread_info(tsk)->psabi == PSABI_IA32)
-#define TASK_X32(tsk) test_tsk_thread_flag(tsk, TIF_X32)
+#define TASK_X32(tsk) (task_thread_info(tsk)->psabi == PSABI_X32)
 
 #endif /* _ASM_X86_THREAD_INFO_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 75059c9de829..d9a72e186db6 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -534,7 +534,6 @@ void set_personality_64bit(void)
 	/* Make sure to be in 64bit mode */
 	current_thread_info()->psabi = PSABI_IA64;
 	clear_thread_flag(TIF_ADDR32);
-	clear_thread_flag(TIF_X32);
 	/* Pretend that this comes from a 64bit execve */
 	task_pt_regs(current)->orig_ax = __NR_execve;
 	current_thread_info()->status &= ~TS_COMPAT;
@@ -554,7 +553,6 @@ static void __set_personality_x32(void)
 {
 #ifdef CONFIG_X86_X32
 	current_thread_info()->psabi = PSABI_X32;
-	set_thread_flag(TIF_X32);
 	if (current->mm)
 		current->mm->context.ia32_compat = PSABI_X32;
 	current->personality &= ~READ_IMPLIES_EXEC;
@@ -575,7 +573,6 @@ static void __set_personality_ia32(void)
 {
 #ifdef CONFIG_IA32_EMULATION
 	current_thread_info()->psabi = PSABI_IA32;
-	clear_thread_flag(TIF_X32);
 	if (current->mm)
 		current->mm->context.ia32_compat = PSABI_IA32;
 	current->personality |= force_personality32;
-- 
2.27.0

