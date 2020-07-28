Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DB0C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F02682065E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgG1UWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgG1UWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:22:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A739C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:22:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D2E48297F2F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     keescook@chromium.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 2/6] arch: x86: Wrap TIF_IA32 checks
Date:   Tue, 28 Jul 2020 16:22:25 -0400
Message-Id: <20200728202229.1195682-3-krisman@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728202229.1195682-1-krisman@collabora.com>
References: <20200728202229.1195682-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove TIF_IA32, add wrapper that check the process
has IA32 ABI without using the flag directly.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/events/core.c             | 2 +-
 arch/x86/events/intel/ds.c         | 2 +-
 arch/x86/events/intel/lbr.c        | 2 +-
 arch/x86/include/asm/compat.h      | 2 +-
 arch/x86/include/asm/thread_info.h | 2 ++
 arch/x86/kernel/perf_regs.c        | 2 +-
 arch/x86/oprofile/backtrace.c      | 2 +-
 7 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 4103665c6e03..42dff74c6197 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2491,7 +2491,7 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 	struct stack_frame_ia32 frame;
 	const struct stack_frame_ia32 __user *fp;
 
-	if (!test_thread_flag(TIF_IA32))
+	if (!TASK_IA32(current))
 		return 0;
 
 	cs_base = get_segment_base(regs->cs);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index dc43cc124e09..27d1cc1f3d05 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1261,7 +1261,7 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
 		old_to = to;
 
 #ifdef CONFIG_X86_64
-		is_64bit = kernel_ip(to) || !test_thread_flag(TIF_IA32);
+		is_64bit = kernel_ip(to) || !TASK_IA32(current);
 #endif
 		insn_init(&insn, kaddr, size, is_64bit);
 		insn_get_length(&insn);
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 65113b16804a..6c097a2eac97 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -920,7 +920,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 	 * on 64-bit systems running 32-bit apps
 	 */
 #ifdef CONFIG_X86_64
-	is64 = kernel_ip((unsigned long)addr) || !test_thread_flag(TIF_IA32);
+	is64 = kernel_ip((unsigned long)addr) || !TASK_IA32(current);
 #endif
 	insn_init(&insn, addr, bytes_read, is64);
 	insn_get_opcode(&insn);
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index d4edf281fff4..d39f9b3ae683 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -181,7 +181,7 @@ static inline void __user *arch_compat_alloc_user_space(long len)
 {
 	compat_uptr_t sp;
 
-	if (test_thread_flag(TIF_IA32)) {
+	if (TASK_IA32(current)) {
 		sp = task_pt_regs(current)->sp;
 	} else {
 		/* -128 for the x32 ABI redzone */
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 934aa15b20f2..a3859595847c 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -243,4 +243,6 @@ extern void arch_setup_new_exec(void);
 #define arch_setup_new_exec arch_setup_new_exec
 #endif	/* !__ASSEMBLY__ */
 
+#define TASK_IA32(tsk) test_tsk_thread_flag(tsk, TIF_IA32)
+
 #endif /* _ASM_X86_THREAD_INFO_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index bb7e1132290b..9b446d3b67d2 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -123,7 +123,7 @@ int perf_reg_validate(u64 mask)
 
 u64 perf_reg_abi(struct task_struct *task)
 {
-	if (test_tsk_thread_flag(task, TIF_IA32))
+	if (TASK_IA32(task))
 		return PERF_SAMPLE_REGS_ABI_32;
 	else
 		return PERF_SAMPLE_REGS_ABI_64;
diff --git a/arch/x86/oprofile/backtrace.c b/arch/x86/oprofile/backtrace.c
index a2488b6e27d6..3f1086afa297 100644
--- a/arch/x86/oprofile/backtrace.c
+++ b/arch/x86/oprofile/backtrace.c
@@ -49,7 +49,7 @@ x86_backtrace_32(struct pt_regs * const regs, unsigned int depth)
 	struct stack_frame_ia32 *head;
 
 	/* User process is IA32 */
-	if (!current || !test_thread_flag(TIF_IA32))
+	if (!current || !TASK_IA32(current))
 		return 0;
 
 	head = (struct stack_frame_ia32 *) regs->bp;
-- 
2.27.0

